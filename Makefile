# include .env file and export its env vars
# (-include to ignore error if it does not exist)
-include .env

# deps
update:; forge update

# Build & test
build  :; forge build --via-ir

test   :; forge test --via-ir -vvv

test-usdt-v3-ethereum :; forge test -vvv --match-contract AaveV3EthUSDTPayloadTest

# Utilities
download :; cast etherscan-source --chain ${chain} -d src/etherscan/${chain}_${address} ${address}
git-diff :
	@mkdir -p diffs
	@printf '%s\n%s\n%s\n' "\`\`\`diff" "$$(git diff --no-index --diff-algorithm=patience --ignore-space-at-eol ${before} ${after})" "\`\`\`" > diffs/${out}.md


# ################ EXAMPLE ################
# The script section will be periodically cleaned up as each script will usually just be executed once
# The commented out section suits as an example for contributors and should not be altered

# Create proposal (always mainnet on Governance v2)
create-proposal-ledger :; forge script script/CreateMainnetProposals.s.sol:CreateCbETHProposal --rpc-url mainnet --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} -vvvv
create-proposal-pk :; forge script script/CreateMainnetProposals.s.sol:CreateCbETHProposal --rpc-url mainnet --broadcast --legacy --private-key ${PRIVATE_KEY} -vvvv
# notice: mocking sender to be the ecosystem reserve so proposition power is enough in simulation
emit-create-proposal :; forge script script/CreateMainnetProposals.s.sol:SafeSinglePayloadProposal --rpc-url mainnet -vv --sender 0x25F2226B597E8F9514B3F68F00f494cF4f286491

# Deploy MAINNET payload
# Make sure you properly setup `ETHERSCAN_API_KEY_MAINNET` for verification
cb-ledger :;  forge script script/DeployMainnetPayload.s.sol:CbETH --rpc-url mainnet --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
cb-pk :;  forge script script/DeployMainnetPayload.s.sol:CbETH --rpc-url mainnet --broadcast --legacy --private-key ${PRIVATE_KEY} --verify -vvvv

# Deploy POLYGON payload
# Make sure you properly setup `ETHERSCAN_API_KEY_POLYGON` for verification
mai-ledger :;  forge script script/DeployPolygonPayload.s.sol:MiMatic --rpc-url polygon --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
mai-pk :;  forge script script/DeployPolygonPayload.s.sol:MiMatic --rpc-url polygon --broadcast --legacy --private-key ${PRIVATE_KEY} --verify -vvvv

# Deploy OPTIMISM payload
# Make sure you properly setup `ETHERSCAN_API_KEY_OPTIMISM` for verification
op-ledger :;  forge script script/DeployOptimismPayload.s.sol:Op --rpc-url optimism --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
op-pk :;  forge script script/DeployOptimismPayload.s.sol:Op --rpc-url optimism --broadcast --legacy --private-key ${PRIVATE_KEY} --verify -vvvv

# Deploy ARBITRUM payload
# Make sure you properly setup `ETHERSCAN_API_KEY_ARBITRUM` for verification
caps-ledger :;  forge script script/DeployArbitrumPayload.s.sol:ArbCaps --rpc-url arbitrum --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
caps-pk :;  forge script script/DeployArbitrumPayload.s.sol:ArbCaps --rpc-url arbitrum --broadcast --legacy --private-key ${PRIVATE_KEY} --verify -vvvv
# ################ EXAMPLE END #############

# YOUR SCRIPT GOES BELOW HERE

# Gauntlet rates updates
# the content of AaveV3MultichainRatesUpdate-Mar7.t.sol needs to be commented
deploy-pol-payload-rates-mar7 :; forge script src/AaveV3RatesUpdates_20230307/AaveV3RatesUpdates_20230307.s.sol:DeployPayloadPolygon --rpc-url polygon --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
deploy-opt-payload-rates-mar7 :; forge script src/AaveV3RatesUpdates_20230307/AaveV3RatesUpdates_20230307.s.sol:DeployPayloadOptimism --rpc-url optimism --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
deploy-arb-payload-rates-mar7 :; forge script src/AaveV3RatesUpdates_20230307/AaveV3RatesUpdates_20230307.s.sol:DeployPayloadArbitrum --rpc-url arbitrum --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv

emit-create-proposal-rates-mar7 :; forge script src/AaveV3RatesUpdates_20230307/AaveV3RatesUpdates_20230307.s.sol:CreateProposal --rpc-url mainnet -vv --sender 0x25F2226B597E8F9514B3F68F00f494cF4f286491

# ACI LUSD OP listing

test-aci-lusd-op :; forge test -vvv --match-contract AaveV3OPNewListings_20230327
test-function-lusd-op :; forge test -vvv --match-contract AaveV3OPNewListings_20230327 --match-test testLUSD
