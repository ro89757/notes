// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Car {
    uint public speed;

    constructor(uint _speed){
        speed = _speed;
    }
    function drive() virtual public returns(string memory){}
}

contract ElectricCar is Car {
    uint public batteryLevel;

    constructor(uint _speed, uint _batteryLevel) Car(_speed) {
        batteryLevel = _batteryLevel;
    }
    
    function drive() public override returns(string memory){
         if (batteryLevel >= 10) { // 假设每次驾驶消耗 10% 的电量
            batteryLevel -= 10;
            return string(abi.encodePacked("batteryLevel:" , uint2str(batteryLevel)));
        } else {
            return "Not enough battery to drive.";
        }
    }

     // 辅助函数，将 uint 转换为字符串
    function uint2str(uint _i) internal pure returns (string memory) {
        if (_i == 0) {
            return "0";
        }
        uint j = _i;
        uint len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint k = len;
        while (_i != 0) {
            k = k - 1;
            uint8 temp = (48 + uint8(_i - _i / 10 * 10));
            bytes1 b1 = bytes1(temp);
            bstr[k] = b1;
            _i /= 10;
        }
        return string(bstr);
    }
}

