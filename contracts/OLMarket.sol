pragma solidity ^0.4.15;


import "./OLRandomContract.sol";
import "./OLPublicAddress.sol";
import "./OLMarketServerInterface.sol";
import "./OLServerInterface.sol";
import "./OLBlackWhiteListInterface.sol";
import "./StantardTokenInterface.sol";
import "./OLFeeManagerInterface.sol";
import "./OLCommonConfigure.sol";
import "./OLAddressSuperManager.sol";
import "./OLCommonCall.sol";
import "./OLAddressPublicAddressManager.sol";
import "./OLSuperManager.sol";


contract OLMarket is OLMarketServerInterface, OLAddressSuperManager, OLCommonCall, OLCommonConfigure {

    OLPublicAddress oclpa;
    string private constant TAG = "OLMarket";

    function OCMarket(){
        oclpa = OLPublicAddress(getOuLianPublicAddress());
    }

    function getFee(string servarName) public returns (uint){
        OLFeeManagerInterface olServerInterface = OLFeeManagerInterface(oclpa.getServerAddress("OLFeeManager"));
        return olServerInterface.getFee(servarName);
    }

    function callServer(string servarName, uint versionCaller)returns (uint reason){

        uint nCode = preCheckAndPay(servarName, versionCaller);
        if (nCode != errorCode_success) {
            return nCode;
        }
        addLog(TAG, "5");

        OLServerInterface olServerInterface = OLServerInterface(oclpa.getServerAddress(servarName));
        olServerInterface.callServer(msg.sender, versionCaller);
        addLog(TAG, "6");
        return errorCode_success;
    }

    function preCheckAndPay(string servarName, uint versionCaller) public returns (uint errorCode){
        addLog(TAG, "1");
        OLServerInterface olServerInterface = OLServerInterface(oclpa.getServerAddress(servarName));
        if (versionCaller != getCurrentVersion()) {
            return errorCode_versionIsOld;
        }

        addLog(TAG, "2");
        OLBlackWhiteListInterface olBlackWhiteListInterface = OLBlackWhiteListInterface(oclpa.getServerAddress("OLBlackWhiteList"));
        if (!olBlackWhiteListInterface.isAddrCanCallServer(servarName, msg.sender)) {
            return errorCode_noPermitAccess;
        }

        uint nServerStatus = oclpa.getServerStatus(servarName);
        if (nServerStatus != serverStatusNormal) {
            return errorCode_serverIsFreezed;
        }
        addLog(TAG, "3");

        OLSuperManager olSuperManager = OLSuperManager(getSuperManagerContractAddress());
        StantardTokenInterface stantardTokenInterface = StantardTokenInterface(oclpa.getServerAddress("OracleChainToken"));
        uint nAllowance = stantardTokenInterface.allowance(msg.sender, olSuperManager.getSuperManager());


        OLFeeManagerInterface olFeeManagerInterface = OLFeeManagerInterface(oclpa.getServerAddress("OLFeeManager"));
        uint nFeeNeeded = olFeeManagerInterface.getFee(servarName);
        if (nAllowance < nFeeNeeded) {
            return errorCode_feeIsNotEnough;
        }
        addLog(TAG, "4");


        stantardTokenInterface.transferFrom(msg.sender, olSuperManager.getSuperManager(), nFeeNeeded);
        return errorCode_success;
    }
}