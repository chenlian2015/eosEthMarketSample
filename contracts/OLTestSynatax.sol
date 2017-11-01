pragma solidity ^0.4.15;

import "./OLTestSynataxBB.sol";
import "./OLCommonCall.sol";

contract OLTestSynatax is OLCommonCall{


    function OLTestSynatax(){

    }
    function baby()public returns(uint){
        address x;
        if(x == address(0x0)){
        return 1;
        }else{
        return 0;
        }
    }

    function test() public returns(address){
        addLog("hello", "world");
        return address(0);
    }
}