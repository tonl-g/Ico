//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol";
import "./Ownable.sol";
import "./IToken.sol";

contract Ico is Ownable {
    // Address of token seller
    address payable private _owner;
    address payable private _buyers;
    // State variables
    mapping(address => uint256) private _balances;
    mapping (address => mapping (address => uint256)) private _allowances;
    IToken private _token;
    uint256 private _price;
    uint256 private _deadline;

    // Events

    // constructor
    constructor(address tokenAddress, address payable owner_, address payable buyers_, uint256 price_, uint256 delay_) Ownable(owner_) {
        _token = IToken(tokenAddress);
        _owner = owner_;
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
        _buyers[account] = !_buyers[account];
    }


    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

    function allowance(address owner_, address spender) public view returns (uint256) {
        return _allowances[owner_][spender];
    }

    function _deposit(address sender, uint256 amount) private {
        _balances[sender] += amount;
    }

}

