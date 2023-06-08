# How to contribute

## Proposal

Your proposal should follow the following naming Convention:

- `src/Aave[V2|V3][Topic]_[YYYY][MM][DD]/Aave[V2|V3][Topic]_[YYYY][MM][DD].s.sol`
- `src/Aave[V2|V3][Topic]_[YYYY][MM][DD]/Aave[V2|V3][Network][Topic]_[YYYY][MM][DD].sol`
- `src/Aave[V2|V3][Topic]_[YYYY][MM][DD]/Aave[V2|V3][Network|Multi][Topic]_[YYYY][MM][DD]_Test.t.sol`

While the proposal tests can be combined in a single file, when addressing multiple networks, each payload should be placed in it's own file. The reason for this is that foundry verification will upload all contracts on verification, eventually bloating the code tab and making it hard to verify code on-chain.

## AIP

- `src/Aave[V2|V3][Topic]_[YYYY][MM][DD]/Topic.md`

Markdown files will automatically be uploaded to ipfs once merged to main.

## Testing

## Submitting changes

## Conventions
