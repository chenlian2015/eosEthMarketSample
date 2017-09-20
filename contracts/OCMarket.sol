pragma solidity ^0.4.15;

import "./OCMarketInterface.sol";
import "./OCRandomContract.sol";
import "./OCLPublicAddress.sol";

contract OCMarket{

    OCLPublicAddress oclpa;

    function OCMarket(){
        oclpa = OCLPublicAddress(0x002cacf5ee5d350d9c903435f6670650df97777e);
    }

    function ()payable{
    }

    function requestOneUUID(bytes32 uuidFrom, OCMarketInterface callBack) payable {
        logsaddress.push(msg.sender);
        OCRandomContract ocRandomServer = OCRandomContract(oclpa.getServerAddress("OCRandomContract"));
        ocRandomServer.requestOneUUID(uuidFrom, callBack);
    }

    address[] public logsaddress;
    function logaddresslength() public returns(uint){
        return logsaddress.length;
    }

    function logaddressmyself(uint i) public returns(address){
        return logsaddress[i];
    }
}