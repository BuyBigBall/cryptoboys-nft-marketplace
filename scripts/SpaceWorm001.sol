// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SpaceWorms001 is ERC721, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;
	uint256 private price = 100000000000000000; // 0.1 BNB
	address payable private _owner;
	

    constructor() ERC721("SpaceWorms001", "SW1") {}

    function _baseURI() internal pure override returns (string memory) {
        return "https://negociosytecnologias.net/erc721/";
    }

    function mint(address to) payable public returns (uint256)
    {
		require(balanceOf(to) <= 1, 'Cada address solo puede tener hasta dos NFT');
        require(_tokenIdCounter.current() < 10, 'Se han minteado todos los NFT'); 
		require(msg.value == price, "No tiene suficiente BNB");
        _tokenIdCounter.increment();
        _safeMint(to, _tokenIdCounter.current());

        return _tokenIdCounter.current();
    }

	function withdraw(address payable recipient) public onlyOwner 
	{
        uint256 balance = address(this).balance;
        recipient.transfer(balance);
    }	

    function actualBalance() public view returns (uint256)
	{
        uint256 balance = address(this).balance;
        return balance;
    }

}