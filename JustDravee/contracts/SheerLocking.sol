pragma solidity 0.8.4;

// MAX 200 LOC
contract SheerLocking {
    address private immutable DEPLOYER;
    uint256 private DEPLOY_TIMESTAMP;
    string private constant YEZSBBM28A = "I waited so long for  season 4 :'( ";
    string private constant V3NF4M1LQS = "Jim Moriarty";
    string private constant BQ6TQGCX9N = " is ";
    string private constant IRT8I6TGHK = "the best";
    string private constant P4SRT2J78Q = "The Woman";
    string private constant EEQV6UJ310 = "Benedict Cumberbatch";
    string private constant WC0PT98SKH = " is nice too. ";
    string private constant H7CADDWW9U = "Jonny Lee Miller";
    string private constant BBD0FG8JUZ = "Henry Cavill";
    string private constant LLQTQAOTQV = "/";
    string private constant JM7VGZT6DR = "Sherlock of Steel";
    string private constant M1PGA9WP8G = " and ";
    string private constant PRYY37W9KW = "Missy";
    string private constant KHZPZL6OFX = "Enola";
    string private constant FNFEYDC4ZP = " were a good team too!";
    string private constant XGV62N0A66 = "Lucy Liu";
    string private constant OR636UE7J5 = "The Master in Doctor Who";
    mapping(address => bool) private _blackList1;
    mapping(address => bool) private _successList1;
    mapping(address => bool) private _blackList2;
    mapping(address => bool) private _successList2;
    mapping(address => bool) private _blackList3;
    mapping(address => bool) private _successList3;
    mapping(address => bool) private _blackList4;
    mapping(address => bool) private _successList4;
    mapping(address => bool) private _blackList5;
    mapping(address => bool) private _successList5;
    mapping(address => bool) private _blackList6;
    mapping(address => bool) private _successList6;
    mapping(address => bool) private _blackList7;
    mapping(address => bool) private _successList7;

    modifier lockone() {
        require(msg.sender == DEPLOYER);
        _;
    }

    modifier lockTwo() {
        require(msg.sender != tx.origin);
        _;
    }

    modifier lockThree1(bytes8 _keyThree) {
        require(uint32(uint64(_keyThree)) == uint16(uint64(_keyThree)));
        require(uint32(uint64(_keyThree)) != uint64(_keyThree));
        _;
    }

    modifier lockThree2(bytes8 _keyThree) {
        require(uint32(uint64(_keyThree)) == uint128(uint64(_keyThree)));
        require(uint32(uint64(_keyThree)) != uint64(_keyThree));
        _;
    }

    modifier lockThree4(bytes8 _keyThree) {
        require(uint32(uint64(_keyThree)) == uint8(uint64(_keyThree)));
        require(uint8(uint64(_keyThree)) != uint64(_keyThree));
        _;
    }

    modifier lockThree3(bytes8 _keyThree) {
        require(uint32(uint64(_keyThree)) == uint16(uint64(_keyThree)));
        require(uint32(uint64(_keyThree)) != uint64(_keyThree));
        _;
    }

    modifier lockThree7(bytes8 _keyThree) {
        require(uint8(uint64(_keyThree)) == uint16(uint64(_keyThree)));
        require(uint8(uint64(_keyThree)) != uint64(_keyThree));
        _;
    }

    modifier lockOne1() {
        require(!_blackList1[tx.origin] && !_blackList1[msg.sender]);
            _blackList1[tx.origin] = true;
            _blackList1[msg.sender] = true;
        _;
    }

    modifier lockOne2() {
        require(!_blackList2[tx.origin] && !_blackList2[msg.sender]);
            _blackList2[tx.origin] = true;
            _blackList2[msg.sender] = true;
        _;
    }
    modifier lockOne3() {
        require(!_blackList3[tx.origin] && !_blackList3[msg.sender]);
            _blackList3[tx.origin] = true;
            _blackList3[msg.sender] = true;
        _;
    }
    modifier lockOne4() {
        require(!_blackList4[tx.origin] && !_blackList4[msg.sender]);
            _blackList4[tx.origin] = true;
            _blackList4[msg.sender] = true;
        _;
    }
    modifier lockOne5() {
        require(!_blackList5[tx.origin] && !_blackList5[msg.sender]);
            _blackList5[tx.origin] = true;
            _blackList5[msg.sender] = true;
        _;
    }
    modifier lockOne6() {
        require(!_blackList6[tx.origin] && !_blackList6[msg.sender]);
            _blackList6[tx.origin] = true;
            _blackList6[msg.sender] = true;
        _;
    }
    modifier lockOne7() {
        require(!_blackList7[tx.origin] && !_blackList7[msg.sender]);
            _blackList7[tx.origin] = true;
            _blackList7[msg.sender] = true;
        _;
    }
    
    modifier lockFour() {
        require(gasleft() % 1 == 0);
        _;
    }

    modifier lockFive() {
        uint x;
        assembly { x := extcodesize(caller()) }
        require(x == 0);
        _;
    }
    
    constructor() payable {
        DEPLOYER = msg.sender; 
        DEPLOY_TIMESTAMP = block.timestamp; 
    }

    function unSheerLock1(string calldata passphrase1, string calldata passphrase2, string calldata passphrase3, string calldata passphrase4, string calldata passphrase5, bytes8 keyThree) external payable lockOne1 lockTwo lockThree1(keyThree) lockFour lockFive {
        require(msg.value == 24725 wei);
        if(bytes(passphrase1).length != 0 && bytes(passphrase2).length != 0 && bytes(passphrase3).length != 0 && bytes(passphrase4).length != 0 && bytes(passphrase5).length != 0 
            && keccak256(bytes(string(abi.encodePacked(passphrase1, passphrase2, passphrase3, passphrase4, passphrase5)))) == keccak256(bytes(string(abi.encodePacked(EEQV6UJ310, BQ6TQGCX9N, IRT8I6TGHK))))) {            
            _successList1[tx.origin] = true;
            _blackList1[tx.origin] = _blackList1[msg.sender] = false;
        }
    }
    function unSheerLock2(string calldata passphrase4, string calldata passphrase2, string calldata passphrase3, string calldata passphrase1, string calldata passphrase5, bytes8 keyThree) external payable lockOne2 lockTwo lockThree1(keyThree) lockFour lockFive {
        if(bytes(passphrase1).length != 0 && bytes(passphrase2).length == 0 && bytes(passphrase3).length != 0 && bytes(passphrase4).length == 0 && bytes(passphrase5).length == 0 
            && keccak256(bytes(string(abi.encodePacked(passphrase1, passphrase2, passphrase3, passphrase5)))) == keccak256(bytes(string(abi.encodePacked(V3NF4M1LQS, WC0PT98SKH, YEZSBBM28A))))) {            
            _successList2[tx.origin] = true;
            _blackList2[tx.origin] = _blackList2[msg.sender] = false;
        }
    }
    function unSheerLock3(string calldata passphrase1, string calldata passphrase2, string calldata passphrase3, string calldata passphrase4, string calldata passphrase5, bytes8 keyThree) external payable lockOne3 lockTwo lockThree3(keyThree) lockFour lockFive {
        if(bytes(passphrase1).length != 0 && bytes(passphrase2).length != 0 && bytes(passphrase3).length == 0 && bytes(passphrase4).length != 0 && bytes(passphrase5).length != 0 
            && keccak256(bytes(string(abi.encodePacked(passphrase1, passphrase2, passphrase3, passphrase4, passphrase5)))) == keccak256(bytes(string(abi.encodePacked(P4SRT2J78Q, BQ6TQGCX9N, PRYY37W9KW, LLQTQAOTQV, OR636UE7J5))))) {            
            _successList3[tx.origin] = true;
            _blackList3[tx.origin] = _blackList3[msg.sender] = false;
        }
    }
    function unSheerLock4(string calldata passphrase1, string calldata passphrase2, string calldata passphrase3, string calldata passphrase4, string calldata passphrase5, bytes8 keyThree) external payable lockOne4 lockTwo lockThree3(keyThree) lockFour lockFive {
        if(bytes(passphrase1).length == 0 && bytes(passphrase2).length == 0 && bytes(passphrase3).length != 0 && bytes(passphrase4).length == 0 && bytes(passphrase5).length == 0 
        && keccak256(bytes(string(abi.encodePacked(passphrase5, passphrase1, passphrase3, passphrase4)))) == keccak256(bytes("John Watson had a role in Ali G (Ricky C) "))) {            
            _successList4[tx.origin] = true;
            _blackList4[tx.origin] = _blackList4[msg.sender] = false;
        }
    }
    function unSheerLock5(string calldata passphrase3, string calldata passphrase2, string calldata passphrase1, string calldata passphrase4, string calldata passphrase5, bytes8 keyThree) external payable lockOne5 lockTwo lockThree1(keyThree) lockFour lockFive {
        if(bytes(passphrase1).length != 0 && bytes(passphrase2).length == 0 && bytes(passphrase3).length != 0 && bytes(passphrase4).length != 0 && bytes(passphrase5).length == 0 
            && keccak256(bytes(string(abi.encodePacked(passphrase3, passphrase2, passphrase1, passphrase4, passphrase5)))) == keccak256(bytes(string(abi.encodePacked(BBD0FG8JUZ,": ",JM7VGZT6DR, M1PGA9WP8G, KHZPZL6OFX, "'s big bro"))))) {            
            _successList5[tx.origin] = true;
            _blackList5[tx.origin] = _blackList5[msg.sender] = false;
        }
    }

    function unSheerLock6(string calldata passphrase1, string calldata passphrase2, string calldata passphrase3, string calldata passphrase5, bytes8 keyThree) external payable lockOne6 lockTwo lockThree3(keyThree) lockFour lockFive {
        if(bytes(passphrase1).length != 0 && bytes(passphrase2).length != 0 && bytes(passphrase3).length == 0 && bytes(passphrase5).length != 0 
            && keccak256(bytes(string(abi.encodePacked(passphrase1, passphrase2, passphrase3, passphrase5)))) == keccak256(bytes("Sir Arthur Conan Doyle died in 1930, so copyright on Sherlock Holmes expired in 2000 in the UK")))  {            
            _successList6[tx.origin] = true;
            _blackList6[tx.origin] = _blackList6[msg.sender] = false;
        }
    }

    function unSheerLock7(string calldata passphrase5, string calldata passphrase2, string calldata passphrase3, string calldata passphrase4, string calldata passphrase1, bytes8 keyThree) external payable lockOne7 lockTwo lockThree1(keyThree) lockFour lockFive {
        if(bytes(passphrase1).length != 0 && bytes(passphrase2).length != 0 && bytes(passphrase3).length == 0 && bytes(passphrase4).length != 0 && bytes(passphrase5).length != 0 
            && keccak256(bytes(string(abi.encodePacked(passphrase5, passphrase2, passphrase3, passphrase4, passphrase1)))) == keccak256(bytes(string(abi.encodePacked(H7CADDWW9U, M1PGA9WP8G, XGV62N0A66, FNFEYDC4ZP)))))  {            
            _successList7[tx.origin] = true;
            _blackList7[tx.origin] = _blackList7[msg.sender] = false;
        }
    }

    function solverIsL33t() external view returns(bool) {
        return _successList1[tx.origin] && _successList2[tx.origin] && _successList3[tx.origin] && _successList4[tx.origin] && _successList5[tx.origin] && _successList6[tx.origin] && _successList7[tx.origin];
    }
}