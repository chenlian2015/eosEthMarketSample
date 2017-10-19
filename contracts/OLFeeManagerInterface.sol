pragma solidity ^0.4.15;


contract OLFeeManagerInterfacce {

    mapping (string => uint)  feeSetting;

    /**
    only who has permission can call setFee
    @param serverName
    @fee the fee of serverName, with uint moct
    @return 0 success, or other error code reference OLCommon.sol
    */
    function setFee(string serverName, uint fee)public returns (uint){}

    /**
    @return get the fee needed to call this string serverName
    */
    function getFee(string serverName) public returns (uint){}
}