pragma solidity ^0.4.15;


import "./OLRandomContractCallBackInterface.sol";
import "./OLServerInterface.sol";
import "./OLRandomContractInterface.sol";
import "./OLPublicAddress.sol";
import "./OLServerInterface.sol";
import "./OLMarketServerInterface.sol";
import "./OLCommon.sol";


contract OLRandomContract is OLRandomContractCallBackInterface, OLServerInterface, OLCommon, OLRandomContractInterface {

    string currentContractName = "OLRandomContract";

    uint private seedCountNeeded = 3;

    bytes32 constant nNothingProvidedLable = bytes32(0);

    bytes32 constant nHashProvidedLable = bytes32(1);

    bytes32 constant nSeedProvidedLable = bytes32(2);

    struct OneRequest {
    address callBackAddress;

    mapping (bytes32 => bytes32) hashSeed;
    mapping (address => bytes32) senderSeedLable;

    bytes32[] seedIndex;//为了遍历hashSeed
    uint nHashGetedCount;
    uint nSeedGetedCount;
    OLRandomContractInterface callBack;//请求可能来自不同的服务,所以需要一个活的变量
    }

    OneRequest[] private cacheRequests;

    uint private nCurrentIndex = 0;

    function addOneRequest(address addr) private {
        OneRequest memory oneRequest;
        oneRequest.callBackAddress = addr;
        oneRequest.nHashGetedCount = 0;
        cacheRequests.push(oneRequest);
    }

    function requestOneUUID(address callBackAddress, uint versionCaller) public returns (uint code){

        OLPublicAddress oclpa = OLPublicAddress(getOuLianPublicAddress());
        OLMarketServerInterface olMarketServerInterface = OLMarketServerInterface(oclpa.getServerAddress(marketName));
        uint nCode = olMarketServerInterface.preCheckAndPay(currentContractName, versionCaller);
        if (nCode != errorCode_success) {
            return nCode;
        }

        addOneRequest(callBackAddress);
        return errorCode_success;
    }

    function callServer(address callFrom, uint versionCaller) public returns (bool){
        OLPublicAddress oclpa = OLPublicAddress(getOuLianPublicAddress());
        if (msg.sender == oclpa.getServerAddress(marketName)) {
            addOneRequest(callFrom);
        }
    }

    function sendOnlyHash(bytes32 hash) public returns (uint){

        if (getCurrentNeedsCount() <= 0) {
            return errorCode_noHashSeedNeeded;
        }

        //一个人，针对一个请求，只能投一次票
        if (cacheRequests[nCurrentIndex].senderSeedLable[msg.sender] != nNothingProvidedLable) {
            return errorCode_hashSeedProvided;
        }

        cacheRequests[nCurrentIndex].senderSeedLable[msg.sender] = nHashProvidedLable;


        cacheRequests[nCurrentIndex].hashSeed[hash] = nHashProvidedLable;
        cacheRequests[nCurrentIndex].nHashGetedCount++;
        return errorCode_success;
    }

    function nowCanProvideHash() public returns (bool){
        if (getCurrentNeedsCount() > 0) {
            return (cacheRequests[nCurrentIndex].senderSeedLable[msg.sender] != nHashProvidedLable);
        }
        else {
            return false;
        }
    }

    function sendSeedAndHash(bytes32 seed, bytes32 hash) public returns (uint) {

        if (getCurrentNeedsCount() <= 0) {
            return errorCode_noHashSeedNeeded;
        }

        if (cacheRequests[nCurrentIndex].nHashGetedCount < seedCountNeeded) {
            return errorCode_hashSeedCountNotEnough;
        }


        if (hash != keccak256(seed)) {
            return errorCode_hashSeedNotPair;
        }


        if (cacheRequests[nCurrentIndex].hashSeed[hash] != nHashProvidedLable) {
            return errorCode_hashNotProvided;
        }

        cacheRequests[nCurrentIndex].hashSeed[hash] = seed;
        cacheRequests[nCurrentIndex].seedIndex.push(hash);
        cacheRequests[nCurrentIndex].nSeedGetedCount++;

        if (cacheRequests[nCurrentIndex].nSeedGetedCount == seedCountNeeded) {

            bytes memory bytesSeed = getBytes(cacheRequests[nCurrentIndex].hashSeed[cacheRequests[nCurrentIndex].seedIndex[0]]);
            for (uint i = 1; i < cacheRequests[nCurrentIndex].seedIndex.length; i++) {
                bytes32 keytmp = cacheRequests[nCurrentIndex].seedIndex[i];
                bytesSeed = addBytes(cacheRequests[nCurrentIndex].hashSeed[keytmp], bytesSeed);
            }

            while (nCurrentIndex < cacheRequests.length)
            OLRandomContractCallBackInterface olRandomContractCallBackInterface = OLRandomContractCallBackInterface(cacheRequests[nCurrentIndex].callBackAddress);
            olRandomContractCallBackInterface.callBackForRequestRandom(keccak256(bytesSeed));
            nCurrentIndex++;
        }
    }


    function addBytes(bytes32 a, bytes b) private returns (bytes){
        bytes memory c = new bytes(32 + b.length);
        for (uint i = 0; i < c.length; i++) {
            if (i < 32) {
                c[i] = a[i];
            }
            else {
                c[i] = b[i - 32];
            }
        }
        return c;
    }

    function getBytes(bytes32 a) private returns (bytes){
        bytes memory b = new bytes(32);
        for (uint i = 0; i < 32; i++) {
            b[i] = a[i];
        }
        return b;
    }

    function getCurrentNeedsCount() public returns (uint){
        return cacheRequests.length - nCurrentIndex;
    }
}