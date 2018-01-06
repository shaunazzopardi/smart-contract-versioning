pragma solidity 0.4.19;

contract v1{
    address currentVersion; //unused, but needed to have the exact same storage as the caller contract
    
    //Template
    //
    //<type> <varName>;
    //
    //Note that return type is always boolean, 
    //since we shall only call it using a delegate call, which assumes a boolean return value indicating success or failure
    //
    //function <methodName>() public{
    //    //do something
    //    <varName> = 6;
    //    if(<someConditonIndicatingFailure>){
    //        revert();
    //    }
    //}
    
    uint methodThatReturnsIntReturnValue;
    function methodThatReturnsInt() public{
        //do something
        methodThatReturnsIntReturnValue = 6;
        if(true){
            revert();
        }
    }
    
    bool methodThatReturnsBoolReturnValue;
    function methodThatReturnsBoolReturnValue() public{
        //do something
        methodThatReturnsBoolReturnValue = true;
        if(true){
            revert();
        }
    }
    
    function() public{
        revert();
    }
}
