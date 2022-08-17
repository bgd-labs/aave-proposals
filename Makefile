# include .env file and export its env vars
# (-include to ignore error if it does not exist)
-include .env

# deps
update:; forge update

# Build & test
build  :; forge build --sizes

test   :; forge test -vvv
deploy-mai :;  forge script script/DeployPolygonMiMatic.s.sol:DeployPolygonMiMatic --rpc-url ${RPC_URL} --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify --etherscan-api-key ${ETHERSCAN_API_KEY} -vvvv
verify-mai :;  forge script script/DeployPolygonMiMatic.s.sol:DeployPolygonMiMatic --rpc-url ${RPC_URL} --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify --etherscan-api-key ${ETHERSCAN_API_KEY} -vvvv
deploy-frax :;  forge script script/DeployPolygonFrax.s.sol:DeployPolygonFrax --rpc-url ${RPC_URL} --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify --etherscan-api-key ${ETHERSCAN_API_KEY} -vvvv
verify-frax :;  forge script script/DeployPolygonFrax.s.sol:DeployPolygonFrax --rpc-url ${RPC_URL} --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify --etherscan-api-key ${ETHERSCAN_API_KEY} -vvvv