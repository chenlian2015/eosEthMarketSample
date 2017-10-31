const OLBlackWhiteListInterface = artifacts.require('./OLBlackWhiteListInterface.sol')
const OLFeeManagerInterface = artifacts.require('./OLFeeManagerInterface.sol')
const OLLogToolInterface = artifacts.require('./OLLogToolInterface.sol')
const OLLotteryContract = artifacts.require('./OLLotteryContract.sol')
const OLMarketServerInterface = artifacts.require('./OLMarketServerInterface.sol')
const OLPublicAddressInterface = artifacts.require('./OLPublicAddressInterface.sol')
const OLRandomContractInterface = artifacts.require('./OLRandomContractInterface.sol')
const OLSuperManager = artifacts.require('./OLSuperManager.sol')
const StantardTokenInterface = artifacts.require('./StantardTokenInterface.sol')


const OLTestSynatax = artifacts.require('./OLTestSynatax.sol')
const ThirdPartyVoter = artifacts.require('./ThirdPartyVoter.sol')

contract('OLTestSynatax', function (accounts) {

    console.log('start')
    if (true) {
        var olTestSynatax = OLTestSynatax.at('0x3cc018497a726215ca555093888ffb349c84442a');
        olTestSynatax.test.call().then(function (result) {
            console.log(result);
        });
        return;
    }


    var OLSuperManager = '0x5c6565b4920eb53d316568dd63bab5a9b99d26ee'
    var OLPublicAddressInterface = '0x5c6565b4920eb53d316568dd63bab5a9b99d26ee'

    var OLLogToolInterface = '0xa72fc9ed54fbb381cf493aeec6f2ea1315925438'
    var StantardTokenInterface = '0x5c6565b4920eb53d316568dd63bab5a9b99d26ee'
    var OLMarketServerInterface = '0x5c6565b4920eb53d316568dd63bab5a9b99d26ee'

    var OLBlackWhiteListInterface = '0x8ae305bda0ec07c8a38ff7bf4a85f85654591f5b'
    var OLFeeManagerInterface = '0x099825d6ad61c97dfbbcc51f7cfcb5bd35305526'
    var OLLotteryContract = '0x5c6565b4920eb53d316568dd63bab5a9b99d26ee'

    var OLRandomContractInterface = '0x5c6565b4920eb53d316568dd63bab5a9b99d26ee'


    var OLPublicAddressAbstraction = OLPublicAddress.at(OLPublicAddressInterface)
    /*步骤1
    1.truffle compile
    2.truffle migrate
    3.OLPublicAddress的以太坊地址写到各个合约需要公用地址的.sol文件中
    步骤1---end */

    /*步骤2--start---
     将各个合约地址注册到OLPublicAddress中
    */


    if (true) {

        OLPublicAddressAbstraction.putServerAddress('OLSuperManager', OLSuperManager)
        OLPublicAddressAbstraction.putServerAddress('OLPublicAddress', OLPublicAddressInterface)

        OLPublicAddressAbstraction.putServerAddress('OLLogTool', OLLogToolInterface)
        OLPublicAddressAbstraction.putServerAddress('OracleChainToken', StantardTokenInterface)
        OLPublicAddressAbstraction.putServerAddress('OLMarket', OLMarketServerInterface)
        OLPublicAddressAbstraction.putServerAddress('OLBlackWhiteList', OLBlackWhiteListInterface)
        OLPublicAddressAbstraction.putServerAddress('OLFeeManager', OLFeeManagerInterface)
        OLPublicAddressAbstraction.putServerAddress('OLLotteryContract', OLLotteryContract)
        OLPublicAddressAbstraction.putServerAddress('OLRandomContract', OLRandomContractInterface)
    }

    //充值步骤
    if (true) {

    }

    //乐透参与调用
    if (true) {

    }

    //随机数种子调用
    if (true) {
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
    if (false) {
        var OLLogToolInterface
    .
        sol = OLLogToolInterface.sol.at(addrOLLogToolInterface)

        OCLotteryContractAbstraction.loglength.call().then(function (result) {
            console.log('OCLotteryContractAbstraction log count:')
            console.log(result)
            for (i = 0; i < result; i++) {
                OCLotteryContractAbstraction.logmyself.call(i).then(function (strResult) {
                    console.log('OCLotteryContractAbstraction:' + strResult)
                })
            }
        })
    }
})
