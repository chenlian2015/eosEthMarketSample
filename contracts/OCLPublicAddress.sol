pragma solidity ^0.4.15;


contract OCLPublicAddress {

    mapping (string => address) serverAddress;

    function putServerAddress(string contractName, address contractAddress) public returns(address) {
        serverAddress[contractName] = contractAddress;
        return contractAddress;
    }

    function getServerAddress(string contractName) public returns (address){
        return serverAddress[contractName];
    }
}