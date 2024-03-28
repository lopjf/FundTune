// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {FundTune} from "../src/FundTune.sol";

contract FundTuneTest is Test {
    FundTune public fundTune;

    // function setUp() public {
    //     fundTune = new FundTune();
    //     fundTune.setNumber(0);
    // }

    // function test_Increment() public {
    //     fundTune.increment();
    //     assertEq(fundTune.number(), 1);
    // }

    // function testFuzz_SetNumber(uint256 x) public {
    //     fundTune.setNumber(x);
    //     assertEq(fundTune.number(), x);
    // }
}
