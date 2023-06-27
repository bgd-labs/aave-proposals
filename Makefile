# include .env file and export its env vars
# (-include to ignore error if it does not exist)
-include .env

# deps
update:; forge update

# Build & test
build  :; forge build

test   :; forge test -vv
test-contract :; forge test --match-contract ${filter} -vvv

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
create-proposal-ledger :; forge script script/CreateProposals.s.sol:MultiPayloadProposal --rpc-url mainnet --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} -vvvv
create-proposal-pk :; forge script script/CreateProposals.s.sol:SinglePayloadProposal --rpc-url mainnet --broadcast --legacy --private-key ${PRIVATE_KEY} -vvvv
# notice: mocking sender to be the ecosystem reserve so proposition power is enough in simulation
emit-create-proposal :; forge script script/CreateProposals.s.sol:SafeSinglePayloadProposal --rpc-url mainnet -vv --sender 0x25F2226B597E8F9514B3F68F00f494cF4f286491

# Deploy MAINNET payload
# Make sure you properly setup `ETHERSCAN_API_KEY_MAINNET` for verification
cb-ledger :;  forge script script/DeployMainnetPayload.s.sol:ExampleMainnetPayload --rpc-url mainnet --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
cb-pk :;  forge script script/DeployMainnetPayload.s.sol:ExampleMainnetPayload --rpc-url mainnet --broadcast --legacy --private-key ${PRIVATE_KEY} --verify -vvvv

# Deploy POLYGON payload
# Make sure you properly setup `ETHERSCAN_API_KEY_POLYGON` for verification
mai-ledger :;  forge script script/DeployPolygonPayload.s.sol:ExamplePolygonPayload --rpc-url polygon --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
mai-pk :;  forge script script/DeployPolygonPayload.s.sol:ExamplePolygonPayload --rpc-url polygon --broadcast --legacy --private-key ${PRIVATE_KEY} --verify -vvvv

# Deploy OPTIMISM payload
# Make sure you properly setup `ETHERSCAN_API_KEY_OPTIMISM` for verification
op-ledger :;  forge script script/DeployOptimismPayload.s.sol:ExampleOptimismPayload --rpc-url optimism --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
op-pk :;  forge script script/DeployOptimismPayload.s.sol:ExampleOptimismPayload --rpc-url optimism --broadcast --legacy --private-key ${PRIVATE_KEY} --verify -vvvv

# Deploy ARBITRUM payload
# Make sure you properly setup `ETHERSCAN_API_KEY_ARBITRUM` for verification
caps-ledger :;  forge script script/DeployArbitrumPayload.s.sol:ExampleArbitrumPayload --rpc-url arbitrum --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
caps-pk :;  forge script script/DeployArbitrumPayload.s.sol:ExampleArbitrumPayload --rpc-url arbitrum --broadcast --legacy --private-key ${PRIVATE_KEY} --verify -vvvv

# Deploy AVALANCHE payload
# Make sure you properly setup `ETHERSCAN_API_KEY_ARBITRUM` for verification
caps-ledger :;  forge script script/DeployAvalanchePayload.s.sol:ExampleAvalanchePayload --rpc-url arbitrum --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
caps-pk :;  forge script script/DeployAvalanchePayload.s.sol:ExampleAvalanchePayload --rpc-url arbitrum --broadcast --legacy --private-key ${PRIVATE_KEY} --verify -vvvv
# ################ EXAMPLE END #############

# GENERIC SCRIPTS

# GENERIC SCRIPTS END

# YOUR SCRIPT GOES BELOW HERE

# Gauntlet rates updates
# the content of AaveV3MultichainRatesUpdate-Mar7.t.sol needs to be commented
deploy-pol-payload-rates-mar7 :; forge script src/AaveV3RatesUpdates_20230307/AaveV3RatesUpdates_20230307.s.sol:DeployPayloadPolygon --rpc-url polygon --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
deploy-opt-payload-rates-mar7 :; forge script src/AaveV3RatesUpdates_20230307/AaveV3RatesUpdates_20230307.s.sol:DeployPayloadOptimism --rpc-url optimism --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
deploy-arb-payload-rates-mar7 :; forge script src/AaveV3RatesUpdates_20230307/AaveV3RatesUpdates_20230307.s.sol:DeployPayloadArbitrum --rpc-url arbitrum --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv

