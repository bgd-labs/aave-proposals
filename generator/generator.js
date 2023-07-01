import fs from "fs";
import path from "path";
import { Command, Option } from "commander";
import {
  generateAIP,
  generateProposal,
  generateScript,
  generateTest,
} from "./templates.js";
import {
  SHORT_CHAINS,
  generateChainName,
  generateName,
  getDate,
} from "./common.js";

const program = new Command();

program
  .name("proposal-generator")
  .description("CLI to generate aave proposals")
  .version("0.0.0")
  .addOption(new Option("-cfg, --configEngine", "extends config engine"))
  .addOption(
    new Option(
      "-name, --name <string>",
      "name of the proposal"
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
  .addOption(new Option("-t, --title <string>"))
  .addOption(new Option("-a, --author <string>"))
  .addOption(new Option("-d, --discussion <string>"))
  .addOption(new Option("-s, --snapshot <string>"));

program.parse();

const options = program.opts();

console.log(options);

const baseName = generateName(options);

// create files
const baseFolder = path.join(process.cwd(), "src", baseName);
fs.mkdirSync(baseFolder, { recursive: true });

function createFiles(options, chain) {
  fs.writeFileSync(
    path.join(baseFolder, `${generateChainName(options, chain)}.sol`),
    generateProposal(options, chain)
  );
  fs.writeFileSync(
    path.join(baseFolder, `${generateChainName(options, chain)}.t.sol`),
    generateTest(options, chain)
  );
}

options.chains.forEach((chain) => createFiles(options, chain));

fs.writeFileSync(
  path.join(baseFolder, `${baseName}.s.sol`),
  generateScript(options)
);
fs.writeFileSync(
  path.join(baseFolder, `${options.name}.md`),
  generateAIP(options)
);

// print instructions
console.log("Here is a list of commands for testing and deployment");
console.log(`test: make test-contract filter=${options.name}`);
// console.log(`deploy: make deploy-ledger filter=${options.name}`);
