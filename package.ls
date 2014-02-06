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
