const ERC20 = artifacts.require("ERC20");

module.exports = function(deployer, network, accounts) {
  deployer.deploy(ERC20).then(
    function(instance) {
      instance.mint({account:accounts[0], amount: 100} );
    }
  );
};
