# FactureNFTQuantum

**Quantum-resistant RWA invoice tokenization — Rayls Hackathon**

by StrainUS (Dr Strain) — All Rights Reserved 2026

---

## What it does

Mints invoice-backed NFTs with quantum-resistant cryptographic proofs on the Rayls ecosystem. Each NFT represents a real invoice with a commitment that proves authenticity without revealing sensitive data.

## Smart Contracts

| Contract | Description |
|---|---|
| FactureNFTQuantum.sol | ERC-721 with quantum proof — onlyOwner mint |
| AIFactureAttestation.sol | On-chain AI attestation event emitter |

## Security

- onlyOwner protection on mintQuantumRWA
- Double keccak256 with QUANTUM_SALT
- verifyQuantumProof public function
- Slither + Mythril + Echidna audited

## Audit Status

| Tool | Status |
|---|---|
| Slither | PASS |
| Mythril | PASS |
| Echidna | PASS |

## Deploy
```bash
forge build
forge test
forge create src/FactureNFTQuantum.sol:FactureNFTQuantum --rpc-url https://testnet-rpc.rayls.com --private-key YOUR_KEY --broadcast --constructor-args YOUR_ADDRESS
```

## Ecosystem

| Component | Repo |
|---|---|
| Frontend | https://github.com/StrainUS/rayls-marketplace-hackathon |
| MVP Origin | https://github.com/StrainUS/rayls-facture-hackathon |
| RLS Token | https://github.com/StrainUS/rayls-facture-hackathon-v2 |

---

Copyright 2026 StrainUS — All Rights Reserved
