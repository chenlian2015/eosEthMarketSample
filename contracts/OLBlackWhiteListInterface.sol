pragma solidity ^0.4.15;


contract OLBlackWhiteListInterface {

    function setContractServerBlackWhiteListType(string contractName, uint nType) public returns (uint){}

    function getContractServerBlackWhiteListType(string contractName) public returns (uint){}

    function addToBlackList(string contractName, address addr) public returns (uint){}

    function addToWhiteList(string contractName, address addr) public returns (uint){}

    function isAddressInBlackList(string contractName, address addr) public returns (bool){}

    function isAddressInWhiteList(string contractName, address addr) public returns (bool){}

    function isAddrCanCallServer(string contractName, address addr)returns (bool bCanCall){}

    function removeFromBlackList(string contractName, address addr) public returns (uint){}

    function removeFromWhiteList(string contractName, address addr) public returns (uint){}
}