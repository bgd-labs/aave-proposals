# Aave <> CoW Swap: Aave Curator

The Aave Curator is a smart contract tool deveoped in order to more easily allow the Aave DAO to swap its tokens.
Up until now, the DAO relied on custom one-use contracts in order to accomplish the swap of one token for another.
Some examples include the BAL <> AAVE swap from 2022, the acquisition of CRV or the acquisition of B-80BAL-20WETH.
All the instances listed above required significant time to develop, test, and review, all while reinventing the
wheel every time for something that should be easy to reuse.

Aave Curator facilitates swaps of tokens by the DAO without the constant need to review the contracts that do so.

## How It Works

Aave Curator relies on [Milkman](https://github.com/charlesndalton/milkman), a smart contract that builds on top of
[COW Swap](https://swap.cow.fi/#/faq/protocol), under the hood in order to find the best possible swap execution for
the DAO while protecting funds from MEV exploits and bad slippage.

Aave Curator is a permissioned smart contract, and it has two potential privileged users: the owner and the guardian.
The owner will be the DAO (however, ownership can be transferred) and the guardian is an address to be chosen by the
DAO to act an asset manager. The role of the asset manager (guardian) is to more easily swap tokens for the DAO without
the need to go through the full governance flow. Aave Curator can hold funds and swap for other tokens and keep them in
case the DAO chooses so. Aave Curator can only withdraw tokens to the Collector contract.

The curator contract can also deposit tokens it holds into Aave V3 pools or Aave V2 pools. It an also cancel pending swaps.

The tokens the curator can trade from and to have to previously been voted by the DAO.

### Methods

```
function swap(
    address fromToken,
    address toToken,
    address recipient,
    uint256 amount,
    uint256 slippage
  ) external onlyOwnerOrGuardian
```

Swaps `fromToken` to `toToken` in the specified `amount`. The recipient of the `toToken` can either be the Aave Curator
or the Collector.

Slippage is specified in basis points, for example `100` is 1% slippage. The maximum amount would be `10_000` for 100% slippage.

A note on slippage and CoW Swap:

Slippage not only accounts for the difference in price, but also gas costs incurred for the swap itself. What follows is an example:
A user wants to swap 100 USDC for DAI, the price is about 1-to-1 as they are both stablecoins. The slippage needed for this trade, with
gas prices of 80 gwei could be over 20%, because the transaction itself might cost around $20 dollars, and then the solver needs an incentive
to do the trade so maybe the actual slippage in price is 1% and it trades at 1.005 cost of DAI per USDC.

For a 1,000,000 USDC to DAI swap, this looks very different. Slippage might be around 0.005% where the solver gets $30, plus gas costs of
around $20 dollars, so setting the slippage to 0.5% or 1% to ensure that the swap is picked up is more than enough. The slippage tolerance
does not mean that's what the trade will definitely trade at. CoW Swap finds the best match and then executes at that price. Solvers are
competing at market prices for swaps all the time and they are incentivized to keep prices tight in order to get picked as executors.

Some tokens that are not "standard" ERC-20, such as Aave Interest Bearing Tokens (aTokens) are more gas consuming because the solvers
take into account the costs of wrapping and unwrapping the tokens. Aave Curator supports aToken to aToken swaps though it is easier to
swap between underlyings.

Depending on the tokens and amounts, slippage will have to vary. A good heuristic is:

Trades of $1,000,000 worth of value or more, around 0.5-1% slippage.
Trades in the six figures, 1-2%.
Trades in the high five-figures, around 3%.
Trades below $15,000 worth of value, 5% slippage.
Trades in the low thousands and less are not really worth swapping because gas costs are a huge proportion of the swap.

The [CoW Swap UI](https://swap.cow.fi/#/1/swap/WETH) can be checked to get an estimate of slippage if executing at that time.

Aave Curator uses Chainlink oracles for its slippage protection feature. The oracles have to be set by governance when allowing
fromTokens and toTokens. Governance should enforce that all oracles set are base-USD (ie: V3 oracles and not V2 oracles). Aave Curator
supports base-ETH swaps as well, but both bases have to be the same. For example USDC/ETH to AAVE/ETH or USDC/USD to AAVE/USD. It
does not support USDC/ETH to AAVE/USD swaps and this can lead to bad trades because of price differences.

```
function cancelSwap(
    address tradeMilkman,
    address fromToken,
    address toToken,
    address recipient,
    uint256 amount,
    uint256 slippage
) external onlyOwnerOrGuardian
```

This methods cancels a pending trade. Trades should take just a couple of minutes to be picked up and traded, so if something's not right, the user
should move fast to cancel.

Most likely, this function will be called when a swap is not getting executed because slippage might be too tight and there's no match for it.

`function depositTokenIntoV2(address token, uint256 amount) external onlyOwnerOrGuardian`

Deposits funds held on AaveCurator into Aave V2 on behalf of the Collector.

`function depositTokenIntoV3(address token, uint256 amount) external onlyOwnerOrGuardian`

Deposits funds held on AaveCurator into Aave V3 on behalf of the Collector.

`function setAllowedFromToken(address token, address oracle, bool allowed) external onlyOwner`

Sets an allowed token to be able to swap from. It can be set to allowed == false in order to block swaps from this token.
The address of the Oracle needs to be a Chainlink oracle that has a base in USD (ie: AAVE/USD oracle).

`function setAllowedToToken(address token, address oracle, bool allowed) external onlyOwner`

Sets an allowed token to be able to swap to. It can be set to allowed == false in order to block swaps from this token.
The address of the Oracle needs to be a Chainlink oracle that has a base in USD (ie: USDC/USD oracle).

Both `setAllowedFromToken` and `setAllowedToToken` can be combined to only allower AaveCurator to do specific swaps that
the DAO approves of beforehand. For example, only swapping to stables from known tokens.

`function setMilkmanAddress(address _milkman) external onlyOwner`

Milkman is a [smart contract](https://github.com/charlesndalton/milkman) that programatically submits trades on COW Swap via
smart contracts. COW Swap otherwise uses an off-chain AIP. The team listens to events emitted by Milkman and then handles
trading afterward. Milkman then checks orders submitted to see if they meet the parameters specified. In case Milkman is upgraded
to a new address, this function let's the contract update the address.

`function setChainlinkPriceChecker(address _priceChecker) external onlyOwner`

Allows to update the Chainlink Price Checker (read about price checkers [here](https://github.com/charlesndalton/milkman#price-checkers))
if the price checker were to be upgraded.

`function withdrawToCollector(address[] calldata tokens) external onlyOwnerOrGuardian`

Withdrawal function for funds to leave AaveCurator. They can only be withdrawn to the Aave Collector contract.

```
  function _getPriceCheckerAndData(
    address fromToken,
    address toToken,
    uint256 slippage
) internal view returns (address, bytes memory)
```

Read-only function to get an idea of how many tokens to expect when performing a swap. This helper can be used
to determine the slippage percentage to submit on the swap.

### Deployed Address

Mainnet: [`0x`]()
