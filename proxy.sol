pragma solidity 0.4.19;

contract proxy{
    
    address currentVersion; //address to v1 contract on blockchain
    
    //Template method proxy call
    //
    //<type> <varName>;
    //function <methodName>() public returns(<returnTypeIfAny>){
    //    if(currentVersion.delegatecall(msg.data)){
    //        returns <varName>;
    //    }
    //    else{
    //        revert();
    //    }
    //}
    
    //example method that returns uint
    uint methodThatReturnsIntReturnValue;
    function methodThatReturnsInt() public returns(uint){
        if(currentVersion.delegatecall(msg.data)){
            returns methodThatReturnsIntReturnValue;
        }
        else{
            revert();
        }
    }
    
    //example method that returns bool
    bool methodThatReturnsBoolReturnValue;
    function methodThatReturnsInt() public returns(bool){
        if(currentVersion.delegatecall(msg.data)){
            returns methodThatReturnsBoolReturnValue;
        }
        else{
            revert();
        }
    }
    
    function() public{
        revert();
    }
}
