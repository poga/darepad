# MoltenPad

Melt people into liquid.

## Usage

Install moltenpad

```
git clone git@github.com:poga/moltenpad.git
npm i
npm prepublish
```

You will need a theme to compile. For now, there is only one theme: simple

```
git clone git@github.com:poga/moltenpad-simple.git
```

Compile:

```
./bin/moltenpad YOUR_MARKDOWN.md THEME_INDEX.JADE_PATH YOUR_FIREPAD_REF
```

Compiled app will be at ./build/
