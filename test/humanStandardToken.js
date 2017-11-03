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
  if (0) {
    var olTestSynatax = OLTestSynatax.at('0xbd1bf35bf582ad0aab73b2cc640117451cd93acc')
    olTestSynatax.addLog.call('ss', 'wr').then(function (result) {
      console.log(result)
    })
    return
  }

  var addrOLPublicAddressInterface = '0xc410c30537903e5931be17af4482dc84b5f75cb7'

  var addrOracleChainToken = '0x510898c8c054474f97118a04e714b910ba17f72f'
  var addrOLLogToolInterface = '0x47eb902d7667033cfac640011cfaa129f0abcd46'
  var addrOLMarketServerInterface = '0x66919b31b17fd80ad876f918f0b8ec25865ad885'

  var addrOLBlackWhiteListInterface = '0x926c06af60ed06ebb00bf75e3759bd6db3eaa94c'
  var addrOLFeeManagerInterface = '0x821d59e3b3e63b053fca1b4b4eddb433cbe55a22'
  var addrOLLotteryContract = '0x7586e387a747c80dc92e0d10a6256d637cc01baf'

  var addrOLRandomContractInterface = '0x35cf82599ad7be5284500a94a1c3ce605fcceb4b'

  var olLogToolInterface = OLLogToolInterface.at(addrOLLogToolInterface)

  /*步骤1
  1.truffle compile
  2.truffle migrate
  3.OLPublicAddress的以太坊地址写到各个合约需要公用地址的.sol文件中
  步骤1---end */

  /*步骤2--start---
   将各个合约地址注册到OLPublicAddress中
  */
  var logTool = OLLogToolInterface.at(addrOLLogToolInterface)
  if (1) {
    logTool.clear()
  }

  var OLPublicAddressAbstraction = OLPublicAddress.at(addrOLPublicAddressInterface)
  if (0) {

    OLPublicAddressAbstraction.putServerAddress('OLSuperManager', addrOLMarketServerInterface, 1)
    OLPublicAddressAbstraction.putServerAddress('OLPublicAddress', addrOLPublicAddressInterface, 1)
    OLPublicAddressAbstraction.putServerAddress('OLLogTool', addrOLLogToolInterface, 1)
    OLPublicAddressAbstraction.putServerAddress('OracleChainToken', addrOracleChainToken, 1)
    OLPublicAddressAbstraction.putServerAddress('OLMarket', addrOLMarketServerInterface, 1)
    OLPublicAddressAbstraction.putServerAddress('OLBlackWhiteList', addrOLBlackWhiteListInterface, 1)
    OLPublicAddressAbstraction.putServerAddress('OLFeeManager', addrOLFeeManagerInterface, 1)
    OLPublicAddressAbstraction.putServerAddress('OLLotteryContract', addrOLLotteryContract, 1)
    OLPublicAddressAbstraction.putServerAddress('OLRandomContract', addrOLRandomContractInterface, 1)

    OLPublicAddressAbstraction.getServerAddress.call('OLSuperManager').then(function (result) {
      console.log(result)
    })
  }

  if (1) {
    var olFeeManager = OLFeeManagerInterface.at(addrOLFeeManagerInterface)
    olFeeManager.setFee('OLRandomContract', 18)//单位oct
    olFeeManager.setFeedBackFee('OLRandomContract', 1)//单位oct

    olFeeManager.getFee.call('OLRandomContract').then(function (result) {
      console.log(result)
    })
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
  if (1) {
    logTool.length.call().then(function (result) {
      console.log('*****Log ')
      console.log('*****Log ')
      console.log('*****Log count:')
      console.log(result)

      for (i = 0; i < result; i++) {

        logTool.getTagAt.call(i).then(function (strResult) {
          console.log('Tag:' + strResult)
        })

        logTool.getContentAt.call(i).then(function (strResult) {
          console.log('Content:' + strResult)
        })

      }
    })
  }
})
