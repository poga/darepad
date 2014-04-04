# DarePad

SOP of everything

## Install

Install DarePad

```
git clone git@github.com:poga/darepad.git
npm i
```

You will need a theme to compile. For now, there is only one theme: simple

```
git clone git@github.com:poga/moltenpad-simple.git
```

## Usage

```
./bin/darepad -h
```

### example

```
./bin/darepad -i markdown.md -t ../moltenpad-simple/index.jade -o build --firepadRef https://...firebaseio.com
```

## Development

watch change and rebuild:

```
npm run dev
```
