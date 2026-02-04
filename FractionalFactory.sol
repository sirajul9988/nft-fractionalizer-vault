// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./FractionalVault.sol";

/**
 * @title FractionalFactory
 * @dev Factory contract to deploy new FractionalVaults easily.
 */
contract FractionalFactory {
    address[] public vaults;

    function createVault(
        address _nftCollection,
        uint256 _tokenId,
        string memory _name,
        string memory _symbol
    ) external returns (address) {
        FractionalVault newVault = new FractionalVault(
            _nftCollection,
            _tokenId,
            _name,
            _symbol
        );
        newVault.transferOwnership(msg.sender);
        vaults.push(address(newVault));
        return address(newVault);
    }
}
