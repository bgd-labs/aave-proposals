import { input, confirm } from "@inquirer/prompts";

function numberOrCurrent(value) {
  if (value != "KEEP_CURRENT" && isNaN(value))
    return "Must be number or KEEP_CURRENT";
  return true;
}

async function subCli() {
  const answers = {
    asset: await input({
      // TODO: should be select, but npm package needs to be restructured a bit
      message: "Which asset would you like to amend?",
    }),
    borrowCap: await input({
      message: "New borrow cap",
      default: "KEEP_CURRENT",
      validate: numberOrCurrent,
    }),
    supplyCap: await input({
      message: "New supply cap",
      default: "KEEP_CURRENT",
      validate: numberOrCurrent,
    }),
  };
  const anotherOne = await confirm({
    message: "Do you want to amend another cap?",
    default: false,
  });
  if (anotherOne) return [answers, ...(await subCli())];
  return [answers];
}

export async function cli(options) {
  options.capUpdates = await subCli();
  return options;
}

export function test({ chain }) {
  return `function test_capUpdated() external {
    GovHelpers.executePayload(
      vm,
      address(proposal),
      ${CHAIN_TO_EXECUTOR[chain]}
    );
    // DO STUFF
  }`;
}

export function proposalCode() {
  return `function capsUpdates() public pure override returns (IEngine.CapsUpdate[] memory) {
    IEngine.CapsUpdate[] memory capsUpdate = new IEngine.CapsUpdate[](1);

    // capsUpdate[0] = IEngine.CapsUpdate({
    //   asset: AaveV3PolygonAssets.EURS_UNDERLYING,
    //   supplyCap: EngineFlags.KEEP_CURRENT,
    //   borrowCap: 1_500_000
    // });

    return capsUpdate;
  }`;
}
