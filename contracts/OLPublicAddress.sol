pragma solidity ^0.4.15;
import "./OLSuperManager.sol";

contract OLPublicAddress {

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
            5;
        }

        serverAddress[contractName] = contractAddress;

        if (fee < 0) {
            return 2;
        }
        serverFee[contractName] = fee;
        return 0;
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
            5;
        }

        if (fee < 0) {
            return 2;
        }
        serverFee[contractName] = fee;
        return 0;
    }
}