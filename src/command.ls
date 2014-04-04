require! nomnom

darepad = require \..

opts = nomnom.script \darepad
  .options do
    input:
      abbr: \i
      required: true
      help: 'input markdown path'
    theme:
      abbr: \t
      metavar: \THEME_DIR
      help: 'path to the theme base dir'
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
    firepadRef:
      metavar: 'FIREBASE_REF'
      help: 'firebase ref for firepad'
  .parse!

<- darepad.compile opts
