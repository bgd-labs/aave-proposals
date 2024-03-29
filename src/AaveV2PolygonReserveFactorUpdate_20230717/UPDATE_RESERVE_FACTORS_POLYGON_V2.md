---
title: Reserve Factor Updates - Polygon Aave v2
author: TokenLogic
discussions: https://governance.aave.com/t/arfc-reserve-factor-updates-polygon-aave-v2/13937
---

# Simple Summary

This AIP will update Reserve Factors (RF) on Polygon v2 to encourage users to migrate funds to v3.

# Motivation

With the goal of transitioning users from Polygon v2 to v3, this publication, if implemented, will increase the RF of asset on the v2 deployment.

Increasing the RF routes a larger portion of the interest paid by users to Aave DAO’s Treasury. User’s funds are not at risk of liquidation and the borrowing rate remains unchanged.

By progressively increasing the reserve factors, the interest rate for supplying these assets on v2 will be increasingly less attractive, thus encouraging suppliers to transition positions to v3.

Of the assets that are currently frozen, with the exception of BAL, the RF is to be increaed to 99.99%. Around $680k of users positions, CRV, DPI, GHST and LINK will receive near zero deposit yield. This represents less than 0.5% of Aave v2’s TVL. The highest deposit yield of these assets at the time of writing is 0.21%. This change will have minimal affect.

The remaining assets are to receive an incremental 5% increase in the RF. After implementing this publication, user elasticity shall be assessed and the impact of the updates before moving forward with additional increases.

# Specification

The following parameters are to be updated as follows:

|Asset|Reserve Factor |
|---|---|
|DAI|26.00%|
|USDC|28.00%|
|USDT|27.00%|
|wBTC|60.00%|
|wETH|50.00%|
|MATIC|46.00%|
|BAL|37.00%|
|CRV|99.99%|
|GHST|99.99%|
|LINK|99.99%|


# Implementation

A list of relevant links like for this proposal:

* [Governance Forum Discussion](https://governance.aave.com/t/arfc-reserve-factor-updates-polygon-aave-v2/13937)

* [Test Cases](https://github.com/defijesus/aave-proposals/blob/reserve-factor-polygon-v2/src/AaveV2PolygonReserveFactorUpdate_20230717/AaveV2PolygonReserveFactorUpdate_20230717.t.sol)

* [Payload Implementation](https://github.com/defijesus/aave-proposals/blob/reserve-factor-polygon-v2/src/AaveV2PolygonReserveFactorUpdate_20230717/AaveV2PolygonReserveFactorUpdate_20230717.sol)

* [Pre-Post Payload Protocol Diff](https://github.com/defijesus/aave-proposals/blob/reserve-factor-polygon-v2/diffs/preTestPolygonReserveFactorUpdate20230717_postTestPolygonReserveFactorUpdate20230717.md)

* [Deployed Contracts](https://polygonscan.com/address/0x812ddad273544754d0672a009c27550899e658aa#code)

The proposal Payload was reviewed by [Bored Ghost Developing](https://bgdlabs.com/).

# Disclaimer

The author, TokenLogic, receives payment indirectly from [Aave Grant DAO](https://twitter.com/AaveGrants) via [Butter](https://twitter.com/butterymoney) as part of the [Incentivised Delegate Campaign](https://governance.aave.com/t/temp-check-incentivized-delegate-campaign-3-month/11732). [TokenLogic is a delegate](https://governance.aave.com/t/tokenlogic-delegate-platform/12516) within Aave community. 

Delegate: [0x2cc1ADE245020FC5AAE66Ad443e1F66e01c54Df1](https://app.aave.com/governance/)

# Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).