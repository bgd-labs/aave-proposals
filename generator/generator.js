import fs from "fs";
import path from "path";
import { Command, Option } from "commander";
import { generateAIP, generateScript } from "./templates.js";
import {
  AVAILABLE_CHAINS,
  AVAILABLE_VERSIONS,
  generateChainName,
  generateName,
  pascalCase,
} from "./common.js";
import { engineProposalTemplate } from "./templates/engineProposal.template.js";
import { rawProposalTemplate } from "./templates/rawProposal.template.js";
import { testTemplate } from "./templates/test.template.js";
import { input, checkbox, select, confirm } from "@inquirer/prompts";

const program = new Command();

program
  .name("proposal-generator")
  .description("CLI to generate aave proposals")
  .version("0.0.0")
  .addOption(
    new Option("-f, --force", "force creation (might overwrite existing files)")
  )
  .addOption(new Option("-cfg, --configEngine", "extends config engine"))
  .addOption(new Option("-ch, --chains <letters...>").choices(AVAILABLE_CHAINS))
  .addOption(
    new Option("-pv, --protocolVersion <string>").choices(AVAILABLE_VERSIONS)
  )
  .addOption(new Option("-t, --title <string>", "aip title"))
  .addOption(new Option("-a, --author <string>", "author"))
  .addOption(new Option("-d, --discussion <string>", "forum link"))
  .addOption(new Option("-s, --snapshot <string>", "snapshot link"))
  .allowExcessArguments(false)
  .parse(process.argv);

const options = program.opts();

// workaround as there's validate is not currently supported on checkbox
// https://github.com/SBoudrias/Inquirer.js/issues/1257
while (!options.chains?.length === true) {
  options.chains = await checkbox({
    message: "Chains this proposal targets",
    choices: AVAILABLE_CHAINS.map((v) => ({ name: v, value: v })),
    validate(input) {
      // currently ignored due to a bug
      if (input.length == 0)
        return "You must target at least one chain in your proposal!";
      return true;
    },
  });
}

if (!options.protocolVersion) {
  options.protocolVersion = await select({
    message: "Protocol version this proposal targets",
    choices: AVAILABLE_VERSIONS.map((v) => ({ name: v, value: v })).reverse(),
    default: "V3", // default on select not currently supported which is why we reverse
  });
}

/**
 * TODO: config engine flag is a bit arbitrary.
 * Would be better to ask for specific features & inline proper tests and boilerplate
 */
if (!options.configEngine) {
  options.configEngine = await confirm({
    message: "To you plan to use the config engine?",
    default: true,
  });
}

if (!options.title) {
  options.title = await input({
    message: "Title of your proposal",
    validate(input) {
      if (input.length == 0) return "Your title can't be empty";
      return true;
    },
  });
}
// topic name is a bit arbitrary
options.topic = pascalCase(options.title);

if (!options.author) {
  options.author = await input({
    message: "Author of your proposal",
    validate(input) {
      if (input.length == 0) return "Your author can't be empty";
      return true;
    },
  });
}

if (!options.discussion) {
  options.discussion = await input({
    message: "Link to forum discussion",
  });
}

if (!options.snapshot) {
  options.snapshot = await input({
    message: "Link to snapshot",
  });
}

const baseName = generateName(options);
const baseFolder = path.join(process.cwd(), "src", baseName);

if (!options.force && fs.existsSync(baseFolder)) {
  options.force = await confirm({
    message:
      "A proposal already exists at that location, do you want to override?",
    default: false,
  });
}

// create files
if (fs.existsSync(baseFolder) && !options.force) {
  console.log("Creation skipped as folder already exists.");
  console.log("If you want to overwrite, supply --force");
} else {
  fs.mkdirSync(baseFolder, { recursive: true });

  async function createFiles(options, chain) {
    const contractName = generateChainName(options, chain);
    if (options.configEngine) {
      fs.writeFileSync(
        path.join(baseFolder, `${contractName}.sol`),
        engineProposalTemplate({
          ...options,
          contractName,
          chain,
        })
      );
    } else {
      fs.writeFileSync(
        path.join(baseFolder, `${contractName}.sol`),
        rawProposalTemplate({
          ...options,
          contractName,
          chain,
        })
      );
    }
    fs.writeFileSync(
      path.join(baseFolder, `${contractName}.t.sol`),
      await testTemplate({
        ...options,
        contractName,
        chain,
      })
    );
  }

  options.chains.forEach((chain) => createFiles(options, chain));

  fs.writeFileSync(
    path.join(baseFolder, `${baseName}.s.sol`),
    generateScript(options, baseName)
  );
  fs.writeFileSync(
    path.join(baseFolder, `${options.topic}.md`),
    generateAIP(options)
  );
}
