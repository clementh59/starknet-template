# Starknet-template

## Install

```shell
git submodule init
git submodule update
```

## Compile

```shell
make
```

## Test

```shell
make test
```

To test a specific file, you'll need to use `testFile`:
```shell
make testFile path=test_erc20.cairo
```

## Deploy

```shell
make deploy
```

## Update openzeppelin dependency

```shell
protostar update cairo_contracts
```
