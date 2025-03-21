// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract Error{
    uint256 public balance;
    error ExternalCallFailed();

    constructor(uint256 initBalance){
        require(initBalance >= 0,"inintBalance cannot be nagetive");
        balance = initBalance;
    }
    //存款
    function deposit(uint256 amount) external{
        require(amount > 0,"amount must be greater than zero");
        balance += amount;
    }
    //取款
    function withdraw(uint256 amount) external{
        require(amount > 0,"withdrawal amount must be greater than zero");
        require(amount <= balance,"insuffcient balance");
        balance -= amount;
    }
    // 检查余额是否为零
    function checkBalance() external view returns (bool) {
        // 使用 assert 检查内部逻辑错误
        assert(balance >= 0); // 这里假设余额不应该为负数，如果为负数则说明有内部错误
        return balance == 0;
    }

    // 强制回滚交易
    function forceRevert() external pure {
        revert("This transaction is being reverted forcefully");
    }

    // 除法函数，展示如何处理除以零的情况
    function divide(uint256 numerator, uint256 denominator) external pure returns (uint256) {
        require(denominator != 0, "Denominator cannot be zero");
        return numerator / denominator;
    }
    // 调用外部合约的函数，使用 try/catch 捕获异常
    function callExternalContract(address target, bytes memory data) external returns (bool success, bytes memory result) {
        (success, result) = target.call(data); // 调用外部合约
        if (!success) {
            revert ExternalCallFailed(); // 捕获失败并回滚
        }
    }

    // 使用 try/catch 处理外部调用异常
    function safeCallExternalContract(address target, bytes memory data) external returns (bool success, bytes memory result) {
        try this.callExternalContract(target, data) returns (bool callSuccess, bytes memory callResult) {
            success = callSuccess;
            result = callResult;
        } catch Error(string memory reason) {
            // 捕获 revert 或 require 抛出的错误
            revert(string(abi.encodePacked("External call failed: ", reason)));
        } catch {
            revert("unknown error:");
        }
    }
}