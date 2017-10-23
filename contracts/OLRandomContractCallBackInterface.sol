pragma solidity ^0.4.15;


contract OLRandomContractCallBackInterface {
    /*
    @param randomValue,a random number send back to random request
    */
    function callBackForRequestRandom(bytes32 randomValue) public {}
}