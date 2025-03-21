// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "@openzeppelin/contracts/token/ERC777/ERC777.sol";
import "@openzeppelin/contracts/token/ERC777/extensions/ERC777Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/introspection/IERC1820Registry.sol";

contract MyToken is ERC777, ERC777Burnable, Ownable {
    IERC1820Registry private _erc1820 = IERC1820Registry(0x1820a4B7618BdE71Dce8cdc73aAB6C95905faD24);
    bytes32 constant private TOKENS_RECIPIENT_INTERFACE_HASH = keccak256("TokensRecipient");

    constructor(address[] memory defaultOperators) ERC777("MyToken", "MTK", defaultOperators) {}

    function operatorSend(
        address sender,
        address recipient,
        uint256 amount,
        bytes calldata data,
        bytes calldata operatorData
    ) external {
        require(isOperatorFor(msg.sender, sender), "ERC777: caller is not an operator for sender");
        _send(sender, recipient, amount, data, operatorData);
    }

    function isOperatorFor(address operator, address account) public view returns (bool) {
        return hasRole(DEFAULT_ADMIN_ROLE, operator) || getOperator(account) == operator;
    }

    function _callTokensReceived(
        address operator,
        address from,
        address to,
        uint256 amount,
        bytes calldata userData,
        bytes calldata operatorData,
        bool preventLocking
    ) internal override {
        super._callTokensReceived(operator, from, to, amount, userData, operatorData, preventLocking);

        if (to.code.length > 0) {
            try IERC777Recipient(to).tokensReceived(operator, from, amount, userData, operatorData) {
                // Hook executed successfully
            } catch {
                revert("ERC777: tokensReceived rejected");
            }
        }
    }
}