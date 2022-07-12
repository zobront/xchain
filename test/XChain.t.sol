// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/XChain.sol";

contract ContractTest is Test {
    address constant NFT_CONTRACT = 0x78D72E60BaE892F97b97fEBAE5886DaB2eF0cbC8;

    function setUp() public {}

    function testPeekWithChainId() public {
        bytes memory res = XChain.peek(1, NFT_CONTRACT, '"ownerOf(uint256)" 1');
        address addr = XChain.decodeAddress(res);
        assert(addr == 0xf346100e892553DcEb41A927Fb668DA7B0b7C964);
    }
    
    function testPeekWithChainName() public {
        bytes memory res = XChain.peek("rinkeby", NFT_CONTRACT, '"ownerOf(uint256)" 1');
        address addr = XChain.decodeAddress(res);
        assert(addr == 0x39E4BE283Fa2c56781375507Ae837BaCAb1169Ab);
    }

    function testPeekWithCalldata() public {
        bytes memory res = XChain.peekWithCalldata("mainnet", NFT_CONTRACT, "0x6352211e0000000000000000000000000000000000000000000000000000000000000001");
        address addr = XChain.decodeAddress(res);
        assert(addr == 0xf346100e892553DcEb41A927Fb668DA7B0b7C964);
    }

    function testPeekReturningInt() public {
        bytes memory res = XChain.peek("mainnet", NFT_CONTRACT, '"balanceOf(address)" 0xf346100e892553DcEb41A927Fb668DA7B0b7C964');
        uint256 balance = XChain.decodeInt(res);
        assert(balance == 1);
    }

    // TODO: Add tests for other return types...
    
}
