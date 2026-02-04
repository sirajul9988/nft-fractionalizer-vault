// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title FractionalVault
 * @dev Vault that holds an NFT and issues ERC20 fractions.
 */
contract FractionalVault is ERC20, ERC721Holder, Ownable {
    IERC721 public immutable nftCollection;
    uint256 public immutable tokenId;
    bool public isFractionalized;

    event Fractionalized(uint256 supply);
    event Redeemed(address owner);

    constructor(
        address _nftCollection, 
        uint256 _tokenId, 
        string memory _name, 
        string memory _symbol
    ) ERC20(_name, _symbol) Ownable(msg.sender) {
        nftCollection = IERC721(_nftCollection);
        tokenId = _tokenId;
    }

    /**
     * @notice Locks the NFT and mints fractional shares.
     * @param _supply The number of ERC20 fractions to mint.
     */
    function fractionalize(uint256 _supply) external onlyOwner {
        require(!isFractionalized, "Already fractionalized");
        require(nftCollection.ownerOf(tokenId) == msg.sender, "Not the NFT owner");

        isFractionalized = true;
        nftCollection.safeTransferFrom(msg.sender, address(this), tokenId);
        _mint(msg.sender, _supply);

        emit Fractionalized(_supply);
    }

    /**
     * @notice Allows a user with 100% of the supply to burn shares and reclaim the NFT.
     */
    function redeem() external {
        require(balanceOf(msg.sender) == totalSupply(), "Must own all shares");

        _burn(msg.sender, totalSupply());
        isFractionalized = false;
        nftCollection.safeTransferFrom(address(this), msg.sender, tokenId);

        emit Redeemed(msg.sender);
    }
}
