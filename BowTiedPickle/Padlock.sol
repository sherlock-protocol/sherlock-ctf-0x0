pragma solidity 0.8.4;

contract Padlock {

    bool public tumbler1 = false;
    bool public tumbler2 = false;
    bool public tumbler3 = false;

    bool public opened = false;

    uint256 public tries;
    uint256 constant maxTries = 3;

    bytes32 public passHash;

    constructor(string memory _password) {
        passHash = keccak256(abi.encodePacked(_password));
    }

    event BrokenPick(uint256 tries);
    event Opened(address picker);

    function pick1(string memory passphrase) public {
        require(tries <= maxTries,"No lockpicks left");

        if (keccak256(abi.encodePacked(passphrase)) == passHash) {
            tumbler1 = true;
        } else {
            tries++;
            emit BrokenPick(tries);
        }
        
    }

    function pick2() public payable {
        require(tries <= maxTries,"No lockpicks left");
        require(tumbler1,"Nothing on two...");

        if (msg.value == 33) {
            tumbler2 = true;
        } else {
            tries++;
            emit BrokenPick(tries);
        }

    }

    function pick3(bytes16 message) public {
        require(tries <= maxTries,"No lockpicks left");
        require(tumbler1,"Nothing on three...");
        require(tumbler2,"Nothing on three...");

        if (bytes2(bytes8(message)) == 0x6942) {
            tumbler3 = true;
        } else {
            tries++;
            emit BrokenPick(tries);
        }

    }

    function open() public {
        require(tumbler1 && tumbler2 && tumbler3);
        opened = true;
        emit Opened(msg.sender);
    }

    

}
