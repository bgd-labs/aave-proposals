// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {Test} from 'forge-std/Test.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV2Ethereum} from 'aave-address-book/AaveV2Ethereum.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';

import {IVeToken} from './interfaces/IVeToken.sol';
import {IWardenBoost} from './interfaces/IWardenBoost.sol';
import {StrategicAssetsManager} from './StrategicAssetsManager.sol';
import {VeTokenManager} from './VeTokenManager.sol';
import {Core} from './Core.sol';

interface ISmartWalletChecker {
  function allowlistAddress(address contractAddress) external;
}

contract VeTokenManagerTest is Test {
  event BuyBoost(address delegator, address receiver, uint256 amount, uint256 duration);
  event DelegateUpdate(address indexed oldDelegate, address indexed newDelegate);
  event Lock(uint256 cummulativeTokensLocked, uint256 lockHorizon);
  event Unlock(uint256 tokensUnlocked);
  event VoteCast(uint256 voteData, bool support);
  event VotingContractUpdate(address indexed token, address voting);

  error NullClaimAmount();

  // Helpers
  address public constant SMART_WALLET_CHECKER = 0x7869296Efd0a76872fEE62A058C8fBca5c1c826C;

  // VeToken
  address public constant BAL = 0xba100000625a3754423978a60c9317c58a424e3D;
  address public constant B_80BAL_20WETH = 0x5c6Ee304399DBdB9C8Ef030aB642B10820DB8F56;
  address public constant VE_BAL = 0xC128a9954e6c874eA3d62ce62B468bA073093F25;
  address public constant WARDEN_VE_BAL = 0x42227bc7D65511a357c43993883c7cef53B25de9;
  address public constant VE_BOOST = 0x67F8DF125B796B05895a6dc8Ecf944b9556ecb0B;
  bytes32 public constant BALANCER_SPACE_ID = 'balancer.eth';

  address public constant CRV = 0xD533a949740bb3306d119CC777fa900bA034cd52;
  address public constant VE_CRV = 0x5f3b5DfEb7B28CDbD7FAba78963EE202a494e2A2;
  address public constant CRV_VOTING = 0xBCfF8B0b9419b9A88c44546519b1e909cF330399;

  uint256 public constant LOCK_DURATION_ONE_YEAR = 365 days;
  uint256 public constant WEEK = 7 days;

  address public immutable initialDelegate = makeAddr('initial-delegate');

  StrategicAssetsManager public strategicAssets;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 17523941);

    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets = new StrategicAssetsManager();
    vm.stopPrank();
  }

  function _addVeToken(
    address underlying,
    address veToken,
    address warden,
    uint256 lockDuration,
    address delegate,
    bytes32 spaceId
  ) internal {
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.addVeToken(underlying, veToken, warden, lockDuration, delegate, spaceId);
    vm.stopPrank();
  }
}

contract BuyBoostTest is VeTokenManagerTest {
  function test_revertsIf_invalidCaller() public {
    vm.expectRevert('ONLY_BY_OWNER_OR_GUARDIAN');
    strategicAssets.buyBoost(
      B_80BAL_20WETH,
      makeAddr('delegator'),
      makeAddr('receiver'),
      1e18,
      100000
    );
  }

  function test_revertsIf_wardenNotRegistered() public {
    _addVeToken(B_80BAL_20WETH, VE_BAL, address(0), LOCK_DURATION_ONE_YEAR, address(0), '');
    vm.expectRevert(Core.TokenNotRegistered.selector);
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.buyBoost(
      B_80BAL_20WETH,
      makeAddr('delegator'),
      makeAddr('receiver'),
      1e18,
      100000
    );
    vm.stopPrank();
  }

  function test_successful() public {
    deal(BAL, address(strategicAssets), 100e18);
    address delegator = 0x20EADfcaf91BD98674FF8fc341D148E1731576A4;
    _addVeToken(B_80BAL_20WETH, VE_BAL, WARDEN_VE_BAL, LOCK_DURATION_ONE_YEAR, address(0), '');
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.buyBoost(B_80BAL_20WETH, delegator, address(strategicAssets), 4000e18, 1);
    vm.stopPrank();
  }
}

