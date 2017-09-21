pragma solidity ^0.4.15;


import "./OCMarketInterface.sol";
import "./OCMarket.sol";
import "./OCLPublicAddress.sol";


contract OCLotteryContract is OCMarketInterface {


    struct JoinersGroup {
    bytes32 uuid;
    address[] oneGroupLotteryJoiners;
    address prizerOne;
    address[] prizerTwo;
    }

    mapping (address => uint) balance;

    uint oneTimeJoinFee = 0.000123456 * 1000000000000000000;//10^18次方
    uint currentIndex = 0;

    uint oneGroupJoiners = 5;

    uint randomFee = 0.0001 * 1000000000000000000;//10^18次方;

    OCLPublicAddress oclpa;

    address[] lotteryJoiners;

    mapping (bytes32 => JoinersGroup) mapJoinersGroup;

    OCMarket ocMarket;

    event LogJoinOneLottery(address bidder, uint amountto, uint amountfrom); // Event
    event LogFeeNotEnoughForJoinLottery(address bidder, uint sent, uint realNeed); // Event
    event LogError(address bidder, string step); // Event


    function OCLotteryContract(){
        lotteryJoiners = new address[](oneGroupJoiners);
        oclpa = OCLPublicAddress(0x8cb94b79cb4ea51e228b661cd38f81484d2632da);
    }

    function() payable {
        balance[msg.sender] += msg.value;
        if (balance[msg.sender] >= oneTimeJoinFee) {
            joinOneLottery();
            balance[msg.sender] -= msg.value;
        }
        else {
            LogFeeNotEnoughForJoinLottery(msg.sender, msg.value, oneTimeJoinFee);
        }
    }

    function getBalance() public returns (uint){
        return balance[msg.sender];
    }


    function joinOneLottery() payable {
        assert(currentIndex < oneGroupJoiners);
        lotteryJoiners[currentIndex] = msg.sender;

        if (currentIndex >= (oneGroupJoiners - 1)) {
            bytes32 uuid = keccak256(lotteryJoiners);
            mapJoinersGroup[uuid].uuid = keccak256(lotteryJoiners);

            for (uint i = 0; i < lotteryJoiners.length; i++) {
                mapJoinersGroup[uuid].oneGroupLotteryJoiners.push(lotteryJoiners[i]);
            }

            ocMarket = OCMarket(oclpa.getServerAddress("OCMarket"));
            ocMarket.requestOneUUID.gas(4009217).value(randomFee)(uuid, this);

            currentIndex = 0;
        }
        else {
            currentIndex++;
        }
    }

    string[] public logs;

    function logmyself(uint i) public returns (string){
        return logs[i];
    }

    function loglength() public returns (uint){
        return logs.length;
    }


    function callBackForRequestRandom(bytes32 uuidRequest, bytes32 randomValue){
        logs.push("callBackForRequestRandom_b");
        uint nIndexFirstPrize = uint(randomValue[0]) % oneGroupJoiners;
        mapJoinersGroup[uuidRequest].prizerOne = mapJoinersGroup[uuidRequest].oneGroupLotteryJoiners[nIndexFirstPrize];
        logs.push("callBackForRequestRandom_c");
        if (nIndexFirstPrize < (oneGroupJoiners / 2)) {
            logs.push("callBackForRequestRandom_d");
            if (mapJoinersGroup[uuidRequest].oneGroupLotteryJoiners.length > nIndexFirstPrize + 2) {
                mapJoinersGroup[uuidRequest].prizerTwo.push(mapJoinersGroup[uuidRequest].oneGroupLotteryJoiners[nIndexFirstPrize + 1]);
                mapJoinersGroup[uuidRequest].prizerTwo.push(mapJoinersGroup[uuidRequest].oneGroupLotteryJoiners[nIndexFirstPrize + 2]);
            }
            else {
                logs.push("callBackForRequestRandom_e");
            }
        }
        else {
            logs.push("callBackForRequestRandom_f");
            if (0 <= nIndexFirstPrize - 2) {
                mapJoinersGroup[uuidRequest].prizerTwo.push(mapJoinersGroup[uuidRequest].oneGroupLotteryJoiners[nIndexFirstPrize - 1]);
                mapJoinersGroup[uuidRequest].prizerTwo.push(mapJoinersGroup[uuidRequest].oneGroupLotteryJoiners[nIndexFirstPrize - 2]);
            }
            else {
                logs.push("callBackForRequestRandom_g");
            }
        }
    }

}



