// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// Define your ERC20 token contract
contract NomCoin is ERC20 {
    // Define the global variables for balances, total supply, name, and symbol below
    address private owner;

    uint private MaxTotalSupply = 5000000000e18;
    uint public _totalSupply;


    // Constructor that mints the initial supply to the deployer of the contract
    constructor(uint256 initialSupply) ERC20("NomCoin", "NCN") {
        // Mint the initial supply of tokens to the deployer's address
        owner = msg.sender;
        if(_totalSupply > MaxTotalSupply) revert totalSupplyMaxedOut();

        _totalSupply += initialSupply;

        _mint(msg.sender, initialSupply);
    }

    // Custom Error
    error onlyOwnerFunction();
    error notAccountOwner();
    error totalSupplyMaxedOut();

    // Checker Functions
    function confirmSupply() private view {
        if(_totalSupply > MaxTotalSupply) revert totalSupplyMaxedOut();
    }

    // Function to mint new tokens to a specified address
    function mint(address to, uint256 amount) public {
        // Implement the mint function using the _mint internal function
        if(to != owner) revert onlyOwnerFunction();
        _totalSupply += amount;

        confirmSupply();

        _mint(to, amount);
    }

    // Function to burn tokens from a specified address
    function burn(address from, uint256 amount) public {
        // Implement the burn function using the _burn internal function
        if(msg.sender != from) revert notAccountOwner();

        _burn(from, amount);
    }

    // Function to transfer tokens from the caller's address to a specified address
    function transfer(address to, uint256 amount) public override returns (bool) {
        // Implement the transfer function using the _transfer internal function
        _transfer(msg.sender, to, amount);

        return true;
    }

    // Function to approve an address to spend a certain amount of tokens on behalf of the caller
    function approve(address spender, uint256 amount) public override returns (bool) {
        // Implement the approve function using the _approve internal function
        _approve(owner, spender, amount, true);

        return true;
    }

    // Function to transfer tokens from one address to another using an allowance
    function transferFrom(address from, address to, uint256 amount) public override returns (bool) {
        // Implement the transferFrom function using the _transfer and _approve internal functions
        _approve(from, to, amount, true);
        _transfer(from, to, amount);

        return true;
    }

    function getBalanceOf(address account) public view returns (uint256) {
        // Implement the getBalanceOf function
        return balanceOf(account);
    }
}