contract SellBoostTest is VeTokenManagerTest {
  function test_revertsIf_invalidCaller() public {
    uint64 expiration = uint64(block.timestamp + 10000);
    vm.expectRevert('ONLY_BY_OWNER_OR_GUARDIAN');
    strategicAssets.sellBoost(B_80BAL_20WETH, 1000, 10, expiration, 1000, 10000, true);
  }

  function test_revertsIf_wardenNotRegistered() public {
    uint64 expiration = uint64(block.timestamp + 10000);
    vm.expectRevert(Core.TokenNotRegistered.selector);
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.sellBoost(B_80BAL_20WETH, 1000, 10, expiration, 1000, 10000, true);
    vm.stopPrank();
  }

  function test_successful() public {
    vm.expectRevert();
    IWardenBoost(WARDEN_VE_BAL).offers(7); // ID 7 Doesn't exist yet

    _addVeToken(B_80BAL_20WETH, VE_BAL, WARDEN_VE_BAL, LOCK_DURATION_ONE_YEAR, address(0), '');

    uint64 expiration = uint64(block.timestamp + WEEK);
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.sellBoost(B_80BAL_20WETH, 1000, 10, expiration, 1000, 10000, true);
    vm.stopPrank();

    IWardenBoost.BoostOffer memory offer = IWardenBoost(WARDEN_VE_BAL).offers(7);

    assertEq(offer.pricePerVote, 1000);
    assertEq(offer.maxDuration, 10);
    assertEq(offer.expiryTime, expiration);
    assertEq(offer.minPerc, 1000);
    assertEq(offer.maxPerc, 10000);
  }
}

contract UpdateBoostOfferTest is VeTokenManagerTest {
  function test_revertsIf_invalidCaller() public {
    uint64 expiration = uint64(block.timestamp + 10000);
    vm.expectRevert('ONLY_BY_OWNER_OR_GUARDIAN');
    strategicAssets.updateBoostOffer(B_80BAL_20WETH, 1000, 10, expiration, 1000, 10000, true);
  }

  function test_revertsIf_wardenNotRegistered() public {
    uint64 expiration = uint64(block.timestamp + 10000);
    vm.expectRevert(Core.TokenNotRegistered.selector);
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.updateBoostOffer(B_80BAL_20WETH, 1000, 10, expiration, 1000, 10000, true);
    vm.stopPrank();
  }

  function test_revertsIf_noOfferExists() public {
    _addVeToken(B_80BAL_20WETH, VE_BAL, WARDEN_VE_BAL, LOCK_DURATION_ONE_YEAR, address(0), '');

    uint64 expiration = uint64(block.timestamp + 10000);

    vm.expectRevert();
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.updateBoostOffer(B_80BAL_20WETH, 1000, 10, expiration, 1000, 10000, true);
    vm.stopPrank();
  }

  function test_successful() public {
    vm.expectRevert();
    IWardenBoost(WARDEN_VE_BAL).offers(7); // ID 7 Doesn't exist yet

    _addVeToken(B_80BAL_20WETH, VE_BAL, WARDEN_VE_BAL, LOCK_DURATION_ONE_YEAR, address(0), '');

    uint64 expiration = uint64(block.timestamp + WEEK);
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.sellBoost(B_80BAL_20WETH, 1000, 10, expiration, 1000, 10000, true);
    vm.stopPrank();

    IWardenBoost.BoostOffer memory offer = IWardenBoost(WARDEN_VE_BAL).offers(7);

    assertEq(offer.maxDuration, 10);
    assertEq(offer.expiryTime, expiration);
    assertEq(offer.minPerc, 1000);
    assertEq(offer.maxPerc, 10000);

    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.updateBoostOffer(
      B_80BAL_20WETH,
      1000,
      20,
      uint64(expiration + WEEK),
      1000,
      5000,
      true
    );
    vm.stopPrank();

    IWardenBoost.BoostOffer memory offerUpdated = IWardenBoost(WARDEN_VE_BAL).offers(7);

    assertEq(offerUpdated.maxDuration, 20);
    assertEq(offerUpdated.expiryTime, uint64(expiration + WEEK));
    assertEq(offerUpdated.minPerc, 1000);
    assertEq(offerUpdated.maxPerc, 5000);
  }
}

