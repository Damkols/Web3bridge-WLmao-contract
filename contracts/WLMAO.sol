// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";


contract WLMAO is IERC20, ERC20, Ownable {

    IERC20 LMAO;

    uint256 public transferPercentage = 8;

    constructor(address _LMAO, string memory name, string memory symbol) ERC20(name, symbol) {
        // _mint(msg.sender, initialSupply * (10 ** uint256(decimals())));
        LMAO = IERC20(_LMAO);
    }
    
     function depositLmao (uint _amount) external {
        require(_amount > 0, "Amount must be greater than 0");
        uint256 percent = (_amount * transferPercentage) / 100;
        uint256 transferAmount = _amount - percent;
        LMAO.transferFrom(msg.sender, address(this), _amount);
        _mint(msg.sender, transferAmount);
     }

    function withdrawLmao (uint _amount) external {
        require(_amount > 0, "Amount must be greater than 0");
        _burn(msg.sender, _amount);
        LMAO.transfer(msg.sender, _amount);
    }

}
