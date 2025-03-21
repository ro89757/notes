// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

library ArrayUtils {
    /// @notice 检查数组中是否包含某个元素
    /// @param self 数组引用
    /// @param value 要查找的元素
    /// @return 是否包含该元素
    function contains(uint256[] storage self, uint256 value) internal view returns (bool) {
        for (uint256 i = 0; i < self.length; i++) {
            if (self[i] == value) {
                return true;
            }
        }
        return false;
    }

    /// @notice 获取数组中第一个匹配的元素索引，如果不存在则返回数组长度
    /// @param self 数组引用
    /// @param value 要查找的元素
    /// @return 索引或数组长度
    function indexOf(uint256[] storage self, uint256 value) internal view returns (uint256) {
        for (uint256 i = 0; i < self.length; i++) {
            if (self[i] == value) {
                return i;
            }
        }
        return self.length;
    }

    /// @notice 删除数组中的第一个匹配元素，并返回是否删除成功
    /// @param self 数组引用
    /// @param value 要删除的元素
    /// @return 是否删除成功
    function remove(uint256[] storage self, uint256 value) internal returns (bool) {
        for (uint256 i = 0; i < self.length; i++) {
            if (self[i] == value) {
                // 将最后一个元素移动到当前位置
                self[i] = self[self.length - 1];
                self.pop();
                return true;
            }
        }
        return false;
    }
}