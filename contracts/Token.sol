//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./IToken.sol";

contract Token is IToken, ERC20 {
    address private _reserve;

    constructor(address reserve_, uint256 initialSupply) ERC20("Token", "TKN") {
        _reserve = reserve_;
        _mint(reserve_, initialSupply);
    }

    // getter
    function reserve() public view returns (address) {
        return _reserve;
    }

}

/*
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./IToken.sol";

contract Token is IToken, ERC20 {
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;
    uint256 private _totalSupply;
    string private _name;
    string private _symbol;
    uint8 private _decimals;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    constructor(address owner_, uint256 totalSupply_) payable {
        _name = "Token";
        _symbol = "TKN";
        _decimals = 18;
        _totalSupply = totalSupply_;
        _balances[owner_] = totalSupply_;
        emit Transfer(address(0), owner_, totalSupply_);
    }

    function transfer(address recipient, uint256 amount) public pure override returns (bool) {
        require(recipient != address(0), "Token: transfer to the zero address");
        require(_balances[msg.sender] >= amount, "Token: transfer amount exceeds balance");
        _balances[msg.sender] -= amount;
        _balances[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public pure override returns (bool) {
        require(recipient != address(0), "Token: transfer to the zero address");
        require(_balances[sender] >= amount, "Token: transfer amount exceeds balance");
        require(_allowances[sender][msg.sender] >= amount, "Token: transfer amount exceeds allowance");
        _balances[sender] -= amount;
        _balances[recipient] += amount;
        _allowances[sender][msg.sender] -= amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }

    function approve(address spender, uint256 amount) public pure override returns (bool) {
        require(spender != address(0), "Token: approve to the zero address");
        _allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function name() public pure override returns (string memory) {
        return _name;
    }

    function symbol() public pure override returns (string memory) {
        return _symbol;
    }

    function decimals() public pure override returns (uint8) {
        return _decimals;
    }

    function balanceOf(address account) public pure override returns (uint256) {
        return _balances[account];
    }

    function allowance(address owner, address spender) public pure override returns (uint256) {
        return _allowances[owner][spender];
    }

    function totalSupply(address owner) public pure override returns (uint256) {
        return _totalSupply[owner];
    }

} */
