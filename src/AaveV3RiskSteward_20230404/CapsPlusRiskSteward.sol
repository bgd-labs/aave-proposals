// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IACLManager, IPoolConfigurator, IPoolDataProvider} from 'aave-address-book/AaveV3.sol';

library RiskStewardLibrary {
  struct CapUpdate {
    address asset;
    uint256 supplyCap;
    uint256 borrowCap;
  }

  uint256 constant KEEP_CURRENT = type(uint256).max - 1;

  string public constant INVALID_CALLER = '1';
  string public constant NOT_STICTLY_HIGHER = '2';
  string public constant DECOUNCE_NOT_RESPECTED = '3';
  string public constant UPDATE_BIGGER_MAX = '4';
}

contract CapsPlusRiskSteward {
  struct Debounce {
    uint40 supplyCapLastUpdated;
    uint40 borrowCapLastUpdated;
  }

  uint256 public constant MINIMUM_DELAY = 5 days;

  IPoolConfigurator immutable POOL_CONFIGURATOR;
  IPoolDataProvider immutable POOL_DATA_PROVIDER;
  address immutable RISK_COUNCIL;

  mapping(address => Debounce) public timelocks;

  modifier onlyRiskCouncil() {
    require(RISK_COUNCIL == msg.sender, RiskStewardLibrary.INVALID_CALLER);
    _;
  }

  constructor(
    IPoolConfigurator configurator,
    IPoolDataProvider poolDataProvider,
    address riskCouncil
  ) {
    POOL_CONFIGURATOR = configurator;
    POOL_DATA_PROVIDER = poolDataProvider;
    RISK_COUNCIL = riskCouncil;
  }

  /**
   * Allows increasing borrow and supply caps accross multiple assets
   * @dev A cap increase is only possible ever 5 days per asset
   * @dev A cap increase is only allowed to increase the cap by 50%
   * @param capUpdates caps to be updated
   */
  function updateCaps(RiskStewardLibrary.CapUpdate[] memory capUpdates) public onlyRiskCouncil {
    for (uint256 i = 0; i < capUpdates.length; i++) {
      (uint256 currentBorrowCap, uint256 currentSupplyCap) = POOL_DATA_PROVIDER.getReserveCaps(
        capUpdates[i].asset
      );
      Debounce memory debounce = timelocks[capUpdates[i].asset];
      if (capUpdates[i].supplyCap != RiskStewardLibrary.KEEP_CURRENT) {
        require(capUpdates[i].supplyCap > currentSupplyCap, RiskStewardLibrary.NOT_STICTLY_HIGHER);
        require(
          block.timestamp - debounce.supplyCapLastUpdated > MINIMUM_DELAY,
          RiskStewardLibrary.DECOUNCE_NOT_RESPECTED
        );
        require(
          increaseWithinAllowedRange(currentSupplyCap, capUpdates[i].supplyCap),
          RiskStewardLibrary.UPDATE_BIGGER_MAX
        );
        POOL_CONFIGURATOR.setSupplyCap(capUpdates[i].asset, capUpdates[i].supplyCap);
        timelocks[capUpdates[i].asset].supplyCapLastUpdated = uint40(block.timestamp);
      }
      if (capUpdates[i].borrowCap != RiskStewardLibrary.KEEP_CURRENT) {
        require(capUpdates[i].borrowCap > currentBorrowCap, RiskStewardLibrary.NOT_STICTLY_HIGHER);
        require(
          block.timestamp - debounce.borrowCapLastUpdated > MINIMUM_DELAY,
          RiskStewardLibrary.DECOUNCE_NOT_RESPECTED
        );
        require(
          increaseWithinAllowedRange(currentBorrowCap, capUpdates[i].borrowCap),
          RiskStewardLibrary.UPDATE_BIGGER_MAX
        );
        POOL_CONFIGURATOR.setBorrowCap(capUpdates[i].asset, capUpdates[i].borrowCap);
        timelocks[capUpdates[i].asset].borrowCapLastUpdated = uint40(block.timestamp);
      }
    }
  }

  /**
   * Ensures the cap increase is within the allowed range.
   * @param from current cap
   * @param to new cap
   * @return bool true, if difference is within the max 100% increase window
   */
  function increaseWithinAllowedRange(uint256 from, uint256 to) public pure returns (bool) {
    return to - from <= from;
  }
}
