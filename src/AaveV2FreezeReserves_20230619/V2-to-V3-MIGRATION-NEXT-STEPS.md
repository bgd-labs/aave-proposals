---
title: Chaos Labs V2 to V3 Migration Next Steps
author: Chaos Labs (@Chaos Labs)
discussions: https://governance.aave.com/t/arfc-chaos-labs-v2-to-v3-migration-next-steps/13701
---

## Simple Summary

This AIP proposes to Freeze the the 1INCH, ENS, LINK, MKR, SNX & UNI reserves on the Aave V2 Ethereum pool

## Motivation

Following the successful deployment of Aave V3 on the Ethereum network, we propose a reassessment of smaller-to-medium capitalization tokens. Unlike CRV (we will soon contribute further insights on this topic, as the complexity of the CRV market, primarily due to its substantial scale, warrants a more nuanced examination), these markets exhibit a more modest size and generally can be conveniently migrated. This diverges from preceding deliberations on market freezes prior to the V3 launch. With V3 live, invoking a freeze on V2 markets does not preclude users from capitalizing on these markets. Instead, it enhances the community’s capacity to safeguard user funds more effectively, as V3’s advanced risk management mechanisms provide a more secure environment. This proactive strategy aims to enforce a freeze on low-to-medium capital assets on V2, thereby averting a scenario resembling Aave V2’s current overexposure to CRV while permitting users to engage with Aave via V3 markets.

## Specification

This AIP will call freezeReserve() method from the Aave V2 Pool Configurator contract for the following assets: 1INCH, ENS, LINK, MKR, SNX & UNI

```solidity
contract AaveV2FreezeReserves_20230619 is IProposalGenericExecutor {
  address public constant ONEINCH = AaveV2EthereumAssets.ONE_INCH_UNDERLYING;
  address public constant ENS = AaveV2EthereumAssets.ENS_UNDERLYING;
  address public constant LINK = AaveV2EthereumAssets.LINK_UNDERLYING;
  address public constant MKR = AaveV2EthereumAssets.MKR_UNDERLYING;
  address public constant SNX = AaveV2EthereumAssets.SNX_UNDERLYING;
  address public constant UNI = AaveV2EthereumAssets.UNI_UNDERLYING;


  function execute() external {
    AaveV2Ethereum.POOL_CONFIGURATOR.freezeReserve(ONEINCH);
    AaveV2Ethereum.POOL_CONFIGURATOR.freezeReserve(ENS);
    AaveV2Ethereum.POOL_CONFIGURATOR.freezeReserve(LINK);
    AaveV2Ethereum.POOL_CONFIGURATOR.freezeReserve(MKR);
    AaveV2Ethereum.POOL_CONFIGURATOR.freezeReserve(SNX);
    AaveV2Ethereum.POOL_CONFIGURATOR.freezeReserve(UNI);
  }
}
```

## References

- [proposalCode](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV2FreezeReserves_20230619/AaveV2FreezeReserves_20230619.sol)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
