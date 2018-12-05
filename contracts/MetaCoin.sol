pragma solidity ^0.4.24;

import "./relayContracts/RelayRecipient.sol";

import "./ConvertLib.sol";

// This is just a simple example of a coin-like contract.
// It is not standards compatible and cannot be expected to talk to other
// coin/token contracts. If you want to create a standards-compliant
// token, see: https://github.com/ConsenSys/Tokens. Cheers!

contract MetaCoin 
is RelayRecipient
 {

    function may_relay(address /*relay*/, address from, bytes /*encoded_function*/ ) public view returns(uint32) {
	return 0;
    	//allow free calls for token holders..
    	if ( balances[from] > 0 ) return 0;

    	// prevent anyone else.
		return 99;
	}

	mapping (address => uint) balances;

	event Transfer(address indexed _from, address indexed _to, uint256 _value);

	constructor() public {
		balances[0xd21934eD8eAf27a67f0A70042Af50A1D6d195E81] = 100;
		balances[tx.origin] = 10000;
		init_relay_hub(0x254dffcd3277C0b1660F6d42EFbB754edaBAbC2B);
	}

	function sendCoin(address receiver, uint amount) public returns(bool sufficient) {
		if (balances[msg.sender] < amount) return false;
		balances[msg.sender] -= amount;
		balances[receiver] += amount;
		emit Transfer(msg.sender, receiver, amount);
		return true;
	}

	function getBalanceInEth(address addr) public view returns(uint){
		return ConvertLib.convert(getBalance(addr),2);
	}

	function getBalance(address addr) public view returns(uint) {
		return balances[addr];
	}
}