contract RemoveBoostOfferTest is VeTokenManagerTest {
  function test_revertsIf_invalidCaller() public {
    vm.expectRevert('ONLY_BY_OWNER_OR_GUARDIAN');
    strategicAssets.removeBoostOffer(B_80BAL_20WETH);
  }

  function test_revertsIf_wardenNotRegistered() public {
    vm.expectRevert(Core.TokenNotRegistered.selector);
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.removeBoostOffer(B_80BAL_20WETH);
    vm.stopPrank();
  }

  function test_successful() public {
    vm.expectRevert();
    IWardenBoost(WARDEN_VE_BAL).offers(7); // ID 7 Doesn't exist yet

    _addVeToken(B_80BAL_20WETH, VE_BAL, WARDEN_VE_BAL, LOCK_DURATION_ONE_YEAR, address(0), '');

    uint64 expiration = uint64(block.timestamp + WEEK);
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.sellBoost(B_80BAL_20WETH, 1000, 10, expiration, 1000, 10000, true);
    vm.stopPrank();

    IWardenBoost.BoostOffer memory offer = IWardenBoost(WARDEN_VE_BAL).offers(7);

    assertEq(
      IERC20(IWardenBoost(WARDEN_VE_BAL).delegationBoost()).allowance(
        address(strategicAssets),
        WARDEN_VE_BAL
      ),
      type(uint256).max
    );

    assertEq(offer.maxDuration, 10);
    assertEq(offer.expiryTime, expiration);
    assertEq(offer.minPerc, 1000);
    assertEq(offer.maxPerc, 10000);

    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.removeBoostOffer(B_80BAL_20WETH);
    vm.stopPrank();

    vm.expectRevert();
    IWardenBoost(WARDEN_VE_BAL).offers(7); // ID 7 Doesn't exist anymore

    assertEq(
      IERC20(IWardenBoost(WARDEN_VE_BAL).delegationBoost()).allowance(
        address(strategicAssets),
        WARDEN_VE_BAL
      ),
      0
    );
  }
}

