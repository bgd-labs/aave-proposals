// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';
import {IPoolConfigurator, ConfiguratorInputTypes} from 'aave-address-book/AaveV3.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @dev This payload sets borrow caps for multiple assets on AAVE V3 Polygon
 * - Dicussion: https://governance.aave.com/t/arc-chaos-labs-supply-and-borrow-cap-updates-aave-v3-polygon-and-arbitrum-2023-02-07/11605
 */
contract AaveV3PolCapsPayload is IProposalGenericExecutor {
  address public constant BAL = 0x9a71012B13CA4d3D0Cdc72A177DF3ef03b0E76A3;
  address public constant EURS = 0xE111178A87A3BFf0c8d18DECBa5798827539Ae99;
  address public constant DAI = 0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063;
  address public constant USDC = 0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174;
  address public constant USDT = 0xc2132D05D31c914a87C6611C10748AEb04B58e8F;

  uint256 public constant BAL_SUPPLY_CAP = 361_000;
  uint256 public constant EURS_BORROW_CAP = 947_000;
  uint256 public constant DAI_BORROW_CAP = 30_000_000;
  uint256 public constant USDC_BORROW_CAP = 100_000_000;
  uint256 public constant USDT_BORROW_CAP = 30_000_000;

  function execute() external {
    IPoolConfigurator configurator = AaveV3Polygon.POOL_CONFIGURATOR;

    configurator.setSupplyCap(BAL, BAL_SUPPLY_CAP);

    configurator.setBorrowCap(EURS, EURS_BORROW_CAP);

    configurator.setBorrowCap(DAI, DAI_BORROW_CAP);

    configurator.setBorrowCap(USDC, USDC_BORROW_CAP);

    configurator.setBorrowCap(USDT, USDT_BORROW_CAP);
  }
}
