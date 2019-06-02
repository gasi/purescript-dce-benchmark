#!/usr/bin/env bats

function setup {
  rm -rf dist output
  cd ../..
  if [[ ! -d purescript ]]; then
    git clone git@github.com:gasi/purescript.git
  fi
  cd purescript
  git checkout esm-codegen
  stack build
  stack exec purs \
    -- compile ../purescript-dce-benchmark/example3-dce-purs/src/*.purs \
    --output ../purescript-dce-benchmark/example3-dce-purs/output
  cd ../purescript-dce-benchmark/example3-dce-purs
  npx webpack
}

@test 'PureScript compiles to `export` syntax' {
  cat output/Main/index.js | grep 'export {'
}
@test 'The generated webpack bundle has a `pureScriptUnused` function' {
  cat dist/main.js | grep 'pureScriptUnused' | grep 'function'
}
@test "The function is designated as an unused export in the webpack bundle" {
  grep 'unused harmony export pureScriptUnused' < dist/main.js
}
