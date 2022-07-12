# <h1 align="center"> xchain </h1>

**Cross chain calls from Solidity tests and scripts**

## Installation

```
forge install zobront/xchain
```

## Usage

1. ADD IMPORT INTO TEST OR SCRIPT

```solidity
import { XChain } from "xchain/XChain.sol";
```

2. ENABLE [FFI](https://book.getfoundry.sh/cheatcodes/ffi.html).

```
The easiest option is to add `ffi = true` to your `foundry.toml` file.

You can also pass the `--ffi` flag to any forge commands you run (e.g. `forge script Script --ffi`).
```

3. ADD RPC URLS TO FILE

```
The file lives at ./lib/xchain/rpcs.txt. 
```

4. MAKE CROSS CHAIN CALLS

```solidity

// There are two peek functions: peek() and peekWithCalldata().

XChain.peek(
    uint _chainId OR string memory _chainName,
    address contract,
    string memory functionSig
)

XChain.peekWithCalldata(
    uint _chainId OR string memory _chainName,
    address contract,
    string memory _calldata
)

// Example peek() with Chain ID
bytes memory res = XChain.peek(1, CONTRACT_ADDRESS, '"ownerOf(uint256)" 1');

// Example peek() with Chain Name
bytes memory res = XChain.peek("mainnet", CONTRACT_ADDRESS, '"ownerOf(uint256)" 1');

// Example peekWithCalldata() with Chain ID.
bytes memory res = XChain.peekWithCalldata(1, CONTRACT_ADDRESS, "0x6352211e0000000000000000000000000000000000000000000000000000000000000001");

```

5. DECODE RESPONSES

```solidity
// Responses are always encoded as bytes, and must be decoded into the expected type.
address addr = address(uint160(uint256(bytes32(res))));

// There are two built in helper methods for decoding addresses and ints.
address addr = XChain.decodeAddress(res);
uint num = XChain.decodeInt(res);

```

### Notes

- It assumes you are running on a UNIX based machine with `bash`, `tail`, `sed`, `tr`, `curl` and `cast` installed.

## Example

You can find [example usage for tests](./test/XChain.t.sol) in the `test` repo.

## Contributing

[] build in functions to decode returned bytes for complex types
[] have rpcs pull from environment variables?

Clone this repo and run:

```
forge install
```

Make sure all tests pass, add new ones if needed:

```
forge test
```

## Why?

There is often a need to get data from other chains in the middle of Solidity tests and scripts. Currently, Forge only allows forking one network, so we aren't able to access this other data. With XChain, you can easily get data from other chains in the middle of your tests and scripts.

## Development

This project uses [Foundry](https://getfoundry.sh). See the [book](https://book.getfoundry.sh/getting-started/installation.html) for instructions on how to install and use Foundry.

## Thanks

Shout out to [Devan Non](https://twitter.com/devan_non) and [Ape Dev](https://twitter.com/_apedev) for their work on [Solenv](https://github.com/memester-xyz/solenv) and [Surl](https://github.com/memester-xyz/surl/), which inspired this project.