emit-create-proposal-rates-mar7 :; forge script src/AaveV3RatesUpdates_20230307/AaveV3RatesUpdates_20230307.s.sol:CreateProposal --rpc-url mainnet -vv --sender 0x25F2226B597E8F9514B3F68F00f494cF4f286491

# ACI cbETH Supply cap
deploy-cbeth-eth-payload :; forge script src/AaveV3EthCBETHSupplyCapsPayload_20230328/DeployEthCBETHSupplyCapUpdate_20230328.s.sol:DeployPayloadEthereum --rpc-url mainnet --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
create-cbeth-eth-proposal :; forge script src/AaveV3EthCBETHSupplyCapsPayload_20230328/DeployEthCBETHSupplyCapUpdate_20230328.s.sol:CreateProposal --rpc-url mainnet --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv


# ChaosLabs Risk Params Optimism
deploy-risk-params-mar30-payload :; forge script src/AaveV3OPRiskParams_20230330/DeployAaveV3OPRiskParams_20230330.s.sol:DeployPayloadOptimism --rpc-url mainnet --broadcast --legacy --private-key ${PRIVATE_KEY} --verify -vvvv
create-risk-params-mar30-proposal :; forge script src/AaveV3OPRiskParams_20230330/DeployAaveV3OPRiskParams_20230330.s.sol:CreateProposal --rpc-url mainnet --broadcast --legacy --private-key ${PRIVATE_KEY} --verify -vvvv

# ChaosLabs borrowable isolation update
deploy-borrow-iso-mar30-payload :; forge script src/AaveV3ETHIsoMode_20230330/DeployAaveV3ETHIsoMode_20230330.s.sol:DeployPayloadEthereum --rpc-url mainnet --broadcast --legacy --private-key ${PRIVATE_KEY} --verify -vvvv
create--borrow-iso-mar30-proposal :; forge script src/AaveV3ETHIsoMode_20230330/DeployAaveV3ETHIsoMode_20230330.s.sol:CreateProposal --rpc-url mainnet --broadcast --legacy --private-key ${PRIVATE_KEY} --verify -vvvv

deploy-ava-payload-rates-mar7:; forge script src/AaveV3AvaxRatesUpdates_20230331/DeployAaveV3AvaxRatesUpdatesSteward_20230331.s.sol:DeployPayloadAvalanche --rpc-url avalanche --broadcast --legacy --private-key ${PRIVATE_KEY} --verify -vvvv
deploy-ava-payload-rates-mar7-dry :; forge script src/AaveV3AvaxRatesUpdates_20230331/DeployAaveV3AvaxRatesUpdatesSteward_20230331.s.sol --rpc-url avalanche -vvvv

# ChaosLabs arbitrum supply and borrow caps update
deploy-supply-borrow-caps-mar30-payload :; forge script src/AaveV3ArbSupplyCapsUpdate_20230330/DeployAaveV3ArbSupplyCapsUpdate_20230330.s.sol:DeployPayloadArbitrum --rpc-url arbitrum --broadcast --legacy --private-key ${PRIVATE_KEY} --verify -vvvv
create-supply-borrow-caps-mar30-proposal :; forge script src/AaveV3ArbSupplyCapsUpdate_20230330/DeployAaveV3ArbSupplyCapsUpdate_20230330.s.sol:CreateProposal --rpc-url arbitrum --broadcast --legacy --private-key ${PRIVATE_KEY} --verify -vvvv

# ACI DFS flashborrowers whitelist
deploy-eth-dfs-payload :; forge script src/AaveV3DFSFlashBorrow_20230403/DeployDFSPayloads.s.sol:DFSMainnetPayload --rpc-url mainnet --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
deploy-arb-dfs-payload :; forge script src/AaveV3DFSFlashBorrow_20230403/DeployDFSPayloads.s.sol:DFSArbitrumPayload --rpc-url arbitrum --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
deploy-opt-dfs-payload :; forge script src/AaveV3DFSFlashBorrow_20230403/DeployDFSPayloads.s.sol:DFSOptimismPayload --rpc-url optimism --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
create-dfs-proposal :; forge script src/AaveV3DFSFlashBorrow_20230403/CreateDFSProposal.s.sol:DFSProposal --rpc-url optimism --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv

