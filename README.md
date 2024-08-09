# Out of Gas Test

- When contract A calls contract B with all remaining gas, if contract B runs out of gas, I would expect the entire TX to revert, but instead it does not.

## Steps

0. Clone repo, `pnpm install`. Make sure you have foundry, and an anvil node running locally on 8545.

1. `pnpm run test`. This will deploy the 2 example contracts in `src/TestContracts.sol`. And then call the outer contracts function.

2. forge will print 3 TX hashes from the previous script. The last tx hash is for the function call. `cast run {hash}`to see the trace, which will look like:

```
Executing previous transactions from the block.
Traces:
  [78506] 0x9B4aC8FAfC44575C6963fA22D50963379e899a49::99aa9f22()
    ├─ [30286] 0x20F43316cf784C821a65aE874c8060f30c30c7C4::97303290()
    │   └─ ← [OutOfGas]
    └─ ← [Stop]


Transaction successfully executed.
Gas used: 99570
```

As you can see, the inner call ran out of gas, yet the outer call succeeded.

## Solutions

If one wants to call an external contract, and revert the tx if it runs out of gas, but not otherwise, than one needs to spend some gas after calling the external contract, as a simple return seems to consume 0 gas.

eg
```
for (uint256 i = 0; i < 10; i++) {
  continue;
}
```

I noticed that consuming very little gas, like with a `require(true)` call does not trigger it. A for loop that consumes ~500 gas seems to be the minimum to trigger the revert.