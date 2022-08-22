//sending eth through a function and reverts
// Get funds from users
// Withdraw funds
// Set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./PriceConverter.sol"; 
//smart contracts can hold funds just like wallets.
error NotOwner();

contract FundMe {
    using PriceConverter for uint256;

    //gas - 941922 (intially)
    //gas - 919483 (after using the constant keyword)
    //if we only set the variable once and never change it we can use the constant keyword
    //using the constant keyword makes it gas efficient
    //if we use constant keyword we have to write the variable name in caps
    uint256 public constant MIN_USD = 50 * 1e18;

    address [] public funders;
    mapping(address => uint256)  public addressToAmtFunded;

    //if we only set it inside the constructor then we use immutable
    address public immutable i_owner;
    constructor(){
        i_owner = msg.sender;
    }

    function fund() public payable{
        //want to be able to set a minimum fund amount in USD
        //How do we send ETH to this contract?

        
        //require(getConversionRate(msg.value) >= minUsd ,"Didn't send enough"); //1e18 = 10^18; 
        require(msg.value.getConversionRate() >= MIN_USD ,"Didn't send enough"); //1e18 = 10^18; 
        
        //what is reverting?
        //undo any action before, and send remaining gas back
        //18 decimals
        funders.push(msg.sender);
        addressToAmtFunded[msg.sender] = msg.value;
    }

    


    function withdraw() public onlyOwner{
        
        /* starting index, ending index , step amount*/
        for(uint256 funderIndex = 0;funderIndex<=funders.length;funderIndex++){
            //code
            address funder = funders[funderIndex]; 
            addressToAmtFunded[funder] = 0;        
        }
        //reset the array
        funders = new address[](0);
        //actually withdraw the funds

        /*there are three different ways to send ether or native blockchain currency
            1. transfer
            2. send 
            3. call
        */

        //1. transfer 
        //msg.sender = address
        // //payable(msg.sender) = payable address
        // payable(msg.sender.transfer(address(this).balance));
         
        //  //2. send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess,"Send failed");

        // //3. call
        // //byte objects are arrays 
        // // (bool callSuccess, bytes memory dataReturned) = payable(msg.sender).call{value: address(this).balance}("");
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess,"Call failed");
    }

    modifier onlyOwner{
        //require(msg.sender == i_owner,"Sender is not owner");//do this first
        _; //then the rest of the code
        //if _; this comes above the require statement then do the code first then the require statement
        if(msg.sender != i_owner) { revert NotOwner();} 
    }

    //what happens if someone sends this contract ETH  withot calling the fund function
    receive() external payable{
         fund();
     }
    fallback() external payable{
        fund();
    }
}

