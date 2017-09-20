pragma solidity ^0.4.15;

import "./OCRandomContract.sol";
import "./OCLPublicAddress.sol";

contract ThirdPartyVoter{

    OCLPublicAddress oclpa;

    function ThirdPartyVoter(){
        oclpa = OCLPublicAddress(0x002cacf5ee5d350d9c903435f6670650df97777e);
    }

    function sendOnlyHash(string seed){
        OCRandomContract ocRandomServer = OCRandomContract(oclpa.getServerAddress("OCRandomContract"));
        ocRandomServer.sendOnlyHash(keccak256(keccak256(seed)));
    }

    function sendSeedAndHash(string seed){
        OCRandomContract ocRandomServer = OCRandomContract(oclpa.getServerAddress("OCRandomContract"));
        ocRandomServer.sendSeedAndHash(keccak256(seed), keccak256(keccak256(seed)));
    }

}