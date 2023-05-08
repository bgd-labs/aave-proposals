// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';

import {AaveV3EthsdCRV_20230503_Payload} from './AaveV3EthsdCRV_20230503_Payload.sol';

contract AaveV3PolCapsUpdates_20230328Test is ProtocolV3TestBase, TestWithExecutor {
    address public constant SD_CRV = 0xD1b5651E55D4CeeD36251c61c50C889B36F6abB5;
  AaveV3EthsdCRV_20230503_Payload payload;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17219011);
    _selectPayloadExecutor(AaveGovernanceV2.SHORT_EXECUTOR);

    payload = new AaveV3EthsdCRV_20230503_Payload();
  }

  function testExecute() public {
    // Pre-execution balances of CRV and aCRV
    assertEq(
      IERC20(AaveV2EthereumAssets.CRV_UNDERLYING).balanceOf(
        address(AaveV2Ethereum.COLLECTOR)),
        19714118888439666456840
    );
    assertEq(
      IERC20(AaveV2EthereumAssets.CRV_A_TOKEN).balanceOf(
        address(AaveV2Ethereum.COLLECTOR)),
        754275831989801164278616
    );
    // End Pre-execution balances of CRV and aCRV

    _executePayload(address(payload));

    // Post-execution balances of CRV and aCRV
    assertEq(
      IERC20(AaveV2EthereumAssets.CRV_UNDERLYING).balanceOf(
        address(AaveV2Ethereum.COLLECTOR)),
        0
    );
    assertEq(
      IERC20(AaveV2EthereumAssets.CRV_A_TOKEN).balanceOf(
        address(AaveV2Ethereum.COLLECTOR)),
        0
    );

    assertEq(
      IERC20(SD_CRV).balanceOf(
        address(AaveV2Ethereum.COLLECTOR)),
        0
    );

    vm.startPrank(address(AaveV2Ethereum.COLLECTOR));
    IERC20(SD_CRV).transferFrom(
      address(AaveV2Ethereum.COLLECTOR),
      makeAddr('new-addy'),
      100_000e18
    );
    vm.stopPrank();
    // End Post-execution balances of CRV and aCRV
}
}
