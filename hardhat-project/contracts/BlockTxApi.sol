// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract BlockAndTransactionInfo {
    // 事件：用于记录区块和交易信息
    event BlockInfo(
        uint256 blockNumber,
        uint256 timestamp,
        address miner,
        uint256 gasPrice
    );

    // 函数：获取并记录当前区块和交易信息
    function getBlockAndTransactionInfo() external {
        // 获取当前区块号
        uint256 currentBlockNumber = block.number;

        // 获取当前区块的时间戳
        uint256 currentTimestamp = block.timestamp;

        // 获取当前区块的矿工地址
        address currentMiner = block.coinbase;

        // 获取当前交易的 Gas 价格
        uint256 currentGasPrice = tx.gasprice;

        // 触发事件，记录信息
        emit BlockInfo(currentBlockNumber, currentTimestamp, currentMiner, currentGasPrice);
    }

    // 函数：直接返回当前区块号
    function getBlockNumber() external view returns (uint256) {
        return block.number;
    }

    // 函数：直接返回当前区块的时间戳
    function getTimestamp() external view returns (uint256) {
        return block.timestamp;
    }

    // 函数：直接返回当前区块的矿工地址
    function getMiner() external view returns (address) {
        return block.coinbase;
    }

    // 函数：直接返回当前交易的 Gas 价格
    function getGasPrice() external view returns (uint256) {
        return tx.gasprice;
    }
}