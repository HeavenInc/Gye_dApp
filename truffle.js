module.exports = {
    networks: {
     development: {
     host: "localhost",
     port: 9545, //ganache: 7545, truffle develop: 9545
     network_id: "*" // ganache: 5777
     }
    },
    mocha: {
     reporter: 'eth-gas-reporter',
     reporterOptions : {
      currency: 'KRW',
      gasPrice: 21
     }
    }
};