# ACI Proposal
deploy-aci-payload :; forge script src/AaveV3ACIProposal_20230411/DeployMainnetACIPayload.s.sol:DeployMainnetACIPayload --rpc-url mainnet --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
create-aci-payload :; forge script src/AaveV3ACIProposal_20230411/DeployMainnetACIPayload.s.sol:ACIPayloadProposal --rpc-url mainnet --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv

# AAVE risk params
deploy-aci-payload :; forge script src/AaveV3RiskParams_20230516/DeployMainnetACIPayload.s.sol:DeployMainnetACIPayload --rpc-url mainnet --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
create-aci-payload :; forge script src/AaveV3RiskParams_20230516/DeployMainnetACIPayload.s.sol:ACIPayloadProposal --rpc-url mainnet --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv

deploy-caps-apr21-payload-dry :; forge script src/AaveV3PolCapsUpdate_20230421/DeployAaveV3PolCapsUpdate_20230421.s.sol:DeployPayloadPolygon --rpc-url polygon -vvvv
deploy-caps-apr21-payload :; forge script src/AaveV3PolCapsUpdate_20230421/DeployAaveV3PolCapsUpdate_20230421.s.sol:DeployPayloadPolygon --rpc-url polygon --broadcast --legacy --private-key ${PRIVATE_KEY} --verify -vvvv
emit-create-caps-apr21-proposal :; forge script src/AaveV3PolCapsUpdate_20230421/DeployAaveV3PolCapsUpdate_20230421.s.sol:CreateProposal --rpc-url mainnet --legacy --sender 0x25F2226B597E8F9514B3F68F00f494cF4f286491

# ChaosLabs Caps Update
deploy-pol-caps-update-apr27-payload :; forge script src/AaveV3SupplyBorrowUpdate_20230427/DepolyAaveV3SupplyBorrowUpdatePayloads.s.sol:DeployAaveV3POLSupplyBorrowUpdate_20230427 --rpc-url polygon --broadcast --legacy --private-key ${PRIVATE_KEY} --verify -vvvv
deploy-op-caps-update-apr27-payload :; forge script src/AaveV3SupplyBorrowUpdate_20230427/DepolyAaveV3SupplyBorrowUpdatePayloads.s.sol:DeployAaveV3OPSupplyBorrowUpdate_20230427 --rpc-url optimism --broadcast --legacy --private-key ${PRIVATE_KEY} --verify -vvvv
deploy-eth-caps-update-apr27-payload :; forge script src/AaveV3SupplyBorrowUpdate_20230427/DepolyAaveV3SupplyBorrowUpdatePayloads.s.sol:DeployAaveV3ETHSupplyBorrowUpdate_20230427 --rpc-url mainnet --broadcast --legacy --private-key ${PRIVATE_KEY} --verify -vvvv
deploy-ava-caps-update-apr27-payload :; forge script src/AaveV3SupplyBorrowUpdate_20230427/DepolyAaveV3SupplyBorrowUpdatePayloads.s.sol:DeployAaveV3AVASupplyBorrowUpdate_20230427 --rpc-url avalanche --broadcast --legacy --private-key ${PRIVATE_KEY} --verify -vvvv
deploy-arb-caps-update-apr27-payload :; forge script src/AaveV3SupplyBorrowUpdate_20230427/DepolyAaveV3SupplyBorrowUpdatePayloads.s.sol:DeployAaveV3ARBSupplyBorrowUpdate_20230427 --rpc-url arbitrum --broadcast --legacy --private-key ${PRIVATE_KEY} --verify -vvvv
create-caps-update-apr27-payload :; forge script src/AaveV3SupplyBorrowUpdate_20230427/DepolyAaveV3SupplyBorrowUpdatePayloads.s.sol:CreateProposal --rpc-url mainnet --legacy --sender 0x25F2226B597E8F9514B3F68F00f494cF4f286491

# ChaosLabs risk params for Polygon
deploy-risk-params-poly-apr27 :; forge script src/AaveV3PolRiskParams_20230423/DeployAaveV3PolRiskParams_20230423.s.sol:DeployPayloadPolygon --rpc-url polygon --broadcast --legacy --private-key ${PRIVATE_KEY} --verify -vvvv
create-risk-params-poly-apr27 :; forge script src/AaveV3PolRiskParams_20230423/DeployAaveV3PolRiskParams_20230423.s.sol:CreateProposal --rpc-url polygon --broadcast --legacy --private-key ${PRIVATE_KEY} --verify -vvvv

