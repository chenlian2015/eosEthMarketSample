pragma solidity ^0.4.15;

import "./OLTestSynataxBB.sol";
contract OLTestSynatax{

    mapping(uint=>bytes32) x;

    function test() private returns(bool){
        return x[1]==bytes32(0x0);
    }
}