/* Birthday.sol
Ecrivez un smart contract Birthday qui permettra à une adresse de retirer tous les fonds du smart contract à partir d'une certaine date.
Les fonds pourront être envoyés par ses amis via une fonction offer ou bien directement depuis une transaction via metamask. Il faudra donc implémenter la fonction receive.
Une fonction getPresent permettra de récupérer tous les ethers envoyés au smart contract et ne sera débloquée que pour une adresse précise et à une date précise (un timestamp).
Dans le constructor vous devrez obligatoirement y indiquer l'adresse de la personne dont ce sera l'anniversaire et aussi un nombre qui correspondra à un nombre de jours qui sera le délai entre l'anniversaire et la date déploiement du smart contract.
Il faudra vous servir de block.timestamp: https://docs.soliditylang.org/en/latest/units-and-global-variables.html#time-units
Attention le timestamp d'un block est exprimé en seconds.
Déterminer la date d'anniversaire au jour près, on ne pas se fier à des dates précises (à la seconde) dans une blockchain. C'est un exercice ouvert, essayez d'être le plus cohérent avec la problématique à résoudre.
Il peut exister plusieurs solutions. */

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol";

contract Birthday {
// Library usage
using Address for address payable;

// Type declarations

// State variables
mapping(address => bool) private _friends;
mapping(address => uint256) private _balances;
address private _birthdayOwner;
int256 private _piggyBank;

// Events
event Deposited(address indexed sender, uint256 amount);
event Transfered(
        address indexed sender,
        address indexed recipient,
        uint256 amount
    );

// constructor
constructor(address birthdayOwner_, int256 piggyBank_) {
    if (block.timestamp >= start + daysAfter * 1 days) {
      // ...
    }
}

// Function modifiers
/* modifier onlyFriends() {
    require(msg.sender == _friends, "Birthday: Only friends can participate");
    _;
} */

// Functions

receive() external payable {
        _deposit(msg.sender, msg.value);
    }
    
    fallback() external {}
    
    function deposit() external payable {
        _deposit(msg.sender, msg.value);
    }

function offer(address recipient, uint256 amount) external payable {
    require(_balances[msg.sender] > 0,"Birthday: can not offer 0 ether");
        require(_balances[msg.sender] >= amount,"Birthday: Not enough Ether to offer");
        require(recipient != address(0),"Birthday: offer to the zero address");
        _balances[msg.sender] -= amount;
        _balances[recipient] += amount;
}

function getPresent() external payable {

}

function isFriends(address account) public view returns (bool) {
        return _friends[account];
    }
    
function _deposit(address sender, uint256 amount) private {
        _balances[sender] += amount;
        emit Deposited(sender, amount);
    }

}
