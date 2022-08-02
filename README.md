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

## Use utils.py

`utils.py` contains a few helpers such as:
- `str_to_felt()`
- `felt_to_str()`
- `str_to_felt_array()`
- `uint256_to_int()`
- `int_to_uint256()`
- `hex_to_felt()`


```shell
python3 -i utils/utils.py
```

```python
>>> str_to_felt('ERC20-101')
1278752977803006783537
```

## Update openzeppelin dependency

```shell
protostar update cairo_contracts
```
