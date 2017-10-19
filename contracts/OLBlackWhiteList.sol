pragma solidity ^0.4.15;


contract OLBlackWhiteList {
    int private notinuse = - 1;

    int private inuse = 1;

    mapping (string => mapping (address => uint)) whiteList;

    mapping (string => mapping (address => uint)) blackList;

    function addToWhiteList(string contractName, address addr) public returns (uint){
        whiteList[contractName][addr] = inuse;
    }

    function removeFromWhiteList(string contractName, address addr) public returns (uint){
        whiteList[contractName][addr] = notinuse;
    }

    function addToBlackList(string contractName, address addr) public returns (uint){
        blackList[contractName][addr] = inuse;
    }

    function removeFromBlackList(string contractName, address addr) public returns (uint){
        blackList[contractName][addr] = notinuse;
    }
}