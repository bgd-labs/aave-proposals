// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Ethereum_GHOFunding_20230926} from './AaveV3_Ethereum_GHOFunding_20230926.sol';
import {AaveV2_Ethereum_TUSDOffboardingPlanPartII_20230925} from '../20230925_AaveV2_Eth_TUSDOffboardingPlanPartII/AaveV2_Ethereum_TUSDOffboardingPlanPartII_20230925.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

/**
 * @dev Test for AaveV3_Ethereum_GHOFunding_20230926
 * command: make test-contract filter=AaveV3_Ethereum_GHOFunding_20230926
 */
contract AaveV3_Ethereum_GHOFunding_20230926_Test is ProtocolV3TestBase {
  AaveV3_Ethereum_GHOFunding_20230926 internal proposal;
  AaveV2_Ethereum_TUSDOffboardingPlanPartII_20230925 internal pastProposal;

  struct Swap {
    address proxy;
    address underlying;
    uint256 amount;
  }

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18313824);
    pastProposal = new AaveV2_Ethereum_TUSDOffboardingPlanPartII_20230925();
    proposal = new AaveV3_Ethereum_GHOFunding_20230926();
  }

  function testProposalExecution() public {
    address COLLECTOR = address(AaveV2Ethereum.COLLECTOR);

    // this prop redeems tusd and busd from aave v2, we need it to be executed before we execute ours.
    GovHelpers.executePayload(vm, address(pastProposal), AaveGovernanceV2.SHORT_EXECUTOR);

    Swap[4] memory swaps;
    // milkman creates intermediary contract for each swap
    // while swap is not executed the assets will be in these swap-specific proxy addresses instead of aaveSwapper
    // proxy contracts addresses are deterministic, they could be derived via code. 
    // I simulated execution and copy pasted the address for simplicity
    // see https://etherscan.io/address/0x11C76AD590ABDFFCD980afEC9ad951B160F02797#code#L878
    swaps[0] = Swap({
      proxy: 0x3Df592eae98c2b4f312ADE339C01BBE2C8444618,
      underlying: AaveV2EthereumAssets.DAI_UNDERLYING,
      amount: (370_000 * 1e18) + IERC20(AaveV2EthereumAssets.DAI_A_TOKEN).balanceOf(COLLECTOR)
    });

    swaps[1] = Swap({
      proxy: 0x0eB322ac55dB67a5cA0810BA0eDae3501b1B7263,
      underlying: AaveV2EthereumAssets.BUSD_UNDERLYING,
      amount: IERC20(AaveV2EthereumAssets.BUSD_UNDERLYING).balanceOf(COLLECTOR)
    });

    swaps[2] = Swap({
      proxy: 0x8F2ca8bE5e06180d36117A8aE3f615837790d59B,
      underlying: AaveV2EthereumAssets.TUSD_UNDERLYING,
      amount: IERC20(AaveV2EthereumAssets.TUSD_UNDERLYING).balanceOf(COLLECTOR)
    });

    swaps[3] = Swap({
      proxy: 0xfEc76f65e943239E5A7CDC3CA6a89c26a0803FFd,
      underlying: AaveV2EthereumAssets.USDT_UNDERLYING,
      amount: 370_000 * 1e6
    });

    GovHelpers.executePayload(vm, address(proposal), AaveGovernanceV2.SHORT_EXECUTOR);

    for(uint i = 0; i < swaps.length; i++) {
      uint256 proxyBalanceAfter = IERC20(swaps[i].underlying).balanceOf(swaps[i].proxy);
      assertEq(proxyBalanceAfter, swaps[i].amount);
    }
    
  }
}
