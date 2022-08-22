// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7; 

//EVM - Ethereum Virtual Machine
//avalanche, fantom, Polygon

//0.8.15 - latest version
/*
    if we are ok with any version above a version]
    syntax: ^0.8.7
*/
/*
    if we want to select versions in a range then
    syntax: >=0.8.7 <0.9.0;
*/

//anyithing we write inside contract are details of the contract
contract SimpleStorage{
    /*
        //boolean, uint, int , address, bytes
        bool hasfavoriteNum = true;
        uint256 favNum = 123;   //we can specify the size, by default it is 256 bits 
        //lowest - 8 and highest = 256
        string favNumInTxt = "five";
        int256 favInt = -5; //lowest - 8 and highest = 256
        address myAddress = 0x8903fa7A57da175dA74592820fa70588e8D05557;
        //lowest - 1 and highest = 32
        bytes32 favBytes = "cat"; //it is a string which automatically gets converted into bytes
    */
    
    //if visibility specifier is assigned then by default visibility is internal
    //it gets indexed at 0th position
    uint256 favNum ; //this gets initialized to zero
    //public variable implicitly get assigned a function that returns its values.
    //virtual has to be adder in the parent file to override the function in the child file.
    function store(uint256 _favNum) public virtual{
        favNum = _favNum;
        
    }
    // 0xd9145CCE52D386f254917e481eB44e9943F39138

    // view and pure function when called alone dont spend gas
    // view and pure functions disallow modification of state as they are only for reading purpose only
    // pure functions additionaly disallow you to read from blockchain state
    // if a gas calling function calls a view or pure function - only then will it costs gas
    //view and pure function dosent modify the state of the blockchain 
    function retrieve() public view returns(uint256){
        return favNum;
    }

    struct People{
        uint256 favNum;
        string name;
    }

    People public person = People({favNum: 2, name: "bosir"});

    //an array is a data structure that holds a list of other data types
    
    //uint256[] public favNumList;
    People[] public people;

    //mapping
    mapping(string => uint256) public nameToFavNum;

    //calldata,memory, storage
    //memory - temporary variables that can be modified
    //calldata - temporary variables that cannot be modified
    //storage = permanent variables that can be modified
    //memory user for array,struct or mapping types
    //we need specify for string because it does not know where to store a string and string is basically a array behind the scenes
    function addPerson(string memory _name,uint256  _favNum) public{
        //People memory newPerson = People({favNum: _favNum,name: _name}); 
        //People memory newPerson = People(_favNum,_name);  
        people.push(People(_favNum,_name));
        nameToFavNum[_name] = _favNum;
    }

    //warnings wont stop your code from compling


} 