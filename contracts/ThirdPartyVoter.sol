pragma solidity ^0.4.15;


import "./OLRandomContract.sol";
import "./OLPublicAddress.sol";
import "./OLCommonConfigure.sol";
import "./OLCommonCall.sol";
import "./OLAddressPublicAddressManager.sol";


contract ThirdPartyVoter is OLCommonCall, OLCommonConfigure {
    string private constant TAG = "ThirdPartyVoter";
    OLPublicAddress oclpa;

    function ThirdPartyVoter(){
        oclpa = OLPublicAddress(getOuLianPublicAddress());
    }

    function sendOnlyHash(string seed){
        addLog(TAG, "1");
        OLRandomContract ocRandomServer = OLRandomContract(oclpa.getServerAddress("OLRandomContract"));
        ocRandomServer.sendOnlyHash(keccak256(keccak256(seed)));
    }

    function sendSeedAndHash(string seed){
        addLog(TAG, "2");
        OLRandomContract ocRandomServer = OLRandomContract(oclpa.getServerAddress("OLRandomContract"));
        ocRandomServer.sendSeedAndHash(keccak256(seed), keccak256(keccak256(seed)));
    }
}