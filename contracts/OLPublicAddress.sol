pragma solidity ^0.4.15;
import "./OLSuperManager.sol";
import "./OLCommon.sol";
contract OLPublicAddress is OLCommon{

    mapping (string => address) serverAddress;

    mapping (string => uint) serverFee;//服务费

    /*
    如果要删除一个服务，则contractAddress设置值为0即可
    if you want to delete one contractName,just set contractAddress=0
    @param fee,means the fee you need to provide to call this server
    */
    function putServerAddress(string contractName, address contractAddress, uint fee) public returns (uint) {

        OLSuperManager olSuperManager = OLSuperManager(0x8ae305bda0ec07c8a38ff7bf4a85f85654591f5b);

        if (!olSuperManager.isUserHasPermissonToModify(msg.sender, "OLPublicAddress")) {
            return errorCode_success;
        }

        serverAddress[contractName] = contractAddress;

        if (fee < 0) {
            return errorCode_parameterError;
        }
        serverFee[contractName] = fee;
        return errorCode_success;
    }

    function getServerAddress(string contractName) public returns (address){
        return serverAddress[contractName];
    }

    function getFee(string contractName) public returns (uint){
        return serverFee[contractName];
    }

    function setServerFee(string contractName, uint fee) public returns (uint){
        OLSuperManager olSuperManager = OLSuperManager(0x8ae305bda0ec07c8a38ff7bf4a85f85654591f5b);

        if (!olSuperManager.isUserHasPermissonToModify(msg.sender, "OLPublicAddress")) {
            return errorCode_success;
        }

        if (fee < 0) {
            return errorCode_parameterError;
        }
        serverFee[contractName] = fee;
        return errorCode_success;
    }
}