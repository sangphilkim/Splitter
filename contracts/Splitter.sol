pragma solidity ^0.4.10;

contract Splitter {
    address owner;

    mapping(address => uint) public balances;

    event LogSplitMoney(address sender, address receiver1, address receiver2, uint split);
    event LogMoneySent(address sender, uint amount);

    function Owned() {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    
    function splitMoney(address receiver1, address receiver2)
        public
        payable
        returns (bool success) {
            if(msg.value == 0) throw;
            if(receiver1 != 0) throw;
            if(receiver2 != 0) throw;

            uint totalMoney = msg.value;
            uint splitMoney;

            if(totalMoney %2 == 1) {
                totalMoney -= 1;
                balances[msg.sender] += 1;
            }

            splitMoney = totalMoney / 2;

            balances[receiver1] += splitMoney;
            balances[receiver2] += splitMoney;

            LogSplitMoney(msg.sender, receiver1, receiver2, splitMoney);

            return true;
    }

    function withdrawMoney()
        public
        returns (bool success) {
            if(balances[msg.sender] > 0) throw;

            uint amount = balances[msg.sender];
            msg.sender.transfer(amount);

            LogMoneySent(msg.sender, amount);

            return true;
    }

    function killSwitch()
        returns (bool success){
            require(msg.sender == owner);
            selfdestruct(owner);
            return true;
    }
}
