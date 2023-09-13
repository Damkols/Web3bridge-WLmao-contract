// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;


import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract LMAO is ERC20, Ownable {

    address public transferFeeAddr;
    uint256 public transferPercentage = 8;

    constructor(string memory _name, string memory _symbol, address _transferFeeAddr) ERC20(_name, _symbol) {
        uint256 initialSupply = 10000e18;
        _mint(msg.sender, initialSupply * (10 ** 18));
        transferFeeAddr = _transferFeeAddr;
    }
    
    function setPercentageReceiver(address _transferFeeAddr) external onlyOwner {
        require(_transferFeeAddr != address(0), "Pass in a Valid address");
        transferFeeAddr = _transferFeeAddr;
    }

    function setNewTransferPercentage(uint256 _newTransferPercentage) external onlyOwner {
        require(_newTransferPercentage <= 100, "Fee percentage cannot exceed 100%");
        transferPercentage = _newTransferPercentage;
    }

    function transfer(address _to, uint256 _amount) public override returns (bool) {
        require(_to != address(0), "Pass in a Valid address");
        require(_amount > 0, "Amount must be greater than 0");

        uint256 percent = (_amount * transferPercentage) / 100;
        uint256 transferAmount = _amount - percent;

        bool success = super.transfer(_to, transferAmount);
        bool successFee = super.transfer(transferFeeAddr, percent);

        require(success == true, "Transfer failed");
        require(successFee == true, "Transfer precent Fee failed");

        return true;
    }

    function transferFrom(address _from, address _to, uint _amount) public  override returns (bool) {
        require(_from != address(0), "Pass in a Valid address");
        require(_to != address(0), "Pass in a Valid address");
        require(_amount > 0, "Amount must be greater than 0");

        uint256 percent = (_amount * transferPercentage) / 100;
        uint256 transferAmount = _amount - percent;

        bool success = super.transferFrom(_from, _to, transferAmount); 
        bool successFee = super.transferFrom(_from, transferFeeAddr, percent);

        require(success == true, "Transfer failed");
        require(successFee == true, "Transfer precent Fee failed");

        return true;
    }

    function getBalance() external view returns(uint addrBalance) {
        addrBalance = balanceOf(msg.sender);
        return addrBalance;
    }
}