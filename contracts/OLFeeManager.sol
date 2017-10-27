pragma solidity ^0.4.15;


import "./OLFeeManagerInterface.sol";
import "./OLSuperManager.sol";
import "./OLCommonCall.sol";
import "./OLAddressSuperManager.sol";

contract OLFeeManager is OLFeeManagerInterface,OLAddressSuperManager,OLCommonCall, OLCommonConfigure {

    mapping (string => uint)  private feeSetting;

    mapping (string => uint)  private feeFeedBackSetting;

    mapping (address => uint)  private feeFeedBackAwardBalance;

    function setFee(string serverName, uint fee) public returns (uint){
        OLSuperManager olSuperManager = OLSuperManager(getSuperManagerAddress());
        if (!olSuperManager.isUserHasPermissonToModify(msg.sender, "OLFeeManager")) {
            return errorCode_noPermitAccess;
        }
        feeSetting[serverName] = fee;
        return errorCode_success;
    }

    function setFeedBackFee(string serverName, uint fee) public returns (uint){
        OLSuperManager olSuperManager = OLSuperManager(getSuperManagerAddress());
        if (!olSuperManager.isUserHasPermissonToModify(msg.sender, "OLFeeManager")) {
            return errorCode_noPermitAccess;
        }
        feeFeedBackSetting[serverName] = fee;
        return errorCode_success;
    }

    function getFee(string serverName) public returns (uint){
        return feeSetting[serverName];
    }

    function getFeedBackFeeAward(string serverName) public returns (uint){
        return feeFeedBackSetting[serverName];
    }

    function addFeeFeedBack(address serverPorvider, string contractName) public returns (uint){
        OLSuperManager olSuperManager = OLSuperManager(getSuperManagerAddress());
        if (!olSuperManager.isUserHasPermissonToModify(msg.sender, "OLFeeManagerAddFeeFeedBack")) {
            return errorCode_noPermitAccess;
        }

        feeFeedBackAwardBalance[serverPorvider] += getFeedBackFeeAward(contractName);
        return errorCode_success;
    }
}