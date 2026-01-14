1. Add file → Create new file
2. Filename: examples/reentrancy/SafeBank.sol
3. Вставь:

solidityDownloadCopy code// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SafeBank {
    mapping(address => uint256) public balance;
    bool locked;

    modifier nonReentrant(){ require(!locked,"REENTRANCY"); locked=true; _; locked=false; }

    function deposit() external payable { balance[msg.sender] += msg.value; }

    function withdraw(uint256 amount) external nonReentrant {
        require(balance[msg.sender] >= amount, "INSUFFICIENT");
        balance[msg.sender] -= amount;
        (bool ok,) = msg.sender.call{value: amount}("");
        require(ok, "TRANSFER_FAILED");
    }
}
