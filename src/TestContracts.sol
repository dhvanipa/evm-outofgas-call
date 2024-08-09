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
    for (uint256 i = 0; i < 1000; i++) {
      continue;
    }

    address(chipContractAddress).call(abi.encodeWithSignature("onMine()"));
  }
}
