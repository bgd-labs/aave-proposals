---
title: Freeze TUSD Reserve on Aave V2 Ethereum
author: Marc Zeller (@marczeller), Aave-Chan initiative
discussions: https://governance.aave.com/t/arfc-freeze-tusd-on-aave-v2-ethereum-pool/13835
---

## Simple Summary

This AIP proposes to Freeze the TUSD reserve on the Aave V2 Ethereum pool

## Motivation

Following recent events with the TUSD asset, The ACI propose to freeze the TUSD reserve on the Aave V2 Ethereum pool. This will prevent users from depositing or borrowing TUSD on the Aave V2 Ethereum pool. This will not affect current positions. Users will still be able to repay and withdraw TUSD from the Aave V2 Ethereum pool.
This AIP is designed to take a conservative approach to the TUSD situation. It will allow the community to take a step back and assess the situation before making any further decisions.

## Specification

This AIP will call freezeReserve() method from the Aave V2 Pool Configurator contract for TUSD.

```solidity
contract AaveV2FreezeReserves_20230627 is IProposalGenericExecutor {
  address public constant TUSD = AaveV2EthereumAssets.TUSD_UNDERLYING;

  function execute() external {
    AaveV2Ethereum.POOL_CONFIGURATOR.freezeReserve(TUSD);
  }
}
```

## References

- [proposalCode](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV2FreezeReserves_20230627/AaveV2FreezeReserves_20230627.sol)
- [Tests](https://github.com/bgd-labs/aave-proposals/blob/main/src/AaveV2FreezeReserves_20230627/AaveV2FreezeReserves_20230627.t.sol)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
