require! fs
require! path
require! htmlparser2
require! marked
require! jade
{ncp} = require \ncp

exports.parseFile = (file, options, cb) ->
  err, text <- fs.readFile file, \utf8
  # override renderer to generate custom header id
  stack = []
  renderer = new marked.Renderer!
  renderer.heading = (text, level) ->
    for i to stack.length - level then stack.pop!
    stack.push text
    header-id = stack.join(\-).replace(/[\s\.\[\]\/#$]/g, "-")
    return "<h#level id='#header-id'>#text</h#level>"

  html = marked text, renderer: renderer
  h, title <- scan-hierarchy html
  list <- build-hierarchy-list h
  err, html <- jade.renderFile options.theme, content: html, menu: list, title: title, firepadRef: options.firepadRef, pretty: true
  console.log err.message if err
  err <- ncp path.dirname(options.theme), options.output
  console.log err.message if err
  fs.mkdirSync "#{options.output}/javascript"
  fs.createReadStream('app/moltenpad.js').pipe(fs.createWriteStream("#{options.output}/javascript/moltenpad.js"))
  err <- fs.writeFile "#{options.output}/index.html", html
  console.log err.message if err

scan-hierarchy = (html, cb) ->
  hierarchies = []
  stack = ['']
  is-header = false
  parser = new htmlparser2.Parser do
    onopentag: (n, attr) ->
      if m = n is /h(\d)+/
        for i til stack.length - m[1] then stack.pop!
        stack.push attr.id
        hierarchies ++= id: attr.id, path: stack.join(\/), d: stack.length - 1
        is-header := true
    ontext: (t) ->
      if is-header
        hierarchies[*-1].name = t
        is-header := false
  parser.write html
  cb? hierarchies, hierarchies[0].name

build-hierarchy-list = (hierarchies, cb) ->
  list = ""
  current-deep = 0
  for h in hierarchies
    if h.d < current-deep
      list += \</ul> * (current-deep - h.d)
    else if h.d > current-deep
      list += \<ul> * (h.d - current-deep)
    current-deep += (h.d - current-deep)
    list += "<li><a href='\##{h.id}'>#{h.name}</a><br /></li>"
  list += \</ul>
  cb? list

