pragma solidity ^0.4.15;


contract OLRandomContractCallBackInterface {
    uint constant public errorCode_noHashSeedNeeded = 201;

    uint constant public errorCode_hashSeedProvided = 202;

    uint constant public errorCode_hashSeedCountNotEnough = 203;

    uint constant public errorCode_hashSeedNotPair = 204;

    uint constant public errorCode_seedProvided = 205;

    uint constant public errorCode_hashNotProvided = 206;


    /*
    @param randomValue,a random number send back to random request
    */
    function callBackForRequestRandom(bytes32 randomValue) public {}
}