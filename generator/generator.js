const fs = require("fs");
const path = require("path");
const { Command, Option } = require("commander");
const program = new Command();

program
  .name("proposal-generator")
  .description("CLI to generate aave proposals")
  .version("0.0.0")
  .addOption(new Option("-cfg, --configEngine", "extends config engine"))
  .addOption(
    new Option(
      "-t, --topic <string>",
      "topic of the proposal"
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
  .addOption(new Option("-a, --author <string>"))
  .addOption(new Option("-d, --discussion <string>"))
  .addOption(new Option("-s, --snapshot <string>"));

program.parse();

const options = program.opts();

console.log(options);
const date = new Date();
const years = date.getFullYear();
const months = date.getMonth() + 1; // it's js so months are 0 indexed
const day = date.getDate();

const SHORT_CHAINS = {
  Ethereum: "Eth",
  Polygon: "Pol",
  Optimism: "Opt",
  Arbitrum: "Arb",
  Fantom: "Ftm",
  Avalanche: "Ava",
  Metis: "Met",
  Harmony: "Har",
};

const baseName = `${options.protocolVersion === "v2" ? "AaveV2" : "AaveV3"}_${
  options.chains.length === 1 ? SHORT_CHAINS[options.chains[0]] : "Multi"
}_${options.topic}_${years}${day}${months}`;

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
if (options.chains.length > 1) {
  options.chains.forEach((chain) =>
    createFiles(baseName.replace("_Multi_", `_${chain}_`))
  );
} else {
  createFiles(baseName);
}

fs.writeFileSync(
  path.join(baseFolder, `${baseName}.s.sol`),
  "should use some template"
);