contract Claim is VeTokenManagerTest {
  function test_revertsIf_invalidCaller() public {
    vm.expectRevert('ONLY_BY_OWNER_OR_GUARDIAN');
    strategicAssets.claim(B_80BAL_20WETH);
  }

  function test_revertsIf_wardenNotRegistered() public {
    vm.expectRevert(Core.TokenNotRegistered.selector);
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.claim(B_80BAL_20WETH);
    vm.stopPrank();
  }

  function test_revertsIf_noRewardsWereEarned() public {
    _addVeToken(B_80BAL_20WETH, VE_BAL, WARDEN_VE_BAL, LOCK_DURATION_ONE_YEAR, address(0), '');

    uint64 expiration = uint64(block.timestamp + WEEK);
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.sellBoost(B_80BAL_20WETH, 1000, 10, expiration, 1000, 10000, true);

    vm.expectRevert(NullClaimAmount.selector);
    strategicAssets.claim(B_80BAL_20WETH);
    vm.stopPrank();
  }

  function test_successful() public {
    vm.startPrank(0x10A19e7eE7d7F8a52822f6817de8ea18204F2e4f); // Authenticated Address
    ISmartWalletChecker(SMART_WALLET_CHECKER).allowlistAddress(address(strategicAssets));
    vm.stopPrank();

    _addVeToken(B_80BAL_20WETH, VE_BAL, WARDEN_VE_BAL, LOCK_DURATION_ONE_YEAR, address(0), '');

    deal(B_80BAL_20WETH, address(strategicAssets), 1_000e18);

    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.lock(B_80BAL_20WETH);
    vm.stopPrank();

    deal(BAL, address(this), 1_000e18);

    uint64 expiration = uint64(block.timestamp + WEEK);
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.sellBoost(B_80BAL_20WETH, 1000, 10, expiration, 1000, 10000, true);
    vm.stopPrank();

    IERC20(BAL).approve(WARDEN_VE_BAL, type(uint256).max);
    uint256 amount = 400e18;
    uint256 maxFee = IWardenBoost(WARDEN_VE_BAL).estimateFees(address(strategicAssets), amount, 1);
    IWardenBoost(WARDEN_VE_BAL).buyDelegationBoost(
      address(strategicAssets),
      address(this),
      amount,
      1,
      maxFee
    );

    vm.warp(WEEK);

    uint256 balanceBefore = IERC20(BAL).balanceOf(address(strategicAssets));

    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.claim(B_80BAL_20WETH);
    vm.stopPrank();

    uint256 balanceAfter = IERC20(BAL).balanceOf(address(strategicAssets));

    assertGt(balanceAfter, balanceBefore);
  }
}

contract SetSpaceId is VeTokenManagerTest {
  function test_revertsIf_invalidCaller() public {
    vm.expectRevert('ONLY_BY_OWNER_OR_GUARDIAN');
    strategicAssets.setSpaceId(B_80BAL_20WETH, BALANCER_SPACE_ID);
  }

  function test_revertsIf_veTokenNotRegistered() public {
    vm.expectRevert(Core.TokenNotRegistered.selector);
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.setSpaceId(B_80BAL_20WETH, BALANCER_SPACE_ID);
    vm.stopPrank();
  }

  function test_successful() public {
    _addVeToken(B_80BAL_20WETH, VE_BAL, WARDEN_VE_BAL, LOCK_DURATION_ONE_YEAR, initialDelegate, '');

    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.setSpaceId(B_80BAL_20WETH, BALANCER_SPACE_ID);
    vm.stopPrank();

    assertEq(
      strategicAssets.DELEGATE_REGISTRY().delegation(address(strategicAssets), BALANCER_SPACE_ID),
      initialDelegate
    );
  }
}

contract SetDelegationSnapshot is VeTokenManagerTest {
  function test_revertsIf_invalidCaller() public {
    vm.expectRevert('ONLY_BY_OWNER_OR_GUARDIAN');
    strategicAssets.setDelegateSnapshot(B_80BAL_20WETH, makeAddr('another-delegate'));
  }

  function test_revertsIf_veTokenNotRegistered() public {
    vm.expectRevert(Core.TokenNotRegistered.selector);
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.setDelegateSnapshot(B_80BAL_20WETH, makeAddr('another-delegate'));
    vm.stopPrank();
  }

  function test_successful() public {
    address newDelegate = makeAddr('another-delegate');
    _addVeToken(
      B_80BAL_20WETH,
      VE_BAL,
      WARDEN_VE_BAL,
      LOCK_DURATION_ONE_YEAR,
      initialDelegate,
      BALANCER_SPACE_ID
    );

    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.setDelegateSnapshot(B_80BAL_20WETH, newDelegate);
    vm.stopPrank();

    assertEq(
      strategicAssets.DELEGATE_REGISTRY().delegation(address(strategicAssets), BALANCER_SPACE_ID),
      newDelegate
    );
  }
}

