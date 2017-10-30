pragma solidity ^0.4.15;

import "./OLTestSynataxBB.sol";
contract OLTestSynatax{


    function OLTestSynatax(){

    }
    function baby()public returns(address){
        return msg.sender;
    }

    function test() public returns(address){

        return baby();
    }
}