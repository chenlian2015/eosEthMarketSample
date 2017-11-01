pragma solidity ^0.4.15;


import "./OLPublicAddressInterface.sol";
import "./OLLogToolInterface.sol";
import "./OLAddressPublicAddressManager.sol";

contract OLCommonCall is OLAddressPublicAddressManager{

    string public constant marketName = "OLMarket";
    address addrOuLianPublicAddress;
    function setOuLianPublicAddress(address addr){
        addrOuLianPublicAddress = addr;
    }

    function addLog(string logTag, string logContent) public {
//        OLPublicAddressInterface olPublicAddressInterface = OLPublicAddressInterface(getOuLianPublicAddress());
//        OLLogToolInterface olLogToolInterface = OLLogToolInterface(olPublicAddressInterface.getServerAddress("OLLogTool"));
//        olLogToolInterface.addLog(logTag, logContent);
    }
}