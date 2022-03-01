// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/*********************************************************************************************************************
████████╗██╗    ██╗██╗███████╗████████╗███████╗██████╗ ████████╗███████╗ ██████╗██╗  ██╗   ██╗    ██╗████████╗███████╗
╚══██╔══╝██║    ██║██║██╔════╝╚══██╔══╝██╔════╝██╔══██╗╚══██╔══╝██╔════╝██╔════╝██║  ██║   ██║    ██║╚══██╔══╝██╔════╝
   ██║   ██║ █╗ ██║██║███████╗   ██║   █████╗  ██║  ██║   ██║   █████╗  ██║     ███████║   ██║ █╗ ██║   ██║   █████╗  
   ██║   ██║███╗██║██║╚════██║   ██║   ██╔══╝  ██║  ██║   ██║   ██╔══╝  ██║     ██╔══██║   ██║███╗██║   ██║   ██╔══╝  
   ██║   ╚███╔███╔╝██║███████║   ██║   ███████╗██████╔╝   ██║   ███████╗╚██████╗██║  ██║██╗╚███╔███╔╝   ██║   ██║     
   ╚═╝    ╚══╝╚══╝ ╚═╝╚══════╝   ╚═╝   ╚══════╝╚═════╝    ╚═╝   ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝ ╚══╝╚══╝    ╚═╝   ╚═╝     
   Project Name: Narcissus
   Creator: D'Lacie Jeanne
   Contract Developer: Stinky (@nomamesgwei)
*********************************************************************************************************************/

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";

contract Narcissus is ERC721, Ownable, Pausable, ERC721Enumerable, ERC721Burnable {
    using Counters for Counters.Counter;

    // @notice Counter for number of minted characters
    Counters.Counter public _tokenIds;    
    // Max Supply of Narcissus
    uint256 public immutable maxSupply = 100;
    // Base URI used for token metadata
    string private _baseTokenUri;     

    constructor(
        string memory name,
        string memory symbol,
        string memory _tokenURI
    ) ERC721(name, symbol) {
        _baseTokenUri = _tokenURI;

        // 0-99 = 100 total NFTs
        for(uint256 i = 0; i < 100; i++)
        {
            _tokenIds.increment();
            _safeMint(_msgSender(), _tokenIds.current());
        }        
    }

    /*
     * @notice set the baseURI
     * @param baseURI
     */  
    function setBaseURI(string memory baseURI) public onlyOwner {
        _baseTokenUri = baseURI;
    }  

    /* @notice Pause Degen Dwarf minting */  
    function pauseMinting() external onlyOwner {
        _pause();
    }

    /* @notice Resume Degen Dwarf minting*/  
    function unpauseMinting() external onlyOwner {
        _unpause();
    }   

    /* @notice Withdraw funds in Degen Dwarfs contract*/  
    function withdraw() external onlyOwner {
        payable(_msgSender()).transfer(address(this).balance);
    }

    // Internal functions
    /* @notice Returns the baseURI */      
    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenUri;
    }

    // Private functions
    /* @notice Returns the baseURI */         
    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        return string(abi.encodePacked(_baseURI(), toString(tokenId), ".json"));
    }

    function toString(uint256 value) internal pure returns (string memory) {
    // Inspired by OraclizeAPI's implementation - MIT license
    // https://github.com/oraclize/ethereum-api/blob/b42146b063c7d6ee1358846c198246239e9360e8/oraclizeAPI_0.4.25.sol
        if (value == 0) {
            return "0";
        }

        uint256 temp = value;
        uint256 digits;

        while (temp != 0) {
            digits++;
            temp /= 10;
        }

        bytes memory buffer = new bytes(digits);

        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }

        return string(buffer);
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal virtual override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId);

        // do stuff before every transfer
        // e.g. check that vote (other than when minted) 
        // being transferred to registered candidate
    }
    
    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721, ERC721Enumerable) returns (bool) {
        return
            interfaceId == type(IERC721).interfaceId ||
            interfaceId == type(IERC721Metadata).interfaceId ||
            super.supportsInterface(interfaceId);
    }
}