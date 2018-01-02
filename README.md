# smart-contract-versioning
A template for type-safe smart contract versioning on Ethereum.

Due to the nature of a blockchain, smart contracts are (syntactically) immutable. Once a contract is created at a certain address, then its code cannot be changed during its lifetime. This creates problems for dealing with bugs in a contract, i.e. a bug cannot be repaired, but the repaired contract has to be re-created and written to the blockchain anew.

Using a proxy contract and <i>delegatecalls</i> has been proposed as a solution to this (see [1, 2, 3, 4]). Here I describe another approach to versioning also using this proxy pattern, but relying purely on Solidity constructs rather than relying on some assembly code. This approach also deals seamlessly with the size of return values, which other approaches hard code using assembly (e.g. to 32-bit see [2, 5]).

This approach starts with the assumption that the proxy contract is part of our Trusted Computing Base, i.e. we assume there are no bugs in it. We try to ensure this by keeping it as simple as possible. This contract's storage contains the state of the program, an <i>address</i> variable pointing to the current implementation version, and the methods exposed publicly. Before discussing how these methods look, a brief primer on <i>delegatecall</i> is needed.

<i>delegatecall</i> delegates methods calls to other contracts. We can pass as a parameter the payload of the current call by passing it <i>msg.data</i>. It allows the called contract to operate with the storage of the caller method, which makes it a bit of a security risk, but more on how to manage that risk in future work. It also does not allow any value to be returned, but assumes that the return value is a boolean, indicating success of the call. We can go around this using some assembly tricks, as mentioned before ([2, 5]), however this assumes the bit size of the return value. We take a different approach.


Consider the following method:


```
function <methodName>() public returns(<type>){        
        <type> <varName>;
                
        //do something with <varName>

        if(<someConditonIndicatingSuccess>){
            return <varName>;
        }
        else{
            revert();
        }
    }
```

To prepare this for use with our proxy we would transform it as follows, by creating a new variable for the return value, while changing the return type to boolean (recall that we intend to call this with <i>delegatecall</i> which assumes a boolean return value), and setting the new storage variable before returning.


---------------------------------
    <type> <varName>;
    function <methodName>() public returns(bool){
        //do something
        <varName> = 6;
        if(<someConditonIndicatingSuccess>){
            return true;
        }
        else{
            return false;
        }
    }
-----------------------------------

In the proxy we can the call the smart contract at address <i>currentVersion</i>, pointing to the contract providing the above method, using delegate call. 

Proxy/Interface method
--------------------------------
```
    address currentVersion = 0x000;
    
    <type> <varName>;
    function <methodName>() public returns(<returnTypeIfAny>){
        if(currentVersion.delegatecall(msg.data)){
            returns <varName>;
        }
        else{
            revert();
        }
    }
```
---------------------------------

Note that since the called contract uses the storage of the caller contract, the called contract's storage is not affected after calling a method within it using a <i>delegatecall</i>. To maintain type-safety, the variables with the same name in both contracts must have the same type. We can ensure this through an automatic procedure (WIP) transforming methods, as illustrated above.

[1] https://gist.github.com/Arachnid/4ca9da48d51e23e5cfe0f0e14dd6318f

[2] http://martin.swende.se/blog/EVM-Assembly-trick.html

[3] https://blog.zeppelin.solutions/proxy-libraries-in-solidity-79fbe4b970fd (https://github.com/maraoz/solidity-proxy/blob/master/test/test.js)

[4] https://zupzup.org/smart-contract-interaction/

[5] https://ethereum.stackexchange.com/questions/15164/how-can-i-get-delegatecall-to-return-data/15170

TODO
------------------------

1. Secure setting contract version address
