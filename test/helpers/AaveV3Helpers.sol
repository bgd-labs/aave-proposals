// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.13;

import 'forge-std/console.sol';
import {Vm} from 'forge-std/Vm.sol';

interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount)
        external
        returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender)
        external
        view
        returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}

struct TokenData {
    string symbol;
    address tokenAddress;
}

struct ReserveTokens {
    address aToken;
    address stableDebtToken;
    address variableDebtToken;
}

struct ReserveConfig {
    string symbol;
    address underlying;
    address aToken;
    address stableDebtToken;
    address variableDebtToken;
    uint256 decimals;
    uint256 ltv;
    uint256 liquidationThreshold;
    uint256 liquidationBonus;
    uint256 liquidationProtocolFee;
    uint256 reserveFactor;
    bool usageAsCollateralEnabled;
    bool borrowingEnabled;
    address interestRateStrategy;
    bool stableBorrowRateEnabled;
    bool isActive;
    bool isFrozen;
    bool isSiloed;
    uint256 supplyCap;
    uint256 borrowCap;
    uint256 debtCeiling;
    uint256 eModeCategory;
}

struct ReserveConfigurationMap {
    //bit 0-15: LTV
    //bit 16-31: Liq. threshold
    //bit 32-47: Liq. bonus
    //bit 48-55: Decimals
    //bit 56: reserve is active
    //bit 57: reserve is frozen
    //bit 58: borrowing is enabled
    //bit 59: stable rate borrowing enabled
    //bit 60: asset is paused
    //bit 61: borrowing in isolation mode is enabled
    //bit 62-63: reserved
    //bit 64-79: reserve factor
    //bit 80-115 borrow cap in whole tokens, borrowCap == 0 => no cap
    //bit 116-151 supply cap in whole tokens, supplyCap == 0 => no cap
    //bit 152-167 liquidation protocol fee
    //bit 168-175 eMode category
    //bit 176-211 unbacked mint cap in whole tokens, unbackedMintCap == 0 => minting disabled
    //bit 212-251 debt ceiling for isolation mode with (ReserveConfiguration::DEBT_CEILING_DECIMALS) decimals
    //bit 252-255 unused

    uint256 data;
}

struct ReserveData {
    //stores the reserve configuration
    ReserveConfigurationMap configuration;
    //the liquidity index. Expressed in ray
    uint128 liquidityIndex;
    //the current supply rate. Expressed in ray
    uint128 currentLiquidityRate;
    //variable borrow index. Expressed in ray
    uint128 variableBorrowIndex;
    //the current variable borrow rate. Expressed in ray
    uint128 currentVariableBorrowRate;
    //the current stable borrow rate. Expressed in ray
    uint128 currentStableBorrowRate;
    //timestamp of last update
    uint40 lastUpdateTimestamp;
    //the id of the reserve. Represents the position in the list of the active reserves
    uint16 id;
    //aToken address
    address aTokenAddress;
    //stableDebtToken address
    address stableDebtTokenAddress;
    //variableDebtToken address
    address variableDebtTokenAddress;
    //address of the interest rate strategy
    address interestRateStrategyAddress;
    //the current treasury balance, scaled
    uint128 accruedToTreasury;
    //the outstanding unbacked aTokens minted through the bridging feature
    uint128 unbacked;
    //the outstanding debt borrowed against this asset in isolation mode
    uint128 isolationModeTotalDebt;
}

struct InterestStrategyValues {
    uint256 excessUtilization;
    uint256 optimalUtilization;
    address addressesProvider;
    uint256 baseVariableBorrowRate;
    uint256 stableRateSlope1;
    uint256 stableRateSlope2;
    uint256 variableRateSlope1;
    uint256 variableRateSlope2;
}

interface IAddressesProvider {
    function getPriceOracle() external returns (address);
}

interface IAaveOracle {
    function getSourceOfAsset(address asset) external returns (address);

    function getAssetPrice(address asset) external returns (address);
}

interface IReserveInterestRateStrategy {
    function getMaxVariableBorrowRate() external view returns (uint256);

    function EXCESS_UTILIZATION_RATE() external view returns (uint256);

