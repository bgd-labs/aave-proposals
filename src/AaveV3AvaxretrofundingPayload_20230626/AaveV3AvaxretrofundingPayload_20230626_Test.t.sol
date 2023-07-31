// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import 'forge-std/Test.sol';

import {AaveV3AvaxretrofundingPayload} from './AaveV3AvaxretrofundingPayload_20230626.sol';
import {AaveV3Avalanche} from 'aave-address-book/AaveV3Avalanche.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

contract AaveV3AvaxretrofundingPayloadTest is Test {
  struct TokenBalances {
    uint256 aAvaWAVAX;
    uint256 avWAVAX;
    uint256 aAvaWBTC;
    uint256 avWBTC;
  }

  address public constant COLLECTOR_ADDRESS = address(AaveV3Avalanche.COLLECTOR);
  address public constant AAVECO_ADDRESS = 0xa8F8E9c54e099c4fADB797f5196E07ce484824aF;

  address public constant aAvaWAVAX = 0x6d80113e533a2C0fe82EaBD35f1875DcEA89Ea97;
  address public constant avWAVAX = 0xDFE521292EcE2A4f44242efBcD66Bc594CA9714B;
  address public constant aAvaWBTC = 0x078f358208685046a11C85e8ad32895DED33A249;
  address public constant avWBTC = 0x686bEF2417b6Dc32C50a3cBfbCC3bb60E1e9a15D;

  uint256 public constant AMOUNT_aAvaWAVAX = 9584.301837e18;
  uint256 public constant AMOUNT_avWAVAX = 19415.698163e18;
  uint256 public constant AMOUNT_aAvaWBTC = 1.077275e8;
  uint256 public constant AMOUNT_avWBTC = 1.807146e8;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 32737321);
  }

  function testExecute() public {
    TokenBalances memory collectorBefore = TokenBalances({
      aAvaWAVAX: IERC20(aAvaWAVAX).balanceOf(COLLECTOR_ADDRESS),
      avWAVAX: IERC20(avWAVAX).balanceOf(COLLECTOR_ADDRESS),
      aAvaWBTC: IERC20(aAvaWBTC).balanceOf(COLLECTOR_ADDRESS),
      avWBTC: IERC20(avWBTC).balanceOf(COLLECTOR_ADDRESS)
    });
    TokenBalances memory aaveCoBefore = TokenBalances({
      aAvaWAVAX: IERC20(aAvaWAVAX).balanceOf(AAVECO_ADDRESS),
      avWAVAX: IERC20(avWAVAX).balanceOf(AAVECO_ADDRESS),
      aAvaWBTC: IERC20(aAvaWBTC).balanceOf(AAVECO_ADDRESS),
      avWBTC: IERC20(avWBTC).balanceOf(AAVECO_ADDRESS)
    });

    // Address of the AVAX Guardian used to execute
    GovHelpers.executePayload(
      vm,
      address(new AaveV3AvaxretrofundingPayload()),
      AaveV3Avalanche.ACL_ADMIN
    );

    TokenBalances memory collectorAfter = TokenBalances({
      aAvaWAVAX: IERC20(aAvaWAVAX).balanceOf(COLLECTOR_ADDRESS),
      avWAVAX: IERC20(avWAVAX).balanceOf(COLLECTOR_ADDRESS),
      aAvaWBTC: IERC20(aAvaWBTC).balanceOf(COLLECTOR_ADDRESS),
      avWBTC: IERC20(avWBTC).balanceOf(COLLECTOR_ADDRESS)
    });
    TokenBalances memory aaveCoAfter = TokenBalances({
      aAvaWAVAX: IERC20(aAvaWAVAX).balanceOf(AAVECO_ADDRESS),
      avWAVAX: IERC20(avWAVAX).balanceOf(AAVECO_ADDRESS),
      aAvaWBTC: IERC20(aAvaWBTC).balanceOf(AAVECO_ADDRESS),
      avWBTC: IERC20(avWBTC).balanceOf(AAVECO_ADDRESS)
    });

    // Check before/after amounts to ensure they match, allowing a delta of 1 due to AToken rounding
    assertApproxEqAbs(collectorBefore.aAvaWAVAX - collectorAfter.aAvaWAVAX, AMOUNT_aAvaWAVAX, 1);
    assertApproxEqAbs(aaveCoAfter.aAvaWAVAX - aaveCoBefore.aAvaWAVAX, AMOUNT_aAvaWAVAX, 1);

    assertApproxEqAbs(collectorBefore.avWAVAX - collectorAfter.avWAVAX, AMOUNT_avWAVAX, 1);
    assertApproxEqAbs(aaveCoAfter.avWAVAX - aaveCoBefore.avWAVAX, AMOUNT_avWAVAX, 1);

    assertApproxEqAbs(collectorBefore.aAvaWBTC - collectorAfter.aAvaWBTC, AMOUNT_aAvaWBTC, 1);
    assertApproxEqAbs(aaveCoAfter.aAvaWBTC - aaveCoBefore.aAvaWBTC, AMOUNT_aAvaWBTC, 1);

    assertApproxEqAbs(collectorBefore.avWBTC - collectorAfter.avWBTC, AMOUNT_avWBTC, 1);
    assertApproxEqAbs(aaveCoAfter.avWBTC - aaveCoBefore.avWBTC, AMOUNT_avWBTC, 1);
  }
}