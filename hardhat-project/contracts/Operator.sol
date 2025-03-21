// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./MyToken777.sol";

contract Operator is Ownable {
    MyToken public token;

    constructor(address tokenAddress) {
        token = MyToken(tokenAddress);
    }

    function setToken(address _tokenAddress) external onlyOwner {
        token = MyToken(_tokenAddress);
    }

    function operatorSend(
        address sender,
        address recipient,
        uint256 amount,
        bytes calldata data,
        bytes calldata operatorData
    ) external {
        require(owner() == msg.sender || isOperator(msg.sender), "Operator: caller is not the owner or an operator");
        token.operatorSend(sender, recipient, amount, data, operatorData);
    }

    function isOperator(address account) public view returns (bool) {
        return owner() == account || hasRole(DEFAULT_ADMIN_ROLE, account);
    }
}