contract ClearDelegationSnapshot is VeTokenManagerTest {
  function test_revertsIf_invalidCaller() public {
    vm.expectRevert('ONLY_BY_OWNER_OR_GUARDIAN');
    strategicAssets.clearDelegateSnapshot(B_80BAL_20WETH);
  }

  function test_revertsIf_veTokenNotRegistered() public {
    vm.expectRevert(Core.TokenNotRegistered.selector);
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.clearDelegateSnapshot(B_80BAL_20WETH);
    vm.stopPrank();
  }

  function test_successful() public {
    _addVeToken(
      B_80BAL_20WETH,
      VE_BAL,
      WARDEN_VE_BAL,
      LOCK_DURATION_ONE_YEAR,
      initialDelegate,
      BALANCER_SPACE_ID
    );

    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.clearDelegateSnapshot(B_80BAL_20WETH);
    vm.stopPrank();

    assertEq(
      strategicAssets.DELEGATE_REGISTRY().delegation(address(strategicAssets), BALANCER_SPACE_ID),
      address(0)
    );
  }
}

// TODO: Vote Aragon tests

contract SetVotingContract is VeTokenManagerTest {
  function test_revertsIf_invalidCaller() public {
    vm.expectRevert('ONLY_BY_OWNER_OR_GUARDIAN');
    strategicAssets.setVotingContract(CRV, CRV_VOTING);
  }

  function test_revertsIf_veTokenNotRegistered() public {
    vm.expectRevert(Core.TokenNotRegistered.selector);
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.setVotingContract(CRV, CRV_VOTING);
    vm.stopPrank();
  }

  function test_revertsIf_votingContractIsAddressZero() public {
    _addVeToken(CRV, VE_CRV, address(0), LOCK_DURATION_ONE_YEAR, address(0), '');
    vm.expectRevert(Core.Invalid0xAddress.selector);
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.setVotingContract(CRV, address(0));
    vm.stopPrank();
  }

  function test_successful() public {
    _addVeToken(CRV, VE_CRV, address(0), LOCK_DURATION_ONE_YEAR, address(0), '');
    vm.expectEmit();
    emit VotingContractUpdate(CRV, CRV_VOTING);
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.setVotingContract(CRV, CRV_VOTING);
    vm.stopPrank();
  }
}

contract SetLockDuration is VeTokenManagerTest {
  function test_revertsIf_invalidCaller() public {
    vm.expectRevert('ONLY_BY_OWNER_OR_GUARDIAN');
    strategicAssets.setLockDuration(B_80BAL_20WETH, LOCK_DURATION_ONE_YEAR);
  }

  function test_revertsIf_veTokenNotRegistered() public {
    vm.expectRevert(Core.TokenNotRegistered.selector);
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.setLockDuration(B_80BAL_20WETH, LOCK_DURATION_ONE_YEAR);
    vm.stopPrank();
  }

  function test_revertsIf_lockDurationIsLowerThanCurrent() public {
    _addVeToken(B_80BAL_20WETH, VE_BAL, WARDEN_VE_BAL, LOCK_DURATION_ONE_YEAR, address(0), '');
    vm.expectRevert(VeTokenManager.InvalidNewDuration.selector);
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.setLockDuration(B_80BAL_20WETH, LOCK_DURATION_ONE_YEAR - 1);
    vm.stopPrank();
  }

  function test_successful() public {
    _addVeToken(B_80BAL_20WETH, VE_BAL, WARDEN_VE_BAL, LOCK_DURATION_ONE_YEAR, address(0), '');
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.setLockDuration(B_80BAL_20WETH, LOCK_DURATION_ONE_YEAR + 1);
    vm.stopPrank();
  }
}

