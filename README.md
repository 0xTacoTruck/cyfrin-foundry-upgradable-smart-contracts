# Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

  
# LESSON NOTES

My notes taken during this course can be found in the Notes.md file of this repository.


## ENVIRONMENT VARIABLES

### FROM TERMINAL, WE WANT FORGE TO REFER TO OUR .ENV FILE. TO DO THIS:
```shell
$ source .env
```

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

## Cast

```shell
$ cast <subcommand>
```

### Cast Function Signature

- Will return hexadecimal value
- Allows to check that we are doing what we expect to be doing- e.g check hex data in metamask against the hex value of function name to verify correct function is being called

```shell
$ cast sig "functionName()"
```

### Cast Using CallData Decode

- This is used to achieve the same goal of 'cast sig', however, this is used for functions that have parameters which makes the hex string much larger
- This would return what each of the parameters are for the function

```shell
$ cast --calldata-decode "functionName()" HexString(e.g.2a4d5b etc etc)
```


### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```


## Development

This project uses [Foundry](https://getfoundry.sh). See the [book](https://book.getfoundry.sh/getting-started/installation.html) for instructions on how to install and use Foundry.
