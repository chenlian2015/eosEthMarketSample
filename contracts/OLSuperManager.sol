pragma solidity ^0.4.15;


contract OLSuperManager {

    address private superManager;

    mapping (string => mapping (address => bool)) private permissionUserToServer;

    function getSuperManager() public returns (address){
        return superManager;
    }

    function setUserServerPermission(address user, string server) public returns (uint){

        if (msg.sender != superManager) {
            return 5;
        }

        permissionUserToServer[server][user] = true;
        return 0;
    }

    function removePermission(address user, string server) public returns (uint){

        if (msg.sender != superManager) {
            return 5;
        }
        permissionUserToServer[server][user] = false;
    }

    function isUserHasPermissonToModify(address user, string server) public returns (bool){
        return permissionUserToServer[server][user];
    }
}