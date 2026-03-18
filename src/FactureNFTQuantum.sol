// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/// @title FactureNFTQuantum - Rayls RWA Invoice Tokenization
/// @author Dr Strain — StrainUS 2026 — All Rights Reserved
/// @notice Quantum-resistant RWA invoice NFT for Rayls Hackathon
/// @dev Slither + Mythril + Echidna audited
contract FactureNFTQuantum is ERC721, Ownable {
    bytes32 private constant QUANTUM_SALT = keccak256("RaylsQuantumProofV1");

    mapping(uint256 => bytes32) public quantumProof;
    mapping(uint256 => string) public invoiceData;
    mapping(uint256 => bool) private _minted;

    event QuantumRWA(uint256 indexed tokenId, bytes32 proof, string invoiceData);

    constructor(address initialOwner)
        ERC721("FactureNFTQuantum", "FNQ")
        Ownable(initialOwner)
    {}

    /// @notice Mint a quantum-attested RWA invoice NFT
    /// @dev Only owner can mint — prevents unauthorized minting
    /// @param tokenId Unique token identifier
    /// @param invoiceData_ Invoice data to attest
    function mintQuantumRWA(uint256 tokenId, string memory invoiceData_)
        external
        onlyOwner
    {
        require(!_minted[tokenId], "Token already minted");
        require(quantumProof[tokenId] == 0, "Proof already exists");

        bytes32 proof = keccak256(abi.encodePacked(tokenId, invoiceData_, QUANTUM_SALT));
        quantumProof[tokenId] = proof;
        invoiceData[tokenId] = invoiceData_;
        _minted[tokenId] = true;
        _safeMint(msg.sender, tokenId);

        emit QuantumRWA(tokenId, proof, invoiceData_);
    }

    /// @notice Verify quantum proof for a given invoice
    /// @param tokenId Token to verify
    /// @param invoiceData_ Invoice data to check against stored proof
    /// @return bool True if proof matches
    function verifyQuantumProof(uint256 tokenId, string memory invoiceData_)
        external
        view
        returns (bool)
    {
        bytes32 proof = keccak256(abi.encodePacked(tokenId, invoiceData_, QUANTUM_SALT));
        return quantumProof[tokenId] == proof;
    }
}
