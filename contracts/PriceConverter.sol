// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol"; //nvm package 

library PriceConverter{
    function getPrice() internal view returns(uint256){
        //ABI
        //address - 0x8A753747A1Fa494EC906cE90E9f37563A8AF630e
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        (,int256 price,,,) = priceFeed.latestRoundData();
        //ETH int terms of USD 
        //3000.00000000
        return uint256(price * 1e10);  //1**10=10000000000
    }

    function getVer() internal view returns(uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        return priceFeed.version();
    }

    function getConversionRate(uint256 ethamt) internal view returns (uint256){
        uint256 ethPrice = getPrice();
        //3000_000000000000000000 = ETH/ USD price
        //1_000000000000000000 ETH
        uint256 ethAmtInUsd = (ethPrice*ethamt) / 1e18;
        // 3000
        return ethAmtInUsd; 
    }

}