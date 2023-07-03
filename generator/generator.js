import fs from "fs";
import path from "path";
import { Command, Option } from "commander";
import handlebars from "handlebars";
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

// prepare cli
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

const baseName = generateName(options);

// prepare templates
handlebars.registerHelper("lower", function (str) {
  return str.toLowerCase();
});
handlebars.registerHelper("surroundWithCurlyBraces", function (str) {
  return `{${str}}`;
});
const testTemplate = handlebars.compile(
  fs.readFileSync(
    path.join(process.cwd(), "generator/templates/test.template"),
    "utf8"
  )
);
const engineProposalTemplate = handlebars.compile(
  fs.readFileSync(
    path.join(process.cwd(), "generator/templates/engineProposal.template"),
    "utf8"
  )
);
const rawProposalTemplate = handlebars.compile(
  fs.readFileSync(
    path.join(process.cwd(), "generator/templates/rawProposal.template"),
    "utf8"
  )
);

// create files
const baseFolder = path.join(process.cwd(), "src", baseName);
fs.mkdirSync(baseFolder, { recursive: true });

function createFiles(options, chain) {
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
    testTemplate({
      ...options,
      contractName,
      chain,
      rpc: chain === "Ethereum" ? "mainnet" : chain.toLowerCase(),
    })
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