# Price feeds update
deploy-eth-price-feeds-payload-may4 :; forge script src/AaveV2-V3PriceFeedsUpdate_20230504/DeployAavePriceFeedsUpdate.s.sol:DeployMainnetPayload --rpc-url mainnet --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
deploy-arb-price-feeds-payload-may4 :; forge script src/AaveV2-V3PriceFeedsUpdate_20230504/DeployAavePriceFeedsUpdate.s.sol:DeployArbitrumPayload --rpc-url arbitrum --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
deploy-opt-price-feeds-payload-may4 :; forge script src/AaveV2-V3PriceFeedsUpdate_20230504/DeployAavePriceFeedsUpdate.s.sol:DeployOptimismPayload --rpc-url optimism --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
deploy-pol-price-feeds-payload-may4 :; forge script src/AaveV2-V3PriceFeedsUpdate_20230504/DeployAavePriceFeedsUpdate.s.sol:DeployPolygonPayload --rpc-url polygon --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
create-price-feeds-proposal-may4 :; forge script src/AaveV2-V3PriceFeedsUpdate_20230504/DeployAavePriceFeedsUpdate.s.sol:PriceFeedsUpdateProposal --rpc-url mainnet --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv

# MAI ARB & OP Onboarding
deploy-mai-op-payload :; forge script src/AaveV3OPARBMAIListings_20230425/DeployMainnetARBOPPayloads.s.sol:DeployAaveV3OPMAIListing_20230425 --rpc-url optimism --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
deploy-mai-arb-payload :; forge script src/AaveV3OPARBMAIListings_20230425/DeployMainnetARBOPPayloads.s.sol:DeployAaveV3ARBMAIListing_20230425 --rpc-url arbitrum --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
create-mai-op-proposal :; forge script src/AaveV3OPARBMAIListings_20230425/DeployMainnetARBOPPayloads.s.sol:CreateAaveV3OPMAIListing_20230425 --rpc-url optimism --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
create-mai-op-proposal :; forge script src/AaveV3OPARBMAIListings_20230425/DeployMainnetARBOPPayloads.s.sol:CreateAaveV3ARBMAIListing_20230425 --rpc-url arbitrum --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv

# ir
deploy-polygon-payload :; forge script src/AaveV2PolygonIR_20230519/AaveV2PolygonIR_20230519.s.sol:DeployPolygonPayload --rpc-url polygon --broadcast --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
deploy-ir-proposal :; forge script src/AaveV2PolygonIR_20230519/AaveV2PolygonIR_20230519.s.sol:DeployProposal --rpc-url mainnet --broadcast --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv

# ACI rETH emode and BUSD Offboarding

deploy-rETH-emode-payload :; forge script src/AaveV3EthrETHEmode_20230522/AaveV3ETHrETHEmode_20230522.sol:AaveV3ETHrETHEmode_20230522 --rpc-url mainnet --broadcast --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv

# Steward
deploy-steward-mainnet :; forge script src/AaveV3RiskSteward_20230404/AaveV3RiskSteward_20230404.s.sol:DeployPayloadEthereum --rpc-url mainnet --broadcast --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
deploy-steward-arbitrum :; forge script src/AaveV3RiskSteward_20230404/AaveV3RiskSteward_20230404.s.sol:DeployPayloadArbitrum --rpc-url arbitrum --broadcast --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
deploy-steward-optimism :; forge script src/AaveV3RiskSteward_20230404/AaveV3RiskSteward_20230404.s.sol:DeployPayloadOptimism --rpc-url optimism --broadcast --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
deploy-steward-polygon :; forge script src/AaveV3RiskSteward_20230404/AaveV3RiskSteward_20230404.s.sol:DeployPayloadPolygon --rpc-url polygon --broadcast --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
deploy-steward-avalanche :; forge script src/AaveV3RiskSteward_20230404/AaveV3RiskSteward_20230404.s.sol:DeployPayloadAvalanche --rpc-url avalanche --broadcast --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
deploy-steward-metis :; forge script src/AaveV3RiskSteward_20230404/AaveV3RiskSteward_20230404.s.sol:DeployPayloadMetis --rpc-url metis --broadcast --legacy --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
create-steward-proposal :; forge script src/AaveV3RiskSteward_20230404/AaveV3RiskSteward_20230404.s.sol:CreateProposal --rpc-url mainnet --broadcast --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv

