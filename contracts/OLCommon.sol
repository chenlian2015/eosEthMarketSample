pragma solidity ^0.4.15;
import "./OLSuperManager.sol";

contract OLCommon {

    mapping (uint => string) errorCode;
    uint public errorCode_success = 0;
    uint public errorCode_feeIsNotEnough = 1;
    uint public errorCode_parameterError = 2;
    uint public errorCode_versionIsOld = 3;
    uint public errorCode_noPermitAccess = 4;

    function OLCommonErrorCode(){
//        errorCode_success = "success";
//        errorCode_feeIsNotEnough = "fee is not enough";
//        errorCode_parameterError = "paramerer error";
//        errorCode_versionIsOld = "version is old";
//        errorCode_noPermitAccess = "address is in blacklist or not in whitelist";
//        errorCode[5] = "privilege not limit";
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