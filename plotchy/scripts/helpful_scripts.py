from brownie import (
    network,
    accounts,
    config,
    Contract,
)
from web3 import Web3
import sys
from dotenv import dotenv_values
sys.path.insert(1, dotenv_values(".env")["CRYPTO_TOOLS_PATH"])
import enc

NON_FORKED_LOCAL_BLOCKCHAIN_ENVIRONMENTS = ["hardhat", "development", "ganache"]
LOCAL_BLOCKCHAIN_ENVIRONMENTS = NON_FORKED_LOCAL_BLOCKCHAIN_ENVIRONMENTS + [
    "mainnet-fork",
    "binance-fork",
    "matic-fork",
]
DECIMALS = 18

def get_account(index=None, id=None):
    if index:
        return accounts[index]
    # if network.show_active() in LOCAL_BLOCKCHAIN_ENVIRONMENTS:
    #     return accounts[0]
    if id:
        return accounts.load(id)

    publicKey, privateKey = enc.run_decryption()
    return accounts.add(privateKey)


def padHexTo32Bytes(input, side):
    # print(input, len(input))
    if 'upper' in side.lower() or 'left' in side.lower():
        return "0" * (64 - (len(input) % 64)) + input
    elif 'lower' in side.lower() or 'right' in side.lower():
        return input + "0" * (64 - (len(input) % 64))
        