pragma solidity ^0.4.15;


import "./OLRandomContract.sol";
import "./OLPublicAddress.sol";
import "./OLMarketServerInterface.sol";
import "./OLServerInterface.sol";
import "./OLBlackWhiteListInterface.sol";
import "./StantardTokenInterface.sol";
import "./OLFeeManagerInterface.sol";
import "./OLCommonConfigure.sol";
import "./OLLogToolInterface.sol";

contract OLLogTool is OLLogToolInterface{
    string [] private logs;

    function addLog(string log)public{
        logs.push(log);
    }

    function length()public returns(uint){
        return logs.length;
    }

    function getAt(uint nIndex)public returns(string){
        return logs[nIndex];
    }

    function clear()public{
        delete logs;
    }
}