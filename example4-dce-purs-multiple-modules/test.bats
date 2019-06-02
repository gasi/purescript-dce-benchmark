#!/usr/bin/env bats

function setup {
  rm -rf dist output
  cd ../purescript
  stack build
  stack exec purs \
    -- compile ../example4-dce-purs-multiple-modules/bower_components/**/*.purs ../example4-dce-purs-multiple-modules/src/*.purs \
    --output ../example4-dce-purs-multiple-modules/output
  cd -
  npx webpack
}

@test 'PureScript compiles to `export` syntax' {
  cat output/Main/index.js | grep 'export {'
  cat output/External/index.js | grep 'export {'
}
@test 'PureScript compiles to `import * as … from …` syntax' {
  cat output/Main/index.js | grep 'import \* as External from'
}
@test 'The generated webpack bundle has a `pureScriptUnused` function' {
  cat dist/main.js | grep 'pureScriptUnused' | grep 'function'
}
@test '`pureScriptUnused` designated as an unused export in the webpack bundle' {
  grep 'unused harmony export pureScriptUnused' < dist/main.js
}
@test 'The generated webpack bundle has a `pureScriptExternalUnused` function' {
  cat dist/main.js | grep 'pureScriptUnused' | grep 'function'
}
@test '`pureScriptExternalUnused` is designated as an unused export in the webpack bundle' {
  grep 'unused harmony export pureScriptExternalUnused' < dist/main.js
}
