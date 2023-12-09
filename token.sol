// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleEscrow {
    address public payer;   // Alice's address
    address public payee;   // Bob's address
    uint256 public expiration;  // Time when Bob can withdraw
    uint256 public amount;  // Amount deposited by Alice

    event Deposit(address indexed from, uint256 amount, uint256 expiryTime);
    event Withdrawal(address indexed to, uint256 amount);

    constructor(address _payee) {
        // payer = msg.sender;
        payee = _payee;
        expiration = 60*60*24; //delay of one day
         
         // Bob can withdraw after  "expiryDelay" amount of time after Alice deposits. The expiryDelay is set to one day during deployment.
    }


    // the assumption here is that the first address depositing into this contract is Alice     

    function deposit() external payable {

        if(payer == address(0) ){
            payer = msg.sender;
        }
        else{
            require(msg.sender == payer, "Only Alice can deposit funds");
        }     
        require(msg.value > 0, "Deposit amount must be greater than 0");
        require(amount == 0, "Funds have already been deposited");

        amount = msg.value;

        expiration = block.timestamp + expiration;
        
        emit Deposit(msg.sender, msg.value, expiration);
    }

    function withdraw() external {
        require(msg.sender == payee, "Only Bob can withdraw");
        require(block.timestamp >= expiration, "Withdrawal is not allowed yet");
        require(amount > 0, "No funds to withdraw");


        payable(payee).transfer(amount);
        amount = 0;  // Reset the amount after withdrawal

        emit Withdrawal(payee, amount);
    }
}
