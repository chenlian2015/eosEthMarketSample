pragma solidity ^0.4.15;
import "./OLSuperManager.sol";
import "./OLCommon.sol";
import "./OLPublicAddressInterface.sol";

contract OLPublicAddress is OLCommon,OLPublicAddressInterface{

    mapping (string => address) serverAddress;

    mapping (string => uint) serverFee;//服务费


    mapping (string => uint) serverStatus;//服务状态

    /*
    如果要删除一个服务，则contractAddress设置值为0即可
    if you want to delete one contractName,just set contractAddress=0
    @param fee,means the fee you need to provide to call this server
    */
    function putServerAddress(string contractName, address contractAddress, uint fee, uint serverStatusPar) public returns (uint) {

        OLSuperManager olSuperManager = OLSuperManager(getSuperManagerAddress());
        if (!olSuperManager.isUserHasPermissonToModify(msg.sender, "OLPublicAddress")) {
            return errorCode_success;
        }

        serverAddress[contractName] = contractAddress;
        serverStatus[contractName] = serverStatusPar;

        if (fee < 0) {
            return errorCode_parameterError;
        }
        serverFee[contractName] = fee;
        return errorCode_success;
    }

    function removeServer(string contractName)public returns(uint){
        OLSuperManager olSuperManager = OLSuperManager(getSuperManagerAddress());
        if (!olSuperManager.isUserHasPermissonToModify(msg.sender, "OLPublicAddress")) {
            return errorCode_noPermitAccess;
        }
        serverAddress[contractName] = address(0x0);
    }

    function setServerFee(string contractName, uint fee) public returns (uint){
        OLSuperManager olSuperManager = OLSuperManager(getSuperManagerAddress());
        if (!olSuperManager.isUserHasPermissonToModify(msg.sender, "OLPublicAddress")) {
            return errorCode_success;
        }

        if (fee < 0) {
            return errorCode_parameterError;
        }
        serverFee[contractName] = fee;
        return errorCode_success;
    }

    function serServerStatus(string contractName, uint serverStatusPar)public returns(uint){
        OLSuperManager olSuperManager = OLSuperManager(getSuperManagerAddress());
        if (!olSuperManager.isUserHasPermissonToModify(msg.sender, "OLPublicAddress")) {
            return errorCode_noPermitAccess;
        }

        serverStatus[contractName] = serverStatusPar;
        return errorCode_success;
    }

    function getServerStatus(string contractName)public returns(uint){
        return serverStatus[contractName];
    }

    function getServerAddress(string contractName) public returns (address){
        return serverAddress[contractName];
    }

    function getFee(string contractName) public returns (uint){
        return serverFee[contractName];
    }


}