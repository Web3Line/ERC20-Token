// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol"; // Done
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol"; //Done
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol"; //Done
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol"; // DOne
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Snapshot.sol"; // Done
import "@openzeppelin/contracts/access/AccessControlEnumerable.sol"; // Done

contract Token is
    ERC20,
    ERC20Burnable,
    ERC20Capped,
    ERC20Pausable,
    ERC20Snapshot,
    AccessControlEnumerable
{
    uint256 private constant amountCap = 10**6 * 10**18;

    bytes32 public constant SNAPSHOT_ROLE = keccak256("SNAPSHOT_ROLE");
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    constructor() ERC20("Web3Line", "WLT") ERC20Capped(amountCap) {
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _setupRole(SNAPSHOT_ROLE, msg.sender);
        _setupRole(PAUSER_ROLE, msg.sender);
        _setupRole(MINTER_ROLE, msg.sender);
    }

    function snapshot() public onlyRole(SNAPSHOT_ROLE) {
        _snapshot();
    }

    function pause() public onlyRole(PAUSER_ROLE) {
        _pause();
    }

    function unPause() public onlyRole(PAUSER_ROLE) {
        _unpause();
    }

    function changeAdmin(bytes32 role, bytes32 adminRole)
        public
        onlyRole(getRoleAdmin(role))
    {
        _setRoleAdmin(role, adminRole);
    }

    function mint(address _for, uint256 _amount) public onlyRole(MINTER_ROLE) {
        _mint(_for, _amount);
    }

    function transfer(address _to, uint256 _amount)
        public
        virtual
        override
        whenNotPaused
        returns (bool)
    {
        address owner = _msgSender();
        uint256 _toBeBurned = (_amount * 3) / 1000;
        _amount = _amount - _toBeBurned;
        _transfer(owner, _to, _amount);
        burn(_toBeBurned);
        return true;
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _amount
    ) public virtual override whenNotPaused returns (bool) {
        address spender = _msgSender();
        uint256 _toBeBurned = (_amount * 3) / 1000;
        _amount = _amount - _toBeBurned;
        _spendAllowance(_from, spender, _amount);
        _transfer(_from, _to, _amount);
        burn(_toBeBurned);
        return true;
    }

    function _mint(address account, uint256 amount)
        internal
        virtual
        override(ERC20Capped, ERC20)
    {
        require(
            ERC20.totalSupply() + amount <= cap(),
            "ERC20Capped: cap exceeded"
        );
        super._mint(account, amount);
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal override(ERC20, ERC20Pausable, ERC20Snapshot) whenNotPaused {
        super._beforeTokenTransfer(from, to, amount);
    }
}
// Most Important Functions That Inherited:

// function balanceOf(address account) public view virtual override returns (uint256) {
//     return _balances[account];
// }

// function approve(address spender, uint256 amount) public virtual override returns (bool) {
//         address owner = _msgSender();
//         _approve(owner, spender, amount);
//         return true;
//     }

// function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
//     address owner = _msgSender();
//     _approve(owner, spender, allowance(owner, spender) + addedValue);
//     return true;
// }

// function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
//     address owner = _msgSender();
//     uint256 currentAllowance = allowance(owner, spender);
//     require(currentAllowance >= subtractedValue, "ERC20: decreased allowance below zero");
//     unchecked {
//         _approve(owner, spender, currentAllowance - subtractedValue);
//     }
//     return true;
// }

// function burn(uint256 amount) public virtual {
//     _burn(_msgSender(), amount);
// }

// function burnFrom(address account, uint256 amount) public virtual {
//     _spendAllowance(account, _msgSender(), amount);
//     _burn(account, amount);
// }

// function cap() public view virtual returns (uint256) {
//     return _cap;
// }

// function balanceOfAt(address account, uint256 snapshotId) public view virtual returns (uint256) {
// (bool snapshotted, uint256 value) = _valueAt(snapshotId, _accountBalanceSnapshots[account]);
// return snapshotted ? value : balanceOf(account);
// }

// function grantRole(bytes32 role, address account) public virtual override onlyRole(getRoleAdmin(role)) {
//     _grantRole(role, account);
// }

// function revokeRole(bytes32 role, address account) public virtual override onlyRole(getRoleAdmin(role)) {
//     _revokeRole(role, account);
// }

// function renounceRole(bytes32 role, address account) public virtual override {
//     require(account == _msgSender(), "AccessControl: can only renounce roles for self");

//     _revokeRole(role, account);
// }

// function getRoleMemberCount(bytes32 role) public view virtual override returns (uint256) {
//     return _roleMembers[role].length();
// }

// function getRoleMember(bytes32 role, uint256 index) public view virtual override returns (address) {
//     return _roleMembers[role].at(index);
// }
