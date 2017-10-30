pragma solidity ^0.4.15;


import "./OLCommonConfigure.sol";


contract OLSuperManager is OLCommonConfigure {

    address private superManager = 0x349afb784a8d2d8e37c4ae22d8ef23bfa51c6a74;

    mapping (string => mapping (address => bool)) private permissionUserToServer;

    function getSuperManager() public returns (address){
        return superManager;
    }

    function setUserServerPermission(address user, string server) public returns (uint){

        if (msg.sender != superManager) {
            return errorCode_noPermitAccess;
        }

        permissionUserToServer[server][user] = true;
        return errorCode_success;
    }

    function removePermission(address user, string server) public returns (uint){

        if (msg.sender != superManager) {
            return errorCode_noPermitAccess;
        }
        permissionUserToServer[server][user] = false;
        return errorCode_success;
    }

    function isUserHasPermissonToModify(address user, string server) public returns (bool){
        if (user == superManager) {
            return true;
        }
        return permissionUserToServer[server][user];
    }
}