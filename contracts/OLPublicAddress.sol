pragma solidity ^0.4.15;
import "./OLSuperManager.sol";
import "./OLCommon.sol";
import "./OLPublicAddressInterface.sol";

contract OLPublicAddress is OLCommon,OLPublicAddressInterface{

    mapping(string => address) private serverAddress;

    mapping(string => uint) private serverStatus;//服务状态

    /*
    如果要删除一个服务，则contractAddress设置值为0即可
    if you want to delete one contractName,just set contractAddress=0
    @param fee,means the fee you need to provide to call this server
    */
    function putServerAddress(string contractName, address contractAddress, uint serverStatusPar) public returns (uint) {

        OLSuperManager olSuperManager = OLSuperManager(getSuperManagerAddress());
        if (!olSuperManager.isUserHasPermissonToModify(msg.sender, "OLPublicAddress")) {
            return errorCode_success;
        }

        serverAddress[contractName] = contractAddress;
        serverStatus[contractName] = serverStatusPar;

        return errorCode_success;
    }

    function removeServer(string contractName)public returns(uint){
        OLSuperManager olSuperManager = OLSuperManager(getSuperManagerAddress());
        if (!olSuperManager.isUserHasPermissonToModify(msg.sender, "OLPublicAddress")) {
            return errorCode_noPermitAccess;
        }
        serverAddress[contractName] = address(0x0);
        serverStatus[contractName] = serverStatusRemoved;
    }

    function setServerStatus(string contractName, uint serverStatusPar)public returns(uint){
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

        if(getServerStatus(contractName) != serverStatusNormal){
            return address(0x0);
        }
        return serverAddress[contractName];
    }
}