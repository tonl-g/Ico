//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Address.sol";
import "./Ownable.sol";
import "./Token.sol";

contract ICO is Ownable {
    using Address for address payable;

    Token private _token; //
    address private _owner;
    // State variables
    uint256 private _price;
    uint256 private _nbTokens;
    uint256 private _deadline;

    // Events
     event Bought(address indexed sender, uint256 amount);
    event Withdrawed(address indexed sender, uint256 amount);

    // constructor
    constructor(address tokenAddress, address owner_, address payable buyers_, uint256 price_) Ownable(owner_) {
        _token = Token(tokenAddress); //
        _owner = owner_;
        _buyers = buyers_;
        _price = price_;
        _deadline = block.timestamp;
    }

    // Modifiers
    modifier onTime {
        require(block.timestamp >= _deadline + 2 * 1 weeks, "ICO: Only 2 weeks!");
        _;
    }

    // Function declarations below
    receive() external payable {
        _buyTokens(msg.sender, msg.value);
    }

    function buyTokens() public payable {
        _buyTokens(msg.sender, msg.value);
    }

    function _buyTokens(address payable buyers_, uint256 nbTokens_, uint256 amount) public payable onTime {
        require(msg.value >= 0, "ICO: Price is not 0 ether");
        require(nbTokens_ * _price <= msg.value, "ICO: Not enough Ether for purchase");
        _nbTokens += amount;
        _token.transferFrom(buyers_, msg.sender, amount);
        emit Bought(msg.sender, amount);
    }

    function withdraw(uint256 amount) external payable onTime {
        uint256 balances = address(this).balance;
        payable(msg.sender).sendValue(amount);
        emit Withdrawed(msg.sender, balances);
    }

    function token() public view returns (Token) {
        return _token;
    }

    function price() public view returns (uint256) {
        return _price;
    }

    function nbTokens() public view returns (uint256) {
        return _nbTokens;
    }

    function gain() public view returns (uint256) {
        return _nbTokens * _price;
    }

}

