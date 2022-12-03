// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import 'forge-std/Test.sol';

import {IPoolConfigurator, ConfiguratorInputTypes, IACLManager} from 'aave-address-book/AaveV3.sol';
import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {AaveV3ArbCapsSteward} from '../contracts/v3-Arbitrum-supply-caps-30-11-2022/AaveV3ArbCapsSteward.sol';
import {AaveV3Helpers, ReserveConfig, ReserveTokens, IERC20} from './helpers/AaveV3Helpers.sol';

contract AaveV3ArbCapsByGuardian is Test {
    using stdStorage for StdStorage;

    address public constant GUARDIAN_ARBITRUM =
        0xbbd9f90699c1FA0D7A65870D241DD1f1217c96Eb;

    string public constant LinkSymbol = 'LINK';
    string public constant WETHSymbol = 'WETH';
    string public constant WBTCSymbol = 'WBTC';
    string public constant AAVESymbol = 'AAVE';

    //20.3K WETH
    uint256 public constant WETH_CAP = 20_300;
    //2.1K WBTC
    uint256 public constant WBTC_CAP = 2_100;
    //350K LINK
    uint256 public constant LINK_CAP = 350_000;
    //2.5K AAVE
    uint256 public constant AAVE_CAP = 2_500;

    function setUp() public {}

    function testNewSupplyCaps() public {
        ReserveConfig[] memory allConfigsBefore = AaveV3Helpers
            ._getReservesConfigs(false);

        vm.startPrank(GUARDIAN_ARBITRUM);

        AaveV3ArbCapsSteward capsSteward = new AaveV3ArbCapsSteward();

        IACLManager aclManager = AaveV3Arbitrum.ACL_MANAGER;

        aclManager.addAssetListingAdmin(address(capsSteward));
        aclManager.addRiskAdmin(address(capsSteward));

        capsSteward.execute();

        vm.stopPrank();

        ReserveConfig[] memory allConfigsAfter = AaveV3Helpers
            ._getReservesConfigs(false);

        //LINK
        ReserveConfig memory LinkConfig = AaveV3Helpers._findReserveConfig(
            allConfigsBefore,
            LinkSymbol,
            false
        );
        LinkConfig.supplyCap = LINK_CAP;
        AaveV3Helpers._validateReserveConfig(LinkConfig, allConfigsAfter);

        //WETH
        ReserveConfig memory WETHConfig = AaveV3Helpers._findReserveConfig(
            allConfigsBefore,
            WETHSymbol,
            false
        );
        WETHConfig.supplyCap = WETH_CAP;
        AaveV3Helpers._validateReserveConfig(WETHConfig, allConfigsAfter);

        //WBTC
        ReserveConfig memory WBTCConfig = AaveV3Helpers._findReserveConfig(
            allConfigsBefore,
            WBTCSymbol,
            false
        );
        WBTCConfig.supplyCap = WBTC_CAP;
        AaveV3Helpers._validateReserveConfig(WBTCConfig, allConfigsAfter);

        //AAVE
        ReserveConfig memory AAVEConfig = AaveV3Helpers._findReserveConfig(
            allConfigsBefore,
            AAVESymbol,
            false
        );
        AAVEConfig.supplyCap = AAVE_CAP;
        AaveV3Helpers._validateReserveConfig(AAVEConfig, allConfigsAfter);

        require(capsSteward.owner() == address(0), 'INVALID_OWNER_POST_CAPS');
    }
}
