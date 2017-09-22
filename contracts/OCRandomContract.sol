pragma solidity ^0.4.15;


import "./OCMarketInterface.sol";
import "./OCVoterInterface.sol";


contract OCRandomContract {

    uint seedCountNeeded = 3;

    mapping (address => uint) balance;

    uint randomFee = 0.0001 * 1000000000000000000;//10^18次方;

    struct OneRequest {
    bytes32 uuid;

    mapping (bytes32 => bytes32) hashSeed;
    mapping (address => int) seedSender;

    bytes32[] seedIndex;//为了遍历hashSeed
    uint nHashGetedCount;
    uint nSeedGetedCount;
    OCMarketInterface callBack;//请求可能来自不同的服务,所以需要一个活的变量
    }

    OneRequest[] cacheRequests;

    uint nCurrentIndex = 0;

    uint payBackToSeedContribution = 0.00001 * 1000000000000000000;//10^18次方;

    function requestOneUUID(bytes32 uuidFrom, OCMarketInterface callBack) payable {
        assert(msg.value >= randomFee);
        logsaddress.push(msg.sender);
        OneRequest memory oneRequest;
        oneRequest.uuid = uuidFrom;
        oneRequest.nHashGetedCount = 0;
        oneRequest.callBack = callBack;
        cacheRequests.push(oneRequest);

        balance[msg.sender] += msg.value;
    }

    function OCRandomServer(){
        nCurrentIndex = 0;
    }

    function() payable {
    }

    function sendOnlyHash(bytes32 hash) public {
        logsaddress.push(msg.sender);
        if (getCurrentNeedsCount() > 0) {
            logs.push("sendOnlyHash:getCurrentNeedsCount()>0");
            assert(getCurrentNeedsCount() > 0);
        }
        else {
            return;
        }

        logs.push("sendOnlyHash:assert(cacheRequests[nCurrentIndex].seedSender[msg.sender]!=1)");
        //一个人，针对一个请求，只能投一次票
        assert(cacheRequests[nCurrentIndex].seedSender[msg.sender] != 1);
        cacheRequests[nCurrentIndex].seedSender[msg.sender] = 1;


        if (cacheRequests[nCurrentIndex].hashSeed[hash] != 1) {
            logs.push("sendOnlyHash:cacheRequests[nCurrentIndex].hashSeed[hash]!=1");
            assert(cacheRequests[nCurrentIndex].hashSeed[hash] != 1);
            cacheRequests[nCurrentIndex].hashSeed[hash] = 1;
            cacheRequests[nCurrentIndex].nHashGetedCount++;
        }
        else {
            return;
        }
    }

    function withDrawToMyAccount() internal {
        OCVoterInterface ovi = OCVoterInterface(msg.sender);
        ovi.withDraw.value(payBackToSeedContribution)();
    }

    function currentStatus() public returns (bytes32, uint, uint){
        if (cacheRequests.length > 0) {
            return (cacheRequests[nCurrentIndex].uuid, cacheRequests[nCurrentIndex].nHashGetedCount, cacheRequests[nCurrentIndex].nSeedGetedCount);
        }else{
            return (0,0,0);
        }
    }

    function sendSeedAndHash(bytes32 seed, bytes32 hash) public payable {

        if (getCurrentNeedsCount() > 0) {
            assert(getCurrentNeedsCount() > 0);
            logs.push("sendSeedAndHash:getCurrentNeedsCount()>0");
        }
        else {
            return;
        }

        if (cacheRequests[nCurrentIndex].nHashGetedCount >= seedCountNeeded) {
            assert(cacheRequests[nCurrentIndex].nHashGetedCount >= seedCountNeeded);
            logs.push("sendSeedAndHash:cacheRequests[nCurrentIndex].nHashGetedCount >= seedCountNeeded");
        }
        else {
            return;
        }

        if (hash == keccak256(seed)) {
            assert(hash == keccak256(seed));
            logs.push("sendSeedAndHash:hash == keccak256(seed)");
        }
        else {
            return;
        }

        if (cacheRequests[nCurrentIndex].hashSeed[hash] == 1) {
            assert(cacheRequests[nCurrentIndex].hashSeed[hash] == 1);
            logs.push("sendSeedAndHash:cacheRequests[nCurrentIndex].hashSeed[hash] == 1");
            //表示没有初始化过
        }
        else {
            return;
        }

        cacheRequests[nCurrentIndex].hashSeed[hash] = seed;
        cacheRequests[nCurrentIndex].seedIndex.push(hash);
        cacheRequests[nCurrentIndex].nSeedGetedCount++;

        withDrawToMyAccount();

        if (cacheRequests[nCurrentIndex].nSeedGetedCount == seedCountNeeded) {
            bytes memory strSeed;
            for (uint i = 1; i < cacheRequests[nCurrentIndex].seedIndex.length; i++) {
                bytes32 keytmp = cacheRequests[nCurrentIndex].seedIndex[i];
                strSeed = addBytes(cacheRequests[nCurrentIndex].hashSeed[keytmp], strSeed);
            }
            cacheRequests[nCurrentIndex].callBack.callBackForRequestRandom(cacheRequests[nCurrentIndex].uuid, keccak256(strSeed));
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


    string[] public logs;

    function logmyself(uint i) public returns (string){
        return logs[i];
    }

    function loglength() public returns (uint){
        return logs.length;
    }

    bytes32[] public logsbytes32;

    function logsbytes32length() public returns (uint){
        return logsbytes32.length;
    }

    function logsbytes32myself(uint i) public returns (bytes32){
        return logsbytes32[i];
    }

    address[] public logsaddress;

    function logaddresslength() public returns (uint){
        return logsaddress.length;
    }

    function logaddressmyself(uint i) public returns (address){
        return logsaddress[i];
    }

    function logrequestlength() public returns (uint){
        return cacheRequests.length;
    }

    function logcurrentindex() public returns (uint){
        return nCurrentIndex;
    }
}