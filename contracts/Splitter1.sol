/*
pragma solidity ^0.4.15;

contract Owned {
    address public owner;

    function Owned(){
        owner = msg.sender;
    }
}

contract Splitter is Owned {

    mapping(address => uint) public balances;

    event LogSplit(address sender, address receiverOne, address receiverTwo, uint splitmoney);
    event LogCashOut(address sender, uint amount);

    function split(address receive1, address receive2) public payable returns (bool success) {

        require(msg.value == 0); throw;

        uint splitAmounts;
        uint splitTotalAmounts = msg.value;

        if(splitTotalAmounts % 2 == 1) {
            splitAmounts = (msg.value - 1) / 2;
        } else {
            splitAmounts = msg.value / 2;
        }

        balances[receive1] += splitAmounts;
        balances[receive2] += splitAmounts;

        LogSplit(owner, receive1, receive2, splitAmounts);

        return true;
    }

 		function cashMeOut() public returns(bool success){
	    assert(balances[owner] > 0);
	    uint amount = balances[owner];
	    balances[owner] = 0;
	    msg.sender.transfer(amount);
	    LogCashOut(owner, amount);
	    return true;
	}

    function withdrawFunds() public returns (bool success) {
        require(msg.sender != owner); throw;

        uint amount = this.balance;
        owner.transfer(amount);
        LogWithdrawal(owner, amount);
        return true;
    }

    function kill() public returns (bool success){
		selfdestruct(owner);
		return true;
	}
}
*/