# DFS flashBorrow OP activation

create-dfs-flashborrow-op-proposal :; forge script src/AaveV3DFSFlashBorrow_20230524/CreateDFSProposal.s.sol:DFSProposal --rpc-url mainnet --broadcast --ledger --mnemonics ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv

# BUSD Offboarding plan Part II

deploy-busd-payload :; forge script src/AaveV2EthBUSDIR_20230602/DeployBUSDOffBoard.s.sol:DeployMainnetBUSDPayload --rpc-url mainnet --broadcast --ledger --mnemonics ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vv
create-busd-payload :; forge script src/AaveV2EthBUSDIR_20230602/DeployBUSDOffBoard.s.sol:BUSDPayloadProposal --rpc-url mainnet --broadcast --ledger --mnemonics ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vv

# MAI ARB & OP Fix

test-mai-fix-arb-payload :; forge test -vvv --match-contract AaveV3ArbUpdate_20230327_Test
test-mai-fix-op-payload :; forge test -vvv --match-contract AaveV3OpUpdate_20230327_Test
deploy-mai-fix-op-payload :; forge script src/AaveV3OPARBMAIFixes_20230606/Deploy.s.sol:DeployAaveV3OPMAIFixes_20230606 --rpc-url optimism --broadcast --ledger --mnemonics RANDOM --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
deploy-mai-fix-arb-payload :; forge script src/AaveV3OPARBMAIFixes_20230606/Deploy.s.sol:DeployAaveV3ARBMAIFixes_20230606 --rpc-url arbitrum --broadcast --ledger --mnemonics RANDOM --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
create-mai-proposal :; forge script src/AaveV3OPARBMAIFixes_20230606/Deploy.s.sol:CreateMaiFixesProposal --rpc-url mainnet --broadcast --ledger --mnemonics RANDOM --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv


# 1INCH Onboarding on Ethereum V3

deploy-1inch-eth-payload :; forge script src/AaveV3Eth1INCHListing_20230517/DeployAaveV3Eth1INCHListing_20230517_Payload.s.sol:DeployPayloadEthereum --rpc-url mainnet --broadcast --legacy --private-key ${PRIVATE_KEY} --verify -vvvv
create-1inch-eth-proposal :; forge script src/AaveV3Eth1INCHListing_20230517/DeployAaveV3Eth1INCHListing_20230517_Payload.s.sol:CreateProposal --rpc-url mainnet --legacy --sender 0x25F2226B597E8F9514B3F68F00f494cF4f286491

# ChaosLabs risk params update for Ethereum 20230529

deploy-risk-params-eth-20230529-payload :; forge script src/AaveV3EthRiskParams_20230529/DeployAaveV3EthRiskParams_20230529.s.sol:DeployPayloadEthereum --rpc-url mainnet --broadcast --legacy --private-key ${PRIVATE_KEY} --verify -vvvv
create-risk-params-eth-20230529 :; forge script src/AaveV3EthRiskParams_20230529/DeployAaveV3EthRiskParams_20230529.s.sol:CreateProposal --rpc-url mainnet --legacy --sender 0x25F2226B597E8F9514B3F68F00f494cF4f286491

# ENS Onboarding on Ethereum V3
deploy-ens-eth-payload :; forge script src/AaveV3EthENSListing_20230517/AaveV3EthENSListing_20230517_Payload.s.sol:DeployPayloadEthereum --rpc-url mainnet --broadcast --legacy --private-key ${PRIVATE_KEY} --verify -vvvv
create-ens-eth-proposal :; forge script src/AaveV3EthENSListing_20230517/AaveV3EthENSListing_20230517_Payload.s.sol:CreateProposal --rpc-url mainnet --legacy --sender 0x25F2226B597E8F9514B3F68F00f494cF4f286491

