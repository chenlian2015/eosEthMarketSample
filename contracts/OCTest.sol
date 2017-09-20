pragma solidity ^0.4.15;


contract OCTest {

    uint256 public execTimes;

    uint256 public valueGetTotal;

    mapping (address => uint) customer;

    event LogSent(address bidder, uint amountto, uint amountfrom); // Event
    event LogErr(address bidder, uint amountto, uint amountfrom); // Event

    function getterExecTimes() public returns (uint){
        return execTimes;
    }

    function getterValueTotal() public returns (uint){
        return valueGetTotal;
    }

    function OCTest() payable {
        execTimes = 3;
        valueGetTotal = 2;
    }

    function () payable {
        execTimes++;
        valueGetTotal += msg.value;
        customer[msg.sender] += msg.value;
    }

    function withdraw(uint value) returns(bool success) {
        //if(balances[msg.sender] < value) throw;
        //balances[msg.sender] -= value;
        msg.sender.transfer(value);
        //LogWithdrawal(msg.sender, value);
        return true;
    }

    function withdraw1(uint value) returns(bool success) {
        //if(balances[msg.sender] < value) throw;
        //balances[msg.sender] -= value;
        msg.sender.transfer(10);
        //LogWithdrawal(msg.sender, value);
        return true;
    }

    function withdraw2() returns(uint success) {
        //if(balances[msg.sender] < value) throw;
        //balances[msg.sender] -= value;
        msg.sender.transfer(22);
        //LogWithdrawal(msg.sender, value);
        return 22;
    }

    function getReward(uint value) returns(bool success) {
        //if(balances[msg.sender] < value) throw;
        //balances[msg.sender] -= value;
        msg.sender.transfer(value);
        //LogWithdrawal(msg.sender, value);
        return true;
    }

}