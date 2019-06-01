#!/usr/bin/env bats
function setup {
  rm -rf dist output
  npx pulp build > /dev/null 2>&1
  npx webpack > /dev/null 2>&1
}
@test "Purescript uses module.exports syntax" {
  cat output/Main/index.js | grep 'module\.exports'
}
@test "The generated webpack output has a pureScriptUnused function" {
  cat dist/main.js | grep 'pureScriptUnused' | grep 'function'
}
@test "The function is not designated as an unused export in the webpack bundle" {
  ! grep 'unused harmony export pureScriptUnused' < dist/main.js 
}

@test "But if I mangle it to use es6 syntax it does" {
  rm -rf dist output
  npx pulp build > /dev/null 2>&1

  # Find the line number of 'module.exports'
  local ln="$(grep -n "module\.exports" < output/Main/index.js | grep -o "[0-9]\+")"
  local tempfile="$(mktemp)"
  cat output/Main/index.js | head "-$((ln - 1))" > "${tempfile}"
  mv "${tempfile}" output/Main/index.js
  cat <<EOF >> output/Main/index.js
export {
  pureScriptUsed,
  pureScriptUnused
}
EOF
  npx webpack > /dev/null
  grep 'unused harmony export pureScriptUnused' < dist/main.js 
}
