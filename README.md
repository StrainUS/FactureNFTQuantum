# FactureNFTQuantum

[![License: Proprietary](https://img.shields.io/badge/License-Proprietary-red.svg)](./LICENSE)
[![Solidity](https://img.shields.io/badge/Solidity-0.8.24-blue)](https://soliditylang.org/)
[![OpenZeppelin](https://img.shields.io/badge/OpenZeppelin-v5-blue)](https://openzeppelin.com/)
[![Foundry](https://img.shields.io/badge/Built_with-Foundry-orange)](https://book.getfoundry.sh/)
[![Rayls](https://img.shields.io/badge/Rayls-Testnet-purple)](https://testnet-explorer.rayls.com/)
[![Audit](https://img.shields.io/badge/Slither-PASS-brightgreen)](./slither-audit.md)

> **Quantum-resistant invoice NFT tokenization on the Rayls ecosystem**

Built by [StrainUS (Dr Strain)](https://github.com/StrainUS) — All Rights Reserved 2026

---

## What Is This?

FactureNFTQuantum mints invoice-backed NFTs with quantum-resistant cryptographic proofs on the Rayls blockchain. Each NFT represents a real invoice and includes a cryptographic commitment that proves authenticity without revealing sensitive financial data.

This project is part of the StrainUS Rayls ecosystem — a suite of tools for privacy-preserving RWA tokenization.

---

## Why Quantum-Resistant?

Standard blockchain signatures (ECDSA) are vulnerable to quantum computers. FactureNFTQuantum uses a double-keccak256 commitment scheme with a QUANTUM_SALT to future-proof invoice authenticity proofs — making forgery computationally infeasible even against quantum adversaries.

---

## Smart Contracts

| Contract | Description | Key Feature |
|---|---|---|
| `FactureNFTQuantum.sol` | Main ERC-721 invoice NFT | Quantum-resistant proof + onlyOwner mint |
| `AIFactureAttestation.sol` | On-chain AI attestation | Event emitter for AI agent signatures |

---

## Key Features

- `onlyOwner` protection on `mintQuantumRWA` — prevents unauthorized minting
- Double `keccak256` commitment with `QUANTUM_SALT` — quantum-resistant proof
- `verifyQuantumProof(tokenId, value)` — public verification function
- `AIAttestation` event — on-chain proof of AI agent involvement
- Full NatSpec documentation

---

## Security Audit

| Tool | Status | What It Checks |
|---|---|---|
| Slither | ✅ PASS | Static analysis — reentrancy, access control, overflow |
| Mythril | ✅ PASS | Symbolic execution — integer bugs, dangerous calls |
| Echidna | ✅ PASS | Fuzzing — invariant violations, edge cases |

See [slither-audit.md](slither-audit.md) for full report.

---

## Deploy on Rayls Testnet
```bash
# Build
forge build

# Test
forge test -v

# Deploy
forge create src/FactureNFTQuantum.sol:FactureNFTQuantum \
  --rpc-url https://testnet-rpc.rayls.com \
  --private-key YOUR_PRIVATE_KEY \
  --broadcast \
  --constructor-args YOUR_ADDRESS
```

**Network:** Rayls Testnet | Chain ID: 7295799 | Gas: USDr
**Faucet:** https://devnet-dapp.rayls.com

---

## How It Works

1. Owner calls `mintQuantumRWA(to, invoiceValue, invoiceId)`
2. Contract computes `quantumHash = keccak256(keccak256(value + QUANTUM_SALT))`
3. NFT is minted with the quantum commitment stored on-chain
4. Anyone can call `verifyQuantumProof(tokenId, value)` to verify authenticity
5. `AIAttestation` event is emitted — logged permanently on Rayls

---

## Ecosystem

This repo is part of the StrainUS Rayls suite:

| Component | Description | Link |
|---|---|---|
| RWA Protocol | Full Privacy Node + AI compliance pipeline | [rayls-hackathon-rwa-privacy](https://github.com/StrainUS/rayls-hackathon-rwa-privacy) |
| Marketplace Frontend | React UI for NFT trading | [rayls-marketplace-hackathon](https://github.com/StrainUS/rayls-marketplace-hackathon) |
| MVP Foundry | Original invoice NFT MVP | [rayls-facture-hackathon](https://github.com/StrainUS/rayls-facture-hackathon) |
| RLS Token | Deflationary ERC-20 on Rayls | [rayls-facture-hackathon-v2](https://github.com/StrainUS/rayls-facture-hackathon-v2) |
| QuantumShield | Post-quantum wallet | [quantumshield-deck](https://github.com/StrainUS/quantumshield-deck) |

---

Copyright 2026 StrainUS (Dr Strain) — All Rights Reserved
