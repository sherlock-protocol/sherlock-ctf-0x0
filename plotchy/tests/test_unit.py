from brownie import (
    network,
    accounts,
    config,
    Contract,
    AmusementPark,
    Exploit,
    Setup,
    exceptions
)
from web3 import Web3
import pytest
import json


'''
Is there any harm in not using (,bool success) before every .call()?
I think the ride values become reset either way right? Test this



'''


def deploy_setup():
    setup = Setup.deploy({"from": accounts[0]})
    print(setup.isSolved())
    print(setup.instance())
    return setup.instance()
    # exploit = Exploit.deploy(setup.instance(), {"from": get_account()})
    # finalize_tx = exploit.finalize({"from": get_account()})
    # print(finalize_tx.info())
    # print(setup.isSolved())

def test_deploy():
    # Arrange
    account = accounts[0]
    # Act
    setup = Setup.deploy({"from": account})
    starting_value = setup.isSolved()
    expected = False
    # Assert
    assert starting_value == expected


def test_parkEntrance_to_exit():
    # Arrange
    with open("./build/contracts/AmusementPark.json") as f:
        amusementParkAbi = json.load(f)['abi']
    account = accounts[0]
    setup = Setup.deploy({"from": account})
    # Act
    amusementPark_address = setup.instance()
    # print(amusementPark_address)
    amusementPark = Contract.from_abi("AmusementPark", amusementPark_address, amusementParkAbi)
    calldata = Web3.toHex(hexstr="3a667c1a")[2:]
    enterPark_tx = amusementPark.parkEntrance(calldata, {"from": account})
    enterPark_tx.wait(1)
    # Assert
    starting_value = setup.isSolved()
    expected = False
    assert starting_value == expected


def test_parkEntrance_to_Carousel_And_redo_carousel():
    # Arrange
    with open("./build/contracts/AmusementPark.json") as f:
        amusementParkAbi = json.load(f)['abi']
    account = accounts[0]
    setup = Setup.deploy({"from": account})
    # Act
    amusementPark_address = setup.instance()
    # print(amusementPark_address)
    amusementPark = Contract.from_abi("AmusementPark", amusementPark_address, amusementParkAbi)
    calldata = Web3.toHex(hexstr="92b1f40f0000000000000000000000000000000000000000000000000000000000000000")[2:]
    startingCaro_value = amusementPark.Carousel()
    expectedCaro = False
    enterPark_tx = amusementPark.parkEntrance(calldata, {"from": account})
    enterPark_tx.wait(1)
    endingCaro_value = amusementPark.Carousel()
    expectedEndingCaro = False
    # Assert
    starting_value = setup.isSolved()
    expected = False
    assert startingCaro_value == expectedCaro
    assert endingCaro_value == expectedEndingCaro
    print(starting_value, expected)
    assert starting_value == expected

# def test_checkAnds():
#     # Arrange
#     with open("./build/contracts/AmusementPark.json") as f:
#         amusementParkAbi = json.load(f)['abi']
#     account = accounts[0]
#     setup = Setup.deploy({"from": account})
#     # Act
#     amusementPark_address = setup.instance()
#     # print(amusementPark_address)
#     amusementPark = Contract.from_abi("AmusementPark", amusementPark_address, amusementParkAbi)
#     andValue1 = amusementPark.checkAnds(0, 0, 0, 0, {"from": account})
#     expected1 = False
#     andValue2 = amusementPark.checkAnds(0, 1, 1, 1, {"from": account})
#     expected2 = False
#     andValue3 = amusementPark.checkAnds(1, 0, 1, 1, {"from": account})
#     expected3 = False
#     andValue4 = amusementPark.checkAnds(1, 1, 0, 1, {"from": account})
#     expected4 = False
#     andValue5 = amusementPark.checkAnds(1, 1, 1, 1, {"from": account})
#     expected5 = True

#     # Assert

#     assert andValue1 == expected1
#     assert andValue2 == expected2
#     assert andValue3 == expected3
#     assert andValue4 == expected4
#     assert andValue5 == expected5

def test_outsidePark():
    # Arrange
    with open("./build/contracts/AmusementPark.json") as f:
        amusementParkAbi = json.load(f)['abi']
    account = accounts[0]
    setup = Setup.deploy({"from": account})
    # Act
    amusementPark_address = setup.instance()
    # print(amusementPark_address)
    amusementPark = Contract.from_abi("AmusementPark", amusementPark_address, amusementParkAbi)
    outside_tx = amusementPark._Carousel(Web3.toHex(hexstr="0000000000000000000000000000000000000000000000000000000000000012")[2:], {"from": account})
    


    # Assert

    # assert andValue1 == expected1
