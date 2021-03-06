pragma solidity ^0.4.11;

contract ReactExample {
    address private owner;
    string public you_awesome;
    string private secret;
    string private state;
    bool public pseudoRandomResult;
    event ExperimentComplete (bool result);

    constructor(ReactExample) public {
        owner = msg.sender;
        you_awesome = "You're awesome";
        secret = "secret data";
        state = "initial state";
    }
    function getSecret () public view returns (string) {
        return secret;
    }
    function kill () public {
        require (msg.sender == owner);
        selfdestruct (owner);
    }
    function getState () public view returns (string) {
        return state;
    }
    function setState (string newState) public payable {
        state = newState;
    }
    function () public payable {
        revert ();
    }
    function setExperimentInMotion () public payable returns (bool) {
        bytes32 _pseudoRandomResult = keccak256(abi.encodePacked(msg.sender, msg.data, msg.value));
        if (_pseudoRandomResult > bytes32(10)) pseudoRandomResult = true;
        else pseudoRandomResult = false;

        emit ExperimentComplete (pseudoRandomResult);
    }
}