contract LockTest is VeTokenManagerTest {
  function test_revertsIf_invalidCaller() public {
    vm.expectRevert('ONLY_BY_OWNER_OR_GUARDIAN');
    strategicAssets.lock(B_80BAL_20WETH);
  }

  function test_revertsIf_veTokenNotRegistered() public {
    vm.expectRevert(Core.TokenNotRegistered.selector);
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.lock(B_80BAL_20WETH);
    vm.stopPrank();
  }

  function test_successful_locksFirstTime() public {
    vm.startPrank(0x10A19e7eE7d7F8a52822f6817de8ea18204F2e4f); // Authenticated Address
    ISmartWalletChecker(SMART_WALLET_CHECKER).allowlistAddress(address(strategicAssets));
    vm.stopPrank();

    _addVeToken(B_80BAL_20WETH, VE_BAL, WARDEN_VE_BAL, LOCK_DURATION_ONE_YEAR, address(0), '');

    deal(B_80BAL_20WETH, address(strategicAssets), 1_000e18);

    assertEq(IERC20(B_80BAL_20WETH).balanceOf(address(strategicAssets)), 1_000e18);
    assertEq(IERC20(VE_BAL).balanceOf(address(strategicAssets)), 0);

    vm.expectEmit();
    emit Lock(1_000e18, ((block.timestamp + LOCK_DURATION_ONE_YEAR) / WEEK) * WEEK);

    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.lock(B_80BAL_20WETH);
    vm.stopPrank();

    assertEq(IERC20(B_80BAL_20WETH).balanceOf(address(strategicAssets)), 0);
    assertEq(IERC20(VE_BAL).balanceOf(address(strategicAssets)), 980969970826973230916);
    assertEq(IVeToken(VE_BAL).locked(address(strategicAssets)), 1_000e18);
  }

  function test_successful_increaseBalance() public {
    vm.startPrank(0x10A19e7eE7d7F8a52822f6817de8ea18204F2e4f); // Authenticated Address
    ISmartWalletChecker(SMART_WALLET_CHECKER).allowlistAddress(address(strategicAssets));
    vm.stopPrank();

    _addVeToken(B_80BAL_20WETH, VE_BAL, WARDEN_VE_BAL, LOCK_DURATION_ONE_YEAR, address(0), '');

    deal(B_80BAL_20WETH, address(strategicAssets), 1_000e18);

    assertEq(IERC20(B_80BAL_20WETH).balanceOf(address(strategicAssets)), 1_000e18);
    assertEq(IERC20(VE_BAL).balanceOf(address(strategicAssets)), 0);

    vm.expectEmit();
    emit Lock(1_000e18, ((block.timestamp + LOCK_DURATION_ONE_YEAR) / WEEK) * WEEK);

    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.lock(B_80BAL_20WETH);
    vm.stopPrank();

    assertEq(IERC20(B_80BAL_20WETH).balanceOf(address(strategicAssets)), 0);
    assertEq(IERC20(VE_BAL).balanceOf(address(strategicAssets)), 980969970826973230916);
    assertEq(IVeToken(VE_BAL).locked(address(strategicAssets)), 1_000e18);

    uint256 initialLockEnd = IVeToken(VE_BAL).locked__end(address(strategicAssets));

    deal(B_80BAL_20WETH, address(strategicAssets), 500e18);

    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.lock(B_80BAL_20WETH);
    vm.stopPrank();

    assertEq(IERC20(B_80BAL_20WETH).balanceOf(address(strategicAssets)), 0);
    assertEq(IERC20(VE_BAL).balanceOf(address(strategicAssets)), 1471454956240459846374);
    assertEq(IVeToken(VE_BAL).locked(address(strategicAssets)), 1_500e18);
    assertEq(IVeToken(VE_BAL).locked__end(address(strategicAssets)), initialLockEnd);
  }

  function test_successful_increaseUnlockTime() public {
    vm.startPrank(0x10A19e7eE7d7F8a52822f6817de8ea18204F2e4f); // Authenticated Address
    ISmartWalletChecker(SMART_WALLET_CHECKER).allowlistAddress(address(strategicAssets));
    vm.stopPrank();

    _addVeToken(B_80BAL_20WETH, VE_BAL, WARDEN_VE_BAL, LOCK_DURATION_ONE_YEAR, address(0), '');

    deal(B_80BAL_20WETH, address(strategicAssets), 1_000e18);

    assertEq(IERC20(B_80BAL_20WETH).balanceOf(address(strategicAssets)), 1_000e18);
    assertEq(IERC20(VE_BAL).balanceOf(address(strategicAssets)), 0);

    vm.expectEmit();
    emit Lock(1_000e18, ((block.timestamp + LOCK_DURATION_ONE_YEAR) / WEEK) * WEEK);

    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.lock(B_80BAL_20WETH);
    vm.stopPrank();

    assertEq(IERC20(B_80BAL_20WETH).balanceOf(address(strategicAssets)), 0);
    assertEq(IERC20(VE_BAL).balanceOf(address(strategicAssets)), 980969970826973230916);
    assertEq(IVeToken(VE_BAL).locked(address(strategicAssets)), 1_000e18);

    uint256 initialLockEnd = IVeToken(VE_BAL).locked__end(address(strategicAssets));

    vm.warp(block.timestamp + WEEK);

    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.lock(B_80BAL_20WETH);
    vm.stopPrank();

    uint256 newLockEnd = IVeToken(VE_BAL).locked__end(address(strategicAssets));

    assertEq(IERC20(B_80BAL_20WETH).balanceOf(address(strategicAssets)), 0);
    assertEq(IERC20(VE_BAL).balanceOf(address(strategicAssets)), 980969970826973230916);
    assertEq(IVeToken(VE_BAL).locked(address(strategicAssets)), 1_000e18);
    assertEq(initialLockEnd + WEEK, newLockEnd);
  }
}

