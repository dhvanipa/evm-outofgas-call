// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;

import { Script } from "forge-std/Script.sol";
import { console } from "forge-std/console.sol";

import { WorldContract, ChipContract } from "../src/TestContracts.sol";

contract TestScript is Script {
  function run() external {
    // Load the private key from the `PRIVATE_KEY` environment variable (in .env)
    uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

    // Start broadcasting transactions from the deployer account
    vm.startBroadcast(deployerPrivateKey);

    ChipContract chipContract = new ChipContract();
    WorldContract worldContract = new WorldContract(address(chipContract));

    console.log("Inner contract deployed at");
    console.logAddress(address(chipContract));

    console.log("Outer contract deployed at");
    console.logAddress(address(worldContract));

    worldContract.mine{ gas: 100_000 }();

    vm.stopBroadcast();
  }
}
