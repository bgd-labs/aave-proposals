import fs from "fs";
import path from "path";
import { Command, Option } from "commander";
import { generateAIP, generateScript } from "./templates.js";
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
      .choices(["v2", "v3"])
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

function createFiles(fileName) {
  fs.writeFileSync(
    path.join(baseFolder, `${fileName}.sol`),
    "should use some template"
  );
  fs.writeFileSync(
    path.join(baseFolder, `${fileName}.t.sol`),
    "should use some template"
  );
}

options.chains.forEach((chain) =>
  createFiles(generateChainName(options, chain))
);

fs.writeFileSync(
  path.join(baseFolder, `${baseName}.s.sol`),
  generateScript(options, baseName)
);
fs.writeFileSync(
  path.join(baseFolder, `${options.name}.md`),
  generateAIP(options, baseName)
);

// print instructions
console.log("Here is a list of commands for testing and deployment");
console.log(`test: make test-contract filter=${options.name}`);
// console.log(`deploy: make deploy-ledger filter=${options.name}`);
