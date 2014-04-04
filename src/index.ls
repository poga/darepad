require! fs
require! path
require! htmlparser2
require! marked
require! jade
{ncp} = require \ncp

exports.compile = (opts, cb) ->
  # override renderer to generate custom header id
  stack = []
  renderer = new marked.Renderer!
  renderer.heading = (text, level) ->
    for i to stack.length - level then stack.pop!
    stack.push text
    header-id = stack.join(\-).replace(/[\s\.\[\]\/#$]/g, "-")
    return "<h#level id='#header-id'>#text</h#level>"

  err, text <- fs.readFile opts.input, \utf8
  throw err if err
  html = marked text, renderer: renderer
  h, title <- scan-hierarchy html
  list <- build-hierarchy-list h
  err, html <- jade.renderFile opts.theme, content: html, menu: list, title: title, firepadRef: opts.firepadRef, pretty: true
  throw err if err
  exist <- fs.exists opts.output
  throw 'output dir already exist' if exist and not opts.force
  err <- ncp path.dirname(opts.theme), opts.output
  throw err if err
  err <- fs.mkdir "#{opts.output}/javascript"
  fs.createReadStream('app/darepad.js').pipe(fs.createWriteStream("#{opts.output}/javascript/darepad.js"))
  err <- fs.writeFile "#{opts.output}/index.html", html
  throw err if err
  cb?!

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

