// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.0;

import "./SimpleStorage.sol";

contract StorageFactory{
    SimpleStorage[] public simpleStorageArray;
    function createSimpleStorageContract() public{
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage); 
    }

    //sf - storage factory
    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public{
        //to interact with contracts we need,
        //1. address            2. ABI(application binary interface)
        //SimpleStorage simpleStorage = SimpleStorage(simpleStorageArray[_simpleStorageIndex]);
        //simpleStorageArray[_simpleStorageIndex].store(_simpleStorageNumber);
        SimpleStorage simpleStorage = simpleStorageArray[_simpleStorageIndex];
        simpleStorage.store(_simpleStorageNumber);
    }

    function sfGet(uint256 _simpleStorageNumber) public view returns(uint256){
        //return simpleStorageArray[_simpleStorageNumber].retrieve;
        //                      or
        SimpleStorage simpleStorage = simpleStorageArray[_simpleStorageNumber];
        return simpleStorage.retrieve();

    }
 }
