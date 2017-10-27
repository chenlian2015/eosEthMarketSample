pragma solidity ^0.4.15;


import "./OLPublicAddress.sol";
import "./OLLogToolInterface.sol";
import "./OLAddressPublicAddressManager.sol";


contract OLCommonCall {

    string public constant marketName = "OLMarket";

    function addLog(string log, address addrLog) public {
        OLPublicAddressInterface olPublicAddressInterface = OLPublicAddressInterface(addrLog);
        OLLogToolInterface olLogToolInterface = OLLogToolInterface(olPublicAddressInterface.getServerAddress("OLLogTool"));
        olLogToolInterface.addLog(log);
    }
}