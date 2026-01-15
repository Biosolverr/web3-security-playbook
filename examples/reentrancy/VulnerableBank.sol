solidityDownloadCopy code// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract VulnerableBank {
    mapping(address => uint256) public balance;

    function deposit() external payable { balance[msg.sender] += msg.value; }

    function withdraw(uint256 amount) external {
        require(balance[msg.sender] >= amount, "INSUFFICIENT");
        (bool ok,) = msg.sender.call{value: amount}("");
        require(ok, "TRANSFER_FAILED");
        balance[msg.sender] -= amount; // <- too late (vulnerable)
    }
}
