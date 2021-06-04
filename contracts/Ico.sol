//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Ownable.sol";
import "./Token.sol";

contract Ico is Ownable {
    Token private _token; //
    // Address of token buyers
    address payable private _buyers;
    // State variables
    uint256 private _price;
    uint256 private _deadline;

    // Events

    // constructor
    constructor(address tokenAddress, address payable owner_, address payable buyers_, uint256 price_, uint256 delay_) Ownable(owner_) {
        _token = Token(tokenAddress); //
        _buyers = buyers_;
        _price = price_;
        _deadline = block.timestamp + delay_ * 14 days;
    }

    // Modifiers
    modifier onTime {
        require(_deadline <= block.timestamp, "ICO: Only 2 weeks!");
        _;
    }

    // Function declarations below
    receive() external payable {
        _deposit(msg.sender, msg.value);
    }

    function buyTokens(uint256 nbTokens) external payable onTime returns (bool) {
        require(msg.value >= 0, "ICO: Price is not 0 ether");
        require(nbTokens * _price <= msg.value, "ICO: Not enough Ether for purchase");
        uint256 _realPrice = nbTokens * _price;
        uint256 _remaining = msg.value - _realPrice;
        _token.transferFrom(_buyers, msg.sender, nbTokens);
        _buyers.transfer(_realPrice);
        if(_remaining > 0) {
            msg.sender.transfer(_remaining);
        }
        return true;

    }

    function withdraw(uint256 nbTokens, uint256 amount) external payable {
        require(_token > 0, "Token: can not withdraw 0 token");
        uint256 token = nbTokens;
        nbTokens = 0;
        payable(msg.sender).sendValue(amount);
    }

    function getDeadline() public view returns (uint256) {
        require(_deadline >= block.timestamp, "ICO: Deadline has past.");
        return _deadline - block.timestamp; 
    }

    function setBuyers(address account) public {
        return _buyers[account] = !_buyers[account];
    }

    function price() public view returns (uint256) {
        return _price;
    }

}

