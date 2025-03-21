// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";


contract VirtualCollectible is ERC721URIStorage, ERC721Enumerable, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("VirtualCollectible", "VCL") {}

    /**
     * @dev 铸造一个新的NFT，并设置其元数据URI。
     * @param to 接收NFT的地址。
     * @param tokenURI 该NFT的元数据URI。
     */
    function mint(address to, string memory tokenURI) public onlyOwner {
    _tokenIdCounter.increment(); // 先增加计数器，ID从1开始
    uint256 tokenId = _tokenIdCounter.current(); // 获取新的ID
    _safeMint(to, tokenId); // 铸造NFT
    _setTokenURI(tokenId, tokenURI); // 设置元数据URI
}
    /**
     * @dev 重写 _beforeTokenTransfer 函数以确保可枚举性。
     * 这是 ERC721Enumerable 接口所要求的。
     */
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    /**
     * @dev 重写 supportsInterface 函数以支持 ERC721Enumerable 接口。
     */
    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    /**
     * @dev 获取当前合约中NFT的总数。
     * @return NFT的总数。
     */
    function totalSupply() public view returns (uint256) {
        return _tokenIdCounter.current();
    }
}