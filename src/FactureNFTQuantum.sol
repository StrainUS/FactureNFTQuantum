// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/// @title FactureNFTQuantum - Rayls RWA (Slither Audited)
/// @author Dr Strain IP ⚖️ Patent Pending
contract FactureNFTQuantum is ERC721, Ownable {
    bytes32 private constant QUANTUM_SALT = keccak256("RaylsQuantumProofV1");
    mapping(uint256 => bytes32) public quantumProof;
    mapping(uint256 => string) public invoiceData;

    constructor(address initialOwner) 
        ERC721("FactureNFTQuantum", "FNQ") 
        Ownable(initialOwner) 
    {}

    function mintQuantumRWA(uint256 tokenId, string memory invoiceData_) external {
        require(quantumProof[tokenId] == 0, "Proof exists");
        
        bytes32 proof = keccak256(abi.encodePacked(tokenId, invoiceData_, QUANTUM_SALT));
        quantumProof[tokenId] = proof;
        invoiceData[tokenId] = invoiceData_;
        _safeMint(msg.sender, tokenId);
        
        emit QuantumRWA(tokenId, proof, invoiceData_);
    }

    function verifyQuantumProof(uint256 tokenId, string memory invoiceData_) 
        external view returns (bool) 
    {
        bytes32 proof = keccak256(abi.encodePacked(tokenId, invoiceData_, QUANTUM_SALT));
        return quantumProof[tokenId] == proof;
    }

    event QuantumRWA(uint256 indexed tokenId, bytes32 proof, string invoiceData);
}
