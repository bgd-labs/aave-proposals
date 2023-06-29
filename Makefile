# include .env file and export its env vars
# (-include to ignore error if it does not exist)
-include .env

# deps
update:; forge update

# Build & test
build  :; forge build

test   :; forge test -vv
test-contract :; forge test --match-contract ${filter} -vvv


deploy-ledger :; forge script ${contract} --rpc-url ${chain} $(if ${dry},--sender 0x25F2226B597E8F9514B3F68F00f494cF4f286491 -vvvv,--broadcast --ledger --mnemonics foo --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv)
deploy-pk :; forge script ${contract} --rpc-url ${chain} $(if ${dry},--sender 0x25F2226B597E8F9514B3F68F00f494cF4f286491 -vvvv,--broadcast --private-key ${PRIVATE_KEY} --verify -vvvv)

# Utilities
download :; cast etherscan-source --chain ${chain} -d src/etherscan/${chain}_${address} ${address}
git-diff :
	@mkdir -p diffs
	@printf '%s\n%s\n%s\n' "\`\`\`diff" "$$(git diff --no-index --diff-algorithm=patience --ignore-space-at-eol ${before} ${after})" "\`\`\`" > diffs/${out}.md


# ################ EXAMPLE ################
# The commented out section suits as an example for contributors and should not be altered
# See README.md for more details

# Create proposal (always mainnet on Governance v2)
create-proposal-ledger :; make deploy-ledger contract=script/CreateProposals.s.sol:MultiPayloadProposal chain=mainnet
create-proposal-pk :; make deploy-pk contract=script/CreateProposals.s.sol:SinglePayloadProposal chain=mainnet
# notice: mocking sender to be the ecosystem reserve so proposition power is enough in simulation
emit-create-proposal :; make deploy-ledger contract=script/CreateProposals.s.sol:SafeSinglePayloadProposal chain=mainnet dry=true

# Deploy MAINNET payload
# Make sure you properly setup `ETHERSCAN_API_KEY_MAINNET` for verification
cb-ledger :;  make deploy-ledger contract=script/DeployMainnetPayload.s.sol:ExampleMainnetPayload chain=mainnet
cb-pk :;  make deploy-pk contract=script/DeployMainnetPayload.s.sol:ExampleMainnetPayload chain=mainnet

# Deploy POLYGON payload
# Make sure you properly setup `ETHERSCAN_API_KEY_POLYGON` for verification
mai-ledger :;  make deploy-ledger contract=script/DeployPolygonPayload.s.sol:ExamplePolygonPayload chain=polygon
mai-pk :;  make deploy-pk contract=script/DeployPolygonPayload.s.sol:ExamplePolygonPayload chain=polygon

# Deploy OPTIMISM payload
# Make sure you properly setup `ETHERSCAN_API_KEY_OPTIMISM` for verification
op-ledger :;  make deploy-ledger contract=script/DeployOptimismPayload.s.sol:ExampleOptimismPayload chain=optimism
op-pk :;  make deploy-pk contract=script/DeployOptimismPayload.s.sol:ExampleOptimismPayload chain=optimism

# Deploy ARBITRUM payload
# Make sure you properly setup `ETHERSCAN_API_KEY_ARBITRUM` for verification
caps-ledger :;  make deploy-ledger contract=script/DeployArbitrumPayload.s.sol:ExampleArbitrumPayload chain=arbitrum
caps-pk :;  make deploy-pk contract=script/DeployArbitrumPayload.s.sol:ExampleArbitrumPayload chain=arbitrum

# Deploy AVALANCHE payload
# Make sure you properly setup `ETHERSCAN_API_KEY_ARBITRUM` for verification
caps-ledger :;  make deploy-ledger contract=script/DeployAvalanchePayload.s.sol:ExampleAvalanchePayload chain=arbitrum
caps-pk :;  make deploy-pk contract=script/DeployAvalanchePayload.s.sol:ExampleAvalanchePayload chain=arbitrum
# ################ EXAMPLE END #############
