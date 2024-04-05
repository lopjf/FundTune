// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "./DaoToken.sol";
import "./StableCoin.sol";

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


// For now ticket price is a constant
uint constant TICKET_PRICE = 40 * 10 ** 6;
uint constant WINNING_QUORUM = 51;

contract EventDAO is ERC1155, Ownable, ReentrancyGuard {
    DaoToken public daoToken;
    StableCoin public stableCoin;
    

    struct Event {
        address artist;
        bool isActive;
        uint256 depositDeadline;
        uint256 voteDeadline;
        uint256 totalDeposits;
        mapping(address => uint256) deposits;
        mapping(uint8 => uint256) votesCountry;
        mapping(uint8 => uint256) votesMonth;
        // in the ui we will display the country with a uint associated to it
        uint8[] voteOptionsCountry;
        uint8[] voteOptionsMonth;
        uint8 winningOptionCountry;
        uint8 winningOptionMonth;
        uint nftId;
    }

    mapping(uint256 => Event) public events;
    uint256 public nextEventId;

    constructor(address initialOwner, address daoTokenAddress, address stableCoinAddress) ERC1155("EventTicket") Ownable(initialOwner) {
        daoToken = DaoToken(daoTokenAddress);
        stableCoin = StableCoin(stableCoinAddress);
    }

    function organizeEvent(
        address _artist,
        uint256 depositPeriod,
        uint256 votePeriod
    ) external {
        require(
            daoToken.balanceOf(msg.sender) > 0,
            "You don't have DAO tokens"
        );

        uint256 eventId = nextEventId++;
        Event storage newEvent = events[eventId];
        newEvent.artist = _artist;
        newEvent.isActive = true;
        newEvent.depositDeadline = block.timestamp + depositPeriod;
        newEvent.voteDeadline = newEvent.depositDeadline + votePeriod;
        newEvent.nftId = 0;
    }

    function depositTokens(uint256 eventId, uint256 amount) external {
        Event storage event_ = events[eventId];

        require(
            daoToken.transferFrom(msg.sender, address(this), amount),
            "Transfer failed"
        );

        event_.deposits[msg.sender] += amount;
        event_.totalDeposits += amount;
    }

    function mintNftForParticipants(uint256 eventId, uint256 amount) external nonReentrant {
        Event storage event_ = events[eventId];
        // uint amountToMint = event_.deposits[msg.sender];

        require(
            block.timestamp > event_.voteDeadline,
            "Vote stage has not ended yet"
        );

        require(
            block.timestamp < event_.depositDeadline,
            "Deposit period ended"
        );
        require(amount > 0, "You cant mint");

        require(
            stableCoin.transferFrom(msg.sender, address(this), amount),
            "Transfer failed"
        );

        amount /= TICKET_PRICE;

        // event_.deposits[msg.sender] = 0;

        _mint(msg.sender, events[eventId].nftId, amount, "");

        event_.nftId += 1;
    }

    function voteCountryMonth(
        uint256 eventId,
        uint8 country,
        uint8 month
    ) external {
        Event storage event_ = events[eventId];
        uint amount = event_.deposits[msg.sender];

        require(
            block.timestamp <= event_.voteDeadline,
            "Voting period has ended"
        );
        require(
            block.timestamp > event_.depositDeadline,
            "Deposit period not ended"
        );
        require(amount > 0, "You haven't despoited anything for this event");

        event_.votesCountry[country] += amount;
        event_.votesMonth[month] += amount;
    }

    function determineWinner(uint256 eventId) external {
        Event storage event_ = events[eventId];
        require(
            block.timestamp > event_.voteDeadline,
            "Voting period not ended"
        );
        require(event_.winningOptionCountry == 0, "Winner already decided");

        uint256 winningVoteCountCountry = 0;
        uint256 winningVoteCountMonth = 0;

        for (uint i = 0; i < event_.voteOptionsCountry.length; i++) {
            uint256 optionVote = event_.votesCountry[
                event_.voteOptionsCountry[i]
            ];

            if (optionVote > winningVoteCountCountry) {
                winningVoteCountCountry = optionVote;
                event_.winningOptionCountry = event_.voteOptionsCountry[i];
            }
        }

        for (uint i = 0; i < event_.voteOptionsMonth.length; i++) {
            uint256 optionVote = event_.votesMonth[event_.voteOptionsMonth[i]];

            if (optionVote > winningVoteCountMonth) {
                winningVoteCountMonth = optionVote;
                event_.winningOptionMonth = event_.voteOptionsMonth[i];
            }
        }

        require(
            (winningVoteCountCountry * 100) / event_.totalDeposits >=
                WINNING_QUORUM,
            "No option has reached the majority"
        );
        require(
            (winningVoteCountMonth * 100) / event_.totalDeposits >=
                WINNING_QUORUM,
            "No option has reached the majority"
        );
    }

     function setNewStableCoinAddress(address _stableCoin) external onlyOwner {
         stableCoin = StableCoin(_stableCoin);
    }


    
}
