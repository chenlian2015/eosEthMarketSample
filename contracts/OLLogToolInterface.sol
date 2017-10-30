pragma solidity ^0.4.15;


contract OLLogToolInterface {

    function addLog(string log, string logContent) public {}

    function length() public returns (uint){}

    function getAt(uint nIndex) public returns (string){}

    function clear() public {}
}