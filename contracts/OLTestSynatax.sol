pragma solidity ^0.4.15;

import "./OLTestSynataxBB.sol";
contract OLTestSynatax{

    string [] name;

    function add(string namePar) public{
        name.push(namePar);
    }

    function length()public returns(uint){
        return name.length;
    }

    function clear() public {
        delete name;
    }

    function getAt(uint nIndex) returns(string){
        return name[nIndex];
    }
}