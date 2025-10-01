// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract TrafficControl {
    enum SignalState { RED, YELLOW, GREEN }

    struct Signal {
        string location;
        SignalState state;
        uint256 lastUpdated;
    }

    address public admin;
    mapping(string => Signal) public signals;

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action.");
        _;
    }

    constructor() {
        admin = msg.sender;
    }

    function setSignalState(string memory _location, SignalState _state) public onlyAdmin {
        signals[_location] = Signal({
            location: _location,
            state: _state,
            lastUpdated: block.timestamp
        });
    }

    function getSignalState(string memory _location) public view returns (SignalState, uint256) {
        Signal memory s = signals[_location];
        return (s.state, s.lastUpdated);
    }

    function emergencyOverride(string memory _location) public onlyAdmin {
        signals[_location].state = SignalState.RED;
        signals[_location].lastUpdated = block.timestamp;
    }
}
