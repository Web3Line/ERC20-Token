# ERC20-Token
Powerful ERC20 Token With Lots Of Abilities Using OpenZeppelin Libraries With Deflation Method Of Burning 0.03% Of THe TX Amount And Also "AccessControlEnumerable" As Access Control For Rules Of:
  1. SNAPSHOT_ROLE
  2. PAUSER_ROLE 
  3. MINTER_ROLE <br><br>
# SmartContract Main Functions
  1. snapshot => Takes snapshot for having history of transactions  //SNAPSHOT_ROLE
  2. pause => Pauses transactions in major conditions //PAUSER_ROLE
  3. unPause => Unpauses transactions //PAUSER_ROLE
  4. changeAdmin => Changes the admin of the specific role
  5. mint
  6. transfer
  7. transferFrom
  8. balanceOf
  9. approve
  10. increaseAllowance
  11. decreaseAllowance
  12. burn
  13. burnFrom
  14. cap => Sets the Maximum total supply
  15. balanceOfAt => Shows the balance of specific account in specific snapshot Id
  16. grantRole => Adds address to the specific rule
  17. revokeRole => Removes address from the specific rule
  18. renounceRole => User can renounce from the specific rule
  19. getRoleMemberCount => Returns the count of specific rule
  20. getRoleMember => Returns the user with specific Id in specific rule
