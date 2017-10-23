pragma solidity ^0.4.15;


import "./OLRandomContractInterface.sol";
import "./OLMarket.sol";
import "./OLPublicAddress.sol";


contract OLLotteryContract is OLRandomContractInterface {


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

    OLPublicAddress oclpa;

    address[] lotteryJoiners;

    mapping (bytes32 => JoinersGroup) mapJoinersGroup;

    OLMarketServerInterface ocMarket;

    event LogJoinOneLottery(address bidder, uint amountto, uint amountfrom); // Event
    event LogFeeNotEnoughForJoinLottery(address bidder, uint sent, uint realNeed); // Event
    event LogError(address bidder, string step); // Event


    function OCLotteryContract(){
        lotteryJoiners = new address[](oneGroupJoiners);
        oclpa = OLPublicAddress(0x8cb94b79cb4ea51e228b661cd38f81484d2632da);
    }

    function() payable {
        balance[msg.sender] += msg.value;
        if (balance[msg.sender] >= oneTimeJoinFee) {
            joinOneLottery();
            balance[msg.sender] -= oneTimeJoinFee;
        }
        else {
            LogFeeNotEnoughForJoinLottery(msg.sender, msg.value, oneTimeJoinFee);
        }
    }

    function getCurrentLotteryJoiners() public returns (address[]){
        return lotteryJoiners;
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

            ocMarket = OLMarketServerInterface(oclpa.getServerAddress("OCMarket"));
            ocMarket.callServer("OLRandomContract", 1);
            currentIndex = 0;
        }
        else {
            currentIndex++;
        }
    }


    function callBackForRequestRandom(bytes32 uuidRequest, bytes32 randomValue){
        uint nIndexFirstPrize = uint(randomValue[0]) % oneGroupJoiners;
        mapJoinersGroup[uuidRequest].prizerOne = mapJoinersGroup[uuidRequest].oneGroupLotteryJoiners[nIndexFirstPrize];


        if (nIndexFirstPrize < (oneGroupJoiners / 2)) {
            if (mapJoinersGroup[uuidRequest].oneGroupLotteryJoiners.length > nIndexFirstPrize + 2) {
                mapJoinersGroup[uuidRequest].prizerTwo.push(mapJoinersGroup[uuidRequest].oneGroupLotteryJoiners[nIndexFirstPrize + 1]);
                mapJoinersGroup[uuidRequest].prizerTwo.push(mapJoinersGroup[uuidRequest].oneGroupLotteryJoiners[nIndexFirstPrize + 2]);
            }
            else {
            }
        }
        else {
            if (0 <= nIndexFirstPrize - 2) {
                mapJoinersGroup[uuidRequest].prizerTwo.push(mapJoinersGroup[uuidRequest].oneGroupLotteryJoiners[nIndexFirstPrize - 1]);
                mapJoinersGroup[uuidRequest].prizerTwo.push(mapJoinersGroup[uuidRequest].oneGroupLotteryJoiners[nIndexFirstPrize - 2]);
            }
            else {
            }
        }

        balance[mapJoinersGroup[uuidRequest].prizerOne] += oneTimeJoinFee * 2;
        balance[mapJoinersGroup[uuidRequest].prizerTwo[0]] += oneTimeJoinFee;
        balance[mapJoinersGroup[uuidRequest].prizerTwo[1]] += oneTimeJoinFee;
    }

    function getLotteryResultTotal(address joiner) public returns (uint){
        return balance[joiner];
    }

    function withDrawMyBalance() public {
        msg.sender.transfer(balance[msg.sender]);
        balance[msg.sender] = 0;
    }

}



