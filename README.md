# PureScript Dead Code Elimination Proof-of-Concept

## Prerequisites

```sh
brew install bats # or the equivalent on your system
```


## Example 1: DCE in webpack + JS

```sh
cd example1-dce-js
npm install
bats test.bats
```

## Example 2: No DCE with webpack + PureScript CommonJS

```sh
cd example2-no-dce-purs
npm install
npx bower install
bats test.bats
```
