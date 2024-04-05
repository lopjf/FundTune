// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity 0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract DaoToken is ERC20, Ownable, ERC20Permit {

    uint256 claimAmount = 10 * 10 ** 18;
    mapping(address => bool) public claimed;
    
    constructor(address initialOwner) ERC20("FundDAO", "FD") Ownable(initialOwner) ERC20Permit("FundDAO") {}

function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
    function claimFaucet() public {
        require (claimed[msg.sender] == false);
        claimed[msg.sender] = true;
        _mint(msg.sender, claimAmount);
    }
}
