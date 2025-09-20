// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


/// @notice Extremely small ERC20 implementation for demo only
contract MyToken {
string public name = "DemoToken";
string public symbol = "DMT";
uint8 public decimals = 18;
uint256 public totalSupply;


mapping(address => uint256) public balanceOf;
mapping(address => mapping(address => uint256)) public allowance;


event Transfer(address indexed from, address indexed to, uint256 value);
event Approval(address indexed owner, address indexed spender, uint256 value);


constructor(uint256 _initial) {
totalSupply = _initial;
balanceOf[msg.sender] = _initial;
emit Transfer(address(0), msg.sender, _initial);
}


function transfer(address _to, uint256 _value) public returns (bool) {
require(balanceOf[msg.sender] >= _value, "insufficient");
balanceOf[msg.sender] -= _value;
balanceOf[_to] += _value;
emit Transfer(msg.sender, _to, _value);
return true;
}


function approve(address _spender, uint256 _value) public returns (bool) {
allowance[msg.sender][_spender] = _value;
emit Approval(msg.sender, _spender, _value);
return true;
}


function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {
require(balanceOf[_from] >= _value, "insufficient");
require(allowance[_from][msg.sender] >= _value, "allowance");
allowance[_from][msg.sender] -= _value;
balanceOf[_from] -= _value;
balanceOf[_to] += _value;
emit Transfer(_from, _to, _value);
return true;
}


// minting helper for the TokenSale contract
function mint(address _to, uint256 _amount) external returns (bool) {
// NOTE: in a real token you'd restrict who can mint (owner/minter role)
totalSupply += _amount;
balanceOf[_to] += _amount;
emit Transfer(address(0), _to, _amount);
return true;
}
}
