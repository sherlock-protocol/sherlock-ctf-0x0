# Sherlock CTF Submission

## Amusement Park

This repository hosts my CTF challenge contract, setup contract, and exploit contract.

## Description

The Amusement Park is designed to be navigated however the user wants, meaning there are several permutations available.
Each ride is designed to take the user onto another ride, and the user wins the CTF challenge if they can complete each ride and leave the park.
If the user is able to leave the park without riding each of the rides, that would be an unforeseen vulnerability.

## Exploit

AmusementPark tests your calldata crafting abilities. You begin with the single entry function parkEntrance(bytes) that is given a `ticket`, which holds all of your future calldata for the park. Each function in the contract ends with an `address(this).call(ticket)`, which will send you into the next ride of the amusement park. The tricky nature of each ride requiring different calldata alongside some rides manipulating your entire `ticket` is the bulk of the puzzle.

Because the entire exploit is sent as a single piece of calldata, the Exploit.sol is a one-liner in the constructor along with accompanying logic within fallback(). The real puzzle comes in the form of choosing your sequence of rides and the resultant contract ABI encoding that follows. My example exploit goes in top-down order of rides in the contract, but any permutation of ride ordering is acceptable. 

## Contract Location

| Contract               | Goerli                                                                                                                       |
| ---------------------- | ---------------------------------------------------------------------------------------------------------------------------- |
| AmusementPark.sol      | [0xebb997D2FabE73df8cF88Ab28b82B70741592525](https://goerli.etherscan.io/address/0xebb997D2FabE73df8cF88Ab28b82B70741592525) |
| Setup.sol              | [0x869a2D3856BE26cfE77cC7Cb6579219d13373Bc9](https://goerli.etherscan.io/address/0x869a2D3856BE26cfE77cC7Cb6579219d13373Bc9) |