    function OPTIMAL_UTILIZATION_RATE() external view returns (uint256);

    function addressesProvider() external view returns (address);

    function baseVariableBorrowRate() external view returns (uint256);

    function stableRateSlope1() external view returns (uint256);

    function stableRateSlope2() external view returns (uint256);

    function variableRateSlope1() external view returns (uint256);

    function variableRateSlope2() external view returns (uint256);
}

interface IProtocolDataProvider {
    function getReserveConfigurationData(address asset)
        external
        view
        returns (
            uint256 decimals,
            uint256 ltv,
            uint256 liquidationThreshold,
            uint256 liquidationBonus,
            uint256 reserveFactor,
            bool usageAsCollateralEnabled,
            bool borrowingEnabled,
            bool stableBorrowRateEnabled,
            bool isActive,
            bool isFrozen
        );

    function getAllReservesTokens() external view returns (TokenData[] memory);

    function getReserveTokensAddresses(address asset)
        external
        view
        returns (
            address aTokenAddress,
            address stableDebtTokenAddress,
            address variableDebtTokenAddress
        );

    function getReserveCaps(address asset)
        external
        view
        returns (uint256 borrowCap, uint256 supplyCap);

    function getDebtCeiling(address asset) external view returns (uint256);

    function getReserveEModeCategory(address asset)
        external
        view
        returns (uint256);

    function getSiloedBorrowing(address asset) external view returns (bool);

    function getLiquidationProtocolFee(address asset)
        external
        view
        returns (uint256);

    function getUnbackedMintCap(address asset) external view returns (uint256);

    function getDebtCeilingDecimals() external pure returns (uint256);
}

interface IAavePool {
    function supply(
        address asset,
        uint256 amount,
        address onBehalfOf,
        uint16 referralCode
    ) external;

    function borrow(
        address asset,
        uint256 amount,
        uint256 interestRateMode,
        uint16 referralCode,
        address onBehalfOf
    ) external;

    function repay(
        address asset,
        uint256 amount,
        uint256 interestRateMode,
        address onBehalfOf
    ) external returns (uint256);

    function withdraw(
        address asset,
        uint256 amount,
        address to
    ) external returns (uint256);

    function getReserveData(address asset)
        external
        view
        returns (ReserveData memory);
}

interface IInitializableAdminUpgradeabilityProxy {
    function upgradeTo(address newImplementation) external;

    function upgradeToAndCall(address newImplementation, bytes calldata data)
        external
        payable;

    function admin() external returns (address);

    function implementation() external returns (address);
}

