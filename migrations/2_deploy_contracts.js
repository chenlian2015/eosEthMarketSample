// var OLPublicAddress = artifacts.require("./OLPublicAddress.sol")
// var OLRandomContract = artifacts.require('./OLRandomContract.sol')
// var OCMarket = artifacts.require('./OLMarket.sol')
// var OCLotteryContract = artifacts.require('./OLLotteryContract.sol')
var OLTestSynatax = artifacts.require('./OLTestSynatax.sol')
var OLTestSynataxBB = artifacts.require('./OLTestSynataxBB.sol')
module.exports = function(deployer) {
   deployer.deploy(OLTestSynatax);
    deployer.deploy(OLTestSynataxBB);
   // deployer.deploy(OCLotteryContract);
   // deployer.deploy(OCMarket);
   // deployer.deploy(OLRandomContract);
   // deployer.deploy(ThirdPartyVoter);
};