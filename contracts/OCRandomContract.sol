pragma solidity ^0.4.15;

import "./OCMarketInterface.sol";

contract OCRandomContract{

    uint seedCountNeeded = 3;

    mapping(address=>uint) balances;

    struct OneRequest{
        bytes32 uuid;

        mapping(bytes32=>bytes32) hashSeed;
        mapping(address=>int) seedSender;

        bytes32[] seedIndex;//为了遍历hashSeed
        uint nHashGetedCount;
        uint nSeedGetedCount;
        OCMarketInterface callBack;//请求可能来自不同的服务,所以需要一个活的变量
    }

    OneRequest[] cacheRequests;
    uint nCurrentIndex = 0;
    uint payBackToSeedContribution = 2000000;//wei

    function requestOneUUID(bytes32 uuidFrom, OCMarketInterface callBack) payable {
        logsaddress.push(msg.sender);
        OneRequest memory oneRequest;
        oneRequest.uuid = uuidFrom;
        oneRequest.nHashGetedCount = 0;
        oneRequest.callBack = callBack;
        cacheRequests.push(oneRequest);
        logs.push("requestOneUUID");
    }

    function OCRandomServer(){
        nCurrentIndex = 0;
    }

    function ()payable{
    }

    function sendOnlyHash(bytes32 hash)public{
        logsaddress.push(msg.sender);
        logs.push("enter_sendOnlyHash");
        assert(getCurrentNeedsCount()>0);
        logs.push("enter_sendOnlyHasha");
        assert(cacheRequests[nCurrentIndex].nHashGetedCount<seedCountNeeded);
        logs.push("enter_sendOnlyHashb");
        //暂时先屏蔽，不然都没法测试了 assert(cacheRequests[nCurrentIndex].seedSender[msg.sender]!=1);//一个人，针对一个请求，只能投一次票
        logs.push("enter_sendOnlyHashc");
        cacheRequests[nCurrentIndex].seedSender[msg.sender] = 1;
        logs.push("enter_sendOnlyHashd");
        cacheRequests[nCurrentIndex].nHashGetedCount++;
        logs.push("enter_sendOnlyHashe");
    }

    function testEquel(string seed, bytes32 hash)public returns(bool){
        logsbytes32.push(keccak256(seed));
        logsbytes32.push(hash);
        if(keccak256(seed)==hash){
            return true;
        }else{
            return false;
        }
    }

    function sendSeedAndHash(bytes32 seed, bytes32 hash){
        logsaddress.push(msg.sender);
        logs.push("enter_sendSeedAndHash");
        assert(getCurrentNeedsCount()>0);
        logs.push("enter_sendSeedAndHasha");

        if(hash==keccak256(seed)){
            logs.push("hash==keccak256(seed)");
        }else{
            logs.push("hash!=keccak256(seed)");
        }
        logsbytes32.push(seed);
        logsbytes32.push(hash);

        assert(hash==keccak256(seed));
        logs.push("enter_sendSeedAndHashb");
        assert(cacheRequests[nCurrentIndex].hashSeed[hash] != seed);//表示没有初始化过，或者曾经错误初始化过
        logs.push("enter_sendSeedAndHashc");
        assert(keccak256(seed)==hash);
        logs.push("enter_sendSeedAndHashd");

         //msg.sender.transfer(payBackToSeedContribution);

         cacheRequests[nCurrentIndex].hashSeed[hash] = seed;
         logs.push("enter_sendSeedAndHashe");
         cacheRequests[nCurrentIndex].seedIndex.push(hash);
         logs.push("enter_sendSeedAndHashf");
         cacheRequests[nCurrentIndex].nSeedGetedCount++;
         logs.push("enter_sendSeedAndHasg");

         if(cacheRequests[nCurrentIndex].nHashGetedCount == seedCountNeeded){
             logs.push("enter_sendSeedAndHashh");
             bytes memory strSeed;
             for(uint i=1; i<cacheRequests[nCurrentIndex].seedIndex.length; i++){
                 logs.push("enter_sendSeedAndHashi");
                 bytes32  keytmp = cacheRequests[nCurrentIndex].seedIndex[i];
                 strSeed = addBytes(cacheRequests[nCurrentIndex].hashSeed[keytmp], strSeed);
             }
             logs.push("enter_sendSeedAndHashj");
             cacheRequests[nCurrentIndex].callBack.callBackForRequestRandom(cacheRequests[nCurrentIndex].uuid, keccak256(strSeed));
             logs.push("enter_sendSeedAndHashk");
             nCurrentIndex++;
             logs.push("enter_sendSeedAndHashl");

         }
    }

    function addBytes(bytes32 a, bytes b) public returns(bytes){
        bytes memory c = new bytes(32+b.length);
        for(uint i=0; i<c.length; i++){
            if(i<32){
                c[i] = a[i];
            }else{
                c[i] = b[i-32];
            }
        }
        return c;
    }

    function getBytes(bytes32 a)public returns(bytes){
        bytes memory b = new bytes(32);
        for(uint i=0; i<32; i++){
            b[i] = a[i];
        }
        return b;
    }

    function getCurrentNeedsCount() public returns(uint){
        return cacheRequests.length - nCurrentIndex;
    }


    string[] public logs;
    function logmyself(uint i) public returns(string){
        return logs[i];
    }

    function loglength() public returns(uint){
        return logs.length;
    }

    bytes32[] public logsbytes32;
    function logsbytes32length() public returns(uint){
        return logsbytes32.length;
    }

    function logsbytes32myself(uint i) public returns(bytes32){
        return logsbytes32[i];
    }

    address[] public logsaddress;
    function logaddresslength() public returns(uint){
        return logsaddress.length;
    }

    function logaddressmyself(uint i) public returns(address){
        return logsaddress[i];
    }

    function logrequestlength() public returns(uint){
        return cacheRequests.length;
    }

    function logcurrentindex() public returns(uint){
        return nCurrentIndex;
    }

}