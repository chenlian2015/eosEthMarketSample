pragma solidity ^0.4.15;

import "./OLRandomContract.sol";
import "./OLPublicAddress.sol";
import "./OLVoterInterface.sol";

contract ThirdPartyVoter is OLVoterInterface{

    OLPublicAddress oclpa;

    function ThirdPartyVoter(){
        oclpa = OLPublicAddress(0x8cb94b79cb4ea51e228b661cd38f81484d2632da);
    }

    function() payable {
    }

    function withDraw()public payable{
    }

//    function withDrawToMyAccount()public payable{
////        OLRandomContract ocRandomServer = OLRandomContract(oclpa.getServerAddress("OLRandomContract"));
////        ocRandomServer.withDrawToMyAccount();
//    }

    function sendOnlyHash(string seed){
        OLRandomContract ocRandomServer = OLRandomContract(oclpa.getServerAddress("OLRandomContract"));
        ocRandomServer.sendOnlyHash(keccak256(keccak256(seed)));
    }

    function sendSeedAndHash(string seed){
        OLRandomContract ocRandomServer = OLRandomContract(oclpa.getServerAddress("OLRandomContract"));
        ocRandomServer.sendSeedAndHash(keccak256(seed), keccak256(keccak256(seed)));
    }
}