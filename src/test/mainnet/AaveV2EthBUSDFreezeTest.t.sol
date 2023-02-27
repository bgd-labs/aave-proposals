// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV2EthFreezeBUSD} from '../../contracts/mainnet/AaveV2EthFreezeBUSD.sol';

contract AaveV2EthBUSDFreezeTest is ProtocolV2TestBase, TestWithExecutor {
  address public constant BUSD = AaveV2EthereumAssets.BUSD_UNDERLYING;
  string public constant BUSD_SYMBOL = 'BUSD';

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 16671139);
    _selectPayloadExecutor(AaveGovernanceV2.SHORT_EXECUTOR);
  }

  function testBUSD() public {
    createConfigurationSnapshot('pre-BUSD-freezing', AaveV2Ethereum.POOL);
    ReserveConfig[] memory allConfigsBefore = _getReservesConfigs(AaveV2Ethereum.POOL);

    ReserveConfig memory configBUSDBefore = _findReserveConfigBySymbol(allConfigsBefore, BUSD_SYMBOL);

    address BUSDPayload = address(new AaveV2EthFreezeBUSD());

    _executePayload(BUSDPayload);

    ReserveConfig[] memory allConfigsAfter = _getReservesConfigs(AaveV2Ethereum.POOL);

    configBUSDBefore.isFrozen = true;

    _validateReserveConfig(configBUSDBefore, allConfigsAfter);

    _noReservesConfigsChangesApartFrom(
      allConfigsBefore,
      allConfigsAfter,
      configBUSDBefore.underlying
    );

    createConfigurationSnapshot('post-BUSD-freezing', AaveV2Ethereum.POOL);

    diffReports('pre-BUSD-freezing', 'post-BUSD-freezing');
  }
}
