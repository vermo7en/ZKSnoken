pragma solidity >=0.4.21 <0.6.0;

import "./Verifier.sol";
import "./ERC721Mintable.sol";

// calls to the zokrates generated solidity contract <Verifier> or <renamedVerifier>
// defines another contract named SolnSquareVerifier that inherits from your ERC721Mintable class
contract SolnSquareVerifier is CustomERC721 {

    Verifier verifierContract;

    constructor(address verifierAddress,  string memory name, string memory symbol) CustomERC721(name, symbol) public{
        verifierContract = Verifier(verifierAddress);
    }

    struct Solution {
        uint256 index;
        address senderAddress;
    }

    uint256 solutionCounter = 1;

    // stores unique solutions submitted
    mapping(bytes32 => Solution) private solutionsSubmitted;

    event SolutionAdded(bytes32 solutionKey, address solutionAddress);


    // function to add the solutions to the array and emit event
    function addSolution(uint[2] memory a, uint[2][2] memory b, uint[2] memory c, uint[2] memory input) public {
        bytes32 key = keccak256(abi.encodePacked(a, b, c, input));

        require(solutionsSubmitted[key].index == 0, "Solution already exsits");
        solutionsSubmitted[key] = Solution({index: solutionCounter, senderAddress: msg.sender});
        solutionCounter += 1;

        emit SolutionAdded(key, msg.sender);
    }

    // function to mint new NFT only after the solution has been verified
    // makes sure the solution is unique
    // makes sure you handle metadata as well as tokenSupply
    function mintWithVerification(address to, uint256 tokenId, uint[2] memory a, uint[2][2] memory b, uint[2] memory c, uint[2] memory input) public{
        require(verifierContract.verifyTx(a, b, c, input), "Incorrect solution");
        addSolution(a, b, c, input);
        super.mint(to, tokenId);
    }
}