# Price feeds update 13 june
deploy-eth-v2-price-feeds-payload-june13 :; forge script src/AaveV2-V3PriceFeedsUpdate_20230613/DeployAavePriceFeedsUpdate.s.sol:DeployMainnetV2Payload --rpc-url mainnet --broadcast --legacy --ledger --mnemonics a --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
deploy-eth-v3-price-feeds-payload-june13 :; forge script src/AaveV2-V3PriceFeedsUpdate_20230613/DeployAavePriceFeedsUpdate.s.sol:DeployMainnetV3Payload --rpc-url mainnet --broadcast --legacy --ledger --mnemonics a --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
deploy-arb-price-feeds-payload-june13 :; forge script src/AaveV2-V3PriceFeedsUpdate_20230613/DeployAavePriceFeedsUpdate.s.sol:DeployArbitrumPayload --rpc-url arbitrum --broadcast --legacy --ledger --mnemonics a --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
deploy-opt-price-feeds-payload-june13 :; forge script src/AaveV2-V3PriceFeedsUpdate_20230613/DeployAavePriceFeedsUpdate.s.sol:DeployOptimismPayload --rpc-url optimism --broadcast --legacy --ledger --mnemonics a --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
create-price-feeds-proposal-june13 :; forge script src/AaveV2-V3PriceFeedsUpdate_20230613/DeployAavePriceFeedsUpdate.s.sol:PriceFeedsUpdateProposal --rpc-url mainnet --broadcast --legacy --ledger --mnemonics a --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv

# Polygon v2 parameter updates

deploy-polygon-v2-param-updates-payload :; forge script src/AaveV2PolygonRatesUpdates_20230614/DeployPolygonRatesUpdates.s.sol:DeployPolygonV2RatesUpdatesPayload --rpc-url polygon --broadcast --legacy --ledger --mnemonics ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
create-polygon-v2-param-updates-payload :; forge script src/AaveV2PolygonRatesUpdates_20230614/DeployPolygonRatesUpdates.s.sol:PolygonV2RatesUpdatesPayloadProposal --rpc-url polygon --broadcast --legacy --private-key ${PRIVATE_KEY} --verify -vvvv

# add USDCN to arbitrum V3

test-usdcn-arb-payload :; forge test -vvv --match-contract AaveV3ArbNativeUSDCListing_20230621_PayloadTest
deploy-usdcn-arb-payload :; forge script src/AaveV3ArbNativeUSDCListing_20230621/DeployUSDCListing.s.sol:DeployArbUSDNPayload --rpc-url arbitrum --broadcast --ledger --mnemonics ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
create-usdcn-arb-proposal :; forge script src/AaveV3ArbNativeUSDCListing_20230621/DeployUSDCListing.s.sol:USDCNPayloadProposal --rpc-url arbitrum --broadcast --ledger --mnemonics ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv

# V2 freeze reserves Chaos Labs

deploy-V2-freeze :; forge script src/AaveV2FreezeReserves_20230619/DeployV2Freeze.s.sol:DeployPayload --rpc-url mainnet --broadcast --ledger --mnemonics ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
create-V2-freeze :; forge script src/AaveV2FreezeReserves_20230619/DeployV2Freeze.s.sol:CreateProposal --rpc-url mainnet --broadcast --ledger --mnemonics ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv

# V3 Arbitrum Frax Listing

deploy-v3-arb-frax-listing :; forge script src/AaveV3ArbFraxListing_20230619/DeployAaveV3ArbFraxListing.s.sol:DeployAaveV3FraxListingPayload --rpc-url arbitrum --broadcast --ledger --mnemonics ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
create-v3-arb-frax-listing :; forge script src/AaveV3ArbFraxListing_20230619/DeployAaveV3ArbFraxListing.s.sol:AaveV3FraxListingPayloadProposal --rpc-url mainnet --broadcast --legacy --private-key ${PRIVATE_KEY} --verify -vvvv

# V3 Ethereum Frax Listing

deploy-v3-eth-frax-listing :; forge script src/AaveV3EthFraxListing_20230619/DeployAaveV3EthFraxListing.s.sol:DeployAaveV3FraxListingPayload --rpc-url mainnet --broadcast --ledger --mnemonics ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify -vvvv
create-v3-eth-frax-listing :; forge script src/AaveV3EthFraxListing_20230619/DeployAaveV3EthFraxListing.s.sol:AaveV3FraxListingPayloadProposal --rpc-url mainnet --broadcast --legacy --private-key ${PRIVATE_KEY} --verify -vvvv
