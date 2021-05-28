//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol";
import "./Ownable.sol";
import "./IToken.sol";

contract Ico is Ownable {
    IToken private _token;

    // library usage
    using Address for address payable;

    // State variables
    mapping(address => uint256) private _balances;
    mapping (address => mapping (address => uint256)) private _allowances;
    mapping(address => bool) private _buyers;
    uint256 private _deadline;

    // Events

    // constructor
    constructor(address tokenAddress, address owner_, uint256 delay_) Ownable(owner_) {
        _token = IToken(tokenAddress);
        _owner = owner_;
        _deadline = block.timestamp + delay_ * 14 days;
    }

    // Modifiers
    modifier onTime {
        require(_deadline <= block.timestamp, "ICO: 2 weeks!");
        _;
    }

    // Function declarations below
    receive() external payable {
        _deposit(msg.sender, msg.value);
    }

    function buyTokens() external payable {

    }

    function withdraw() external payable {

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

