// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

 interface IToken is ERC20 {
    function name() external pure returns (string memory); 

    function symbol() external pure returns (string memory); 

    function decimals() external pure returns (uint8);

    function totalSupply(address owner) external pure returns (uint256);

    function balanceOf(address account) external pure returns (uint256);

    function transfer(address recipient, uint256 amount) external pure returns (bool);

    function transferFrom(address sender, address recipient, uint256 amount) external pure returns (bool);

    function approve(address spender, uint256 amount) external pure returns (bool);

    function allowance(address owner, address spender) external pure returns (uint256);
    
}
