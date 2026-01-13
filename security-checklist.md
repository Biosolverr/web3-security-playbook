# Security checklist (Solidity)

- Access control (owner/roles), no `tx.origin`
- CEI pattern, reentrancy protection
- Validate inputs, handle decimals/rounding
- Emit events for critical changes