library AaveV3Helpers {
    IProtocolDataProvider internal constant PDP =
        IProtocolDataProvider(0x69FA688f1Dc47d4B5d8029D5a35FB7a548310654);

    IAavePool internal constant POOL =
        IAavePool(0x794a61358D6845594F94dc1DB02A252b5b4814aD);

    address internal constant POOL_CONFIGURATOR =
        0x8145eddDf43f50276641b55bd3AD95944510021E;

    uint256 internal constant RAY = 1e27;

    address internal constant ADDRESSES_PROVIDER =
        0xa97684ead0e402dC232d5A977953DF7ECBaB3CDb;

    struct LocalVars {
        TokenData[] reserves;
        ReserveConfig[] configs;
    }

    function _getReservesConfigs(bool withLogs)
        internal
        view
        returns (ReserveConfig[] memory)
    {
        LocalVars memory vars;

        vars.reserves = PDP.getAllReservesTokens();

        vars.configs = new ReserveConfig[](vars.reserves.length);

        for (uint256 i = 0; i < vars.reserves.length; i++) {
            vars.configs[i] = _getStructReserveConfig(vars.reserves[i]);
            ReserveTokens memory reserveTokens = _getStructReserveTokens(
                vars.configs[i].underlying
            );
            vars.configs[i].aToken = reserveTokens.aToken;
            vars.configs[i].variableDebtToken = reserveTokens.variableDebtToken;
            vars.configs[i].stableDebtToken = reserveTokens.stableDebtToken;
            if (withLogs) {
                _logReserveConfig(vars.configs[i]);
            }
        }

        return vars.configs;
    }

    /// @dev Ugly, but necessary to avoid Stack Too Deep
    function _getStructReserveConfig(TokenData memory reserve)
        internal
        view
        returns (ReserveConfig memory)
    {
        ReserveConfig memory localConfig;
        (
            uint256 decimals,
            uint256 ltv,
            uint256 liquidationThreshold,
            uint256 liquidationBonus,
            uint256 reserveFactor,
            bool usageAsCollateralEnabled,
            bool borrowingEnabled,
            bool stableBorrowRateEnabled,
            bool isActive,
            bool isFrozen
        ) = PDP.getReserveConfigurationData(reserve.tokenAddress);
        localConfig.symbol = reserve.symbol;
        localConfig.underlying = reserve.tokenAddress;
        localConfig.decimals = decimals;
        localConfig.ltv = ltv;
        localConfig.liquidationThreshold = liquidationThreshold;
        localConfig.liquidationBonus = liquidationBonus;
        localConfig.reserveFactor = reserveFactor;
        localConfig.usageAsCollateralEnabled = usageAsCollateralEnabled;
        localConfig.borrowingEnabled = borrowingEnabled;
        localConfig.stableBorrowRateEnabled = stableBorrowRateEnabled;
        localConfig.interestRateStrategy = POOL
            .getReserveData(reserve.tokenAddress)
            .interestRateStrategyAddress;
        localConfig.isActive = isActive;
        localConfig.isFrozen = isFrozen;
        localConfig.isSiloed = PDP.getSiloedBorrowing(reserve.tokenAddress);
        (localConfig.borrowCap, localConfig.supplyCap) = PDP.getReserveCaps(
            reserve.tokenAddress
        );
        localConfig.debtCeiling = PDP.getDebtCeiling(reserve.tokenAddress);
        localConfig.eModeCategory = PDP.getReserveEModeCategory(
            reserve.tokenAddress
        );
        localConfig.liquidationProtocolFee = PDP.getLiquidationProtocolFee(
            reserve.tokenAddress
        );

        return localConfig;
    }

    /// @dev Ugly, but necessary to avoid Stack Too Deep
    function _getStructReserveTokens(address underlyingAddress)
        internal
        view
        returns (ReserveTokens memory)
    {
        ReserveTokens memory reserveTokens;
        (
            reserveTokens.aToken,
            reserveTokens.stableDebtToken,
            reserveTokens.variableDebtToken
        ) = PDP.getReserveTokensAddresses(underlyingAddress);

        return reserveTokens;
    }

    function _findReserveConfig(
        ReserveConfig[] memory configs,
        string memory symbolOfUnderlying,
        bool withLogs
    ) internal view returns (ReserveConfig memory) {
        for (uint256 i = 0; i < configs.length; i++) {
            if (
                keccak256(abi.encodePacked(configs[i].symbol)) ==
                keccak256(abi.encodePacked(symbolOfUnderlying))
            ) {
                if (withLogs) {
                    _logReserveConfig(configs[i]);
                }
                return configs[i];
            }
        }
        revert('RESERVE_CONFIG_NOT_FOUND');
    }

    function _logReserveConfig(ReserveConfig memory config) internal view {
        console.log('Symbol ', config.symbol);
        console.log('Underlying address ', config.underlying);
        console.log('AToken address ', config.aToken);
        console.log('Stable debt token address ', config.stableDebtToken);
        console.log('Variable debt token address ', config.variableDebtToken);
        console.log('Decimals ', config.decimals);
        console.log('LTV ', config.ltv);
        console.log('Liquidation Threshold ', config.liquidationThreshold);
        console.log('Liquidation Bonus ', config.liquidationBonus);
        console.log('Liquidation protocol fee ', config.liquidationProtocolFee);
        console.log('Reserve Factor ', config.reserveFactor);
        console.log(
            'Usage as collateral enabled ',
            (config.usageAsCollateralEnabled) ? 'Yes' : 'No'
        );
        console.log(
            'Borrowing enabled ',
            (config.borrowingEnabled) ? 'Yes' : 'No'
        );
        console.log(
            'Stable borrow rate enabled ',
            (config.stableBorrowRateEnabled) ? 'Yes' : 'No'
        );
        console.log('Supply cap ', config.supplyCap);
        console.log('Borrow cap ', config.borrowCap);
        console.log('Debt ceiling ', config.debtCeiling);
        console.log('eMode category ', config.eModeCategory);
        console.log('Interest rate strategy ', config.interestRateStrategy);
        console.log('Is active ', (config.isActive) ? 'Yes' : 'No');
        console.log('Is frozen ', (config.isFrozen) ? 'Yes' : 'No');
        console.log('Is siloed ', (config.isSiloed) ? 'Yes' : 'No');
        console.log('-----');
        console.log('-----');
    }

    function _validateReserveConfig(
        ReserveConfig memory expectedConfig,
        ReserveConfig[] memory allConfigs
    ) internal view {
        ReserveConfig memory config = _findReserveConfig(
            allConfigs,
            expectedConfig.symbol,
            false
        );
        require(
            keccak256(bytes(config.symbol)) ==
                keccak256(bytes(expectedConfig.symbol)),
            '_validateConfigsInAave() : INVALID_SYMBOL'
        );
        require(
            config.underlying == expectedConfig.underlying,
            '_validateConfigsInAave() : INVALID_UNDERLYING'
        );
        require(
            config.decimals == expectedConfig.decimals,
            '_validateConfigsInAave: INVALID_DECIMALS'
        );
        require(
            config.ltv == expectedConfig.ltv,
            '_validateConfigsInAave: INVALID_LTV'
        );
        require(
            config.liquidationThreshold == expectedConfig.liquidationThreshold,
            '_validateConfigsInAave: INVALID_LIQ_THRESHOLD'
        );
        require(
            config.liquidationBonus == expectedConfig.liquidationBonus,
            '_validateConfigsInAave: INVALID_LIQ_BONUS'
        );
        require(
            config.liquidationProtocolFee ==
                expectedConfig.liquidationProtocolFee,
            '_validateConfigsInAave: INVALID_LIQUIDATION_PROTOCOL_FEE'
        );
        require(
            config.reserveFactor == expectedConfig.reserveFactor,
            '_validateConfigsInAave: INVALID_RESERVE_FACTOR'
        );

        require(
            config.usageAsCollateralEnabled ==
                expectedConfig.usageAsCollateralEnabled,
            '_validateConfigsInAave: INVALID_USAGE_AS_COLLATERAL'
        );
        require(
            config.borrowingEnabled == expectedConfig.borrowingEnabled,
            '_validateConfigsInAave: INVALID_BORROWING_ENABLED'
        );
        require(
            config.stableBorrowRateEnabled ==
                expectedConfig.stableBorrowRateEnabled,
            '_validateConfigsInAave: INVALID_STABLE_BORROW_ENABLED'
        );
        require(
            config.isActive == expectedConfig.isActive,
            '_validateConfigsInAave: INVALID_IS_ACTIVE'
        );
        require(
            config.isFrozen == expectedConfig.isFrozen,
            '_validateConfigsInAave: INVALID_IS_FROZEN'
        );
        require(
            config.isSiloed == expectedConfig.isSiloed,
            '_validateConfigsInAave: INVALID_IS_SILOED'
        );
        require(
            config.supplyCap == expectedConfig.supplyCap,
            '_validateConfigsInAave: INVALID_SUPPLY_CAP'
        );
        require(
            config.borrowCap == expectedConfig.borrowCap,
            '_validateConfigsInAave: INVALID_BORROW_CAP'
        );
        require(
            config.debtCeiling == expectedConfig.debtCeiling,
            '_validateConfigsInAave: INVALID_DEBT_CEILING'
        );
        require(
            config.eModeCategory == expectedConfig.eModeCategory,
            '_validateConfigsInAave: INVALID_EMODE_CATEGORY'
        );
        require(
            config.interestRateStrategy == expectedConfig.interestRateStrategy,
            '_validateConfigsInAave: INVALID_INTEREST_RATE_STRATEGY'
        );
    }

    function _validateInterestRateStrategy(
        address asset,
        address expectedStrategy,
        InterestStrategyValues memory expectedStrategyValues
    ) internal view {
        IReserveInterestRateStrategy strategy = IReserveInterestRateStrategy(
            POOL.getReserveData(asset).interestRateStrategyAddress
        );

        require(
            address(strategy) == expectedStrategy,
            '_validateInterestRateStrategy() : INVALID_STRATEGY_ADDRESS'
        );

        require(
            strategy.EXCESS_UTILIZATION_RATE() ==
                expectedStrategyValues.excessUtilization,
            '_validateInterestRateStrategy() : INVALID_EXCESS_RATE'
        );
        require(
            strategy.OPTIMAL_UTILIZATION_RATE() ==
                expectedStrategyValues.optimalUtilization,
            '_validateInterestRateStrategy() : INVALID_OPTIMAL_RATE'
        );
        require(
            strategy.addressesProvider() ==
                expectedStrategyValues.addressesProvider,
            '_validateInterestRateStrategy() : INVALID_ADDRESSES_PROVIDER'
        );
        require(
            strategy.baseVariableBorrowRate() ==
                expectedStrategyValues.baseVariableBorrowRate,
            '_validateInterestRateStrategy() : INVALID_BASE_VARIABLE_BORROW'
        );
        require(
            strategy.stableRateSlope1() ==
                expectedStrategyValues.stableRateSlope1,
            '_validateInterestRateStrategy() : INVALID_STABLE_SLOPE_1'
        );
        require(
            strategy.stableRateSlope2() ==
                expectedStrategyValues.stableRateSlope2,
            '_validateInterestRateStrategy() : INVALID_STABLE_SLOPE_2'
        );
        require(
            strategy.variableRateSlope1() ==
                expectedStrategyValues.variableRateSlope1,
            '_validateInterestRateStrategy() : INVALID_VARIABLE_SLOPE_1'
        );
        require(
            strategy.variableRateSlope2() ==
                expectedStrategyValues.variableRateSlope2,
            '_validateInterestRateStrategy() : INVALID_VARIABLE_SLOPE_2'
        );
        require(
            strategy.getMaxVariableBorrowRate() ==
                expectedStrategyValues.baseVariableBorrowRate +
                    expectedStrategyValues.variableRateSlope1 +
                    expectedStrategyValues.variableRateSlope2,
            '_validateInterestRateStrategy() : INVALID_VARIABLE_SLOPE_2'
        );
    }

    function _noReservesConfigsChangesApartNewListings(
        ReserveConfig[] memory allConfigsBefore,
        ReserveConfig[] memory allConfigsAfter
    ) internal pure {
        for (uint256 i = 0; i < allConfigsBefore.length; i++) {
            _requireNoChangeInConfigs(allConfigsBefore[i], allConfigsAfter[i]);
        }
    }

    function _noReservesConfigsChangesApartFrom(
        ReserveConfig[] memory allConfigsBefore,
        ReserveConfig[] memory allConfigsAfter,
        string memory assetChangedSymbol
    ) internal pure {
        require(
            allConfigsBefore.length == allConfigsAfter.length,
            'A_UNEXPECTED_NEW_LISTING_HAPPENED'
        );

        for (uint256 i = 0; i < allConfigsBefore.length; i++) {
            if (
                keccak256(abi.encodePacked(assetChangedSymbol)) !=
                keccak256(abi.encodePacked(allConfigsBefore[i].symbol))
            ) {
                _requireNoChangeInConfigs(
                    allConfigsBefore[i],
                    allConfigsAfter[i]
                );
            }
        }
    }

    function _requireNoChangeInConfigs(
        ReserveConfig memory config1,
        ReserveConfig memory config2
    ) internal pure {
        require(
            keccak256(abi.encodePacked(config1.symbol)) ==
                keccak256(abi.encodePacked(config2.symbol)),
            '_noReservesConfigsChangesApartNewListings() : UNEXPECTED_SYMBOL_CHANGED'
        );
        require(
            config1.underlying == config2.underlying,
            '_noReservesConfigsChangesApartNewListings() : UNEXPECTED_UNDERLYING_CHANGED'
        );
        require(
            config1.decimals == config2.decimals,
            '_noReservesConfigsChangesApartNewListings() : UNEXPECTED_DECIMALS_CHANGED'
        );
        require(
            config1.ltv == config2.ltv,
            '_noReservesConfigsChangesApartNewListings() : UNEXPECTED_LTV_CHANGED'
        );
        require(
            config1.liquidationThreshold == config2.liquidationThreshold,
            '_noReservesConfigsChangesApartNewListings() : UNEXPECTED_LIQ_THRESHOLD_CHANGED'
        );
        require(
            config1.liquidationBonus == config2.liquidationBonus,
            '_noReservesConfigsChangesApartNewListings() : UNEXPECTED_LIQ_BONUS_CHANGED'
        );
        require(
            config1.reserveFactor == config2.reserveFactor,
            '_noReservesConfigsChangesApartNewListings() : UNEXPECTED_RESERVE_FACTOR_CHANGED'
        );
        require(
            config1.usageAsCollateralEnabled ==
                config2.usageAsCollateralEnabled,
            '_noReservesConfigsChangesApartNewListings() : UNEXPECTED_USAGE_AS_COLLATERAL_ENABLED_CHANGED'
        );
        require(
            config1.borrowingEnabled == config2.borrowingEnabled,
            '_noReservesConfigsChangesApartNewListings() : UNEXPECTED_BORROWING_ENABLED_CHANGED'
        );

        require(
            config1.stableBorrowRateEnabled == config2.stableBorrowRateEnabled,
            '_noReservesConfigsChangesApartNewListings() : UNEXPECTED_STABLE_BORROWING_CHANGED'
        );
        require(
            config1.isActive == config2.isActive,
            '_noReservesConfigsChangesApartNewListings() : UNEXPECTED_IS_ACTIVE_CHANGED'
        );
        require(
            config1.isFrozen == config2.isFrozen,
            '_noReservesConfigsChangesApartNewListings() : UNEXPECTED_IS_FROZEN_CHANGED'
        );
    }

    function _validateCountOfListings(
        uint256 count,
        ReserveConfig[] memory allConfigsBefore,
        ReserveConfig[] memory allConfigsAfter
    ) internal pure {
        require(
            allConfigsBefore.length == allConfigsAfter.length - count,
            '_validateCountOfListings() : INVALID_COUNT_OF_LISTINGS'
        );
    }

    function _validateReserveTokensImpls(
        Vm vm,
        ReserveConfig memory config,
        ReserveTokens memory expectedImpls
    ) internal {
        vm.startPrank(POOL_CONFIGURATOR);
        require(
            IInitializableAdminUpgradeabilityProxy(config.aToken)
                .implementation() == expectedImpls.aToken,
            '_validateReserveTokensImpls() : INVALID_ATOKEN_IMPL'
        );
        require(
            IInitializableAdminUpgradeabilityProxy(config.variableDebtToken)
                .implementation() == expectedImpls.variableDebtToken,
            '_validateReserveTokensImpls() : INVALID_ATOKEN_IMPL'
        );
        require(
            IInitializableAdminUpgradeabilityProxy(config.stableDebtToken)
                .implementation() == expectedImpls.stableDebtToken,
            '_validateReserveTokensImpls() : INVALID_ATOKEN_IMPL'
        );
        vm.stopPrank();
    }

    function _deposit(
        Vm vm,
        address depositor,
        address onBehalfOf,
        address asset,
        uint256 amount,
        bool approve,
        address aToken
    ) internal {
        uint256 aTokenBefore = IERC20(aToken).balanceOf(onBehalfOf);
        vm.deal(depositor, 1 ether);
        vm.startPrank(depositor);
        if (approve) {
            IERC20(asset).approve(address(POOL), amount);
        }
        POOL.supply(asset, amount, onBehalfOf, 0);
        vm.stopPrank();
        uint256 aTokenAfter = IERC20(aToken).balanceOf(onBehalfOf);

        require(
            _almostEqual(aTokenAfter, aTokenBefore + amount),
            '_deposit() : ERROR'
        );
    }

    function _borrow(
        Vm vm,
        address borrower,
        address onBehalfOf,
        address asset,
        uint256 amount,
        uint256 interestRateMode,
        address debtToken
    ) public {
        uint256 debtBefore = IERC20(debtToken).balanceOf(onBehalfOf);
        vm.deal(borrower, 1 ether);
        vm.startPrank(borrower);
        POOL.borrow(asset, amount, interestRateMode, 0, onBehalfOf);
        vm.stopPrank();

        uint256 debtAfter = IERC20(debtToken).balanceOf(onBehalfOf);
        require(
            _almostEqual(debtAfter, debtBefore + amount),
            '_borrow() : ERROR'
        );
    }

    function _repay(
        Vm vm,
        address whoRepays,
        address debtor,
        address asset,
        uint256 amount,
        uint256 interestRateMode,
        address debtToken,
        bool approve
    ) internal {
        uint256 debtBefore = IERC20(debtToken).balanceOf(debtor);
        vm.deal(whoRepays, 1 ether);
        vm.startPrank(whoRepays);
        if (approve) {
            IERC20(asset).approve(address(POOL), amount);
        }
        POOL.repay(asset, amount, interestRateMode, debtor);
        vm.stopPrank();

        uint256 debtAfter = IERC20(debtToken).balanceOf(debtor);

        require(
            debtAfter == ((debtBefore > amount) ? debtBefore - amount : 0),
            '_repay() : INCONSISTENT_DEBT_AFTER'
        );
    }

    function _withdraw(
        Vm vm,
        address whoWithdraws,
        address to,
        address asset,
        uint256 amount,
        address aToken
    ) internal {
        uint256 aTokenBefore = IERC20(aToken).balanceOf(whoWithdraws);
        vm.deal(whoWithdraws, 1 ether);
        vm.startPrank(whoWithdraws);

        POOL.withdraw(asset, amount, to);
        vm.stopPrank();
        uint256 aTokenAfter = IERC20(aToken).balanceOf(whoWithdraws);

        require(
            aTokenAfter ==
                ((aTokenBefore > amount) ? aTokenBefore - amount : 0),
            '_withdraw() : INCONSISTENT_ATOKEN_BALANCE_AFTER'
        );
    }

    function _validateAssetSourceOnOracle(address asset, address expectedSource)
        external
    {
        IAaveOracle oracle = IAaveOracle(
            IAddressesProvider(ADDRESSES_PROVIDER).getPriceOracle()
        );

        require(
            oracle.getSourceOfAsset(asset) == expectedSource,
            '_validateAssetSourceOnOracle() : INVALID_PRICE_SOURCE'
        );
    }

    function _validateAssetsOnEmodeCategory(
        uint256 category,
        ReserveConfig[] memory assetsConfigs,
        string[] memory expectedAssets
    ) internal pure {
        string[] memory assetsInCategory = new string[](assetsConfigs.length);

        uint256 countCategory;
        for (uint256 i = 0; i < assetsConfigs.length; i++) {
            if (assetsConfigs[i].eModeCategory == category) {
                assetsInCategory[countCategory] = assetsConfigs[i].symbol;
                require(
                    keccak256(bytes(assetsInCategory[countCategory])) ==
                        keccak256(bytes(expectedAssets[countCategory])),
                    '_getAssetOnEmodeCategory(): INCONSISTENT_ASSETS'
                );
                countCategory++;
                if (countCategory > expectedAssets.length) {
                    revert(
                        '_getAssetOnEmodeCategory(): MORE_ASSETS_IN_CATEGORY_THAN_EXPECTED'
                    );
                }
            }
        }
        if (countCategory < expectedAssets.length) {
            revert(
                '_getAssetOnEmodeCategory(): LESS_ASSETS_IN_CATEGORY_THAN_EXPECTED'
            );
        }
    }

    /// @dev To contemplate +1/-1 precision issues when rounding, mainly on aTokens
    function _almostEqual(uint256 a, uint256 b) internal pure returns (bool) {
        if (b == 0) {
            return (a == b) || (a == (b + 1));
        } else {
            return (a == b) || (a == (b + 1)) || (a == (b - 1));
        }
    }
}
