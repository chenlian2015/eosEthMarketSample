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
        OLPublicAddressInterface olPublicAddressInterface = OLPublicAddressInterface(getOuLianPublicAddress());
        address addrTmp = olPublicAddressInterface.getServerAddress("OLLogTool");
        if(addrTmp == address(0x0)){
            return;
        }
        OLLogToolInterface olLogToolInterface = OLLogToolInterface(addrTmp);
        olLogToolInterface.addLog(logTag, logContent);
    }
}