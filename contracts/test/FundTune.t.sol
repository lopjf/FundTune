// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {FundTune} from "../src/FundTune.sol";

    // Maybe use forge test --fork-url <your_rpc_url> to test with a forked mainnet and use USDT from mainnet

contract FundTuneTest is Test {
    FundTune public fundTune;

    function setUp() public {
        fundTune = new FundTune(address(0));
    }

    function testCreateEvent() public {
        fundTune.createEvent("Event1", "Event1 Description", "Artist1", "Location1", 100);
        assertEq(fundTune.eventCount(), 1);
    }

    function testParticipate() public {
        fundTune.createEvent("Event1", "Event1 Description", "Artist1", "Location1", 100);
        fundTune.participate(0, 100);
        assertEq(fundTune.events(0).totalParticipants, 1);
    }
}
