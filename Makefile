# include .env file and export its env vars
# (-include to ignore error if it does not exist)
-include .env

# deps
update:; forge update

# Build & test
build  :; forge build --sizes

test   :; forge test -vvv

# Deploy L2 proposals
deploy-mai-ledger :;  forge script script/DeployPolygonMiMatic.s.sol:DeployPolygonMiMatic --rpc-url ${RPC_URL} --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify --etherscan-api-key ${ETHERSCAN_API_KEY} -vvvv
deploy-mai-pk :;  forge script script/DeployPolygonMiMatic.s.sol:DeployPolygonMiMatic --rpc-url ${RPC_URL} --broadcast --legacy --private-key ${PRIVATE_KEY} --verify --etherscan-api-key ${ETHERSCAN_API_KEY} -vvvv
verify-mai :;  forge script script/DeployPolygonMiMatic.s.sol:DeployPolygonMiMatic --rpc-url ${RPC_URL} --legacy --verify --etherscan-api-key ${ETHERSCAN_API_KEY} -vvvv
deploy-frax-ledger :;  forge script script/DeployPolygonFrax.s.sol:DeployPolygonFrax --rpc-url ${RPC_URL} --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify --etherscan-api-key ${ETHERSCAN_API_KEY} -vvvv
deploy-frax-pk :;  forge script script/DeployPolygonFrax.s.sol:DeployPolygonFrax --rpc-url ${RPC_URL} --broadcast --legacy --private-key ${PRIVATE_KEY} --verify --etherscan-api-key ${ETHERSCAN_API_KEY} -vvvv
verify-frax :;  forge script script/DeployPolygonFrax.s.sol:DeployPolygonFrax --rpc-url ${RPC_URL} --legacy --verify --etherscan-api-key ${ETHERSCAN_API_KEY} -vvvv

# Deploy L1 proposal
deploy-l1-mai-proposal-ledger :; forge script script/DeployL1PolygonProposal.s.sol:DeployMai --rpc-url ${RPC_URL} --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} -vvvv
deploy-l1-mai-proposal-pk :; forge script script/DeployL1PolygonProposal.s.sol:DeployMai --rpc-url ${RPC_URL} --broadcast --legacy --private-key ${PRIVATE_KEY} -vvvv
