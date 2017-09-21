pragma solidity ^0.4.15;

import "./OCMarketInterface.sol";
import "./OCRandomContract.sol";
import "./OCLPublicAddress.sol";

contract OCMarket{

    OCLPublicAddress oclpa;
    mapping(address=>uint) balance;
    uint randomFee = 0.0001 * 1000000000000000000;//10^18次方;

    function OCMarket(){
        oclpa = OCLPublicAddress(0x8cb94b79cb4ea51e228b661cd38f81484d2632da);
    }

    function ()payable{
    }

    function record() payable{
        logsaddress.push(msg.sender);
        balance[msg.sender] += msg.value;
    }

    function getMyBalance(address addr)public returns(uint){
        return balance[addr];
    }

    function requestOneUUID(bytes32 uuidFrom, OCMarketInterface callBack) public payable {
        assert(msg.value>=randomFee);
        record();

        balance[msg.sender]-=randomFee;
        logsaddress.push(msg.sender);

        OCRandomContract ocRandomServer = OCRandomContract(oclpa.getServerAddress("OCRandomContract"));
        ocRandomServer.requestOneUUID.value(randomFee)(uuidFrom, callBack);
    }

    address[] public logsaddress;
    function logaddresslength() public returns(uint){
        return logsaddress.length;
    }

    function logaddressmyself(uint i) public returns(address){
        return logsaddress[i];
    }
}