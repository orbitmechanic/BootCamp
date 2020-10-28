const ERC20 = artifacts.require("ERC20");

module.exports = function(deployer, network, accounts) {
  deployer.deploy(ERC20).then(
    (instance) => {
      instance.mint(accounts[0], 100);
    }
  );
};
