---
title: Polygon v2 - Parameter Update
author: TokenLogic
discussions: https://governance.aave.com/t/arfc-polygon-v2-parameter-update/12817
shortDescription: Encourage Polygon v2 users to migrate to v3
---

# Simple Summary

This AIP will update risk parameters on Polygon v2 to encourage users to migrate funds to v3. No users funds are at risk.

# Abstract

With SD, MaticX and stMATIC rewards being distributed across v3, Aave DAO can further encourage the migration of users to the safer v3 protocol. 

This will be achieved by updating the Uoptimal, Reserve Factor (RF) and Slope2 parameters. This is expected to increase borrowing rates, with deposit rates remaining unchanged. 

# Motivation

Currently, there are two communities distributing three tokens across Polygon v3. 

* SD - Stader Labs
* MaticX & stMATIC - Polygon Foundation

This has led to Polygon v3 offering better deposit rates relative to v2. The TVL on v3 is increasing, largely due to incentives and LSTs being added to the liquidity pool whilst v2's TVL remains more correlated to asset spot pricing.

Liquidity Mining on v3 is encouraging users to migrate and this AIP will further encourage migration by holding v2 deposit rates constant and increasing v2 borrowing costs.

The approach presented has successfully passed [TEMP CHECK](https://snapshot.org/#/aave.eth/proposal/0x478169c0840488588b31d7e23b889b5f9442057db9c7a5b9b6cfdd61fe7108ff) and [ARFC](https://snapshot.org/#/aave.eth/proposal/0x013f763e92d253926bc7f04d79138593a1b31c969a34db7f0955e46850c796d9) votes, with the community electing to migrate via Option 2, the conservative approach. 

This AIP contains revised parameter updates in line with the ARFC Snapshot methodology. The methodogoly applied has been reviewed by Chaos Labs and Gauntlet at the time the ARFC was voted on. 

# Specification

The following parameters are to be updated:

|Asset|Uoptimal|RF |Slope 2|
|---|---|---|---|
|DAI|71.00%|21.00%|105.00%|
|USDC|77.00%|23.00%|134.00%|
|USDT|52.00%|22.00%|236.00%|
|wBTC|37.00%|55.00%|536.00%|
|wETH|40.00%|45.00%|167.00%|
|MATIC|48.00%|41.00%|440.00%|
|BAL|65.00%|32.00%|236.00%|
|CRV|25.00%|38.00%|392.00%|
|GHST|23.00%|60.00%|413.00%|
|LINK|25.00%|50.00%|402.00%|


# Implementation

A list of relevant links like for this proposal:

* [Governance Forum Discussion](https://governance.aave.com/t/arfc-polygon-v2-parameter-update/12817)
* [Test Cases](https://github.com/defijesus/aave-proposals/blob/main/src/AaveV2PolygonRatesUpdates_20230614/AaveV2PolygonRatesUpdates_20230614.t.sol)
* [Pre-Post Payload Diff](https://github.com/defijesus/aave-proposals/blob/main/diffs/preTestPolygonUpdate20230614_postTestPolygonUpdate20230614.md)
* [Payload Implementation](https://github.com/defijesus/aave-proposals/blob/main/src/AaveV2PolygonRatesUpdates_20230614/AaveV2PolygonRatesUpdates_20230614.sol)
* [Deployed Contracts](https://polygonscan.com/address/0xbbd2b7418395d1782f0016095c6a26487d184873#code)

The proposal Payload was reviewed by [Bored Ghost Developing](https://bgdlabs.com/).

# Disclaimer

The author, TokenLogic, receives payment indirectly from [Aave Grant DAO](https://twitter.com/AaveGrants) via [Butter](https://twitter.com/butterymoney) as part of the [Incentivised Delegate Campaign](https://governance.aave.com/t/temp-check-incentivized-delegate-campaign-3-month/11732). [TokenLogic is a delegate](https://governance.aave.com/t/tokenlogic-delegate-platform/12516) within Aave community. 

Delegate: [0xA06c2e5BB33cd6718b08EC9335081Cbba62861f7](https://app.aave.com/governance/)

# Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).