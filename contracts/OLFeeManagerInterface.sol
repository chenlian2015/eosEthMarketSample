pragma solidity ^0.4.15;


contract OLFeeManagerInterface {

    mapping (string => uint)  feeSetting;

    /*
    only who has permission can call setFee
    @param serverName
    @param fee, the fee of serverName, with uint moct
    @return 0 success, or other error code reference OLCommonConfigure.sol
    */
    function setFee(string serverName, uint fee)public returns (uint){}

    /*
    @return get the fee needed to call this string serverName
    */
    function getFee(string serverName) public returns (uint){}
}