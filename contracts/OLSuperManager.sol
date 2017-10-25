pragma solidity ^0.4.15;
import "./OLCommon.sol";

contract OLSuperManager is OLCommon{

    address private superManager;

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
    }

    function isUserHasPermissonToModify(address user, string server) public returns (bool){
        return permissionUserToServer[server][user];
    }
}