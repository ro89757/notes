// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ArrayUtils.sol";

contract ArrayContract {
    using ArrayUtils for uint256[];

    uint256[] public numbers;

    /// @notice 添加一个数字到数组
    /// @param num 要添加的数字
    function addNumber(uint256 num) public {
        numbers.push(num);
    }

    /// @notice 检查数组中是否包含某个数字
    /// @param num 要检查的数字
    /// @return 是否包含
    function hasNumber(uint256 num) public view returns (bool) {
        return numbers.contains(num);
    }

    /// @notice 获取某个数字在数组中的索引
    /// @param num 要查找的数字
    /// @return 索引，如果不存在则返回数组长度
    function getNumberIndex(uint256 num) public view returns (uint256) {
        return numbers.indexOf(num);
    }

    /// @notice 删除数组中的某个数字
    /// @param num 要删除的数字
    /// @return 是否删除成功
    function removeNumber(uint256 num) public returns (bool) {
        return numbers.remove(num);
    }
}