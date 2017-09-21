const OCRandomContract = artifacts.require('./OCRandomContract.sol')
const OCLotteryContract = artifacts.require('./OCLotteryContract.sol')
const OCMarket = artifacts.require('./OCMarket.sol')
const OCLPublicAddress = artifacts.require('./OCLPublicAddress.sol')
const ThirdPartyVoter = artifacts.require('./ThirdPartyVoter.sol')

contract('OCRandomContract', function (accounts) {

  console.log('start')
  /*步骤1
  1.truffle compile
  2.truffle migrate
  3.OCLPublicAddress的以太坊地址写到各个合约需要公用地址的.sol文件中
  步骤1---end */

  /*步骤2--start---
   将各个合约地址注册到OCLPublicAddress中
  */
  var OCLPublicAddressAbstraction = OCLPublicAddress.at('0x8cb94b79cb4ea51e228b661cd38f81484d2632da')


  var addrOCLotteryContract = '0x8ae305bda0ec07c8a38ff7bf4a85f85654591f5b'
  var addrOCMarket = '0x099825d6ad61c97dfbbcc51f7cfcb5bd35305526'
  var addrOCRandomContract = '0xa72fc9ed54fbb381cf493aeec6f2ea1315925438'
  var addrThirdPartyVoter = '0x5c6565b4920eb53d316568dd63bab5a9b99d26ee'
  if(true) {
    OCLPublicAddressAbstraction.putServerAddress('OCLotteryContract', addrOCLotteryContract)
    OCLPublicAddressAbstraction.putServerAddress('OCMarket', addrOCMarket)
    OCLPublicAddressAbstraction.putServerAddress('OCRandomContract', addrOCRandomContract)
    OCLPublicAddressAbstraction.putServerAddress('ThirdPartyVoter', addrThirdPartyVoter)
  }
  /*步骤2---end*/

  if (false) {
    var OCLotteryContractAbstraction = OCLotteryContract.at(addrOCLotteryContract)

    /*步骤3
      1.用钱包转1个eth到OCLotteryContract
    */
    /*步骤3---end---
     */
    var OCMarketAbstraction = OCMarket.at(addrOCMarket)
    OCMarketAbstraction.logaddresslength.call().then(function (result) {
      console.log('OCMarketAbstraction:' + result)
    })

    /*步骤4
    账号0x3175ed2090ae165fca3434fb363f40e31a2a6b4c开始参与抽奖
    1.eth.sendTransaction({from:"0x3175ed2090ae165fca3434fb363f40e31a2a6b4c", to:"0x541123f25fc3ca42c1418f9bd374e2fa08d7c33b", gas:1000000, 'gasPrice': web3.toWei(0.00000001, 'ether'), "value": "123456000000000000"})
    2.一直到有5个用户则形成一组，会自动进入随机数请求环节
    * */

    OCLotteryContractAbstraction.loglength.call().then(function (result) {
      console.log('OCLotteryContractAbstraction log count:')
      console.log(result)
      for (i = 0; i < result; i++) {
        OCLotteryContractAbstraction.logmyself.call(i).then(function (strResult) {
          console.log('OCLotteryContractAbstraction:' + strResult)
        })
      }
    })

    /*步骤6
    查看抽奖结果
    */
    var OCMarketAbstraction = OCMarket.at(addrOCMarket)
    // OCMarketAbstraction.logaddressmyself.call(0).then(function (result) {
    //   console.log('OCMarketAbstraction:' + result)
    // })

    var OCRandomContractAbstraction = OCRandomContract.at(addrOCRandomContract)

    OCRandomContractAbstraction.loglength.call().then(function (result) {
      console.log('OCRandomContractAbstraction log count:')
      console.log(result)
      for (i = 0; i < result; i++) {
        OCRandomContractAbstraction.logmyself.call(i).then(function (strResult) {
          console.log('OCRandomContractAbstraction_logmyself:' + strResult)
        })
      }
    })

    OCRandomContractAbstraction.logaddresslength.call().then(function (result) {
      console.log('OCRandomContractAbstraction logaddressmyself count:')
      console.log(result)
      for (i = 0; i < result; i++) {
        OCRandomContractAbstraction.logaddressmyself.call(i).then(function (strResult) {
          console.log('OCRandomContractAbstraction_logsbytes32myself:' + strResult)
        })
      }
    })
    /*步骤6---end*/

  } else {
    /*步骤5
    1.第三发合约ThirdPartyVoter调用随机数合约OCRandomContract开始提供种子和随机数
    2.随机数合约在拥有3个匹配随机源后，开始回调抽奖合约，并提供相应的随机数
    下面例子没有切换账户，是为了便于测试，否则测试工作量很大，正式环境需要不同的用户提供随机种子，每个任务一个用户只能提供一次正确的种子，但可以随便攻击，没有关系
    */
    var ThirdPartyVoterAbstraction = ThirdPartyVoter.at(addrThirdPartyVoter)

    ThirdPartyVoterAbstraction.sendOnlyHash('123456')
    ThirdPartyVoterAbstraction.sendOnlyHash('1234567')
    ThirdPartyVoterAbstraction.sendOnlyHash('12345678')

    ThirdPartyVoterAbstraction.sendSeedAndHash('123456')
    ThirdPartyVoterAbstraction.sendSeedAndHash('1234567')
    ThirdPartyVoterAbstraction.sendSeedAndHash('12345678')
    /*步骤5---end---*/
  }
})
