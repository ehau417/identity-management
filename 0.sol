// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IdentityManagement {
    struct Identity {
        address owner;
        string name;
        string email;
        bytes32 hash;
        bool verified;
    }

    mapping (bytes32 => Identity) identities; // Map of hash to identity

    function register(string calldata _name, string calldata _email, bytes32 _hash) external {
        require(identities[_hash].owner == address(0), "Identity with hash already exists.");
        identities[_hash] = Identity({
            owner: msg.sender,
            name: _name,
            email: _email,
            hash: _hash,
            verified: false
        });
    }

    function verify(bytes32 _hash) external {
        Identity storage identity = identities[_hash];
        require(identity.owner != address(0), "Identity does not exist.");
        require(identity.owner == msg.sender, "Only the owner can verify their identity.");
        identity.verified = true;
    }

    function getIdentity(bytes32 _hash) external view returns (address, string memory, string memory, bool) {
        Identity storage identity = identities[_hash];
        return (identity.owner, identity.name, identity.email, identity.verified);
    }
}
