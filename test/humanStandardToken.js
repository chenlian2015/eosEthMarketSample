const OLBlackWhiteListInterface = artifacts.require('./OLBlackWhiteListInterface.sol')
const OLFeeManagerInterface = artifacts.require('./OLFeeManagerInterface.sol')
const OLLogToolInterface = artifacts.require('./OLLogToolInterface.sol')
const OLLotteryContract = artifacts.require('./OLLotteryContract.sol')
const OLMarketServerInterface = artifacts.require('./OLMarketServerInterface.sol')
const OLPublicAddressInterface = artifacts.require('./OLPublicAddress.sol')
const OLRandomContractInterface = artifacts.require('./OLRandomContractInterface.sol')
const OLSuperManager = artifacts.require('./OLSuperManager.sol')
const StantardTokenInterface = artifacts.require('./StantardTokenInterface.sol')


const OLTestSynatax = artifacts.require('./OLTestSynatax.sol')
const ThirdPartyVoter = artifacts.require('./ThirdPartyVoter.sol')

contract('OLTestSynatax', function (accounts) {

    console.log('start')
    if (false) {
        var olTestSynatax = OLTestSynatax.at('0x3cc018497a726215ca555093888ffb349c84442a');
        olTestSynatax.test.call().then(function (result) {
            console.log(result);
        });
        return;
    }


    var addrOLSuperManager = '0xac461f5c3682b9bbe9255c1c61f3ba785ab54a25'
    var addrOLPublicAddressInterface = '0x58b65baf8c5f474fa8395fecbb1f439c99d4c0b9'

    var addrOracleChainToken = '0xf0afc140732e95c19ac6e5f7b76183a00f8985a3';
    var addrOLLogToolInterface = '0x87dcbb9cf8933806b59ac496eebf99fa1b1e0561'
    var addrOLMarketServerInterface = '0xc9084278bace8c4c973707b1b274b47b0b47f118'

    var addrOLBlackWhiteListInterface = '0x63ecf4a53ac72d12072dce7b17604ed0f00a6696'
    var addrOLFeeManagerInterface = '0xbee5bcc887a5819d8d2f34f371b824392560d35d'
    var addrOLLotteryContract = '0x1980d47bb029dd205107f07f0ecb3ac42c82a678'

    var addrOLRandomContractInterface = '0x5079dcabbddcb17ecab61c9fcfced0ff40c5434e'


    var OLPublicAddressAbstraction = OLPublicAddressInterface.at(addrOLPublicAddressInterface)
    /*步骤1
    1.truffle compile
    2.truffle migrate
    3.OLPublicAddress的以太坊地址写到各个合约需要公用地址的.sol文件中
    步骤1---end */

    /*步骤2--start---
     将各个合约地址注册到OLPublicAddress中
    */


    if (true) {

        OLPublicAddressAbstraction.getServerAddress("OLSuperManager");
        //OLPublicAddressAbstraction.putServerAddress('OLSuperManager', addrOLSuperManager,1)
        // OLPublicAddressAbstraction.putServerAddress('OLPublicAddress', addrOLPublicAddressInterface,1)
        //
        // OLPublicAddressAbstraction.putServerAddress('OLLogTool', addrOLLogToolInterface,1)
        // OLPublicAddressAbstraction.putServerAddress('OracleChainToken', addrOracleChainToken,1)
        // OLPublicAddressAbstraction.putServerAddress('OLMarket', addrOLMarketServerInterface,1)
        // OLPublicAddressAbstraction.putServerAddress('OLBlackWhiteList', addrOLBlackWhiteListInterface,1)
        // OLPublicAddressAbstraction.putServerAddress('OLFeeManager', addrOLFeeManagerInterface,1)
        // OLPublicAddressAbstraction.putServerAddress('OLLotteryContract', addrOLLotteryContract,1)
        // OLPublicAddressAbstraction.putServerAddress('OLRandomContract', addrOLRandomContractInterface,1)
    }

    //充值步骤
    if (false) {

    }

    //乐透参与调用
    if (false) {

    }

    //随机数种子调用
    if (false) {
        var ThirdPartyVoterAbstraction = ThirdPartyVoter.at(addrThirdPartyVoter)

        ThirdPartyVoterAbstraction.sendOnlyHash('123456')
        ThirdPartyVoterAbstraction.sendOnlyHash('1234567')
        ThirdPartyVoterAbstraction.sendOnlyHash('12345678')

        ThirdPartyVoterAbstraction.sendSeedAndHash('123456')
        ThirdPartyVoterAbstraction.sendSeedAndHash('1234567')
        ThirdPartyVoterAbstraction.sendSeedAndHash('12345678')
        /*步骤5---end---*/
    }

    /*日志查看步骤
    */
    if (true) {

        var logTool = OLLogToolInterface.at(addrOLLogToolInterface)

            logTool.length.call().then(function (result) {
            console.log('OCLotteryContractAbstraction log count:')
            console.log(result)
            for (i = 0; i < result; i++) {
              logTool.getAt.call(i).then(function (strResult) {
                    console.log('OCLotteryContractAbstraction:' + strResult)
                })
            }
        })
    }
})
