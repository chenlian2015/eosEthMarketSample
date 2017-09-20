var OCLPublicAddress = artifacts.require("./OCLPublicAddress.sol");
var OCRandomContract = artifacts.require('./OCRandomContract.sol')
var OCMarket = artifacts.require('./OCMarket.sol')
var OCLotteryContract = artifacts.require('./OCLotteryContract.sol')
var ThirdPartyVoter = artifacts.require('./ThirdPartyVoter.sol')

module.exports = function(deployer) {
  deployer.deploy(OCLPublicAddress);
  deployer.deploy(OCLotteryContract);
  deployer.deploy(OCMarket);
  deployer.deploy(OCRandomContract);
  deployer.deploy(ThirdPartyVoter);
};