const Verifier = artifacts.require('Verifier');
const proofData = require('./proof');

contract('TestSquareVerifier', accounts => {

    const proof = proofData.proof;
    const correctProofInputs = proofData.inputs;
    const incorrectProofInputs = [0, 1];

    describe('Setup', function () {
        beforeEach(async function () {
            this.contract = await Verifier.new({from: accounts[0]});
        });

        it('Tests verification with correct proof', async function () {
            let result = await this.contract.verifyTx.call(proof.a, proof.b, proof.c, correctProofInputs, {from: accounts[0]});
            assert.equal(result, true, "Incorrect proof");
        });

        it('Tests verification with incorrect proof', async function () {
            let result = await this.contract.verifyTx.call(proof.a, proof.b, proof.c, incorrectProofInputs, {from: accounts[0]});
            assert.equal(result, false, "Correct proof");
        });
    });
});
