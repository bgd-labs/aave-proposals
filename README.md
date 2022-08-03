# Aave v3 cross-chain listing template

This template contains an opinionated smart contract template for creating proposals to list assets on the aave polygon v3 market.

For a proposal to be executed on polygon it needs to pass mainnet governance proposal that sends an encoded payload via `sendMessageToChild(address,bytes)` on [FX_ROOT](https://etherscan.io/address/0xfe5e5D361b2ad62c541bAb87C45a0B9B018389a2#code)(mainnet) to [FX_CHILD](https://polygonscan.com/address/0x8397259c983751DAf40400790063935a11afa28a#code)(polygon). Once the state is synced to `FX_CHILD` on polygon network it will queue the payload on [POLYGON_BRIDGE_EXECUTOR](https://polygonscan.com/address/0xdc9A35B16DB4e126cFeDC41322b3a36454B1F772#code).

## About

To simplify the process of creating a cross chain proposal this repository contains an opinionated [CrosschainForwarderPolygon](/src/contracts/polygon/CrosschainForwarderPolygon.sol) which expects a payload address deployed on the polygon network as the only parameter. The mainnet proposal payload will then be a simple `execute()` signature with `DELEGATECALL` enabled.

![visualization](/bridge-listing.png)

## Getting started

### Build

```sh
forge build
```

### Test

```sh
forge test
```

### Deploy

```sh
# only needed for deployment
cp .env.example .env
sh deploy-polygon.sh <FileName> # DeployPolygonMiMatic
```

## Creating the proposal

To create a proposal you have to do two things:

1. deploy the Polygon Payload ([see MiMatic](/src/contracts/polygon/MiMaticPayload.sol))
2. create the mainnet proposal ([see DeployL1Proposal](/script/DeployL1Proposal.s.sol))

While the order of actions is important as the mainnet proposal needs the l2 payload address, both actions can be performed by different parties / addresses.
The address creating the mainnet proposal requires 80k AAVE of proposition power.

## Deployed addresses

- [CrosschainForwarderPolygon](https://etherscan.io/address/0x158a6bc04f0828318821bae797f50b0a1299d45b#code)

## References

- [crosschain-bridge repository](https://github.com/aave/governance-crosschain-bridges#polygon-governance-bridge)
- [first ever polygon bridge proposal](https://github.com/pakim249CAL/Polygon-Asset-Deployment-Generic-Executor)
