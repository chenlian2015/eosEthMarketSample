pragma solidity ^0.4.15;
import "./OLSuperManager.sol";

contract OLCommon {

    mapping (uint => string) errorCode;

    function OLCommonErrorCode(){
        errorCode[0] = "success";
        errorCode[1] = "fee is not enough";
        errorCode[2] = "paramerer error";
        errorCode[3] = "version is old";
        errorCode[4] = "address is in blacklist or not in whitelist";
        errorCode[5] = "privilege not limit";
    }

    function setErrorCode(uint code, string reason) public returns (uint rcode){

        OLSuperManager olSuperManager = OLSuperManager(0x8ae305bda0ec07c8a38ff7bf4a85f85654591f5b);

        if (!olSuperManager.isUserHasPermissonToModify(msg.sender, "OLCommon")) {
            5;
        }
        errorCode[code] = reason;
        return 0;
    }

    function getErrorCode(uint code) public returns (string reason){
        return errorCode[code];
    }
}