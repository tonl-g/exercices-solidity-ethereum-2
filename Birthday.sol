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

// Pragma statements
pragma solidity ^0.8.0;

// Import statements
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol";

// contract
contract Birthday {
// Library usage
using Address for address payable;

// Type declarations
mapping (address => bool) private _friends;
mapping(address => uint256) private _balances;
address private _recipient;
uint256 private _birthday;
uint256 private _participation;

// State variables

// Events
event Deposited(address indexed sender, uint256 amount);

// constructor
constructor (address recipient_, uint256 year, uint256 month, uint256 day){
        _birthday=_humanDateToEpochTime(year,month,day);
        require(_birthday>block.timestamp,"Birthday: This date is already passed.");
        _recipient=recipient_;
    }

// Function modifiers

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
    require (_participation!=0,"Birthday: Sorry, nobody have done any contributions for your present..");
        _participation=0;
        payable(msg.sender).sendValue(address(this).balance);
}

function isFriends(address account) public view returns (bool) {
        return _friends[account];
    }
    
function _deposit(address sender, uint256 amount) private {
        _balances[sender] += amount;
        emit Deposited(sender, amount);
    }
    
function _humanDateToEpochTime(uint256 year,uint256 month, uint256 day)private pure returns (uint256){
        require(year>1970 && month<=12&&day<=31,"Birthday: wrong input in the date");
        return ((year - 1970)*31556926)+(2629743*(month-1)+(86400*(day-1))+36000);
    }
    
}