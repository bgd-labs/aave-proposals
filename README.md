# BGD v3 bridge listing template

This template contains an opinionated smart contract template for creating proposals to list assets on the aave polygon v3 market.

For a proposal to be executed on polygon it needs to pass mainnet governance proposal that sends an encoded payload via `sendMessageToChild(address,bytes)` on [FX_ROOT](https://etherscan.io/address/0xfe5e5D361b2ad62c541bAb87C45a0B9B018389a2#code)(mainnet) to [FX_CHILD](https://polygonscan.com/address/0x8397259c983751DAf40400790063935a11afa28a#code)(polygon). Once the state is synced to `FX_CHILD` on polygon network it will queue the payload on [POLYGON_BRIDGE_EXECUTOR](https://polygonscan.com/address/0xdc9A35B16DB4e126cFeDC41322b3a36454B1F772#code).

## About

To simplify the process of creating a cross chain proposal this repository contains an opinionated [CrosschainForwarderPolygon](/src/contracts/polygon/CrosschainForwarderPolygon.sol) which expects a payload address deployed on the polygon network as the only parameter. The mainnet proposal payload will then be a simple `execute()` signature with `DELEGATECALL` enabled.

![visualization](/bridge-listing.png)

## Getting started

To create a proposal you have to do two things:

1. create and deploy the polygon payload for your proposal ([see MiMatic as reference](/src/contracts/polygon/MiMaticPayload.sol))
2. run the deploy script to create the mainnet proposal

## References

- [crosschain-bridge repository](https://github.com/aave/governance-crosschain-bridges#polygon-governance-bridge)
- [first ever polygon bridge proposal](https://github.com/pakim249CAL/Polygon-Asset-Deployment-Generic-Executor)
