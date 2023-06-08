```diff
diff --git a/src/DefaultReserveInterestRateStrategy/contracts/dependencies/openzeppelin/contracts/IERC20.sol b/src/DefaultReserveInterestRateStrategy/contracts/dependencies/openzeppelin/contracts/IERC20.sol
new file mode 100644
index 0000000..3d69bff
--- /dev/null
+++ b/src/DefaultReserveInterestRateStrategy/contracts/dependencies/openzeppelin/contracts/IERC20.sol
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: agpl-3.0
+pragma solidity 0.6.12;
+
+/**
+ * @dev Interface of the ERC20 standard as defined in the EIP.
+ */
+interface IERC20 {
+  /**
+   * @dev Returns the amount of tokens in existence.
+   */
+  function totalSupply() external view returns (uint256);
+
+  /**
+   * @dev Returns the amount of tokens owned by `account`.
+   */
+  function balanceOf(address account) external view returns (uint256);
+
+  /**
+   * @dev Moves `amount` tokens from the caller's account to `recipient`.
+   *
+   * Returns a boolean value indicating whether the operation succeeded.
+   *
+   * Emits a {Transfer} event.
+   */
+  function transfer(address recipient, uint256 amount) external returns (bool);
+
+  /**
+   * @dev Returns the remaining number of tokens that `spender` will be
+   * allowed to spend on behalf of `owner` through {transferFrom}. This is
+   * zero by default.
+   *
+   * This value changes when {approve} or {transferFrom} are called.
+   */
+  function allowance(address owner, address spender) external view returns (uint256);
+
+  /**
+   * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
+   *
+   * Returns a boolean value indicating whether the operation succeeded.
+   *
+   * IMPORTANT: Beware that changing an allowance with this method brings the risk
+   * that someone may use both the old and the new allowance by unfortunate
+   * transaction ordering. One possible solution to mitigate this race
+   * condition is to first reduce the spender's allowance to 0 and set the
+   * desired value afterwards:
+   * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
+   *
+   * Emits an {Approval} event.
+   */
+  function approve(address spender, uint256 amount) external returns (bool);
+
+  /**
+   * @dev Moves `amount` tokens from `sender` to `recipient` using the
+   * allowance mechanism. `amount` is then deducted from the caller's
+   * allowance.
+   *
+   * Returns a boolean value indicating whether the operation succeeded.
+   *
+   * Emits a {Transfer} event.
+   */
+  function transferFrom(
+    address sender,
+    address recipient,
+    uint256 amount
+  ) external returns (bool);
+
+  /**
+   * @dev Emitted when `value` tokens are moved from one account (`from`) to
+   * another (`to`).
+   *
+   * Note that `value` may be zero.
+   */
+  event Transfer(address indexed from, address indexed to, uint256 value);
+
+  /**
+   * @dev Emitted when the allowance of a `spender` for an `owner` is set by
+   * a call to {approve}. `value` is the new allowance.
+   */
+  event Approval(address indexed owner, address indexed spender, uint256 value);
+}
diff --git a/etherscan/137_0x78Fe5d0427E669ba9F964C3495fF381a805a0487/DefaultReserveInterestRateStrategy/@aave/protocol-v2/contracts/dependencies/openzeppelin/contracts/SafeMath.sol b/src/DefaultReserveInterestRateStrategy/contracts/dependencies/openzeppelin/contracts/SafeMath.sol
similarity index 100%
rename from etherscan/137_0x78Fe5d0427E669ba9F964C3495fF381a805a0487/DefaultReserveInterestRateStrategy/@aave/protocol-v2/contracts/dependencies/openzeppelin/contracts/SafeMath.sol
rename to src/DefaultReserveInterestRateStrategy/contracts/dependencies/openzeppelin/contracts/SafeMath.sol
diff --git a/etherscan/137_0x78Fe5d0427E669ba9F964C3495fF381a805a0487/DefaultReserveInterestRateStrategy/@aave/protocol-v2/contracts/interfaces/ILendingPoolAddressesProvider.sol b/src/DefaultReserveInterestRateStrategy/contracts/interfaces/ILendingPoolAddressesProvider.sol
similarity index 100%
rename from etherscan/137_0x78Fe5d0427E669ba9F964C3495fF381a805a0487/DefaultReserveInterestRateStrategy/@aave/protocol-v2/contracts/interfaces/ILendingPoolAddressesProvider.sol
rename to src/DefaultReserveInterestRateStrategy/contracts/interfaces/ILendingPoolAddressesProvider.sol
diff --git a/etherscan/137_0x78Fe5d0427E669ba9F964C3495fF381a805a0487/DefaultReserveInterestRateStrategy/@aave/protocol-v2/contracts/interfaces/ILendingRateOracle.sol b/src/DefaultReserveInterestRateStrategy/contracts/interfaces/ILendingRateOracle.sol
similarity index 100%
rename from etherscan/137_0x78Fe5d0427E669ba9F964C3495fF381a805a0487/DefaultReserveInterestRateStrategy/@aave/protocol-v2/contracts/interfaces/ILendingRateOracle.sol
rename to src/DefaultReserveInterestRateStrategy/contracts/interfaces/ILendingRateOracle.sol
diff --git a/etherscan/137_0x78Fe5d0427E669ba9F964C3495fF381a805a0487/DefaultReserveInterestRateStrategy/@aave/protocol-v2/contracts/interfaces/IReserveInterestRateStrategy.sol b/src/DefaultReserveInterestRateStrategy/contracts/interfaces/IReserveInterestRateStrategy.sol
similarity index 65%
rename from etherscan/137_0x78Fe5d0427E669ba9F964C3495fF381a805a0487/DefaultReserveInterestRateStrategy/@aave/protocol-v2/contracts/interfaces/IReserveInterestRateStrategy.sol
rename to src/DefaultReserveInterestRateStrategy/contracts/interfaces/IReserveInterestRateStrategy.sol
index 430145e..cee593c 100644
--- a/etherscan/137_0x78Fe5d0427E669ba9F964C3495fF381a805a0487/DefaultReserveInterestRateStrategy/@aave/protocol-v2/contracts/interfaces/IReserveInterestRateStrategy.sol
+++ b/src/DefaultReserveInterestRateStrategy/contracts/interfaces/IReserveInterestRateStrategy.sol
@@ -13,7 +13,25 @@ interface IReserveInterestRateStrategy {
 
   function calculateInterestRates(
     address reserve,
-    uint256 utilizationRate,
+    uint256 availableLiquidity,
+    uint256 totalStableDebt,
+    uint256 totalVariableDebt,
+    uint256 averageStableBorrowRate,
+    uint256 reserveFactor
+  )
+    external
+    view
+    returns (
+      uint256,
+      uint256,
+      uint256
+    );
+
+  function calculateInterestRates(
+    address reserve,
+    address aToken,
+    uint256 liquidityAdded,
+    uint256 liquidityTaken,
     uint256 totalStableDebt,
     uint256 totalVariableDebt,
     uint256 averageStableBorrowRate,
diff --git a/etherscan/137_0x78Fe5d0427E669ba9F964C3495fF381a805a0487/DefaultReserveInterestRateStrategy/@aave/protocol-v2/contracts/protocol/lendingpool/DefaultReserveInterestRateStrategy.sol b/src/DefaultReserveInterestRateStrategy/contracts/protocol/lendingpool/DefaultReserveInterestRateStrategy.sol
similarity index 73%
rename from etherscan/137_0x78Fe5d0427E669ba9F964C3495fF381a805a0487/DefaultReserveInterestRateStrategy/@aave/protocol-v2/contracts/protocol/lendingpool/DefaultReserveInterestRateStrategy.sol
rename to src/DefaultReserveInterestRateStrategy/contracts/protocol/lendingpool/DefaultReserveInterestRateStrategy.sol
index 6f45004..5d994e3 100644
--- a/etherscan/137_0x78Fe5d0427E669ba9F964C3495fF381a805a0487/DefaultReserveInterestRateStrategy/@aave/protocol-v2/contracts/protocol/lendingpool/DefaultReserveInterestRateStrategy.sol
+++ b/src/DefaultReserveInterestRateStrategy/contracts/protocol/lendingpool/DefaultReserveInterestRateStrategy.sol
@@ -7,6 +7,7 @@ import {WadRayMath} from '../libraries/math/WadRayMath.sol';
 import {PercentageMath} from '../libraries/math/PercentageMath.sol';
 import {ILendingPoolAddressesProvider} from '../../interfaces/ILendingPoolAddressesProvider.sol';
 import {ILendingRateOracle} from '../../interfaces/ILendingRateOracle.sol';
+import {IERC20} from '../../dependencies/openzeppelin/contracts/IERC20.sol';
 
 /**
  * @title DefaultReserveInterestRateStrategy contract
@@ -96,6 +97,42 @@ contract DefaultReserveInterestRateStrategy is IReserveInterestRateStrategy {
     return _baseVariableBorrowRate.add(_variableRateSlope1).add(_variableRateSlope2);
   }
 
+  /**
+   * @dev Calculates the interest rates depending on the reserve's state and configurations
+   * @param reserve The address of the reserve
+   * @param liquidityAdded The liquidity added during the operation
+   * @param liquidityTaken The liquidity taken during the operation
+   * @param totalStableDebt The total borrowed from the reserve a stable rate
+   * @param totalVariableDebt The total borrowed from the reserve at a variable rate
+   * @param averageStableBorrowRate The weighted average of all the stable rate loans
+   * @param reserveFactor The reserve portion of the interest that goes to the treasury of the market
+   * @return The liquidity rate, the stable borrow rate and the variable borrow rate
+   **/
+  function calculateInterestRates(
+    address reserve,
+    address aToken,
+    uint256 liquidityAdded,
+    uint256 liquidityTaken,
+    uint256 totalStableDebt,
+    uint256 totalVariableDebt,
+    uint256 averageStableBorrowRate,
+    uint256 reserveFactor
+  ) external view override returns (uint256, uint256, uint256) {
+    uint256 availableLiquidity = IERC20(reserve).balanceOf(aToken);
+    //avoid stack too deep
+    availableLiquidity = availableLiquidity.add(liquidityAdded).sub(liquidityTaken);
+
+    return
+      calculateInterestRates(
+        reserve,
+        availableLiquidity,
+        totalStableDebt,
+        totalVariableDebt,
+        averageStableBorrowRate,
+        reserveFactor
+      );
+  }
+
   struct CalcInterestRatesLocalVars {
     uint256 totalDebt;
     uint256 currentVariableBorrowRate;
@@ -105,9 +142,11 @@ contract DefaultReserveInterestRateStrategy is IReserveInterestRateStrategy {
   }
 
   /**
-   * @dev Calculates the interest rates depending on the reserve's state and configurations
+   * @dev Calculates the interest rates depending on the reserve's state and configurations.
+   * NOTE This function is kept for compatibility with the previous DefaultInterestRateStrategy interface.
+   * New protocol implementation uses the new calculateInterestRates() interface
    * @param reserve The address of the reserve
-   * @param availableLiquidity The liquidity available in the reserve
+   * @param availableLiquidity The liquidity available in the corresponding aToken
    * @param totalStableDebt The total borrowed from the reserve a stable rate
    * @param totalVariableDebt The total borrowed from the reserve at a variable rate
    * @param averageStableBorrowRate The weighted average of all the stable rate loans
@@ -121,16 +160,7 @@ contract DefaultReserveInterestRateStrategy is IReserveInterestRateStrategy {
     uint256 totalVariableDebt,
     uint256 averageStableBorrowRate,
     uint256 reserveFactor
-  )
-    external
-    view
-    override
-    returns (
-      uint256,
-      uint256,
-      uint256
-    )
-  {
+  ) public view override returns (uint256, uint256, uint256) {
     CalcInterestRatesLocalVars memory vars;
 
     vars.totalDebt = totalStableDebt.add(totalVariableDebt);
@@ -138,17 +168,18 @@ contract DefaultReserveInterestRateStrategy is IReserveInterestRateStrategy {
     vars.currentStableBorrowRate = 0;
     vars.currentLiquidityRate = 0;
 
-    uint256 utilizationRate =
-      vars.totalDebt == 0
-        ? 0
-        : vars.totalDebt.rayDiv(availableLiquidity.add(vars.totalDebt));
+    vars.utilizationRate = vars.totalDebt == 0
+      ? 0
+      : vars.totalDebt.rayDiv(availableLiquidity.add(vars.totalDebt));
 
     vars.currentStableBorrowRate = ILendingRateOracle(addressesProvider.getLendingRateOracle())
       .getMarketBorrowRate(reserve);
 
-    if (utilizationRate > OPTIMAL_UTILIZATION_RATE) {
-      uint256 excessUtilizationRateRatio =
-        utilizationRate.sub(OPTIMAL_UTILIZATION_RATE).rayDiv(EXCESS_UTILIZATION_RATE);
+    if (vars.utilizationRate > OPTIMAL_UTILIZATION_RATE) {
+      uint256 excessUtilizationRateRatio = vars
+        .utilizationRate
+        .sub(OPTIMAL_UTILIZATION_RATE)
+        .rayDiv(EXCESS_UTILIZATION_RATE);
 
       vars.currentStableBorrowRate = vars.currentStableBorrowRate.add(_stableRateSlope1).add(
         _stableRateSlope2.rayMul(excessUtilizationRateRatio)
@@ -159,22 +190,19 @@ contract DefaultReserveInterestRateStrategy is IReserveInterestRateStrategy {
       );
     } else {
       vars.currentStableBorrowRate = vars.currentStableBorrowRate.add(
-        _stableRateSlope1.rayMul(utilizationRate.rayDiv(OPTIMAL_UTILIZATION_RATE))
+        _stableRateSlope1.rayMul(vars.utilizationRate.rayDiv(OPTIMAL_UTILIZATION_RATE))
       );
       vars.currentVariableBorrowRate = _baseVariableBorrowRate.add(
-        utilizationRate.rayMul(_variableRateSlope1).rayDiv(OPTIMAL_UTILIZATION_RATE)
+        vars.utilizationRate.rayMul(_variableRateSlope1).rayDiv(OPTIMAL_UTILIZATION_RATE)
       );
     }
 
     vars.currentLiquidityRate = _getOverallBorrowRate(
       totalStableDebt,
       totalVariableDebt,
-      vars
-        .currentVariableBorrowRate,
+      vars.currentVariableBorrowRate,
       averageStableBorrowRate
-    )
-      .rayMul(utilizationRate)
-      .percentMul(PercentageMath.PERCENTAGE_FACTOR.sub(reserveFactor));
+    ).rayMul(vars.utilizationRate).percentMul(PercentageMath.PERCENTAGE_FACTOR.sub(reserveFactor));
 
     return (
       vars.currentLiquidityRate,
@@ -205,8 +233,9 @@ contract DefaultReserveInterestRateStrategy is IReserveInterestRateStrategy {
 
     uint256 weightedStableRate = totalStableDebt.wadToRay().rayMul(currentAverageStableBorrowRate);
 
-    uint256 overallBorrowRate =
-      weightedVariableRate.add(weightedStableRate).rayDiv(totalDebt.wadToRay());
+    uint256 overallBorrowRate = weightedVariableRate.add(weightedStableRate).rayDiv(
+      totalDebt.wadToRay()
+    );
 
     return overallBorrowRate;
   }
diff --git a/etherscan/137_0x78Fe5d0427E669ba9F964C3495fF381a805a0487/DefaultReserveInterestRateStrategy/@aave/protocol-v2/contracts/protocol/libraries/helpers/Errors.sol b/src/DefaultReserveInterestRateStrategy/contracts/protocol/libraries/helpers/Errors.sol
similarity index 100%
rename from etherscan/137_0x78Fe5d0427E669ba9F964C3495fF381a805a0487/DefaultReserveInterestRateStrategy/@aave/protocol-v2/contracts/protocol/libraries/helpers/Errors.sol
rename to src/DefaultReserveInterestRateStrategy/contracts/protocol/libraries/helpers/Errors.sol
diff --git a/etherscan/137_0x78Fe5d0427E669ba9F964C3495fF381a805a0487/DefaultReserveInterestRateStrategy/@aave/protocol-v2/contracts/protocol/libraries/math/PercentageMath.sol b/src/DefaultReserveInterestRateStrategy/contracts/protocol/libraries/math/PercentageMath.sol
similarity index 100%
rename from etherscan/137_0x78Fe5d0427E669ba9F964C3495fF381a805a0487/DefaultReserveInterestRateStrategy/@aave/protocol-v2/contracts/protocol/libraries/math/PercentageMath.sol
rename to src/DefaultReserveInterestRateStrategy/contracts/protocol/libraries/math/PercentageMath.sol
diff --git a/etherscan/137_0x78Fe5d0427E669ba9F964C3495fF381a805a0487/DefaultReserveInterestRateStrategy/@aave/protocol-v2/contracts/protocol/libraries/math/WadRayMath.sol b/src/DefaultReserveInterestRateStrategy/contracts/protocol/libraries/math/WadRayMath.sol
similarity index 100%
rename from etherscan/137_0x78Fe5d0427E669ba9F964C3495fF381a805a0487/DefaultReserveInterestRateStrategy/@aave/protocol-v2/contracts/protocol/libraries/math/WadRayMath.sol
rename to src/DefaultReserveInterestRateStrategy/contracts/protocol/libraries/math/WadRayMath.sol
```
