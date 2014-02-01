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
    lsc -bc app/moltenpad.ls
  """
engines: {node: '*'}
dependencies:
  htmlparser2: \3.4.0
  marked: \0.3.0
  jade: \1.1.5
  ncp: \0.5.0
devDependencies:
  LiveScript: \1.2.x
