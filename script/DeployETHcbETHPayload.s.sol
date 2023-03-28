pragma solidity ^0.8.16;

import {GovHelpers} from 'aave-helpers/GovHelpers.sol';
import {EthereumScript} from 'aave-helpers/../script/Utils.s.sol';
import {AaveV3ETHCapUpdate_20230328} from 'src/AaveV3ETHCapUpdate_20230328/AaveV3ETHCapUpdate_20230328.sol';

contract CreateProposal is EthereumScript {
  function run() external broadcast {
    GovHelpers.Payload[] memory payloads = new GovHelpers.Payload[](1);
    payloads[0] = GovHelpers.buildMainnet(address(0));
    GovHelpers.createProposal(payloads, '');
  }
}

contract DeployPayloadEthereum is EthereumScript {
  function run() external broadcast {
    new AaveV3ETHCapUpdate_20230328();
  }
}
