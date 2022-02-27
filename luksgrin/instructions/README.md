# Sherlock CTF 0x0

Participants have been invited following the Secureum RACE that started on February 1st 2022.

## Participating guide

Every participant will create and deploy their own CTF to the goerli test network. The harder your CTF is, the less it will be captured by other contestants and the less point you will lose.

The Sherlock organizer will get in contact with you on Discord (Evert Kors#2684) and invite you to a private repo where you can work on your CTF. We have created an example CTF repository that can be used as a template. https://github.com/sherlock-protocol/sherlock-ctf-example

The repository must contain the following files before the deadline (Febuary 15)

| File                      | Requirements                   |
| ------------------------- | ------------------------------ |
| contracts/Setup.sol       | Max 50 LoC (solidity metrics)  |
| contracts/{challenge}.sol | Max 200 LoC (solidity metrics) |
| contracts/Exploit.sol     | Max 100 LoC (solidity metrics) |
| README.md                 |                                |

All external contracts, except [OpenZeppelin](https://github.com/OpenZeppelin/openzeppelin-contracts) ones are counted as extra LoC.

NOT allowed

- Calls to external contracts (like Uniswap)
- Assembly / Yul
- Based on secret / hash / password / computing power

**Setup.sol**

Must emit `Deployed(address)` in constructor

Must implement https://github.com/sherlock-protocol/sherlock-ctf-example/blob/main/contracts/ISetup.sol interface

Must not contain constuctor arguments

If constructor is payable, `require(msg.value == {value})` must be the first line

**{challenge}.sol**

Filename must start with the name of your CTF

Must use specific solidity version

- NO: `pragma solidity >=0.4.0 <0.6.0;`
- YES: `pragma solidity 0.8.4;`

Must be solvable at any timestamp, block height, chain id or other network specific conditions

**Exploit.sol**

Must contain single constructor argument, expecting `{challenge}.sol` (reference to the actual CTF)

If constructor is payable, `require(msg.value == {value})` must be the first line

After deployment the `isSolved()` call must return true on `Setup.sol`

**README.md**

> DON'T DEPLOY `Exploit.sol` TO ANY PUBLIC NETWORK OR REPOSITORY

Must contain link to `Setup.sol` and `{challenge}.sol` deployed on Goerli.

Referenced contract addresses must be verified on Etherscan.
