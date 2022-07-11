// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { Vm } from "forge-std/Vm.sol";
import { Solenv } from "solenv/Solenv.sol";
import "openzeppelin-contracts/contracts/utils/Strings.sol";

library XChain {
    Vm constant vm = Vm(address(bytes20(uint160(uint256(keccak256("hevm cheat code"))))));

    function getRPC(uint _id) public returns (string memory) {
        Solenv.config();
        if (_id == 1) {
            return vm.envString("XCHAIN_MAINNET_RPC");
        } else if (_id == 3) {
            return vm.envString("XCHAIN_ROPSTEN_RPC");
        } else if (_id == 4) {
            return vm.envString("XCHAIN_RINKEBY_RPC");
        } else if (_id == 5) {
            return vm.envString("XCHAIN_GOERLI_RPC");
        } else if (_id == 10) {
            return vm.envString("XCHAIN_OPTIMISM_RPC");
        } else if (_id == 56) {
            return vm.envString("XCHAIN_BINANCE_RPC");
        } else if (_id == 137) {
            return vm.envString("XCHAIN_POLYGON_RPC");
        } else if (_id == 250) {
            return vm.envString("XCHAIN_FANTOM_RPC");
        } else if (_id == 43114) {
            return vm.envString("XCHAIN_AVAX_RPC");
        } else if (_id == 42161) {
            return vm.envString("XCHAIN_ARBITRUM_RPC");
        } else {
            revert("Invalid chain id");
        }
    }

    function getRPC(string memory _name) public returns (string memory) {
        Solenv.config();
        bytes32 nameHash = keccak256(bytes(_name));
        if (nameHash == keccak256("mainnet")) {
            return vm.envString("XCHAIN_MAINNET_RPC");
        } else if (nameHash == keccak256("ropsten")) {
            return vm.envString("XCHAIN_ROPSTEN_RPC");
        } else if (nameHash == keccak256("rinkeby")) {
            return vm.envString("XCHAIN_RINKEBY_RPC");
        } else if (nameHash == keccak256("goerli") || nameHash == keccak256("gorli")) {
            return vm.envString("XCHAIN_GOERLI_RPC");
        } else if (nameHash == keccak256("optimism")) {
            return vm.envString("XCHAIN_OPTIMISM_RPC");
        } else if (nameHash == keccak256("binance") || nameHash == keccak256("bsc")) {
            return vm.envString("XCHAIN_BINANCE_RPC");
        } else if (nameHash == keccak256("polygon") || nameHash == keccak256("matic")) {
            return vm.envString("XCHAIN_POLYGON_RPC");
        } else if (nameHash == keccak256("fantom")) {
            return vm.envString("XCHAIN_FANTOM_RPC");
        } else if (nameHash == keccak256("avalanche") || nameHash == keccak256("avax")) {
            return vm.envString("XCHAIN_AVAX_RPC");
        } else if (nameHash == keccak256("arbitrum")) {
            return vm.envString("XCHAIN_ARBITRUM_RPC");
        } else {
            revert("Invalid network name");
        }
    }

    function XChain(
        uint _chainId, 
        address _addr, 
        string memory _fxAndArgs
    ) public returns(bytes memory) {
        return _makeXChainCall(getRPC(_chainId), _addr, _fxAndArgs);
    } 

    function XChain(
        string memory _chainName, 
        address _addr, 
        string memory _fxAndArgs
    ) public returns(bytes memory) {
        return _makeXChainCall(getRPC(_chainName), _addr, _fxAndArgs);
    }

    function XChainFromCalldata(
        string memory _chainName, 
        address _addr, 
        string memory _calldata
    ) public returns(bytes memory) {
        return _makeXChainCall(getRPC(_chainName), _addr, _calldata);
    }

    function XChainFromCalldata(
        uint _chainId,
        address _addr, 
        string memory _calldata
    ) public returns(bytes memory) {
        return _makeXChainCall(getRPC(_chainId), _addr, _calldata);
    }

    function _makeXChainCall(
        string memory _chainRPC, 
        address _addr,
        string memory _data
    ) internal returns (bytes memory) {
        string[] memory inputs = new string[](5);
        inputs[0] = "bash";
        inputs[1] = "./lib/xchain/src/xch.sh";
        inputs[2] = _chainRPC;
        inputs[3] = Strings.toHexString(uint256(uint160(_addr)), 20);
        inputs[4] = _data;
        
        return vm.ffi(inputs);
    }
}
