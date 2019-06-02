module Main where

import External (pureScriptExternalUsed)

pureScriptUsed :: String -> String
pureScriptUsed _ = pureScriptExternalUsed "used"

pureScriptUnused :: String -> String
pureScriptUnused _ = "PureScript unused"
