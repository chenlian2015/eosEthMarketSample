pragma solidity ^0.4.15;


contract OLLogToolInterface {

    function addLog(string log, string logContent);

    function length()  returns (uint);

    function getAt(uint nIndex) returns (string);

    function clear();
}