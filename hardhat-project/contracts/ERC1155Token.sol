// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract MultiTypeToken is ERC1155, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _nonFungibleTokenIds; // 计数器用于生成唯一的非同质化代币ID

    // 定义代币类型
    uint256 public constant TOKEN_TYPE_FUNGIBLE = 0; // 同质化代币类型ID
    uint256 public constant TOKEN_TYPE_NON_FUNGIBLE = 1; // 非同质化代币类型ID

    // 非同质化代币的元数据URI前缀
    string private _baseTokenURI;

    // 构造函数，初始化ERC1155合约并设置基础URI
    constructor(string memory baseURI) ERC1155("") {
        _baseTokenURI = baseURI;
    }

    // 设置基础URI的函数，只有合约所有者可以调用
    function setBaseURI(string memory baseURI) public onlyOwner {
        _baseTokenURI = baseURI;
    }

    // 获取基础URI的函数
    function _baseURI() internal view override returns (string memory) {
        return _baseTokenURI;
    }

    // 铸造同质化代币的函数，只有合约所有者可以调用
    function mintFungible(address to, uint256 amount) public onlyOwner {
        _mint(to, TOKEN_TYPE_FUNGIBLE, amount, ""); // 基础URI为空，因为同质化代币不需要单独的URI
    }

    // 铸造单个非同质化代币的函数，只有合约所有者可以调用
    function mintNonFungible(address to, string memory uri) public onlyOwner {
        uint256 tokenId = _nonFungibleTokenIds.current(); // 获取当前计数器值作为Token ID
        _nonFungibleTokenIds.increment(); // 增加计数器
        _mint(to, TOKEN_TYPE_NON_FUNGIBLE + tokenId, 1, uri); // Token ID需要偏移，避免与同质化代币ID冲突
    }

    // 批量铸造非同质化代币的函数，只有合约所有者可以调用
    function mintMultipleNonFungible(address to, string[] memory uris) public onlyOwner {
        for (uint256 i = 0; i < uris.length; i++) {
            mintNonFungible(to, uris[i]); // 调用单个铸造函数
        }
    }

    // 覆盖uri函数，为非同质化代币提供元数据URI
    function uri(uint256 id) public view override returns (string memory) {
        require(id >= TOKEN_TYPE_NON_FUNGIBLE, "Fungible tokens do not have individual URIs");
        uint256 nonFungibleId = id - TOKEN_TYPE_NON_FUNGIBLE; // 计算实际的非同质化代币ID
        return string(abi.encodePacked(_baseTokenURI, nonFungibleId.toString(), ".json"));
    }

    // 批量转移代币的函数，实现安全批量转移
    function safeBatchTransferFrom(
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) public override {
        // 调用父类的safeBatchTransferFrom实现批量转移
        super.safeBatchTransferFrom(from, to, ids, amounts, data);
    }

    // 获取合约中所有非同质化代币的总供应量（简化实现）
    function totalNonFungibleSupply() public view returns (uint256) {
        return _nonFungibleTokenIds.current();
    }
}