// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test, console} from "forge-std/Test.sol";
import {FactureNFTQuantum} from "../src/FactureNFTQuantum.sol";

contract FactureNFTQuantumTest is Test {
    FactureNFTQuantum nft;
    address owner;

    bytes32 constant RAYLS_QUANTUM_SALT = keccak256("RaylsQuantumProof2026");

    function setUp() public {
        owner = makeAddr("owner");
        vm.prank(owner);
        nft = new FactureNFTQuantum();
    }

    function testMintQuantumRWA() public {
        string memory invoice = "FACTURE #123 - 1000 EUR";
        bytes32 expectedProof = keccak256(abi.encodePacked(keccak256(bytes(invoice)), RAYLS_QUANTUM_SALT));

        vm.expectEmit(true, true, true, true, address(nft));
        emit FactureNFTQuantum.QuantumMint(1, expectedProof);
        
        vm.prank(owner);
        nft.mintQuantumRWA(1, invoice);

        assertEq(nft.ownerOf(1), owner);
        assertEq(nft.quantumProof(1), expectedProof);
        assertTrue(nft.verifyQuantum(1, invoice));
    }
}
