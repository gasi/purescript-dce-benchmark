#!/usr/bin/env bats
@test "A module with an unused ES6 export and tree-shaking enabled will leave a comment next to the unused method" {
  npx webpack > /dev/null && < dist/main.js grep 'unused harmony export javaScriptUnused'
}
