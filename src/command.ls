require! nomnom

leve1up = require \..

opts = nomnom.script \moltenpad
  .options do
    input:
      abbr: \i
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

<- leve1up.compile opts
console.log \complete
