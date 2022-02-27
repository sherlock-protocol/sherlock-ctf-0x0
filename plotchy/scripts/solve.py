from web3 import Web3
from brownie import (
    network,
    accounts,
    config,
    Contract,
    AmusementPark,
    Exploit,
    Setup
)
from web3 import Web3
import sys
from dotenv import dotenv_values
PROJECT_SCRIPTS_PATH = dotenv_values(".env")["CTF_PROJECT_PATH"] + "/scripts/"
PROJECT_BUILD_PATH = dotenv_values(".env")["CTF_PROJECT_PATH"] + "/build/"
sys.path.insert(1, PROJECT_SCRIPTS_PATH)
from helpful_scripts import get_account


def deploy_contracts():
    # setup = Setup.deploy({"from": get_account()})
    setup = Setup.deploy({"from": get_account()}, publish_source=True)
    print(setup.instance())
    print(setup.isSolved())
    # exploit = Exploit.deploy(setup.instance(), {"from": get_account()})
    # finalize_tx = exploit.finalize({"from": get_account()})
    # print(finalize_tx.info())
    # print(setup.isSolved())

def main():
    deploy_contracts()

if __name__ == '__main__':
    main()