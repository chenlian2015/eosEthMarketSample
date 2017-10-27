pragma solidity ^0.4.15;


import "./OLRandomContract.sol";
import "./OLPublicAddress.sol";
import "./OLCommonConfigure.sol";
import "./OLCommonCall.sol";
import "./OLAddressPublicAddressManager.sol";


contract ThirdPartyVoter is OLCommonCall, OLCommonConfigure, OLAddressPublicAddressManager {

    OLPublicAddress oclpa;

    function ThirdPartyVoter(){
        oclpa = OLPublicAddress(getOuLianPublicAddress());
    }

    function sendOnlyHash(string seed){
        OLRandomContract ocRandomServer = OLRandomContract(oclpa.getServerAddress("OLRandomContract"));
        ocRandomServer.sendOnlyHash(keccak256(keccak256(seed)));
    }

    function sendSeedAndHash(string seed){
        OLRandomContract ocRandomServer = OLRandomContract(oclpa.getServerAddress("OLRandomContract"));
        ocRandomServer.sendSeedAndHash(keccak256(seed), keccak256(keccak256(seed)));
    }

}