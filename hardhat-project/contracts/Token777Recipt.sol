// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "@openzeppelin/contracts/token/ERC777/IERC777Recipient.sol";
import "@openzeppelin/contracts/utils/introspection/ERC1820Implementer.sol";

contract TokenRecipient is IERC777Recipient, ERC1820Implementer {
    IERC1820Registry private _erc1820 = IERC1820Registry(0x1820a4B7618BdE71Dce8cdc73aAB6C95905faD24);
    bytes32 constant private TOKENS_RECIPIENT_INTERFACE_HASH = keccak256("TokensRecipient");

    constructor() {
        _erc1820.setInterfaceImplementer(address(this), TOKENS_RECIPIENT_INTERFACE_HASH, address(this));
    }

    function tokensReceived(
        address operator,
        address from,
        uint256 amount,
        bytes calldata userData,
        bytes calldata operatorData
    ) external override {
        // 自动处理逻辑
        // 例如：记录交易、触发事件等
        emit TokensReceived(operator, from, amount, userData, operatorData);
    }

    event TokensReceived(address indexed operator, address indexed from, uint256 amount, bytes userData, bytes operatorData);
}