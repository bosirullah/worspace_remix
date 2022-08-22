//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

//inheritance 
import "./SimpleStorage.sol";

contract ExtraStorage is SimpleStorage{
   function store(uint _favNum) public override{
       favNum =_favNum + 5;
   } 
}