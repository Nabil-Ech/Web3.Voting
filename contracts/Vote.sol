// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Vote  is ERC721 {
    address public voter;
    uint256 public totalclubs;
    uint256 public totalNFT;
    mapping (uint256 => Club) Clubs;
    mapping (uint256 => mapping (address => bool)) hasJoined;
    mapping (uint256 => mapping (address => bool)) hasVoted;
    mapping (uint256 => uint256) voteCount;
    mapping (uint256 => string) public clubNamesById; // Mapping to store club names by ID
    mapping (string => uint256) public clubIdsByName; 

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
        clubNamesById[totalclubs] = _name; // Store club name by ID
        clubIdsByName[_name] = totalclubs; // Store club ID by name
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
        require(hasVoted[_id][msg.sender] = false);
        require(_id!=0);
        require(_id <= totalclubs);
        hasVoted[_id][msg.sender] = true;
        // here  i will keep track of every vote for each club
        voteCount[_id]++;
    }
}