pragma solidity ^0.4.15;


import "./OLRandomContractCallBackInterface.sol";
import "./OLServerInterface.sol";
import "./OLRandomContractInterface.sol";
import "./OLPublicAddress.sol";
import "./OLServerInterface.sol";
import "./OLMarketServerInterface.sol";

contract OLRandomContract is OLRandomContractCallBackInterface,OLServerInterface{

    uint seedCountNeeded = 3;

    mapping (address => uint) balance;

    uint randomFee = 0.0001 * 1000000000000000000;//10^18次方;

    struct OneRequest {

        address callBackAddress;

        mapping (bytes32 => bytes32) hashSeed;
        mapping (address => int) seedSender;

        bytes32[] seedIndex;//为了遍历hashSeed
        uint nHashGetedCount;
        uint nSeedGetedCount;
        OLRandomContractInterface callBack;//请求可能来自不同的服务,所以需要一个活的变量
    }

    OneRequest[] cacheRequests;

    uint nCurrentIndex = 0;

    uint payBackToSeedContribution = 0.00001 * 1000000000000000000;//10^18次方;

    function() payable {
    }

    function OCRandomServer(){
        nCurrentIndex = 0;
    }

    function requestOneUUID(address callBackAddress, uint versionCaller) public returns(uint code){

        OLPublicAddress oclpa = OLPublicAddress(0x8cb94b79cb4ea51e228b661cd38f81484d2632da);
        OLMarketServerInterface olMarketServerInterface = OLMarketServerInterface(oclpa.getServerAddress("OLMarket"));
        uint nCode = olMarketServerInterface.preCheckServerCall("OLRandomContract", versionCaller);
        if(nCode != 0){
            return nCode;
        }

        assert(msg.value >= randomFee);

        OneRequest memory oneRequest;
        oneRequest.callBackAddress = callBackAddress;
        oneRequest.nHashGetedCount = 0;
        cacheRequests.push(oneRequest);

        balance[msg.sender] += msg.value;
        return 0;
    }

    function callServer(address callFrom, uint versionCaller) public returns (bool){
        OLPublicAddress oclpa = OLPublicAddress(0x8cb94b79cb4ea51e228b661cd38f81484d2632da);
        if(msg.sender == oclpa.getServerAddress("OLMarket")){
            requestOneUUID(callFrom, versionCaller);
        }
    }

    function sendOnlyHash(bytes32 hash) public {

        if (getCurrentNeedsCount() > 0) {
            assert(getCurrentNeedsCount() > 0);
        }
        else {
            return;
        }

        //一个人，针对一个请求，只能投一次票
        assert(cacheRequests[nCurrentIndex].seedSender[msg.sender] != 1);
        cacheRequests[nCurrentIndex].seedSender[msg.sender] = 1;


        if (cacheRequests[nCurrentIndex].hashSeed[hash] != 1) {
            assert(cacheRequests[nCurrentIndex].hashSeed[hash] != 1);
            cacheRequests[nCurrentIndex].hashSeed[hash] = 1;
            cacheRequests[nCurrentIndex].nHashGetedCount++;
        }
        else {
            return;
        }
    }

    function ever() public returns (bool){
        if (getCurrentNeedsCount() > 0) {
            return (cacheRequests[nCurrentIndex].seedSender[msg.sender] != 1);
        }
        else {
            return false;
        }
    }

    function sendSeedAndHash(bytes32 seed, bytes32 hash) public payable {

        if (getCurrentNeedsCount() > 0) {
            assert(getCurrentNeedsCount() > 0);
        }
        else {
            return;
        }

        if (cacheRequests[nCurrentIndex].nHashGetedCount >= seedCountNeeded) {
            assert(cacheRequests[nCurrentIndex].nHashGetedCount >= seedCountNeeded);
        }
        else {
            return;
        }

        if (hash == keccak256(seed)) {
            assert(hash == keccak256(seed));
        }
        else {
            return;
        }

        if (cacheRequests[nCurrentIndex].hashSeed[hash] == 1) {
            assert(cacheRequests[nCurrentIndex].hashSeed[hash] == 1);
            //表示没有初始化过
        }
        else {
            return;
        }

        cacheRequests[nCurrentIndex].hashSeed[hash] = seed;
        cacheRequests[nCurrentIndex].seedIndex.push(hash);
        cacheRequests[nCurrentIndex].nSeedGetedCount++;


        if (cacheRequests[nCurrentIndex].nSeedGetedCount == seedCountNeeded) {
            bytes memory strSeed;
            for (uint i = 1; i < cacheRequests[nCurrentIndex].seedIndex.length; i++) {
                bytes32 keytmp = cacheRequests[nCurrentIndex].seedIndex[i];
                strSeed = addBytes(cacheRequests[nCurrentIndex].hashSeed[keytmp], strSeed);
            }


            OLRandomContractCallBackInterface olRandomContractCallBackInterface = OLRandomContractCallBackInterface(cacheRequests[nCurrentIndex].callBackAddress);
            olRandomContractCallBackInterface.callBackForRequestRandom(keccak256(strSeed));
            nCurrentIndex++;
        }
    }

    function addBytes(bytes32 a, bytes b) public returns (bytes){
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

    function getBytes(bytes32 a) public returns (bytes){
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