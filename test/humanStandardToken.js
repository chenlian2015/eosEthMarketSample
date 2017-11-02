const OLBlackWhiteListInterface = artifacts.require('./OLBlackWhiteListInterface.sol')
const OLFeeManagerInterface = artifacts.require('./OLFeeManagerInterface.sol')
const OLLogToolInterface = artifacts.require('./OLLogToolInterface.sol')
const OLLotteryContract = artifacts.require('./OLLotteryContract.sol')
const OLMarketServerInterface = artifacts.require('./OLMarketServerInterface.sol')
const OLPublicAddress = artifacts.require('./OLPublicAddress.sol')
const OLRandomContractInterface = artifacts.require('./OLRandomContractInterface.sol')
const OLSuperManager = artifacts.require('./OLSuperManager.sol')
const StantardTokenInterface = artifacts.require('./StantardTokenInterface.sol')


const OLTestSynatax = artifacts.require('./OLTestSynatax.sol')
const ThirdPartyVoter = artifacts.require('./ThirdPartyVoter.sol')

contract('OLTestSynatax', function (accounts) {

    console.log('start')
    if (false) {
        var olTestSynatax = OLTestSynatax.at('0x541d574d80f1f7c7e219f35ecb2394748987c75c');
        olTestSynatax.addLog.call("ss","wr").then(function (result) {
            console.log(result);
        });
        return;
    }



    var addrOLPublicAddressInterface = '0xde7156c2940a45723b17352e4b5f0e9e5d8e52de'

    var addrOracleChainToken = '0x25fe09f3689b0c3fcc46e6df9196bc1baa0b3973';
    var addrOLLogToolInterface = '0x333cc2b21b2172573d0a5547c2f23f8d940c2579'
    var addrOLMarketServerInterface = '0x3f751a598f4c68d0a918d62688a1814d7ba355d0'

    var addrOLBlackWhiteListInterface = '0x785f3dc8dac8567fe4bce8c001eebec667a1c0d1'
    var addrOLFeeManagerInterface = '0x2ea6f5a9f239ef864844f9b9d119f3b6c56d48fd'
    var addrOLLotteryContract = '0x1980d47bb029dd205107f07f0ecb3ac42c82a678'

    var addrOLRandomContractInterface = '0xc490b57dc8b1089639ea1bc216af2f1bc65e7f14'


    var olLogToolInterface = OLLogToolInterface.at(addrOLLogToolInterface)

    /*步骤1
    1.truffle compile
    2.truffle migrate
    3.OLPublicAddress的以太坊地址写到各个合约需要公用地址的.sol文件中
    步骤1---end */

    /*步骤2--start---
     将各个合约地址注册到OLPublicAddress中
    */

   var OLPublicAddressAbstraction =  OLPublicAddress.at(addrOLPublicAddressInterface);

    if (true) {

      olLogToolInterface.addLog("OLSuperManager", "sss");
      OLPublicAddressAbstraction.addLog("OLSuperManager", "sss");
      OLPublicAddressAbstraction.getServerStatus('OLSuperManager')
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
