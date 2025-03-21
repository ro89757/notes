// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract ABIEncodingDecodingExample {
    // 编码函数：接收多个参数并返回编码后的字节数组
    function encodeData(
        uint256 number,
        string memory text,
        address account,
        bool flag
    ) external pure returns (bytes memory) {
        // 使用 abi.encode 将参数编码为字节数组
        return abi.encode(number, text, account, flag);
    }

    // 解码函数：接收字节数组并解码为原始值
    function decodeData(bytes memory data)
        external
        pure
        returns (
            uint256 number,
            string memory text,
            address account,
            bool flag
        )
    {
        // 使用 abi.decode 将字节数组解码为原始值
        // 注意：解码时需要指定参数的类型和顺序
        (number, text, account, flag) = abi.decode(data, (uint256, string, address, bool));
    }
    //remix 测试
// 0:uint256: number 333
// 1:
// string: text world
// 2:
// address: account 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
// 3:
// bool: flag false
    //0x000000000000000000000000000000000000000000000000000000000000014d00000000000000000000000000000000000000000000000000000000000000800000000000000000000000005b38da6a701c568545dcfcb03fcb875f56beddc400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000005776f726c64000000000000000000000000000000000000000000000000000000
}