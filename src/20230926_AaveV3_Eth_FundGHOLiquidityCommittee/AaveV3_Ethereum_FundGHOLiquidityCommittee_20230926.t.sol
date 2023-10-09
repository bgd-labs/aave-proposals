// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3_Ethereum_FundGHOLiquidityCommittee_20230926} from './AaveV3_Ethereum_FundGHOLiquidityCommittee_20230926.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

/**
 * @dev Test for AaveV3_Ethereum_FundGHOLiquidityCommittee_20230926
 * command: make test-contract filter=AaveV3_Ethereum_FundGHOLiquidityCommittee_20230926
 */
contract AaveV3_Ethereum_FundGHOLiquidityCommittee_20230926_Test is ProtocolV3TestBase {
  AaveV3_Ethereum_FundGHOLiquidityCommittee_20230926 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18314069);
    proposal = AaveV3_Ethereum_FundGHOLiquidityCommittee_20230926(0x5F8Cb9A8e12377aAe2f534813c51eEC7e36D2772);
  }

  function testProposalExecution() public {
    uint256 daiAmount = 406_000 * 1e18;
    uint256 awethAmount = 5 ether;
    address liquidityCommittee = 0x205e795336610f5131Be52F09218AF19f0f3eC60;
    
    // milkman creates intermediary contract for each swap
    // while swap is not executed the assets will be in these swap-specific proxy addresses instead of aaveSwapper
    // proxy contracts addresses are deterministic, they could be derived via code. 
    // I simulated execution and copy pasted the address for simplicity
    // see https://etherscan.io/address/0x11C76AD590ABDFFCD980afEC9ad951B160F02797#code#L878
    address daiMilkmanCreatedContract = 0x3Df592eae98c2b4f312ADE339C01BBE2C8444618;

    AaveV3_Ethereum_FundGHOLiquidityCommittee_20230926 payload = new AaveV3_Ethereum_FundGHOLiquidityCommittee_20230926();
    
    uint256 balanceBefore = liquidityCommittee.balance;

    GovHelpers.executePayload(vm, address(payload), AaveGovernanceV2.SHORT_EXECUTOR);
    
    uint256 proxyBalanceAfter = IERC20(AaveV3EthereumAssets.DAI_UNDERLYING).balanceOf(daiMilkmanCreatedContract);
    assertEq(proxyBalanceAfter, daiAmount);
    
    uint256 balanceAfter = liquidityCommittee.balance;
    assertEq(balanceAfter, balanceBefore + awethAmount);

    assertEq(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING)
        .allowance(address(AaveV3Ethereum.COLLECTOR), liquidityCommittee), 
      daiAmount
    );
  }
}
