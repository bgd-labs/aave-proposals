import fs from "fs";
import path from "path";
import { Command, Option } from "commander";
import { generateAIP, generateScript } from "./templates.js";
import {
  AVAILABLE_CHAINS,
  generateChainName,
  generateName,
  pascalCase,
} from "./common.js";
import { engineProposalTemplate } from "./templates/engineProposal.template.js";
import { rawProposalTemplate } from "./templates/rawProposal.template.js";
import { testTemplate } from "./templates/test.template.js";
import Enquirer from "enquirer";

// prepare cli
const program = new Command();

program
  .name("proposal-generator")
  .description("CLI to generate aave proposals")
  .version("0.0.0")
  .addOption(
    new Option("-f, --force", "force creation (might overwrite existing files)")
  )
  .addOption(new Option("-cfg, --configEngine", "extends config engine"))
  .addOption(
    new Option("--topic <string>", "name of the proposal (e.g. CapsIncrease)")
  )
  .addOption(new Option("-ch, --chains <letters...>").choices(AVAILABLE_CHAINS))
  .addOption(
    new Option("-pv, --protocolVersion <string>")
      .choices(["V2", "V3"])
      .makeOptionMandatory()
  )
  .addOption(new Option("-t, --title <string>", "aip title"))
  .addOption(new Option("-a, --author <string>", "author"))
  .addOption(new Option("-d, --discussion <string>", "forum link"))
  .addOption(new Option("-s, --snapshot <string>", "snapshot link"))
  .allowExcessArguments(false);

program.parse();

const rawOptions = program.opts();

const enquirer = new Enquirer({});
const answers = await enquirer.prompt([
  {
    type: "input",
    name: "topic",
    message: "Topic of your proposal",
    result: (input) => pascalCase(input),
    skip() {
      return rawOptions.topic != undefined;
    },
  },
  {
    type: "multiselect",
    name: "chains",
    message: "Chains this proposal targets",
    choices: AVAILABLE_CHAINS,
    skip() {
      // workaround for https://github.com/enquirer/enquirer/issues/298
      this.state._choices = this.state.choices;
      return rawOptions.chains?.length >= 1;
    },
  },
  {
    type: "confirm",
    name: "force",
    message: "Are you sure you want to overwrite existing files?",
    skip() {
      return rawOptions.force != undefined; // !fs.existsSync(baseFolder) ||
    },
  },
]);

const options = {
  ...answers,
  ...rawOptions,
  topic: pascalCase(rawOptions.topic || answers.topic),
};
console.log(options);
const baseName = generateName(options);
const baseFolder = path.join(process.cwd(), "src", baseName);

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
