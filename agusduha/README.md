# sherlock-ctf-0x0-agusduha - The King Is Dead Long Live The King

| Contract                         | Goerli                                                                                                                       |
| -------------------------------- | ---------------------------------------------------------------------------------------------------------------------------- |
| CTF Proxy                        | [0x1020dFFD73141616fa7A931feE757DC9114B79D9](https://goerli.etherscan.io/address/0x1020dFFD73141616fa7A931feE757DC9114B79D9) |
| TheKingIsDeadLongLiveTheKing.sol | [0x4B8df63820cD31D063a160e1C40f8583227591cB](https://goerli.etherscan.io/address/0x4B8df63820cD31D063a160e1C40f8583227591cB) |
| Setup.sol                        | [0x459D9C80482c541deC1Aa491209EF598BF7c9344](https://goerli.etherscan.io/address/0x459D9C80482c541deC1Aa491209EF598BF7c9344) |

## Disclaimer

The proxy contract is not verified (issues with hardhat-etherscan) but it is a ERC1967Proxy from openzeppelin deployed from Setup.sol (also verified).

The implementation KingVault (TheKingIsDeadLongLiveTheKing.sol) is verified, you have to use the proxy address as if it is the implementation.

The ether to be stolen is in the proxy contract.

Sorry for the inconvenience!
