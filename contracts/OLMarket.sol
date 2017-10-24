pragma solidity ^0.4.15;


import "./OLRandomContract.sol";
import "./OLPublicAddress.sol";
import "./OLMarketServerInterface.sol";
import "./OLServerInterface.sol";
import "./OLBlackWhiteListInterface.sol";
import "./StantardTokenInterface.sol";
import "./OLFeeManagerInterface.sol";


contract OLMarket is OLMarketServerInterface {

    OLPublicAddress oclpa;

    function OCMarket(){
        oclpa = OLPublicAddress(0x8cb94b79cb4ea51e228b661cd38f81484d2632da);
    }

    function getFee(string servarName) public returns (uint){
        OLFeeManagerInterface olServerInterface = OLFeeManagerInterface(oclpa.getServerAddress("OLFeeManager"));
        return olServerInterface.getFee(servarName);
    }


    function callServer(string servarName, uint versionCaller)returns (uint reason){

        uint nCode = preCheckServerCall(servarName, versionCaller);
        if(nCode != 0){
            return nCode;
        }

        OLServerInterface olServerInterface = OLServerInterface(oclpa.getServerAddress(servarName));
        olServerInterface.callServer(msg.sender, versionCaller);
        return 0;
    }

    function getCurrentVersion() public returns (uint version){
        return 1;
    }

    function preCheckServerCall(string servarName, uint versionCaller) public returns (uint errorCode){
        OLServerInterface olServerInterface = OLServerInterface(oclpa.getServerAddress(servarName));
        if (versionCaller != getCurrentVersion()) {
            return 3;
        }

        OLBlackWhiteListInterface olBlackWhiteListInterface = OLBlackWhiteListInterface(oclpa.getServerAddress(servarName));
        if (!olBlackWhiteListInterface.isAddrCanCallServer(msg.sender)) {
            return 4;
        }

        StantardTokenInterface stantardTokenInterface = StantardTokenInterface(oclpa.getServerAddress("OracleChainToken"));
        uint n = stantardTokenInterface.allowance(msg.sender, oclpa.getServerAddress("octManager"));

        OLFeeManagerInterface olFeeManagerInterface = OLFeeManagerInterface(oclpa.getServerAddress("OLFeeManager"));
        uint nFeeNeeded = olFeeManagerInterface.getFee(servarName);
        if (n < nFeeNeeded) {
            return 1;
        }


        stantardTokenInterface.transferFrom(msg.sender, oclpa.getServerAddress("octManager"), nFeeNeeded);

        return 0;
    }
}