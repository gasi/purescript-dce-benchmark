#!/usr/bin/env bats

function setup {
  rm -rf dist output
  cd ../purescript
  stack build
  stack exec purs \
    -- compile ../example3-dce-purs/src/*.purs \
    --output ../example3-dce-purs/output
  cd -
  npx webpack
}

@test 'PureScript compiles to `export` syntax' {
  cat output/Main/index.js | grep 'export {'
}
@test 'The generated webpack bundle has a `pureScriptUnused` function' {
  cat dist/main.js | grep 'pureScriptUnused' | grep 'function'
}
@test '`pureScriptUnused` marked as an unused export in the webpack bundle' {
  grep 'unused harmony export pureScriptUnused' < dist/main.js
}
