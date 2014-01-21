require! fs
require! htmlparser2
require! marked
require! swig

exports.parseFile = (file, options, cb) ->
  err, text <- fs.readFile file, \utf8
  md = marked text
  h <- scan-hierarchy md
  list <- build-hierarchy-list h
  err, tmpl <- fs.readFile options.layoutFile, \utf8
  cb swig.render tmpl, locals: body: list+md

scan-hierarchy = (md, cb) ->
  hierarchies = []
  stack = ['']
  is-header = false
  parser = new htmlparser2.Parser {
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
  }
  parser.write md
  cb? hierarchies

build-hierarchy-list = (hierarchies, cb) ->
  list = ""
  current-deep = 0
  for h in hierarchies
    if h.d < current-deep
      list += \</ul>
      current-deep -= 1
    else if h.d > current-deep
      list += \<ul>
      current-deep += 1
    list += "<li><a href='\##{h.id}'>#{h.name}</a><br /></li>"
  list += \</ul>
  cb? list

