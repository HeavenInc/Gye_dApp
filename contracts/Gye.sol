pragma solidity ^0.4.24;

/** Open Zepplin Libraries */
/** Note: Require in Remix for testing*/
import "github.com/OpenZeppelin/zeppelin-solidity/contracts/math/SafeMath.sol";
import "github.com/OpenZeppelin/zeppelin-solidity/contracts/lifecycle/Pausable.sol";

contract Gye is Pausable {
    using SafeMath for uint256;

    enum Status {INVALID, SETUP, REQUESTED, PAID}
    Status gyeStatus;

    struct GyeParams {
        address gyeOwner;
        //byte32
    }

    struct Funds{
        uint amount; //Amount deposited by the paticipant who can is withdrawable
        uint totalAmount; //Amount which is all paticipant paid all amount
        address holdAddress; // Address of the contract having amount parked temporally - check more
    }
}
