// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity 0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract StableCoin is ERC20, Ownable, ERC20Permit {
    
    uint256 faucetAmount = 10000 * 10 ** 6;
    constructor(address initialOwner) ERC20("StableCoin", "SC") Ownable(initialOwner) ERC20Permit("StableCoin") {}

    function decimals() public pure override returns (uint8) {
        return 6;
    }
    function mint() public {
        _mint(msg.sender, faucetAmount);
    }
    
}