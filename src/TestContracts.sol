// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;

contract InnerContract {
  function expensiveOperation() public {
    // This loop will consume a lot of gas
    for (uint256 i = 0; i < 1e6; i++) {
      // Just wasting gas with no effect
      continue;
    }
  }
}

contract OuterContract {
  InnerContract public innerContract;

  constructor(address _innerContractAddress) {
    innerContract = InnerContract(_innerContractAddress);
  }

  function callExpensiveOperation() public {
    for (uint256 i = 0; i < 1000; i++) {
      continue;
    }

    // Attempt to call the expensive operation with a small amount of gas
    address(innerContract).call(abi.encodeWithSignature("expensiveOperation()"));
  }
}
