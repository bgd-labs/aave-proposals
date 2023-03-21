// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {IACLManager, IPoolConfigurator, IPoolDataProvider} from 'aave-address-book/AaveV3.sol';

// contract AaveV3RiskCouncil_20230321 is IProposalGenericExecutor {
//   function execute() external {}
// }

contract AaveV3RiskCouncil {
  struct CapUpdate {
    address asset;
    uint256 supplyCap;
    uint256 borrowCap;
  }

  struct Timelock {
    uint40 supplyCapLastUpdated;
    uint40 borrowCapLastUpdated;
  }

  uint256 constant KEEP_CURRENT = type(uint256).max;
  uint256 constant MINIMUM_DELAY = 5 days;

  IACLManager immutable ACL_MANAGER;
  address immutable GUARDIAN;
  IPoolConfigurator immutable POOL_CONFIGURATOR;
  IPoolDataProvider immutable POOL_DATA_PROVIDER;
  address immutable RISK_COUNCIL;

  mapping(address => Timelock) timelocks;

  modifier onlyRiskCouncil() {
    require(RISK_COUNCIL == msg.sender, 'Only guardian');
    _;
  }

  constructor(
    IACLManager aclManager,
    address guardian,
    IPoolConfigurator configurator,
    IPoolDataProvider poolDataProvider,
    address riskCouncil
  ) {
    ACL_MANAGER = aclManager;
    GUARDIAN = guardian;
    POOL_CONFIGURATOR = configurator;
    POOL_DATA_PROVIDER = poolDataProvider;
    RISK_COUNCIL = riskCouncil;
  }

  /**
   * Allows updating borrow and supply caps accross multiple assets
   * @dev A cap increase is only possible ever 5 days per asset
   * @dev A cap increase is only allowed to increase the cap by 100%
   * @dev A cap decrease is **always** possible
   * @param capUpdates caps to be updated
   */
  function updateCaps(CapUpdate[] memory capUpdates) public onlyRiskCouncil {
    for (uint256 i = 0; i < capUpdates.length; i++) {
      (uint256 borrowCap, uint256 supplyCap) = POOL_DATA_PROVIDER.getReserveCaps(
        capUpdates[i].asset
      );
      if (capUpdates[i].supplyCap != KEEP_CURRENT) {
        require(capUpdates[i].supplyCap != 0, 'REMOVING_CAPS_NOT_ALLOWED');
        require(
          capUpdates[i].supplyCap < supplyCap ||
            ((block.timestamp - timelocks[capUpdates[i].asset].supplyCapLastUpdated >
              MINIMUM_DELAY) && increaseWithinAllowedRange(supplyCap, capUpdates[i].supplyCap)),
          'SUPPLY_CAP_UPDATE_NOT_ALLOWED'
        );
        POOL_CONFIGURATOR.setSupplyCap(capUpdates[i].asset, capUpdates[i].supplyCap);
        timelocks[capUpdates[i].asset].supplyCapLastUpdated = uint40(block.timestamp);
      }
      if (capUpdates[i].borrowCap != KEEP_CURRENT) {
        require(capUpdates[i].borrowCap != 0, 'REMOVING_CAPS_NOT_ALLOWED');
        require(
          capUpdates[i].borrowCap < borrowCap ||
            ((block.timestamp - timelocks[capUpdates[i].asset].borrowCapLastUpdated >
              MINIMUM_DELAY) && increaseWithinAllowedRange(borrowCap, capUpdates[i].borrowCap)),
          'BORROW_CAP_UPDATE_NOT_ALLOWED'
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

  /**
   * @dev Revokes permissions of the contract in case of an emergency.
   */
  function revokePermissions() public {
    require(msg.sender == GUARDIAN, 'ONLY_GUARDIAN_CAN_REVOKE_PERMISSIONS');
    bytes32[] memory allRoles = getAllAaveRoles();

    for (uint256 i = 0; i < allRoles.length; i++) {
      ACL_MANAGER.renounceRole(allRoles[i], address(this));
    }
  }

  function getAllAaveRoles() public pure returns (bytes32[] memory) {
    bytes32[] memory roles = new bytes32[](6);
    roles[0] = 0x19c860a63258efbd0ecb7d55c626237bf5c2044c26c073390b74f0c13c857433; // asset listing
    roles[1] = 0x08fb31c3e81624356c3314088aa971b73bcc82d22bc3e3b184b4593077ae3278; // bridge
    roles[2] = 0x5c91514091af31f62f596a314af7d5be40146b2f2355969392f055e12e0982fb; // emergency admin
    roles[3] = 0x939b8dfb57ecef2aea54a93a15e86768b9d4089f1ba61c245e6ec980695f4ca4; // flash borrower
    roles[4] = 0x12ad05bde78c5ab75238ce885307f96ecd482bb402ef831f99e7018a0f169b7b; // pool admin
    roles[5] = 0x8aa855a911518ecfbe5bc3088c8f3dda7badf130faaf8ace33fdc33828e18167; // risk admin

    return roles;
  }
}
