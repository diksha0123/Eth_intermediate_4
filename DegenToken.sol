// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DEGEN is ERC20, Ownable {
    struct RedeemedItem {
        uint256 amount;          
        uint256 tokensRedeemed;  
    }

    event TokensRedeemed(address indexed redeemer, uint256 amount, uint256 tokensRedeemed);

    uint256 public tokenCost = 1; 

    mapping(address => RedeemedItem[]) private redeemedItems;

    constructor() ERC20("DEGEN", "DEG") Ownable(msg.sender) {
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }

    function mint(address to, uint256 amount) public onlyOwner {
        require(to != address(0), "Cannot mint to zero address");
        require(amount > 0, "Mint amount must be greater than zero");
        _mint(to, amount);
    }

    function burn(uint256 amount) public {
        require(amount > 0, "Burn amount must be greater than zero");
        _burn(msg.sender, amount);
    }

    function redeem(uint256 amount) public {
        require(amount > 0, "Redeem amount must be greater than zero");
        uint256 cost = amount * tokenCost;
        require(balanceOf(msg.sender) >= cost, "Insufficient token balance");

        _burn(msg.sender, cost);

        redeemedItems[msg.sender].push(RedeemedItem({
            amount: amount,
            tokensRedeemed: cost
        }));

        emit TokensRedeemed(msg.sender, amount, cost);
    }

    function getRedeemedItems(address account) public view returns (RedeemedItem[] memory) {
        require(account != address(0), "Query for zero address");
        return redeemedItems[account];
    }

    function printRedeemedTokens(address account) public view returns (string memory) {
        require(account != address(0), "Query for zero address");
        RedeemedItem[] memory items = redeemedItems[account];
        require(items.length > 0, "No redeemed tokens found");

        string memory result = "";
        for (uint256 i = 0; i < items.length; i++) {
            result = string(abi.encodePacked(
                result,
                "Redemption ", uintToString(i + 1), ": ", 
                "Amount: ", uintToString(items[i].amount), 
                " Tokens Redeemed: ", uintToString(items[i].tokensRedeemed), 
                "\n"
            ));
        }
        return result;
    }

    function uintToString(uint256 v) internal pure returns (string memory) {
        if (v == 0) {
            return "0";
        }
        uint256 digits;
        uint256 temp = v;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (v != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(v % 10)));
            v /= 10;
        }
        return string(buffer);
    }

    function checkBalance(address account) public view returns (uint256) {
        require(account != address(0), "Query for zero address");
        return balanceOf(account);
    }

    function transferTokens(address from, address to, uint256 amount) public {
        require(amount > 0, "Transfer amount must be greater than zero");
        require(from != address(0), "Cannot transfer from zero address");
        require(to != address(0), "Cannot transfer to zero address");

        if (from == msg.sender) {
            _transfer(from, to, amount);
        } else {
            uint256 currentAllowance = allowance(from, msg.sender);
            require(currentAllowance >= amount, "Transfer amount exceeds allowance");
            _approve(from, msg.sender, currentAllowance - amount);
            _transfer(from, to, amount);
        }
    }
}