// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "./ISetup.sol";
import "./TheKingIsDeadLongLiveTheKing.sol";
import "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

contract Setup is ISetup {
    ERC1967Proxy public instance;
    KingVault public kingVault;
    bytes public data;

    address constant admin = address(0xDA0);
    address constant proposer = address(0xDA2);
    address constant king = address(0x0);

    constructor() payable {
        require(msg.value == 0.2 ether);

        kingVault = new KingVault();

        data = abi.encodeWithSelector(
            KingVault.initialize.selector,
            admin,
            proposer,
            king
        );

        instance = new ERC1967Proxy{value: 0.2 ether}(address(kingVault), data);

        emit Deployed(address(instance));
    }

    function isSolved() external view override returns (bool) {
        return address(instance).balance == 0;
    }
}
