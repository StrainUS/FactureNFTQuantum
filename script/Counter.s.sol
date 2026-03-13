// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {FactureNFTQuantum} from "../src/Counter.sol";

contract FactureNFTQuantumScript is Script {
    FactureNFTQuantum public counter;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        counter = new FactureNFTQuantum();

        vm.stopBroadcast();
    }
}
