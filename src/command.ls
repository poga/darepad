require! nomnom

darepad = require \..

opts = nomnom.script \darepad
  .options do
    input:
      abbr: \i
      required: true
      help: 'input markdown path'
    force:
      abbr: \f
      flag: true
      help: 'force overwrite output dir if it\'s already exist'
      default: false
    output:
      abbr: \o
      default: "build"
      metavar: 'OUTPUT_DIR'
      help: "output dir"
  .parse!

<- darepad.compile opts
