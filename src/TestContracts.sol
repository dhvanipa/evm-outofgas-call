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

    (bool success, ) = address(chipContractAddress).call(abi.encodeWithSignature("onMine()"));

    if (!success) {
      // A dummy operation post calling the chip contract to consume gas
      // to trigger out of gas exception, as a simple return does not
      // Note: smaller operations < 10 do not consume enough gas to trigger out of gas exception
      // for (uint256 i = 0; i < 10; i++) {
      //   continue;
      // }
    }
  }
}
