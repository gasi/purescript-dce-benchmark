#!/usr/bin/env bats
# function setup {
  rm -rf dist output
  npx pulp build > /dev/null
  npx webpack > /dev/null
# }
@test "Purescript uses module.exports syntax" {
  cat output/Main/index.js | grep 'module\.exports'
}
@test "The generated webpack output has a pureScriptUnused function" {
  cat dist/main.js | grep 'pureScriptUnused' | grep 'function'
}
@test "The function is not designated as an unused export in the webpack bundle" {
  ! grep 'unused harmony export pureScriptUnused' < dist/main.js 
}
