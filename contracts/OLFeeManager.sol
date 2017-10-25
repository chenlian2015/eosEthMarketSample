pragma solidity ^0.4.15;
import "./OLFeeManagerInterface.sol";
import "./OLSuperManager.sol";


contract OLFeeManager is OLFeeManagerInterface,OLCommon{

    mapping (string => uint)  feeSetting;

    function setFee(string serverName, uint fee)public returns (uint){
        OLSuperManager olSuperManager = OLSuperManager(0x8ae305bda0ec07c8a38ff7bf4a85f85654591f5b);
        if (!olSuperManager.isUserHasPermissonToModify(msg.sender, "OLFeeManager")) {
            return errorCode_noPermitAccess;
        }
        feeSetting[serverName] = fee;
        return errorCode_success;
    }

    function getFee(string serverName) public returns (uint){
        return feeSetting[serverName];
    }
}