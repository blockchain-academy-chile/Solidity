// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/**
 * @title Owner
 * @dev Set & change owner
 */
contract MultiOwner {

    mapping(address => bool) private owners;
    
    // event for EVM logging
    event OwnerAdded(address indexed owner);
    event OwnerRemoved(address indexed owner);
    
    // modifier to check if caller is owner
    modifier isOwner() {
        // If the first argument of 'require' evaluates to 'false', execution terminates and all
        // changes to the state and to Ether balances are reverted.
        // This used to consume all gas in old EVM versions, but not anymore.
        // It is often a good idea to use 'require' to check if functions are called correctly.
        // As a second argument, you can also provide an explanation about what went wrong.
        require(owners[msg.sender], "Caller is not owner");
        _;
    }
    
    /**
     * @dev Set contract deployer as owner
     */
    constructor() {
        owners[msg.sender] = true; // 'msg.sender' is sender of current call, contract deployer for a constructor
        emit OwnerAdded(msg.sender);
    }

    /**
     * @dev Remove owner
     * @param removedOwner address of the removed owner
     */
    function removeOwner(address removedOwner) public isOwner {
        emit OwnerRemoved(removedOwner);
        owners[removedOwner] = false;
    }
    
    /**
     * @dev Add owner
     * @param addedOwner address of the removed owner
     */
    function addOwner(address addedOwner) public isOwner {
        emit OwnerAdded(addedOwner);
        owners[addedOwner] = true;
    }

}
