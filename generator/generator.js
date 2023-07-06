import fs from "fs";
import path from "path";
import { Command, Option } from "commander";
import { generateAIP, generateScript } from "./templates.js";
import { generateChainName, generateName } from "./common.js";
import { engineProposalTemplate } from "./templates/engineProposal.template.js";
import { rawProposalTemplate } from "./templates/rawProposal.template.js";
import { testTemplate } from "./templates/test.template.js";

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
    new Option(
      "-name, --name <string>",
      "name of the proposal (e.g. CapsIncrease)"
    ).makeOptionMandatory()
  )
  .addOption(
    new Option("-ch, --chains <letters...>")
      .choices([
        "Ethereum",
        "Optimism",
        "Arbitrum",
        "Polygon",
        "Avalanche",
        "Fantom",
        "Harmony",
        "Metis",
      ])
      .makeOptionMandatory()
  )
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

const options = program.opts();

const baseName = generateName(options);

// create files
const baseFolder = path.join(process.cwd(), "src", baseName);
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
    path.join(baseFolder, `${options.name}.md`),
    generateAIP(options)
  );
}
