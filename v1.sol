pragma solidity 0.4.19;

contract v1{
        
    //Template
    //
    //<type> <varName>;
    //
    //Note that return type is always boolean, 
    //since we shall only call it using a delegate call, which assumes a boolean return value indicating success or failure
    //
    //function <methodName>() public returns(bool){
    //    //do something
    //    <varName> = 6;
    //    if(<someConditonIndicatingSuccess>){
    //        return true;
    //    }
    //    else{
    //        return false;
    //    }
    //}
    
    uint methodThatReturnsIntReturnValue;
    function methodThatReturnsInt() public returns(bool){
        //do something
        methodThatReturnsIntReturnValue = 6;
        if(true){
            return true;
        }
        else{
            return false;
        }
    }
    
    bool methodThatReturnsBoolReturnValue;
    function methodThatReturnsBoolReturnValue() public returns(bool){
        //do something
        methodThatReturnsBoolReturnValue = true;
        if(true){
            return true;
        }
        else{
            return false;
        }
    }
    
    function() public{
        revert();
    }
}
