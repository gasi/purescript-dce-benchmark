#!/usr/bin/env bats

function setup {
  rm -rf dist output
  npx purs compile src/*.purs
  npx webpack
}

@test 'PureScript compiles to `module.exports` syntax' {
  cat output/Main/index.js | grep 'module\.exports'
}
@test 'The generated webpack bundle has a `pureScriptUnused` function' {
  cat dist/main.js | grep 'pureScriptUnused' | grep 'function'
}
@test '`pureScriptUnused` is not marked as an unused export in the webpack bundle' {
  ! grep 'unused harmony export pureScriptUnused' < dist/main.js
}
@test 'HACK: With manual conversion to ES modules syntax, `pureScriptUnused` is marked as unused' {
  rm -rf dist output
  npx pulp build

  # Find the line number of 'module.exports'
  local line="$(grep -n "module\.exports" < output/Main/index.js | grep -o "[0-9]\+")"
  local tempfile="$(mktemp)"
  cat output/Main/index.js | head "-$((line - 1))" > "${tempfile}"
  mv "${tempfile}" output/Main/index.js
  cat <<EOF >> output/Main/index.js
export {
  pureScriptUsed,
  pureScriptUnused
}
EOF
  npx webpack
  grep 'unused harmony export pureScriptUnused' < dist/main.js
}
