# DarePad

自我檢核文件產生器

## Install

```
git clone git@github.com:poga/darepad.git
npm i
```

## Usage

A darepad document is just a markdown file plus some custom tags.

### example DarePad document

darepad.md:

```
# title

some description

<dp-action label="checkbox label" link="http://www.google.com"></dp-action>
```

```
./bin/darepad -i darepad.md -o build -f
```

### options

 * **-i**: input markdown file name
 * **-o**: output path
 * **-f**: overwrite output path if exist

## Development

watch change and rebuild:

```
npm run dev
```
