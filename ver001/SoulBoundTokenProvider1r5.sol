// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
// import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract SoulBoundTokenProvider1r5 is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;
    
    event Attest(address indexed to, uint256 indexed tokenId);
    event Revoke(address indexed to, uint256 indexed tokenId);

    uint256 public tokenId;
    string _uri;
    address public owner;

    constructor() ERC721("SoulBoundTokenProvider1r5", "SBTP1r5") {
        owner = msg.sender;
        _uri = "QmUexBhr4DB669C4ytpTBVfRBEuVe31z4uDGJ98SjnZEwz";
    }

    function safeMint(address to) public {
        tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        // _safeMint(to);
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, _uri);
    }

    function _beforeTokenTransfer(address from, address to, uint256) pure internal override{
        require(from == address(0) || to == address(0), "Not allowed to transfer token");
    }

    function _afterTokenTransfer(address from, address to, uint256 tknId) internal override{

        if (from == address(0)) {
            emit Attest(to, tknId);
        } else if (to == address(0)) {
            emit Revoke(to, tknId);
        }
    }

    // function tokenURI(uint256 tknId)
    //     public
    //     view
    //     override(ERC721, ERC721URIStorage)
    //     returns (string memory)
    // {
    //     return super.tokenURI(tknId);
    // }

    // function supportsInterface(bytes4 interfaceId)
    //     public
    //     view
    //     override(ERC721, ERC721URIStorage)
    //     returns (bool)
    // {
    //     return super.supportsInterface(interfaceId);
    // }
}