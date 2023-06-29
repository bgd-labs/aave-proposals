// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {AaveMisc} from 'aave-address-book/AaveMisc.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {TransparentProxyFactory} from 'solidity-utils/contracts/transparent-proxy/TransparentProxyFactory.sol';

import {StrategicAssetsManager} from './StrategicAssetsManager.sol';

contract StrategicAssetsManagerPayload is IProposalGenericExecutor {
  function execute() external {
    address strategicAssetsManager = address(new StrategicAssetsManager());
    TransparentProxyFactory(AaveMisc.TRANSPARENT_PROXY_FACTORY_ETHEREUM).create(
      strategicAssetsManager,
      AaveMisc.PROXY_ADMIN_ETHEREUM,
      ''
    );
  }
}
