# Streategic Assets Manager Information

## Main Idea

The main idea of this new contract is for the DAO to be able to handle strategic assets (assets that will earn rewards, or assets that can be used to
vote on different protocols, for example) without the need to go through the full governance flow every week.

Take the following example: the DAO wants to hold veBAL as part of its strategy for the long term. To get the most out of veBAL, the DAO should "re-lock"
its holdings on a weekly basis. This is a very tedious approach and can lead to a lot of voter fatigue. Because of this, the StrategicAssetsManager contract
can be governed by the DAO, while some functions can be invoked by an allowed guardian, acting on the role of Asset Manager.

## Functionality

#### StrategicAssetsManager.sol

```
  function addVeToken(
    address underlying,
    address veToken,
    address warden,
    uint256 lockDuration,
    address initialDelegate,
    bytes32 spaceId
  ) external onlyOwner
```

This function, only governed by the DAO, sets the information needed in order to handle a veToken and all other functionality related to it.
Without this information, the rest of the functionality will revert.

Example: underlying would be B-80BAL-20WETH, veToken would be veBAL.
Warden is a protocol by Paladin: https://app.warden.vote/boosts/ where users can boost their rewards or offer to lock their tokens for a price.
Lock duration is the amount of time the veToken will be locked for. In the case of veBAL, max is 1 year. It can vary across different tokens.
The initial delegate, is somebody who can vote. SpaceID is the snapshot ID for voting, which veBAL uses. veCRV votes via an Aragon contract.

`function removeVeToken(address underlying) external onlyOwner`

Removes the ability to interact with a certain veToken.

`function addSdToken(address underlying, address sdToken, address depositor) external onlyOwner`

SD tokens are StakeDAO tokens: https://stakedao.gitbook.io/stakedaohq/
For them, the underlying, the sdToken address of the token, and the address where to deposit the underlying to receive sdToken.

`function removeSdToken(address underlying) external onlyOwner`

Removes the ability to interact with a certain sdToken.

`function withdrawERC20(address token, address to, uint256 amount) external onlyOwner`

Sends ERC20 tokens to an address. Withdrawal mechanism.

`function setStrategicAssetsManager(address _manager) external onlyOwner`

Adds manager role.

`function removeStrategicAssetManager() external onlyOwner`

Revokes manager role.

#### VeTokenManager.sol

```
 function buyBoost(
    address underlying,
    address delegator,
    address receiver,
    uint256 amount,
    uint256 duration
  ) external onlyOwnerOrManager
```

Purchase boost to incentivize rewards earned by locking (up to 2.5x of earnings). Spend fee token.
For more info see: https://doc.paladin.vote/warden-boost/boost-market

The idea is to increase the yield in the provided liquidity.
For example, pay 10 BAL to boost rewards in a veBAL pool up to 2.5x times, to earn more BAL in return.

```
 function sellBoost(
    address underlying,
    uint256 pricePerVote,
    uint64 maxDuration,
    uint64 expiryTime,
    uint16 minPerc,
    uint16 maxPerc,
    bool useAdvicePrice
  ) external onlyOwnerOrManager
```

Owner of veToken allows others to incentivize their liquidity pools by selling boost. The price can be chosen by the user, or by setting useAdvicePrice, let Warden determine the price.
The seller of boost receives the native token.

```
  function updateBoostOffer(
    address underlying,
    uint256 pricePerVote,
    uint64 maxDuration,
    uint64 expiryTime,
    uint16 minPerc,
    uint16 maxPerc,
    bool useAdvicePrice
  ) external onlyOwnerOrManager
```

Allows the user to update an existing offer to sell boost.

`function removeBoostOffer(address underlying) external onlyOwnerOrManager`

Removes a boost offer.

` function claim(address underlying) external onlyOwnerOrManager`

Claim rewards earned by selling boost.

`function setSpaceId(address underlying, bytes32 _spaceId) external onlyOwnerOrManager`

Sets the spaceID that's used by protocol on Snapshot for voting. For example, "balancer.eth" is Balancer's spaceId on Snapshot.

```
 function setDelegateSnapshot(
    address underlying,
    address newDelegate
  ) external onlyOwnerOrManager
```

Delegate tokens so they can vote on Snapshot.

`function clearDelegateSnapshot(address underlying) external onlyOwnerOrManager`

Remove the active delegate.

```
function voteAragon(
    address underlying,
    uint256 voteData,
    bool support
  ) external onlyOwnerOrManager
```

Vote on Aragon (as opposed to off-chain votes done via Snapshot). veCRV uses Aragon voting.

** Since DAO is unlikely to hold veCRV immediately, this function can likely be removed initially.**

`function setVotingContract(address underlying, address voting) external onlyOwnerOrManager`

Sets the contract where veToken voting takes place (for example, veCRV's Aragon voting contract).

** Since DAO is unlikely to hold veCRV immediately, this function can likely be removed initially.**

```
function setLockDuration(
    address underlying,
    uint256 newLockDuration
  ) external onlyOwnerOrManager
```

Set the lock duration to specific time. For example, max lock for veBAL is 1 year, so set to 1 year (or less).

`function lock(address underlying) external onlyOwnerOrManager`

The main function for veBAL.
Initially, it locks the B-80BAL-20WETH token to receive veBAL. (This contract needs to be allow-listed by Balancer prior to calling or it will fail).
On subsequent calls (for example, weekly) it extends the lock duration once again. The voting % available per token is dependent on the locking duration.
If locking duration is 6 months and the maximum duration is 1 year, then the voting weight is only half.
This function also locks more of the native token held by StrategicAssetsManager available on the contract.

`function unlock(address underlying) external onlyOwnerOrManager`

Unlocks the veToken in order to receive the underlying once again. Lock duration needs to have passed or transaction will revert.

#### SdTokenManager.sol

`function lock(address underlying, uint256 amount) external onlyOwnerOrManager`

Locks underlying for sdToken for 4 years.

`function retrieveUnderlying(address token) external onlyOwnerOrManager`

This function is TODO depending on how we choose to approach this.
There is no mechanism to unlock from sdTokens and Llama has voiced their concerns with sdTokens but the DAO voted to include them so we have added this functionality.
The StakeDAO docs mention to go to Curve.fi and swap using the pool. This has no MEV protection so a better alternative might be using COW Swap or the Curator contract.

##### LSDLiquidityGaugeManager.sol

`function setGaugeController(address token, address gaugeController) public onlyOwnerOrManager`

Sets the address that handles gauges for sdTokens or veTokens.

Here is the proposal on Balancer as it relates to GHO: https://forum.balancer.fi/t/bip-xxx-approve-the-smbpt-gauges-for-the-aave-sm/4949
This post has the explanation on all the steps the DAO can expect to interact with these protocols to maximize rewards.
The excalidraw towards the bottom of the page is helpful in seeing the full flow.

Curve docs on liquidity gauges: https://curve.readthedocs.io/dao-gauges.html

The main concept here is that the ecosystem rewards liquidity providers by rewarding them with token emissions. These tokens are distributed according to which gauges receive the
most votes.

```
function voteForGaugeWeight(
    address token,
    address gauge,
    uint256 weight
  ) external onlyOwnerOrManager
```

Utilizing the veToken holdings or sdToken holdings, the DAO can vote to redirect emissions to the DAO's own gauge.
Here, by voting for the DAO's gauge, and also purchasing boost, the DAO can expect to earn a lot more BAL rewards over time than just by holding a veToken for example.
