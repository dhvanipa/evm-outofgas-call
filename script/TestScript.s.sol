// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;

import { Script } from "forge-std/Script.sol";
import { console } from "forge-std/console.sol";

import { OuterContract, InnerContract } from "../src/TestContracts.sol";

contract TestScript is Script {
  function run() external {
    // Load the private key from the `PRIVATE_KEY` environment variable (in .env)
    uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

    // Start broadcasting transactions from the deployer account
    vm.startBroadcast(deployerPrivateKey);

    InnerContract innerContract = new InnerContract();
    OuterContract outerContract = new OuterContract(address(innerContract));

    console.log("Inner contract deployed at");
    console.logAddress(address(innerContract));

    console.log("Outer contract deployed at");
    console.logAddress(address(outerContract));

    outerContract.callExpensiveOperation{ gas: 100_000 }();

    vm.stopBroadcast();
  }
}
