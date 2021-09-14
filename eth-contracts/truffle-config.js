const HDWallet = require("truffle-hdwallet-provider");
const INFURA_KEY = "<Insert key here>";
const fs = require('fs');

const MNEMONIC = "<Insert mnemonic here>";

module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",    
      port: 8545,            
      network_id: "*",
     },
    //   rinkeby: {
    //       provider:  new HDWallet(MNEMONIC,`https://rinkeby.infura.io/v3/${INFURA_KEY}`),
    //       network_id: "4",
    //       gas: 4500000,
    //       from: "0x9674c509e00Db0b98370C76b21C40493C0D23A6a",
    //       confirmations: 2
    //   }
     },
};
