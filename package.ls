#!/usr/bin/env lsc -cj
author:
  name: ['Poga Po']
  email: 'poga@poga.tw'
name: 'DarePad'
description: 'SOP of everything'
version: '0.0.1'
main: \lib/index.js
bin:
  darepad: 'bin/darepad'
repository:
  type: 'git'
  url: 'git://github.com/poga/darepad.git'
scripts:
  prepublish: """
    ./node_modules/gulp/bin/gulp.js --require LiveScript
  """
  dev: "./node_modules/gulp/bin/gulp.js --require LiveScript dev"
engines: {node: '*'}
dependencies: {}
devDependencies:
  'crypto-js': \~3.1.2-3
  express: \~4.4.0
  jade: \~1.3.1
  LiveScript: \~1.2.0
  gulp: \~3.6.0
  'gulp-util': \~2.2.14
  'gulp-stylus': \~1.0.2
  nib: \~1.0.2
  'gulp-livescript': \~0.3.0
  'gulp-jade': \~0.5.0
  'gulp-livereload': \~1.5.0
  'connect-livereload': \~0.4.0
  'gulp-plumber': \~0.6.2
  browserify: \~4.1.6
  "gulp-browserify": \~0.5.0
