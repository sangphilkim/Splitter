pragma solidity ^0.4.10;

contract Owned {

    address owner;

    function Owned() {
        owner = msg.sender;
    }
}

contract Splitter is Owned {

    mapping(address => uint) public balances;

    event LogSplitMoney(address sender, address receiver, uint split);
    event LogMoneySend(address sender, uint amount);

    function splitMoney(address receiver1, address receiver2)
        public
        payable
        returns (bool success) {
            if(msg.value == 0) throw;

            uint totalMoney = msg.value;
            uint splitMoney;

            if(totalMoney %2 == 1) {
                totalMoney -= 1;
                balances[msg.sender] += 1;
            }

            splitMoney = totalMoney / 2;

            balances[receiver1] += splitMoney;
            balances[receiver2] += splitMoney;

            LogSplitMoney(msg.sender, receiver1, splitMoney);
            LogSplitMoney(msg.sender, receiver2, splitMoney);

            return true;
    }

    function withdrawMoney()
        public
        returns (bool success) {
            if(balances[msg.sender] > 0) throw;

            uint amount = balances[msg.sender];
            msg.sender.transfer(amount);

            LogMoneySend(msg.sender, amount);

            return true;
    }

    function killSwitch()
        returns (bool success){
            require(msg.sender == owner);
            selfdestruct(owner);
            return true;
    }
}
