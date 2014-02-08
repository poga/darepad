#!/usr/bin/env lsc -cj
author:
  name: ['Poga Po']
  email: 'poga@poga.tw'
name: 'MoltenPad'
description: 'Liquify People'
version: '0.0.1'
main: \lib/index.js
bin:
  molten: 'bin/moltenpad'
repository:
  type: 'git'
  url: 'git://github.com/poga/moltenpad.git'
scripts:
  prepublish: """
    lsc -cj package.ls &&
    lsc -bc -o lib src
    lsc -bc app/app.ls
    browserify app/app.js -o app/moltenpad.js
  """
  dev: "./node_modules/gulp/bin/gulp.js --require LiveScript dev"
engines: {node: '*'}
dependencies:
  htmlparser2: \~3.4.0
  marked: \~0.3.0
  jade: \~1.1.5
  ncp: \~0.5.0
  'crypto-js': \~3.1.2
  nomnom: \~1.6.2
devDependencies:
  LiveScript: \1.2.x
  browserify: \~3.24.11
  "gulp-util": \~2.2.14
  gulp: \~3.5.2
  "gulp-livescript": \~0.1.1
  "gulp-browserify": \~0.4.2
  "gulp-concat": \~2.1.7
