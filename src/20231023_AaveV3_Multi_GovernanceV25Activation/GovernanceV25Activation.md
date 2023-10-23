---
title: "Governance v2.5 Activation"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/bgd-aave-governance-v3-activation-plan/14993/10"
---

## Simple Summary

Proposal for the partial activation of Aave Governance v3 in an interim Aave Governance v2.5 version, without the new voting mechanism and assets, but including all other components (a.DI, Governance v3 execution layer, Robot).


## Motivation

After noticing a problem with the voting assets implementation included in [proposal 345](https://app.aave.com/governance/proposal/345/), we proceeded to cancel it and expand the security procedures around them.

As voting (and assets) are a pretty isolated component within the Aave Governance v3 project, in order to progress with the release of a.DI (Aave Delivery Network) and all non-voting mechanisms of Governance v3, we decided to propose to the community a partial migration to a v2.5 interim version, which will also simplify the final v3 transition.

## Specification

Different from proposal 345, this migration to v2.5 only requires a Level 1 (Short) Executor component. An extensive list of actions executed can be found [HERE](), but as summary, the proposal will:
- Migrate all Level 1 (Short) permissions of the Aave ecosystem smart contracts from the v2 Executors to v3 Executors.
- Fund a.DI.
- Fund Aave Robot.
- Fund the Aave Gelato gas tank.

For transparency, high-level, the items not included compared with proposal 345 are:
- Migration of Level 2 (Long) permissions of the Aave ecosystem to the v3 Executors.
- Migration of the Level 1 (Short) Executor admin to the v3 Executor, in order to keep Governance v2 operative until the final v3 activation.
- Upgrade of the AAVE, aAAVE and stkAAVE implementations.


## References

- Payloads implementations: [Ethereum Short](https://github.com/bgd-labs/gov-v2-v3-migration/blob/main/src/contracts/governance2.5/EthShortMovePermissionsPayload.sol), [Optimism](https://github.com/bgd-labs/gov-v2-v3-migration/blob/main/src/contracts/governance2.5/OptMovePermissionsPayload.sol), [Arbitrum](https://github.com/bgd-labs/gov-v2-v3-migration/blob/main/src/contracts/governance2.5/ArbMovePermissionsPayload.sol), [Polygon](https://github.com/bgd-labs/gov-v2-v3-migration/blob/main/src/contracts/governance2.5/PolygonMovePermissionsPayload.sol), [Avalanche](https://github.com/bgd-labs/gov-v2-v3-migration/blob/main/src/contracts/governance2.5/AvaxMovePermissionsPayload.sol), [Metis](https://github.com/bgd-labs/gov-v2-v3-migration/blob/main/src/contracts/governance2.5/MetisMovePermissionsPayload.sol), [Base](https://github.com/bgd-labs/gov-v2-v3-migration/blob/main/src/contracts/governance2.5/BaseMovePermissionsPayload.sol)

- Payloads tests (migration): [Ethereum Short](https://github.com/bgd-labs/gov-v2-v3-migration/blob/main/tests/governance2.5/EthShortMovePermissionsPayloadTest.t.sol), [Optimism](https://github.com/bgd-labs/gov-v2-v3-migration/blob/main/tests/governance2.5/OptMovePermissionsPayloadTest.t.sol), [Arbitrum](https://github.com/bgd-labs/gov-v2-v3-migration/blob/main/tests/governance2.5/ArbMovePermissionsPayload.t.sol), [Polygon](https://github.com/bgd-labs/gov-v2-v3-migration/blob/main/tests/governance2.5/PolygonMovePermissionsPayloadTest.t.sol), [Avalanche](https://github.com/bgd-labs/gov-v2-v3-migration/blob/main/tests/governance2.5/AvaxMovePermissionsPayloadTest.t.sol), [Metis](https://github.com/bgd-labs/gov-v2-v3-migration/blob/main/tests/governance2.5/MetisMovePermissionsPayloadTest.t.sol), [Base](https://github.com/bgd-labs/gov-v2-v3-migration/blob/main/tests/governance2.5/BaseMovePermissionsPayloadTest.t.sol)

- [Pre-approval Snapshot](https://snapshot.org/#/aave.eth/proposal/0x7e61744629fce7787281905b4d5984b39f9cbe83fbe2dd05d8b77697205ce0ce)
- [Discussion](https://governance.aave.com/t/bgd-aave-governance-v3-activation-plan/14993/10)
- [a.DI (Aave Delivery Infrastructure)](https://github.com/bgd-labs/aave-delivery-infrastructure)
- [Aave Governance V3 smart contracts](https://github.com/bgd-labs/aave-governance-v3)
- [Aave Robot v3](https://github.com/bgd-labs/aave-governance-v3-robot)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
