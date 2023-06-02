// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import 'forge-std/Test.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {AaveV2EthBUSDIR_20230602} from 'src/AaveV2EthBUSDIR_20230602/AaveV2EthBUSDIR_20230602.sol';
import {IERC20} from 'lib/solidity-utils/src/contracts/oz-common/interfaces/IERC20.sol';

contract AaveV3EthBUSDPayloadTest is ProtocolV2TestBase, TestWithExecutor {
  address public constant BUSD = AaveV2EthereumAssets.BUSD_UNDERLYING;
  string public constant BUSD_SYMBOL = 'BUSD';

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17392288);
    _selectPayloadExecutor(AaveGovernanceV2.SHORT_EXECUTOR);
  }

  function testBUSD() public {
    createConfigurationSnapshot('pre-BUSD-Payload-activation', AaveV2Ethereum.POOL);
    ReserveConfig[] memory allConfigsBefore = _getReservesConfigs(AaveV2Ethereum.POOL);

    ReserveConfig memory configBUSDBefore = _findReserveConfigBySymbol(
      allConfigsBefore,
      BUSD_SYMBOL
    );

    address BUSDPayload = address(new AaveV2EthBUSDIR_20230602());

    _executePayload(BUSDPayload);

    ReserveConfig[] memory allConfigsAfter = _getReservesConfigs(AaveV2Ethereum.POOL);

    _noReservesConfigsChangesApartFrom(
      allConfigsBefore,
      allConfigsAfter,
      configBUSDBefore.underlying
    );

    createConfigurationSnapshot('post-BUSD-Payload-activation', AaveV2Ethereum.POOL);

    diffReports('pre-BUSD-Payload-activation', 'post-BUSD-Payload-activation');
  }
}