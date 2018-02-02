# tink_localization
Language localization library

## Objectives of this library:
- Convenient localization definitions for key-value pairs using functions (- Writing the keys and values in one place ( so no need ie. extern definition for function definitions in one file, and key-values in another one))
- Type safe with auto completion, so no possible typos.
- Being able to overwrite at runtime template values
- Having default values compiled into the source if something is not localized in the given language
- Being able to generate standard localization files from it

tink_localization using thx.tpl templates for complex language elements with variables, and pure strings for elements without parameters

- Simply  

# Dependencies
[thx.tpl](http://lib.haxe.org/p/thx.tpl)

# Usage
Check [tests/Playground.hx](https://github.com/grosmar/tink_localization/blob/master/tests/Playground.hx)

# Todo
- Possibility to generate standard localization files from class at compile time (ie .po or .json files)
- Add support for other templating systems (ie haxe.Template, handlebars, etc)