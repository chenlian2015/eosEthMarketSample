const OLBlackWhiteListInterface = artifacts.require('./OLBlackWhiteListInterface.sol')
const OLFeeManagerInterface = artifacts.require('./OLFeeManagerInterface.sol')
const OLLogToolInterface = artifacts.require('./OLLogToolInterface.sol')
const OLLotteryContract = artifacts.require('./OLLotteryContract.sol')
const OLMarketServerInterface = artifacts.require('./OLMarketServerInterface.sol')
const OLPublicAddress = artifacts.require('./OLPublicAddress.sol')
const OLRandomContractInterface = artifacts.require('./OLRandomContractInterface.sol')
const OLRandomContract = artifacts.require('./OLRandomContract.sol')
const OLSuperManager = artifacts.require('./OLSuperManager.sol')
const StantardTokenInterface = artifacts.require('./StantardTokenInterface.sol')

const OLTestSynatax = artifacts.require('./OLTestSynatax.sol')
const ThirdPartyVoter = artifacts.require('./ThirdPartyVoter.sol')

contract('OLTestSynatax', function (accounts) {

  console.log('start')
  if (0) {
    var olTestSynatax = OLTestSynatax.at('0xb0c798a82a65b3c7e27a9c586eb45143676eaf39')
    olTestSynatax.addLog.call('ss', 'wr').then(function (result) {
      console.log(result)
    })
    return
  }

  var addrSuperManager = '0x3f50221826b61bb2861f9e8ea37f9685e441fc0a'
  var addrOLPublicAddressInterface = '0xc8896ff714e470d4a8fb9de2cb87cd08876af014'

  var addrOLMarketServerInterface = '0xa584c7a08b9e99ad169ae83d69b467976398398e'
  var addrOLBlackWhiteListInterface = '0x046e89287f22b629a1157199543b7b7847e3d0f0'
  var addrOLFeeManagerInterface = '0x283ac3bf42c9f360819051b1db35600ef3b5b928'
  var addrOLLogToolInterface = '0x0703cb53b737102f06fe2304a800ad03dda4b893'
  var addrOLRandomContractInterface = '0xec91b9aa0686d26e62478578d8af8ce71de45de4'
  var addrOracleChainToken = '0x87d1acf8e7dd4b889fa902cb5ad7418bdb239b53'
  var addrOLLotteryContract = '0x664a8b4d646fe9d7698ba8b9945943c723b9b6bf'
  var addrThirdPartyVoter = '0x5b2dbc3da8224870c958523cf0e01a9d8cc97d70'

  /*步骤1
  1.truffle compile
  2.truffle migrate
  3.OLPublicAddress的以太坊地址写到各个合约需要公用地址的.sol文件中
  步骤1---end */

  /*步骤2--start---
   将各个合约地址注册到OLPublicAddress中
  */
  var olLogToolInterface = OLLogToolInterface.at(addrOLLogToolInterface)
  var logTool = OLLogToolInterface.at(addrOLLogToolInterface)
  if (0) {
    logTool.clear()
    return
  }

  var OLPublicAddressAbstraction = OLPublicAddress.at(addrOLPublicAddressInterface)
  if (0) {

    OLPublicAddressAbstraction.putServerAddress('OLSuperManager', addrSuperManager, 1)
    OLPublicAddressAbstraction.putServerAddress('OLPublicAddress', addrOLPublicAddressInterface, 1)
    OLPublicAddressAbstraction.putServerAddress('OLLogTool', addrOLLogToolInterface, 1)
    OLPublicAddressAbstraction.putServerAddress('OracleChainToken', addrOracleChainToken, 1)
    OLPublicAddressAbstraction.putServerAddress('OLMarket', addrOLMarketServerInterface, 1)
    OLPublicAddressAbstraction.putServerAddress('OLBlackWhiteList', addrOLBlackWhiteListInterface, 1)
    OLPublicAddressAbstraction.putServerAddress('OLFeeManager', addrOLFeeManagerInterface, 1)
    OLPublicAddressAbstraction.putServerAddress('OLLotteryContract', addrOLLotteryContract, 1)
    OLPublicAddressAbstraction.putServerAddress('OLRandomContract', addrOLRandomContractInterface, 1)

    // OLPublicAddressAbstraction.putServerAddress.call('OLRandomContract', addrOLRandomContractInterface, 1).then(function (result) {
    //   console.log('putServerAddress：')
    //   console.log(result)
    // })

    OLPublicAddressAbstraction.getServerAddress.call('OLRandomContract').then(function (result) {
      console.log('getServerAddress：')
      console.log(result)
    })

    // OLPublicAddressAbstraction.getServerStatus.call('OLRandomContract').then(function (result) {
    //   console.log('getServerStatus:')
    //   console.log(result)
    // })
    console.log('putServerAddress* ok')
  }

  if (0) {

    var olFeeManager = OLFeeManagerInterface.at(addrOLFeeManagerInterface)
    // olFeeManager.setFee.call('OLRandomContract', 3).then(function (result) {
    //   console.log('setFee:')
    //   console.log(result)
    // })
    //单位oct

    olFeeManager.setFee('OLRandomContract', 3)//单位oct
    olFeeManager.setFeedBackFee('OLRandomContract', 1)//单位oct
    //
    olFeeManager.getFee.call('OLRandomContract').then(function (result) {
      console.log('getFee:')
      console.log(result)
    })

    olFeeManager.getFeedBackFeeAward.call('OLRandomContract').then(function (result) {
      console.log('getFeedBackFeeAward:')
      console.log(result)
    })

  }

  var addrUser = '0x73f5f3d7c5c3159594b3087c1f0347049ff11028'
  var addrChargerOrMarket = '0x1e983e02724ab9a99c43fd9a5eb4c9da538b5c05'

  //充值步骤
  if (0) {

    var oStantardTokenInterface = StantardTokenInterface.at(addrOracleChainToken)
    oStantardTokenInterface.chargeFee(addrUser, addrChargerOrMarket, 1001)

    oStantardTokenInterface.allowance.call(addrUser, addrChargerOrMarket).then(function (result) {
      console.log('allowance:')
      console.log(result)
    })

    oStantardTokenInterface.balanceOf.call(addrUser).then(function (result) {
      console.log('balanceOf:')
      console.log(result)
    })
  }

  //乐透参与调用
  if (0) {

    var olMarketServerInterface = OLMarketServerInterface.at(addrOLMarketServerInterface)

    olMarketServerInterface.callServer('OLRandomContract', 1)
    olMarketServerInterface.callServer.call('OLRandomContract', 1).then(function (result) {
      console.log('OLRandomContract:')
      console.log(result)
    })
  }

  if (0) {
    var olRandomContract = OLRandomContract.at(addrOLRandomContractInterface)

    olRandomContract.requestOneUUID(addrOLLotteryContract, 1)
    olRandomContract.requestOneUUID.call(addrOLLotteryContract, 1).then(function (result) {
      console.log('requestOneUUID:')
      console.log(result)
    })
  }

  //随机数种子调用
  if (0) {
    var ThirdPartyVoterAbstraction = ThirdPartyVoter.at(addrThirdPartyVoter)


    //ThirdPartyVoterAbstraction.sendOnlyHash('123456')
    //ThirdPartyVoterAbstraction.sendOnlyHash('1234567')
    //ThirdPartyVoterAbstraction.sendOnlyHash('12345678')

    // ThirdPartyVoterAbstraction.sendSeedAndHash.call('123456').then(function (result) {
    //   console.log('sendSeedAndHash:')
    //   console.log(result)
    // })
    //ThirdPartyVoterAbstraction.sendSeedAndHash('123456')
     ThirdPartyVoterAbstraction.sendSeedAndHash('1234567')
     ThirdPartyVoterAbstraction.sendSeedAndHash('12345678')
    /*步骤5---end---*/
  }

  /*日志查看步骤
  */
  if (1) {
    logTool.length.call().then(function (result) {
      console.log('***** ')
      console.log('***** ')
      console.log('*****Log count:')
      console.log(result)

      for (i = 0; i < result; i++) {

        logTool.getContentAt.call(i).then(function (strResult) {
          console.log('Content:' + strResult)
        })

         logTool.getTagAt.call(i).then(function (strResult) {
         //  console.log('Tag:' + strResult)
         })

      }
    })
  }
})
