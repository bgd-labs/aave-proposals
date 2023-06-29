// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import 'forge-std/Test.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveV2EthBUSDIR_20230602} from 'src/AaveV2EthBUSDIR_20230602/AaveV2EthBUSDIR_20230602.sol';
import {IERC20} from 'lib/solidity-utils/src/contracts/oz-common/interfaces/IERC20.sol';

contract AaveV3EthBUSDPayloadTest is ProtocolV2TestBase {
  address public constant BUSD = AaveV2EthereumAssets.BUSD_UNDERLYING;
  string public constant BUSD_SYMBOL = 'BUSD';

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17399987);
  }

  function testBUSD() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'pre-BUSD-Payload-activation',
      AaveV2Ethereum.POOL
    );

    ReserveConfig memory configBUSDBefore = _findReserveConfigBySymbol(
      allConfigsBefore,
      BUSD_SYMBOL
    );

    address BUSDPayload = address(new AaveV2EthBUSDIR_20230602());

    uint256 aBUSDBalanceBefore = IERC20(AaveV2EthereumAssets.BUSD_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    uint256 BUSDBalanceBefore = IERC20(AaveV2EthereumAssets.BUSD_UNDERLYING).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );

    GovHelpers.executePayload(vm, BUSDPayload, AaveGovernanceV2.SHORT_EXECUTOR);

    // check balances are correct
    uint256 aBUSDBalanceAfter = IERC20(AaveV2EthereumAssets.BUSD_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    uint256 BUSDBalanceAfter = IERC20(AaveV2EthereumAssets.BUSD_UNDERLYING).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    assertApproxEqAbs(aBUSDBalanceAfter, 0, 1500 ether, 'aBUSD_LEFTOVER');
    assertEq(BUSDBalanceAfter, aBUSDBalanceBefore + BUSDBalanceBefore);
    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'post-BUSD-Payload-activation',
      AaveV2Ethereum.POOL
    );

    // check it's not bricked
    ReserveConfig memory configBUSDAfter = _findReserveConfigBySymbol(allConfigsAfter, BUSD_SYMBOL);
    _withdraw(
      configBUSDAfter,
      AaveV2Ethereum.POOL,
      0x8493E5B88526D7044F5f3A54FD770ecd585295Ed,
      1 ether
    ); // aBUSD whale

    // check there are no unexpected changes
    _noReservesConfigsChangesApartFrom(
      allConfigsBefore,
      allConfigsAfter,
      configBUSDBefore.underlying
    );

    diffReports('pre-BUSD-Payload-activation', 'post-BUSD-Payload-activation');
  }
}
