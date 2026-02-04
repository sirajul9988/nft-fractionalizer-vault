# NFT Fractionalizer Vault

Fractionalization lowers the barrier to entry for high-value digital assets. This repository provides a secure mechanism to lock an **ERC-721** token and mint **ERC-20** "fractions" that represent a claim on the underlying asset.



## Features
* **Vaulting Mechanism**: Securely locks the NFT using OpenZeppelin's safe transfer patterns.
* **Proportional Ownership**: Mints a fixed supply of ERC20 tokens to the vault creator.
* **Buyout Logic**: Includes a basic mechanism for users to initiate a buyout to unlock the original NFT.

## How it Works
1. **Deposit**: Owner transfers NFT to the `FractionalVault`.
2. **Fractionalize**: The contract mints $N$ ERC20 tokens representing 100% of the NFT.
3. **Trade**: Fractions can be traded on DEXs like Uniswap.
4. **Redeem**: If a user acquires 100% of the shares, they can burn them to retrieve the NFT.

## License
MIT
