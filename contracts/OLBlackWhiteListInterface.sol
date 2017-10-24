pragma solidity ^0.4.15;


contract OLBlackWhiteListInterface {
    function addToBlackList(address addr)returns (bool){}

    function addToWhiteList(address addr)returns (bool){}

    function isAddressInBlackList(address addr)returns (bool){}

    function isAddressInWhiteList(address addr)returns (bool){}

    function isAddrCanCallServer(address addr)returns (bool bCanCall){}

    function removeFromBlackList(string contractName, address addr) public returns (uint){}

    function removeFromWhiteList(string contractName, address addr) public returns (uint){}
}