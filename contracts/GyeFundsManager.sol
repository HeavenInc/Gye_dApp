pragma solidity ^0.4.24;

/** Open Zepplin Libraries */
/** Note: Require in Remix for testing*/
import "zeppelin-solidity/contracts/math/SafeMath.sol";
import "zeppelin-solidity/contracts/lifecycle/Pausable.sol";

contract GyeFundsManager is Pausable {

    event _depositAmount(address participantAddress, uint participantAmount);
    event _addGyeMember(address gyeMemberAddress);
    event _withdrawValue(address requestAddress, uint requestValue);

    mapping (address => bool) public gyeMembers;
    mapping (address => uint) public gyeAccounts;

    constructor() public {
    }

    /**
       * @dev Procedure for depositing funds to the gye participant account
       * @param gyeParticipant Address of the participant who will deposit funds
       */
    function depositFunds(address gyeParticipant) payable whenNotPaused public {
        require(gyeMembers[gyeParticipant], "Depositer contract address NOT found");
        require(gyeParticipant != address(0), "Invalid address");
        require(msg.value != 0, "Invalid values"); //need to update what amount value

        emit _depositAmount(address gyeParticipant, msg.value);
        gyeAccounts[gyeParticipant] += msg.value;
    }

    /**
       * @dev Procedure for associating gye contract with gyeManager(?)
       * @param gyeContractAdd Gye contract address
       */
    function addMember(address gyeContractAdd) onlyOwner public { //neet to change onlyOwner to onlyManager
        require(gyeContractAdd != address(0), "Invaild address");

        emit _addGyeMember(address gyeContractAdd);
        gyeMembers[gyeContractAdd] = true;
    }

    /**
       * @dev Procedure for withdraw amount
       * @param value Value of the amounts owner requires to pull out
       */
    function withdrawFunds(uint value) public {
        require(gyeAccounts[msg.sender] > 0, "Accounts is empty");
        require(value > 0, "Invaild values"); //need to change 0 to Amount

        emit _withdrawValue(msg.sender, uint value);
        gyeMembers[msg.sender] -= value;
        msg.sender.transfer(value);
    }
}
