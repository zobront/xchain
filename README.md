# <h1 align="center"> xchain </h1>

**Cross chain calls from Solidity tests and scripts**

## Installation

```
forge install zobront/xchain
```

## Usage

1. Add this import to your script or test:

```solidity
import { XChain } from "xchain/XChain.sol";
```

2. Enable [ffi](https://book.getfoundry.sh/cheatcodes/ffi.html).

You can either pass the `--ffi` flag to any forge commands you run (e.g. `forge script Script --ffi`), or you can add `ffi = true` to your `foundry.toml` file.

3. Add any RPC URLs needed to rpcs.txt.

You can find it xyz.

4. Make your cross chain calls:

```solidity
- call with calldata string or function

// Perform a simple get request
(uint256 status, bytes memory data) = "https://httpbin.org/get".get();

// Perform a get request with headers
string[] memory headers = new string[](2);
headers[0] = "accept: application/json";
headers[1] = "Authorization: Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==";
(uint256 status, bytes memory data) = "https://httpbin.org/get".get(headers);

// Perform a post request with headers and JSON body
string[] memory headers = new string[](1);
headers[0] = "Content-Type: application/json";
(uint256 status, bytes memory data) = "https://httpbin.org/post".post(headers, '{"foo": "bar"}');

// Perform a put request
(uint256 status, bytes memory data) = "https://httpbin.org/put".put();

// Perform a patch request
(uint256 status, bytes memory data) = "https://httpbin.org/put".patch();

// Perform a delete request (unfortunately 'delete' is a reserved keyword and cannot be used as a function name)
(uint256 status, bytes memory data) = "https://httpbin.org/delete".del();
```

### Notes

- It assumes you are running on a UNIX based machine with `bash`, `tail`, `sed`, `tr`, `curl` and `cast` installed.

## Example

We have example usage for both [tests](./test/Surl.t.sol) and [scripts](./script/).

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