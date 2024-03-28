// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

/**
 * @title 
 * @author lopjf
 * @notice 
 * @dev 
*/

contract FundTune {

    // Custom events

    /* ========== STATE VARIABLES ========== */
    struct Event {
        uint256 id;
        string name;
        string description;
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
