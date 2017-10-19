pragma solidity ^0.4.15;


import "./OLRandomContract.sol";
import "./OLPublicAddress.sol";
import "./OLMarketServerInterface.sol";
import "./OLServerInterface.sol";


contract OLMarket is OLMarketServerInterface {

    OLPublicAddress oclpa;

    uint randomFee = 0.0001 * 1000000000000000000;//10^18次方;

    function OCMarket(){
        oclpa = OLPublicAddress(0x8cb94b79cb4ea51e228b661cd38f81484d2632da);
    }

    function getFee(string servarName) public returns (uint){
        OLServerInterface olServerInterface = OLServerInterface(oclpa.getServerAddress(servarName));
        return olServerInterface.getFee();
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
        if (versionCaller != getCurrentVersion) {
            return 3;
        }

        OLBlackWhiteListInterface olBlackWhiteListInterface = OLBlackWhiteListInterface(oclpa.getServerAddress(servarName));
        if (!olBlackWhiteListInterface.isAddrCanCallServer(msg.sender)) {
            return 4;
        }

        StantardTokenInterface stantardTokenInterface = StantardTokenInterface(oclpa.getServerAddress("OracleChainToken"));
        uint n = stantardTokenInterface.allowance(msg.sender, oclpa.getServerAddress("octManager"));

        OLFeeManagerInterfacce olFeeManagerInterfacce = OLFeeManagerInterfacce(oclpa.getServerAddress("OLFeeManager"));
        if (n < olServerInterface.getFee(servarName)) {
            return 1;
        }
        stantardTokenInterface.transferFrom(msg.sender, oclpa.getServerAddress("octManager"), olServerInterface.getFee());

        return 0;
    }
}