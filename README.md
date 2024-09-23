# DegenToken - ERC20 Token Contract

DegenToken (DGN) is an ERC20 token contract built using OpenZeppelin's libraries. It includes functionality for minting, burning, and redeeming tokens for game items, along with utility functions for tracking token usage.

## Features

- **ERC20 Standard**: Implements the standard ERC20 functionality for transfers, approvals, and balance management.
- **Minting**: The contract owner can mint new tokens.
- **Burning**: Any user can burn their tokens.
- **Token Redemption**: Users can redeem tokens for in-game items, with different token costs for each item.
- **Token Usage Tracking**: Tracks the total tokens redeemed by each user and allows retrieval of redemption details.

## Functions

- **mint(address to, uint256 amount)**: Owner can mint tokens to a specified address.
- **burn(uint256 amount)**: Users can burn their tokens.
- **redeem(uint256 amount, uint256 RedeemItem)**: Redeem tokens for specific game items. Item 1 costs 50 tokens, item 2 costs 100 tokens, and item 3 costs 200 tokens.
- **getRedeemedItems(address account)**: Retrieves the list of redeemed items for a given account.
- **getTotalTokensRedeemed(address account)**: Returns the total tokens redeemed by a user.
- **printRedeemedTokens(address account)**: Outputs the redeemed tokens with details for a specific user.
- **checkBalance(address account)**: Checks the balance of an account.
- **transferTokens(address from, address to, uint256 amount)**: Transfers tokens between accounts, respecting allowances.

## Example Usage

- **Minting**: The owner can mint tokens:
    ```solidity
    mint(0xAddress, 1000);
    ```

- **Burning**: Any user can burn tokens:
    ```solidity
    burn(100);
    ```

- **Redeeming**: Users can redeem tokens for game items:
    ```solidity
    redeem(1, 2); // Redeem item 2, costing 100 tokens
    ```

## License

This project is licensed under the MIT License.


### Author
Diksha
