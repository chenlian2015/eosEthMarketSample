var OLPublicAddress = artifacts.require("./OLPublicAddress.sol")
var OLRandomContract = artifacts.require('./OLRandomContract.sol')
var OCMarket = artifacts.require('./OLMarket.sol')
var OCLotteryContract = artifacts.require('./OLLotteryContract.sol')
var ThirdPartyVoter = artifacts.require('./ThirdPartyVoter.sol')

module.exports = function(deployer) {
   deployer.deploy(OLPublicAddress);
   deployer.deploy(OCLotteryContract);
   deployer.deploy(OCMarket);
   deployer.deploy(OLRandomContract);
   deployer.deploy(ThirdPartyVoter);
};