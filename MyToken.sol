// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract DevToken is ERC20{
    constructor() ERC20("NYUDEV", "NYUD"){
        _mint(msg.sender,1000*10**18);
    }
}

