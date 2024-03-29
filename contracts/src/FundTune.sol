// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;
import "../node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "../node_modules/@openzeppelin/contracts/token/ERC20/IERC20.sol";

/**
 * @title FundTune
 * @author 
 * @notice FundTune is a smart contract that allows users to create events to attract their favorite artists to perform in their city.
 * @dev 
*/

contract FundTune is Ownable{

    // Custom events

    event EventCreated(
        uint256 indexed eventId,
        string eventName,
        string eventDescription,
        string artist,
        string location,
        uint256 contributionAmount
    );

    event Participated(
        uint256 indexed eventId,
        address indexed participant,
        uint256 contributionAmount
    );

    /* ========== STATE VARIABLES ========== */
    uint256 public eventCount = 0;
    struct Event {
        uint256 id;
        string eventName;
        string eventDescription;
        string artist;
        string location;
        uint256 pricePerTicketUSDT;
        uint256 totalParticipants;
        uint256 totalContribution;
        uint256 withdrawnAmount;
        bool active;
    }
    Event[] public events;
    mapping(uint256 => mapping(address => uint256)) public participantContribution;
    address public usdtAddress;

    /* ========== CONSTRUCTOR ========== */

    constructor(address _usdtAddress) Ownable(msg.sender) {
        usdtAddress = _usdtAddress;
    }
    
    /* ========== SETTER FUNCTIONS ========== */

    function createEvent(
        string memory _eventName,
        string memory _eventDescription,
        string memory _artist,
        string memory _location,
        uint256 _pricePerTicketUSDT
    ) public onlyOwner {
        events.push(
            Event({
                id: eventCount,
                eventName: _eventName,
                eventDescription: _eventDescription,
                artist: _artist,
                location: _location,
                pricePerTicketUSDT: _pricePerTicketUSDT,
                totalParticipants: 0,
                totalContribution: 0,
                withdrawnAmount: 0,
                active: true
            })
        );
        eventCount++;
        emit EventCreated(eventCount, _eventName, _eventDescription, _artist, _location, _pricePerTicketUSDT);
    }

    function participate(uint256 _eventId, uint256 _contributionAmountUSDT) public {
        require(events[_eventId].active, "Not an active Event");
        require(_contributionAmountUSDT % events[_eventId].pricePerTicketUSDT == 0, "Not a valid contribution amount");

        // this require approving USDT from the USDT contract. IERC20(usdtAddress).approve(fundTuneContractAddress, contributionAmountUSDT);
        require(IERC20(usdtAddress).transferFrom(msg.sender, address(this), _contributionAmountUSDT), "Transfer failed");

        participantContribution[_eventId][msg.sender] += _contributionAmountUSDT;
        events[_eventId].totalContribution += _contributionAmountUSDT;
        events[_eventId].totalParticipants = events[_eventId].totalContribution / events[_eventId].pricePerTicketUSDT;
        emit Participated(_eventId, msg.sender, _contributionAmountUSDT);
    }

    function disableEvent(uint256 _eventId) public onlyOwner {
        require(events[_eventId].active == true, "Event is already inactive");
        events[_eventId].active = false;
    }

    function enableEvent(uint256 _eventId) public onlyOwner {
        require(events[_eventId].active == false, "Event is already active");
        events[_eventId].active = true;
    }

    function withdraw(uint256 _eventId) public onlyOwner {
        require(events[_eventId].active == false, "Event is still active");
        require(events[_eventId].totalContribution > events[_eventId].withdrawnAmount, "Nothing to withdraw");
        require(IERC20(usdtAddress).transfer(owner(), events[_eventId].totalContribution - events[_eventId].withdrawnAmount), "Transfer failed");
        events[_eventId].withdrawnAmount += events[_eventId].totalContribution;
    }
}
