---
title: BUSD Offboarding Plan Part II
author: Marc Zeller (@marczeller), Aave-Chan initiative
shortDescription: BUSD Offboarding Plan Part II
discussions: https://governance.aave.com/t/arfc-busd-offboarding-plan-part-ii/13048
created: 2022-06-02
---

## Simple Summary

This AIP proposes to change the InterestRate Strategy the BUSD reserve on the Aave V2 Ethereum pool and withdraw POL aBUSD from Aave V2 Ethereum Pool

## Motivation

[Please refers to the first part of the BUSD offboarding plan for more context.](https://governance.aave.com/t/arfc-busd-offboarding-plan/12170)

The first part of the plan was [a success](https://governance.aave.com/t/arfc-busd-offboarding-plan/12170/3?u=marczeller), driving out liquidity and incentivizing active users to repay their debt and move their position to other stablecoins.

The remaining vBUSD debt holders seem to be inactive or unaffected by high rates, due to the time-sensitive nature of BUSD/Paxos situation and the potential risk of protocol bad debt.

This second part of the offboarding plan will concentrate efforts on creating unsustainable positions for remaining borrowers to either motivate them enough to repay or reach liquidation thresholds.

Both actions are proposed to be performed :

1. modify risk parameters to "force" slope 2 interest rate curve and increase slope 2 aggressiveness
2. remove Protocol Owned Liquidity aBUSD to increase the utilization ratio of BUSD and increase the cost of open positions.

## Specification

Ticker: BUSD (BUSD)

Contract Address: 0x4Fabb145d64652a948d72533023f6E7A623C7C53

The offboarding plan will be carried out With the current AIP with the following parameters:

- Decrease uOptimal from 20% to 2%.
- reserveFactor remains unchanged at 99.9%.
- base rate remains unchanged at 3%.
- slope 1 remains unchanged at 7%.
- Increase slope 2 from 200% to 300%.

Withdrawal of aBUSD from the collector contract. The BUSD will be kept as such in the collector contract, and a separate AIP will organize the swap of BUSD into other assets at a later stage.

```solidity
contract AaveV2EthBUSDIR_20230602 is IProposalGenericExecutor {
  address public constant INTEREST_RATE_STRATEGY = 0xB28cA2760001c9837430F20c50fD89Ed56A449f0;

  function execute() external {
    AaveV2Ethereum.POOL_CONFIGURATOR.setReserveInterestRateStrategyAddress(
      AaveV2EthereumAssets.BUSD_UNDERLYING,
      INTEREST_RATE_STRATEGY
    );

    uint256 aBUSDBalance = IERC20(AaveV2EthereumAssets.BUSD_A_TOKEN).balanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    uint256 availableBUSD = IERC20(AaveV2EthereumAssets.BUSD_UNDERLYING).balanceOf(
      AaveV2EthereumAssets.BUSD_A_TOKEN
    );
    AaveV2Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.BUSD_A_TOKEN,
      address(this),
      aBUSDBalance > availableBUSD ? availableBUSD : aBUSDBalance
    );
    AaveV2Ethereum.POOL.withdraw(
      AaveV2EthereumAssets.BUSD_UNDERLYING,
      type(uint256).max,
      address(AaveV2Ethereum.COLLECTOR)
    );
  }
}
```

## References

- [Tests](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV2EthBUSDIR_20230602/AaveV2EthBUSDIR_20230602Test.t.sol)
- [proposalCode](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV2EthBUSDIR_20230602/AaveV2EthBUSDIR_20230602.sol)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
