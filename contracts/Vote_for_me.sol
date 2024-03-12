// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Vote_for_me is ERC721 {
    address public voter;
    uint256 public totalclubs;
    uint256 public totalNFT;
    mapping (uint256 => Club) Clubs;
    mapping (uint256 => mapping (address => bool)) hasJoined;
    mapping (uint256 => mapping (address => bool)) hasVoted;
    constructor (string memory _name, string memory _symbol) ERC721 (_name, _symbol) {
        voter = msg.sender;
    }

    struct Club {
        uint256 id;
        string name;
        uint256 cost;
    }

    function create_club (string memory _name, uint256 _cost) public {
        totalclubs++;
        Clubs[totalclubs] = Club(totalclubs, _name, _cost);
    }

    function joinClub (uint256 _id) public payable {
        require(hasJoined[_id][msg.sender] = false);
        require(msg.value == Clubs[_id].cost);
        require(_id!=0);
        require(_id <= totalclubs);


        hasJoined[_id][msg.sender] = true ;
        
        totalNFT++;
        _safeMint(msg.sender, totalNFT);
    }

    function vote_for (uint256 _id) public {

    }
}