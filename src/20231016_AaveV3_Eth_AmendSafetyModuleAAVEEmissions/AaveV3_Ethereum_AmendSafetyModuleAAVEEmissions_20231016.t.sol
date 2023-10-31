// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveSafetyModule} from 'aave-address-book/AaveSafetyModule.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Ethereum_AmendSafetyModuleAAVEEmissions_20231016} from './AaveV3_Ethereum_AmendSafetyModuleAAVEEmissions_20231016.sol';
import {IAaveEcosystemReserveController, AaveMisc} from "aave-address-book/AaveMisc.sol";
import {IERC20} from "solidity-utils/contracts/oz-common/interfaces/IERC20.sol";

library HelperStructs {
  struct AssetConfigInput {
    uint128 emissionPerSecond;
    uint256 totalStaked;
    address underlyingAsset;
  }

  struct UserStakeInput {
    address underlyingAsset;
    uint256 stakedByUser;
    uint256 totalStaked;
  }

  struct AssetResponse {
    uint128 emissionPerSecond;
    uint128 lastUpdateTimestamp;
    uint256 index;
  }
}


interface IAaveDistributionManager {
  function configureAssets(HelperStructs.AssetConfigInput[] calldata assetsConfigInput) external;
  function STAKED_TOKEN() external returns(address);
  function totalSupply() external returns(uint256);
  function assets(address asset) external returns(HelperStructs.AssetResponse memory);
}

/**
 * @dev Test for AaveV3_Ethereum_AmendSafetyModuleAAVEEmissions_20231016
 * command: make test-contract filter=AaveV3_Ethereum_AmendSafetyModuleAAVEEmissions_20231016
 */
contract AaveV3_Ethereum_AmendSafetyModuleAAVEEmissions_20231016_Test is ProtocolV3TestBase {

  AaveV3_Ethereum_AmendSafetyModuleAAVEEmissions_20231016 internal proposal;

  address public constant STKAAVE = AaveSafetyModule.STK_AAVE;
  address public constant STKABPT = AaveSafetyModule.STK_ABPT;

  address public constant ECOSYSTEM_RESERVE = AaveMisc.ECOSYSTEM_RESERVE;

  IAaveEcosystemReserveController public constant ECOSYSTEM_RESERVE_CONTROLLER
    = AaveMisc.AAVE_ECOSYSTEM_RESERVE_CONTROLLER;

  uint256 public constant DAILY_EMISSIONS = 385 ether;

  // Total cycle emission (90 days)
  uint256 public constant CYCLE_EMISSIONS = DAILY_EMISSIONS * 90;

  // Daily emission to seconds; 1 day * 24h * 3600 s = 86400
  uint128 public constant EMISSIONS_PER_SECOND = uint128(DAILY_EMISSIONS / 86400);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18364871);
    proposal = new AaveV3_Ethereum_AmendSafetyModuleAAVEEmissions_20231016();
  }

  function testProposalExecution() public {

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.SHORT_EXECUTOR);

    /*
      Check emission changes, the value should be 385 ether * 86400 seconds on a day
    */
    IAaveDistributionManager aaveManager = IAaveDistributionManager(STKAAVE);
    HelperStructs.AssetResponse memory aaveRes = aaveManager.assets(STKAAVE);
    assertEq(aaveRes.emissionPerSecond, EMISSIONS_PER_SECOND);

    IAaveDistributionManager bptManager = IAaveDistributionManager(STKABPT);
    HelperStructs.AssetResponse memory bptRes = bptManager.assets(STKABPT);
    assertEq(bptRes.emissionPerSecond, EMISSIONS_PER_SECOND);

    /*
      Check cycles changes, the allowance should be 385 ether * 90 as described on the proposal
    */
    assertEq(IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).allowance(ECOSYSTEM_RESERVE, STKAAVE), CYCLE_EMISSIONS);
    assertEq(IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).allowance(ECOSYSTEM_RESERVE, STKABPT), CYCLE_EMISSIONS);
  }

}
