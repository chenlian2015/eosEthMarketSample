pragma solidity ^0.4.15;


contract OLMarketServerInterface {
    /*
    @param servarName means the server name you will call
    @param versionCaller,means the version of the callback you implemented
    */
    function callServer(string servarName, uint versionCaller)returns (uint reason){}

    /*
    @return get the fee needed to call this server
    */
    function getFee(string servarName) public returns (uint){}

    /*
    @return get the current version of this server
    */
    function getCurrentVersion() public returns (uint version){}

    /*
    precheck call server
    @return reference OLCommon.sol
    */
    function preCheckServerCall(string servarName, uint versionCaller)public returns(uint errorCode){}
}
