// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.4;

import "./ISetup.sol";
import "./CustomMarketplace.sol";
import "./Exploit.sol";

contract Setup is ISetup {
    CustomMarketplace public instance;
    Exploit public exploit;

    constructor() {
        instance = new CustomMarketplace();
        exploit = new Exploit(instance);

        emit Deployed(address(instance));

        instance.createNFTAndPutOnSale("ipfs://", 5000, 1e18);
        instance.updateInfo(1, address(exploit), 5000, 1e18);
    }

    function isSolved() external view override returns (bool) {
        return exploit.isRansomPaid();
    }
}
