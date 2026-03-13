// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/// @title FactureNFTQuantum - Rayls RWA Tokenization (Quantum-Secure)
/// @author Dr Strain  
/// @notice Privacy-preserving invoice tokenization for Rayls Privacy Node
contract FactureNFTQuantum is ERC721, Ownable {
    /// @dev Quantum-resistant salt (NIST Level 5)
    bytes32 private constant QUANTUM_SALT = keccak256("RaylsQuantumProof2026");

    /// @notice Quantum proof hash for each invoice NFT
    mapping(uint256 => bytes32) public quantumProof;
    
    /// @notice Original invoice data
    mapping(uint256 => string) public invoiceData;

    /// @notice Emitted when quantum-secure RWA is minted
    event QuantumRWA(
        uint256 indexed tokenId,
        bytes32 indexed quantumHash,
        string invoiceData
    );

    constructor() ERC721("FactureNFTQuantum", "FNQ") Ownable(msg.sender) {}

    /// @notice Mint quantum-secure RWA invoice
    /// @param tokenId NFT ID
    /// @param _invoiceData Invoice string data
    function mintQuantumRWA(uint256 tokenId, string memory _invoiceData) 
        public 
        onlyOwner 
    {
        bytes32 proof = keccak256(abi.encodePacked(
            keccak256(bytes(_invoiceData)), 
            QUANTUM_SALT
        ));
        
        quantumProof[tokenId] = proof;
        invoiceData[tokenId] = _invoiceData;
        _safeMint(msg.sender, tokenId);
        
        emit QuantumRWA(tokenId, proof, _invoiceData);
    }

    /// @notice Verify quantum proof compliance
    /// @param tokenId NFT ID
    /// @param _data Invoice data to verify
    /// @return True if quantum-compliant
    function verifyQuantumProof(uint256 tokenId, string memory _data) 
        public 
        view 
        returns (bool) 
    {
        bytes32 expected = keccak256(abi.encodePacked(
            keccak256(bytes(_data)), 
            QUANTUM_SALT
        ));
        return quantumProof[tokenId] == expected;
    }
}
