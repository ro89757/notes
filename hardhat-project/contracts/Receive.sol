// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ReceiveAndFallback {
    // 事件，用于记录接收到的以太币和错误调用
    event Received(address indexed sender, uint256 amount);
    event FallbackCalled(address indexed sender, bytes data);

    // 接收以太币的函数
    receive() external payable {
        emit Received(msg.sender, msg.value);
    }

    // Fallback 函数
    fallback() external payable {
        // 记录调用的数据
        emit FallbackCalled(msg.sender, msg.data);
        // 可以选择抛出错误，这里我们选择不抛出，仅记录
        // revert("Fallback function called");
    }

    // 一个简单的函数，用于查询合约余额
    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}