var Splitter = artifacts.require("./Splitter.sol");

contract('Splitter', function(accounts) {

  var contract;

  var alice = accounts[0];
  var bob = accounts[1];
  var carol = accounts[2];

  var amountOdd = 9;
  var amountEven = 10;


  beforeEach(function() {
    return Splitter.new(bob, carol, {from: alice})
    .then(function(instance) {
      contract = instance;
    });
  });
/*
  it("should just say hello.", function() {
    assert.strictEqual(true, true, true, "Something is wrong.");
  });
*/
  it("should split odd amount to bob and carol from alice", function() {
    return contract.splitMoney(bob, carol, {from: alice, value: amountOdd})
      .then(function(txn){
        return contract.balances(bob);
//        return contract.balances(carol);
      })
      .then(bob => {
        assert.equal(bob.toString(10), "4", "Bob didn't receive the money");
        return contract.balances(carol);
      })
      .then(carol => {
        assert.equal(carol.toString(10), "4", "Carol didn't receive the money");
        return contract.balances(alice);
      })
      .then(alice => {
        assert.equal(alice.toString(10), "1", "Alice didn't receive odd money");
      });
  });

  it("should split even amount to bob and carol", function() {
    return contract.splitMoney(bob, carol, {from: alice, value: amountEven})
      .then(function(txn) {
        return contract.balances(bob);
      })
      .then(bob => {
        assert.equal(bob.toString(10), "5", "Bob didn't get the money");
        return contract.balances(carol);
      })
      .then(carol => {
        assert.equal(carol.toString(10), "5", "Carol didn't get the money");
      });
  });

/*
  it("Kill switch is working", function() {
    return contract.killSwitch({from: alice})
    .then(function(txn) {
      return contract.Owned({from: alice})
    }) .then(alice => {
      assert.strictEqual(alice, "0x", "Alice could not kill contract");
    });
  });
*/



});
