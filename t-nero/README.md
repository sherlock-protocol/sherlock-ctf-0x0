# Description

The challenge used the background of the famous Monopoly boardgame, but make it quite simple (due to limited time of mine), roll two dices and move, that's all. Every play turn require at least 0.25 ETH, this is just for keep participant from keep playing repeatedly without knowing the method to solve it, nothing significant to the solving.

# Intended flaws

I put quite some suspicious points as the honey pots to blend the real one in it. It might seem complicated, but the real flaw is just a simple tricky. It a math challenge combined with type conversion (and also with a bitwise operation).
* I intendedly left the LoC 106-109 blanked. Go to `Exploit.sol` for the details.
* The another way is to go to the penalty slot which is explain in `Exploit2.sol`.
* So just calculate the multiply of two dices to land at this slot, then the `endTurn(balance)` will do the rest.
* The other slots will manipulate the balance, so it is barely possible that you could pre-calculate the move that would drain all ETH in contract.

# Goeril address
* My address: https://goerli.etherscan.io/address/0xf00d3202bdb94407a407dbd7b238af17df40c493
* Deploy transaction: https://goerli.etherscan.io/tx/0x9255eb1a6f8bdcdddaf7d72892ff6c27a00676f9c08edff9251d86682b4b9cea
* Setup: https://goerli.etherscan.io/address/0x34e5ec7da55039f332949a6d7db506cd94594e12
* Monopoly: https://goerli.etherscan.io/address/0x2488764643d43f974b3819dc14400543b3df9904
* gameVault: https://goerli.etherscan.io/address/0x34e5ec7da55039f332949a6d7db506cd94594e12
