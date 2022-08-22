/// SPDX-License-Identifier: MIT
// pragma solidity ^0.6.0; 

// contract SafeMathTester{
//     uint8 public bigNum = 255; //unchecked 

//     function add() public{
//         bigNum++;
//     }
// }

    pragma solidity ^0.8.0; 

    contract SafeMathTester{
        uint8 public bigNum = 255; //unchecked 

        function add() public{
            unchecked {bigNum++;}
        }
    }