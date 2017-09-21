pragma solidity ^0.4.15;

import "./OCRandomContract.sol";
import "./OCLPublicAddress.sol";
import "./OCVoterInterface.sol";

contract ThirdPartyVoter is OCVoterInterface{

    OCLPublicAddress oclpa;

    function ThirdPartyVoter(){
        oclpa = OCLPublicAddress(0x8cb94b79cb4ea51e228b661cd38f81484d2632da);
    }

    function() payable {
    }

    function withDraw()public payable{
    }

//    function withDrawToMyAccount()public payable{
////        OCRandomContract ocRandomServer = OCRandomContract(oclpa.getServerAddress("OCRandomContract"));
////        ocRandomServer.withDrawToMyAccount();
//    }

    function sendOnlyHash(string seed){
        OCRandomContract ocRandomServer = OCRandomContract(oclpa.getServerAddress("OCRandomContract"));
        ocRandomServer.sendOnlyHash(keccak256(keccak256(seed)));
    }

    function sendSeedAndHash(string seed){
        OCRandomContract ocRandomServer = OCRandomContract(oclpa.getServerAddress("OCRandomContract"));
        ocRandomServer.sendSeedAndHash(keccak256(seed), keccak256(keccak256(seed)));
    }
}