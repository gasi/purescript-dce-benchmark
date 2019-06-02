#!/usr/bin/env bats
@test "Unused module export will be marked by webpack with tree-shaking enabled" {
  npx webpack > /dev/null && < dist/main.js grep 'unused harmony export javaScriptUnused'
}
