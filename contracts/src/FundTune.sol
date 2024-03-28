// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

/**
 * @title FundTune
 * @author 
 * @notice FundTune is a smart contract that allows users to create events to attract their favorite artists to perform in their city.
 * @dev 
*/

contract FundTune {

    // Custom events

    /* ========== STATE VARIABLES ========== */
    struct Event {
        uint256 id;
        string eventName;
        string eventDescription;
        string artist;
        string location;
        uint256 contributionAmount;
        address[] participants;
        uint256 totalParticipants;
        uint256 totalContribution;
    }
    mapping(uint256 => Event) public events;

    /* ========== CONSTRUCTOR ========== */
    constructor() {
    }

    /* ========== VIEW FUNCTIONS ========== */

    /* ========== SETTER FUNCTIONS ========== */
}
