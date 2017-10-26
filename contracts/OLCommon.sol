pragma solidity ^0.4.15;


import "./OLSuperManager.sol";


contract OLCommon {
    /*
    global error code on OuLianMarket
    */
    uint constant public errorCode_success = 0;

    uint constant public errorCode_feeIsNotEnough = 1;

    uint constant public errorCode_parameterError = 2;

    uint constant public errorCode_versionIsOld = 3;

    uint constant public errorCode_noPermitAccess = 4;

    uint constant public errorCode_serverIsFreezed = 5;
    /*
    global constant address of constant constract
    */
    function getSuperManagerAddress()public returns(address){
        return address(0x8ae305bda0ec07c8a38ff7bf4a85f85654591f5b);
    }

    function getOuLianPublicAddress()public returns(address){
        return address(0x8ae305bda0ec07c8a38ff7bf4a85f85654591f5b);
    }

    /*
    server status on OuLianMarket
    */
    uint constant serverStatusFreezed = 0;
    uint constant serverStatusNormal = 1;
    uint constant serverStatusRemoved = 2;

    /*
    addr weather or not work in white or black list
    */
    uint constant  notinuse = 2;
    uint constant  inuse = 1;


    /*
    contrant white or black list check way
    */
    uint onlyCheckWhiteList = 1;
    uint onlyCheckNotInBlackList = 2;
    uint checkWhiteAndBlackList = 3;
    uint notCheck = 0;

    string public constant marketName = "OLMarket";
}