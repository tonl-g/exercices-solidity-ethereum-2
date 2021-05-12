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
address private _birthdayOwner;
address private _owner;

// Events

// constructor
constructor(address birthdayOwner_) {

}

// Function modifiers
modifier onlyOwner() {
    require(msg.sender == _owner, "Ownable: Only owner can participate");
    _;
}

// Functions

receive() external payable {
        _deposit(msg.sender, msg.value);
    }

function offer() external payable onlyOwner {

}

function getPresent() external payable onlyOwner {

}

function isFriends(address account) public view returns (bool) {
        return _friends[account];
    }

}
