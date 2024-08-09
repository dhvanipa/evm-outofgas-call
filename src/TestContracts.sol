// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;

contract ChipContract {
  function onMine() public {
    // This loop will consume a lot of gas
    for (uint256 i = 0; i < 1e6; i++) {
      // Just wasting gas with no effect
      continue;
    }
  }
}

contract WorldContract {
  address chipContractAddress;

  constructor(address _chipContractAddress) {
    chipContractAddress = _chipContractAddress;
  }

  function mine() public {
    // Consume some gas before calling the chip contract
    for (uint256 i = 0; i < 1000; i++) {
      continue;
    }

    (bool success, ) = address(chipContractAddress).call(abi.encodeWithSignature("onMine()"));

    if (!success) {
      // A dummy operation post calling the chip contract to consume gas
      // to trigger out of gas exception, as a simple return does not
      // Note: to trigger, set numIterations to >= 10
      uint256 numIterations = 5;
      for (uint256 i = 0; i < numIterations; i++) {
        continue;
      }
    }
  }
}
