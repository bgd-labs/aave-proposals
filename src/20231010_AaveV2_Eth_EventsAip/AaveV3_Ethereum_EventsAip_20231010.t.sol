// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {ProtocolV2TestBase} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

import {AaveMisc} from 'aave-address-book/AaveMisc.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV3_Ethereum_EventsAip_20231010} from './AaveV3_Ethereum_EventsAip_20231010.sol';
import 'forge-std/console.sol';

/**
 * @dev Test for AaveV3_Ethereum_EventsAip_20231010
 * command: make test-contract filter=AaveV3_Ethereum_EventsAip_20231010
 */
// https://github.com/charlesndalton/milkman
contract AaveV3_Ethereum_EventsAip_20231010_Test is ProtocolV2TestBase {
  AaveV3_Ethereum_EventsAip_20231010 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18334762);
    proposal = new AaveV3_Ethereum_EventsAip_20231010();
  }

  function testProposalExecution() public {
    uint256 FUNDING_AMOUNT = 550_000 * 1e18;
    address RECEIVER = 0x1c037b3C22240048807cC9d7111be5d455F640bd;

    // milkman creates intermediary contract for each swap
    // while swap is not executed the assets will be in these swap-specific proxy addresses instead of aaveSwapper
    // proxy contracts addresses are deterministic, they could be derived via code.
    // I simulated execution and copy pasted the address for simplicity
    // see https://etherscan.io/address/0x11C76AD590ABDFFCD980afEC9ad951B160F02797#code#L878

    address daiMilkmanCreatedContract = 0x0eB322ac55dB67a5cA0810BA0eDae3501b1B7263;
    address usdtMilkmanCreatedContract = 0x3Df592eae98c2b4f312ADE339C01BBE2C8444618;

    address COLLECTOR = address(AaveV3Ethereum.COLLECTOR);

    uint256 usdtAmount = 275_000 * 1e6;
    uint256 daiAmount = 275_000 * 1e18;

    AaveV3_Ethereum_EventsAip_20231010 payload = new AaveV3_Ethereum_EventsAip_20231010();

    uint256 balaceBefore = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(address(RECEIVER));

    console.log('balance before --->', balaceBefore);

    GovHelpers.executePayload(vm, address(payload), AaveGovernanceV2.SHORT_EXECUTOR);

    /// check if proxy contracts got the assets to swap
    uint256 usdtBalanceAfter = IERC20(AaveV3EthereumAssets.USDT_UNDERLYING).balanceOf(
      usdtMilkmanCreatedContract
    );

    uint256 daiBalanceAfter = IERC20(AaveV3EthereumAssets.DAI_UNDERLYING).balanceOf(
      daiMilkmanCreatedContract
    );
    console.log('usdtBalanceAfter', usdtBalanceAfter);
    console.log('daiBalanceAfter', daiBalanceAfter);

    /// aaveSwapper never really holds any assets that are earmarked for a swap
    /// the swap function creates a proxy contract for each swap, and those proxies hold the assets waiting to be swapped
    assertEq(usdtBalanceAfter, usdtAmount);
    assertEq(daiBalanceAfter, daiAmount);

    uint256 balaceAfter = IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(address(RECEIVER));

    // Not sure how to simulate this post proxy interaction
    console.log('balaceAfter', balaceAfter);
    assertEq(balaceAfter, balaceBefore + FUNDING_AMOUNT);
  }
}
