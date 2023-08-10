export function cli() {}

export function test({ chain, protocolVersion }) {
  return `function test_isFlashBorrower() external {
    GovHelpers.executePayload(
      vm,
      address(proposal),
      ${CHAIN_TO_EXECUTOR[chain]}
    );
    bool isFlashBorrower = Aave${protocolVersion}${chain}.ACL_MANAGER.isFlashBorrower(proposal.NEW_FLASH_BORROWER());
    assertEq(isFlashBorrower, true);
  }`;
}

export function proposalCode({ chain, protocolVersion }) {
  return `Aave${protocolVersion}${chain}.ACL_MANAGER.addFlashBorrower(NEW_FLASH_BORROWER);`;
}
