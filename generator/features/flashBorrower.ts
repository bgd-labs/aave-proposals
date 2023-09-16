import {input} from '@inquirer/prompts';
import {CodeArtifacts, DEPENDENCIES, FeatureModule} from '../types';
import {CHAIN_TO_EXECUTOR} from '../common';

type FlashBorrower = {
  [chain: string]: {
    address: string;
  };
};

export const flashBorrower: FeatureModule<FlashBorrower> = {
  async cli(opt) {
    const response: FlashBorrower = {};
    for (const chain of opt.chains) {
      console.log(`Fetching information for FlashBorrower on ${chain}`);
      response[chain] = {
        address: await input({
          message: 'Who do you want to grant the flashBorrower role',
        }),
      };
    }
    return response;
  },
  build(opt, cfg) {
    const response: CodeArtifacts = {};
    for (const chain of opt.chains) {
      response[chain] = {
        code: {
          dependencies: [DEPENDENCIES.Addresses],
          constants: [
            `address public constant NEW_FLASH_BORROWER = address(${cfg[chain].address});`,
          ],
          execute: [
            `Aave${opt.protocolVersion}${chain}.ACL_MANAGER.addFlashBorrower(NEW_FLASH_BORROWER);`,
          ],
        },
        test: {
          fn: [
            `function test_isFlashBorrower() external {
            GovHelpers.executePayload(
              vm,
              address(proposal),
              ${CHAIN_TO_EXECUTOR[chain]}
            );
            bool isFlashBorrower = Aave${opt.protocolVersion}${chain}.ACL_MANAGER.isFlashBorrower(proposal.NEW_FLASH_BORROWER());
            assertEq(isFlashBorrower, true);
          }`,
          ],
        },
      };
    }
    return response;
  },
};