contract UnlockTest is VeTokenManagerTest {
  function test_revertsIf_invalidCaller() public {
    vm.expectRevert('ONLY_BY_OWNER_OR_GUARDIAN');
    strategicAssets.unlock(B_80BAL_20WETH);
  }

  function test_revertsIf_veTokenNotRegistered() public {
    vm.expectRevert(Core.TokenNotRegistered.selector);
    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.unlock(B_80BAL_20WETH);
    vm.stopPrank();
  }

  function test_revertsIf_unlockTimeHasNotPassed() public {
    vm.startPrank(0x10A19e7eE7d7F8a52822f6817de8ea18204F2e4f); // Authenticated Address
    ISmartWalletChecker(SMART_WALLET_CHECKER).allowlistAddress(address(strategicAssets));
    vm.stopPrank();

    _addVeToken(B_80BAL_20WETH, VE_BAL, WARDEN_VE_BAL, LOCK_DURATION_ONE_YEAR, address(0), '');

    deal(B_80BAL_20WETH, address(strategicAssets), 1_000e18);

    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.lock(B_80BAL_20WETH);

    vm.expectRevert("The lock didn't expire");
    strategicAssets.unlock(B_80BAL_20WETH);
    vm.stopPrank();
  }

  function test_successful_unlock() public {
    vm.startPrank(0x10A19e7eE7d7F8a52822f6817de8ea18204F2e4f); // Authenticated Address
    ISmartWalletChecker(SMART_WALLET_CHECKER).allowlistAddress(address(strategicAssets));
    vm.stopPrank();

    _addVeToken(B_80BAL_20WETH, VE_BAL, WARDEN_VE_BAL, LOCK_DURATION_ONE_YEAR, address(0), '');

    deal(B_80BAL_20WETH, address(strategicAssets), 1_000e18);

    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.lock(B_80BAL_20WETH);
    vm.stopPrank();

    vm.warp(block.timestamp + LOCK_DURATION_ONE_YEAR + 1);

    vm.expectEmit();
    emit Unlock(1_000e18);

    vm.startPrank(AaveGovernanceV2.SHORT_EXECUTOR);
    strategicAssets.unlock(B_80BAL_20WETH);
    vm.stopPrank();
  }
}
