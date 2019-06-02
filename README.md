# PureScript Dead Code Elimination Proof of Concept

## Prerequisites

```sh
brew install bats # or the equivalent on your system
```

## Quickstart

Run all tests:

```sh
make
```

## Example 1: DCE in webpack + JS

```sh
make --directory example1-dce-js
```

## Example 2: No DCE with webpack + PureScript CommonJS

```sh
make --directory example2-no-dce-purs
```

## Example 3: DCE with webpack + PureScript ESM

```sh
make --directory example3-dce-purs
```
