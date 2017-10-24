pragma solidity ^0.4.15;


import "./OLSuperManager.sol";


contract OLBlackWhiteList {
    uint private notinuse = 2;

    uint private inuse = 1;


    mapping (string => mapping (address => uint)) whiteList;

    mapping (string => mapping (address => uint)) blackList;

    //1 only check address is in whitelist
    uint onlyCheckWhiteList = 1;
    //2 only check address is not in blacklist
    uint onlyCheckNotInBlackList = 2;
    //3 check 1 and 2 same time
    uint checkWhiteAndBlackList = 3;
    //0 default not check
    uint notCheck = 0;
    function isAddrCanCallServer(string contractName, address addr)returns (bool bCanCall){
        uint nType = blackWhiteListType[contractName];
        if (nType == notCheck) {
            return true;
        }
        else if (nType == onlyCheckWhiteList) {
            return isAddressInWhiteList(contractName, addr);
        }
        else if (nType == onlyCheckNotInBlackList) {
            return !isAddressInBlackList(contractName, addr);
        }
        else if (nType == checkWhiteAndBlackList) {
            return isAddressInWhiteList(contractName, addr) && (!isAddressInBlackList(contractName, addr));
        }else {
            return false;
        }
    }

    mapping (string=>uint) blackWhiteListType;

    function setContractServerBlackWhiteListType(string contractName, uint nType)public returns (uint){
        OLSuperManager olSuperManager = OLSuperManager(0x8ae305bda0ec07c8a38ff7bf4a85f85654591f5b);

        if (!olSuperManager.isUserHasPermissonToModify(msg.sender, "OLBlackWhiteList")) {
            return 5;
        }

        blackWhiteListType[contractName] = nType;
    }

    function getContractServerBlackWhiteListType(string contractName)public returns (uint){
        return blackWhiteListType[contractName];
    }

    function addToWhiteList(string contractName, address addr) public returns (uint){
        OLSuperManager olSuperManager = OLSuperManager(0x8ae305bda0ec07c8a38ff7bf4a85f85654591f5b);

        if (!olSuperManager.isUserHasPermissonToModify(msg.sender, "OLBlackWhiteList")) {
            return 5;
        }
        whiteList[contractName][addr] = inuse;
    }

    function removeFromWhiteList(string contractName, address addr) public returns (uint){
        OLSuperManager olSuperManager = OLSuperManager(0x8ae305bda0ec07c8a38ff7bf4a85f85654591f5b);

        if (!olSuperManager.isUserHasPermissonToModify(msg.sender, "OLBlackWhiteList")) {
            return 5;
        }
        whiteList[contractName][addr] = notinuse;
    }

    function addToBlackList(string contractName, address addr) public returns (uint){
        OLSuperManager olSuperManager = OLSuperManager(0x8ae305bda0ec07c8a38ff7bf4a85f85654591f5b);

        if (!olSuperManager.isUserHasPermissonToModify(msg.sender, "OLBlackWhiteList")) {
            return 5;
        }
        blackList[contractName][addr] = inuse;
    }

    function removeFromBlackList(string contractName, address addr) public returns (uint){
        OLSuperManager olSuperManager = OLSuperManager(0x8ae305bda0ec07c8a38ff7bf4a85f85654591f5b);

        if (!olSuperManager.isUserHasPermissonToModify(msg.sender, "OLBlackWhiteList")) {
            return 5;
        }
        blackList[contractName][addr] = notinuse;
    }

    function isAddressInWhiteList(string contractName, address addr) public returns (bool){
        return whiteList[contractName][addr] == inuse;
    }

    function isAddressInBlackList(string contractName, address addr) public returns (bool){
        return blackList[contractName][addr] == inuse;
    }
}