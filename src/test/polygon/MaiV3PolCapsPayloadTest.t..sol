// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {AaveGovernanceV2, AaveV3Polygon} from 'aave-address-book/AaveAddressBook.sol';
import {ProtocolV3TestBase, ReserveConfig, ReserveTokens, IERC20} from 'aave-helpers/ProtocolV3TestBase.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {MAIV3PolCapsPayload} from '../../contracts/polygon/MaiV3PolCapsPayload.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';

contract MAIV3PolCapsPayloadTest is ProtocolV3TestBase, TestWithExecutor {
  MAIV3PolCapsPayload public proposalPayload;

  address public constant MAI = 0xa3Fa99A148fA48D14Ed51d610c367C61876997F1;

  uint256 public constant MAI_SUPPLY_CAP = 1_100_000;
  uint256 public constant MAI_BORROW_CAP = 600_000;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 39351459);
    _selectPayloadExecutor(AaveGovernanceV2.POLYGON_BRIDGE_EXECUTOR);
  }

  function testBorrowCapsPol() public {
    ReserveConfig[] memory allConfigsBefore = _getReservesConfigs(AaveV3Polygon.POOL);

    // 1. create snapshot before payload execution
    createConfigurationSnapshot('preCapChange', AaveV3Polygon.POOL);
    
    // 2. create payload
    proposalPayload = new MAIV3PolCapsPayload();

    // 3. execute l2 payload
    
    _executePayload(address(proposalPayload));
    
    // 4. create snapshot after payload execution
    createConfigurationSnapshot('postCapChange', AaveV3Polygon.POOL);

    //Verify payload:
    ReserveConfig[] memory allConfigsAfter = ProtocolV3TestBase._getReservesConfigs(
      AaveV3Polygon.POOL
    );

    //MAI
    ReserveConfig memory MaiConfig = ProtocolV3TestBase._findReserveConfig(allConfigsBefore, MAI);
    MaiConfig.borrowCap = MAI_BORROW_CAP;
    MaiConfig.supplyCap = MAI_SUPPLY_CAP;
    ProtocolV3TestBase._validateReserveConfig(MaiConfig, allConfigsAfter);

    // 5. compare snapshots
    diffReports('preCapChange', 'postCapChange');
  }
}


    


    

    