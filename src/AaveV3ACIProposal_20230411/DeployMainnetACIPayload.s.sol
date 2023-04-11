pragma solidity ^0.8.16;
import {EthereumScript} from 'aave-helpers/../script/Utils.s.sol';
import {ProposalPayload} from 'src/AaveV3ACIProposal_20230411/AaveV3ACIProposal_20230411.sol';


contract DeployMainnetACIPayload is EthereumScript {
  function run() external broadcast {
    new ProposalPayload();
  }
}
