pragma solidity ^0.5.12;

import "ds-test/test.sol";

import "./erc20.sol";

contract erc20Test is DSTest {
    erc20 erc;

    function setUp() public {
        erc = new erc20();
    }

    function testFail_basic_sanity() public {
        assertTrue(false);
    }

    function test_basic_sanity() public {
        assertTrue(true);
    }
}
