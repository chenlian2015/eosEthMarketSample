const OCRandomContract = artifacts.require('./OCRandomContract.sol')
const OCLotteryContract = artifacts.require('./OCLotteryContract.sol')
const OCMarket = artifacts.require('./OCMarket.sol')
const OCLPublicAddress = artifacts.require("./OCLPublicAddress.sol")
const ThirdPartyVoter = artifacts.require("./ThirdPartyVoter.sol")


contract('OCRandomContract', function (accounts) {

  console.log('start')


  var OCLPublicAddressAbstraction = OCLPublicAddress.at("0x002cacf5ee5d350d9c903435f6670650df97777e");

   OCLPublicAddressAbstraction.putServerAddress("OCLotteryContract", "0xa499c5feafa59bbea7f66328c64c947f71a6c7cc");
   OCLPublicAddressAbstraction.putServerAddress("OCMarket", "0x4d11af90893881591a8dfb6cff078fb89fba0533");
   OCLPublicAddressAbstraction.putServerAddress("OCRandomContract", "0x670db66fa1d0edbe6822e33432d53539e8984fd2");
   OCLPublicAddressAbstraction.putServerAddress("ThirdPartyVoter", "0x7e959d3bbcf4a060ba40b8e6d22b2ed5f99bc95d");


  var OCLotteryContractAbstraction = OCLotteryContract.at("0xa499c5feafa59bbea7f66328c64c947f71a6c7cc");
  OCLotteryContractAbstraction.loglength.call().then(function (result) {
      console.log("OCLotteryContractAbstraction log count:");
      console.log(result);
      for(i=0; i<result;i++){
        OCLotteryContractAbstraction.logmyself.call(i).then(function (strResult) {
            console.log("OCLotteryContractAbstraction:"+strResult);
        });
      }
  })

  var OCMarketAbstraction = OCMarket.at("0x4d11af90893881591a8dfb6cff078fb89fba0533");
  OCMarketAbstraction.logaddressmyself.call(0).then(function(result){
    console.log("OCMarketAbstraction:"+result);
  });


  var OCRandomContractAbstraction = OCRandomContract.at("0x670db66fa1d0edbe6822e33432d53539e8984fd2");
  OCRandomContractAbstraction.testEquel.call("123", "0x64e604787cbf194841e7b68d7cd28786f6c9a0a3ab9f8b0a0e87cb4387ab0107").then(function (result) {
      console.log(result);
  })

  OCRandomContractAbstraction.loglength.call().then(function (result) {
    console.log("OCRandomContractAbstraction log count:");
    console.log(result);
    for(i=0; i<result;i++){
      OCRandomContractAbstraction.logmyself.call(i).then(function (strResult) {
        console.log("OCRandomContractAbstraction_logmyself:"+strResult);
      });
    }
  })

  OCRandomContractAbstraction.logsbytes32length.call().then(function(result){
    console.log("OCRandomContractAbstraction log count:");
    console.log(result);
    for(i=0; i<result;i++){
      OCRandomContractAbstraction.logsbytes32myself.call(i).then(function (strResult) {
        console.log("OCRandomContractAbstraction_logsbytes32myself:"+strResult);
      });
    }
  });

   // var ThirdPartyVoterAbstraction = ThirdPartyVoter.at("0x7e959d3bbcf4a060ba40b8e6d22b2ed5f99bc95d");
   // ThirdPartyVoterAbstraction.sendOnlyHash("12345678");
   // ThirdPartyVoterAbstraction.sendSeedAndHash("12345678");


  // var OCRandomContractInterface = OCRandomContract.at("0xdd482c88b82ce69d5d547869cffcdbf67f3f522e");
  // var OCLotteryContractInterface = OCLotteryContract.at("0xc955c1a69a3d24ff68a76946ec744b4fbed0d2f87516fb826f20b584ab70bcba");
  // var OCMarketInterface = OCMarket.at("0x3b8422c7e369ee894136a71acff1a223223a95c9");

  // var hst = OCTest.at('0xc705f510148289273f609f38a983050aecef7f5f');
  // hst.getReward.call(16);
  // hst.getReward(18);
  // hst.withdraw(11);
  // hst.withdraw1(12);
  // hst.withdraw2();
  // hst.getReward(15);
  //
  // valueTotal = hst.getterValueTotal.call()
  //
  // valueTotal.then(function(xresult) {
  //   console.log(xresult)
  // })

//   async () =>{
//     const balance = hst.balanceOf.call(accounts[2])
//     console.log("balance 2 left:")
//     console.log(balance)
//       balance.then(function(result) {
//         console.log(result) //will log results.
//       })
//   }
//
//     hst.transfer(accounts[1], 996, {from: accounts[2]})
//     const balance_1 = hst.balanceOf.call(accounts[1])
//     console.log("balance 1 left:");
//     console.log(balance_1);
//     balance_1.then(function(result) {
//     console.log(result) //will log results.
//     sleep.sleep(30)
//   })
})

//   beforeEach(async () => {
//     HST = await HumanStandardTokenAbstraction.new(1000000, 'Simon Bucks', 1, 'SBX', {from: accounts[2]})
//   })
//
//   console.log("bx")
//   it('creation: xshould create an initial balance of 1000000 for the creator', async () => {
//     console.log("bx1")
//     const balance = await HST.balanceOf.call(accounts[2])
//     console.log(balance)
//     console.log("bx2")
//     assert.strictEqual(balance.toNumber(), 1000000)
//     console.log("bx3")
//   })
//
//   console.log("fx")
//   it('transfers: should transfer 10000 to accounts[1] with accounts[2] having 999', async () => {
//     await HST.transfer(accounts[1], 999, {from: accounts[2]})
//     const balance = await HST.balanceOf.call(accounts[1])
//   console.log("fx1")
//   assert.strictEqual(balance.toNumber(), 999)
// })
//   console.log("gx")

// console.log("cx")
//   it('creation: test correct setting of vanity information', async () => {
//     const name = await HST.name.call()
//     assert.strictEqual(name, 'Simon Bucks')
//
//     const decimals = await HST.decimals.call()
//     assert.strictEqual(decimals.toNumber(), 1)
//
//     const symbol = await HST.symbol.call()
//     assert.strictEqual(symbol, 'SBX')
//   })

// console.log("dx")
//   it('creation: should succeed in creating over 2^256 - 1 (max) tokens', async () => {
//     // 2^256 - 1
//     let HST2 = await HumanStandardTokenAbstraction.new('115792089237316195423570985008687907853269984665640564039457584007913129639935', 'Simon Bucks', 1, 'SBX', {from: accounts[2]})
//     const totalSupply = await HST2.totalSupply()
//     const match = totalSupply.equals('1.15792089237316195423570985008687907853269984665640564039457584007913129639935e+77')
//     assert(match, 'result is not correct')
//   })

// console.log("ex")
//   // TRANSERS
//   // normal transfers without approvals
//   it('transfers: ether transfer should be reversed.', async () => {
//     console.log("ex1")
//     const balanceBefore = await HST.balanceOf.call(accounts[2])
//     assert.strictEqual(balanceBefore.toNumber(), 10000)
//
//   console.log("ex2")
//     web3.eth.sendTransaction({from: accounts[2], to: HST.address, value: web3.toWei('0.123', 'Ether')}, async (err, res) => {
//       console.log("ex3")
//       expectThrow(new Promise((resolve, reject) => {
//         if (err) reject(err)
//         resolve(res)
//       }))
//
//       const balanceAfter = await HST.balanceOf.call(accounts[2])
//       assert.strictEqual(balanceAfter.toNumber(), 10000)
//     })
//   })

// it('transfers: should fail when trying to transfer 10001 to accounts[1] with accounts[2] having 10000', () => {
//   return expectThrow(HST.transfer.call(accounts[1], 10001, {from: accounts[2]}))
// })
//
// it('transfers: should handle zero-transfers normally', async () => {
//   assert(await HST.transfer.call(accounts[1], 0, {from: accounts[2]}), 'zero-transfer has failed')
// })
//
// // NOTE: testing uint256 wrapping is impossible in this standard token since you can't supply > 2^256 -1
// // todo: transfer max amounts
//
// // APPROVALS
// it('approvals: msg.sender should approve 100 to accounts[1]', async () => {
//   await HST.approve(accounts[1], 100, {from: accounts[2]})
//   const allowance = await HST.allowance.call(accounts[2], accounts[1])
//   assert.strictEqual(allowance.toNumber(), 100)
// })
//
// it('approvals: msg.sender should approve 100 to SampleRecipient and then NOTIFY SampleRecipient. It should succeed.', async () => {
//   let SRS = await SampleRecipientSuccess.new({from: accounts[2]})
//   await HST.approveAndCall(SRS.address, 100, '0x42', {from: accounts[2]})
//   const allowance = await HST.allowance.call(accounts[2], SRS.address)
//   assert.strictEqual(allowance.toNumber(), 100)
//
//   const value = await SRS.value.call()
//   assert.strictEqual(value.toNumber(), 100)
// })
//
// it('approvals: msg.sender should approve 100 to SampleRecipient and then NOTIFY SampleRecipient and throw.', async () => {
//   let SRS = await SampleRecipientThrow.new({from: accounts[2]})
//   return expectThrow(HST.approveAndCall.call(SRS.address, 100, '0x42', {from: accounts[2]}))
// })
//
// // bit overkill. But is for testing a bug
// it('approvals: msg.sender approves accounts[1] of 100 & withdraws 20 once.', async () => {
//   const balance0 = await HST.balanceOf.call(accounts[2])
//   assert.strictEqual(balance0.toNumber(), 10000)
//
//   await HST.approve(accounts[1], 100, {from: accounts[2]}) // 100
//   const balance2 = await HST.balanceOf.call(accounts[2])
//   assert.strictEqual(balance2.toNumber(), 0, 'balance2 not correct')
//
//   HST.transferFrom.call(accounts[2], accounts[2], 20, {from: accounts[1]})
//   await HST.allowance.call(accounts[2], accounts[1])
//   await HST.transferFrom(accounts[2], accounts[2], 20, {from: accounts[1]}) // -20
//   const allowance01 = await HST.allowance.call(accounts[2], accounts[1])
//   assert.strictEqual(allowance01.toNumber(), 80) // =80
//
//   const balance22 = await HST.balanceOf.call(accounts[2])
//   assert.strictEqual(balance22.toNumber(), 20)
//
//   const balance02 = await HST.balanceOf.call(accounts[2])
//   assert.strictEqual(balance02.toNumber(), 9980)
// })
//
// // should approve 100 of msg.sender & withdraw 50, twice. (should succeed)
// it('approvals: msg.sender approves accounts[1] of 100 & withdraws 20 twice.', async () => {
//   await HST.approve(accounts[1], 100, {from: accounts[2]})
//   const allowance01 = await HST.allowance.call(accounts[2], accounts[1])
//   assert.strictEqual(allowance01.toNumber(), 100)
//
//   await HST.transferFrom(accounts[2], accounts[2], 20, {from: accounts[1]})
//   const allowance012 = await HST.allowance.call(accounts[2], accounts[1])
//   assert.strictEqual(allowance012.toNumber(), 80)
//
//   const balance2 = await HST.balanceOf.call(accounts[2])
//   assert.strictEqual(balance2.toNumber(), 20)
//
//   const balance0 = await HST.balanceOf.call(accounts[2])
//   assert.strictEqual(balance0.toNumber(), 9980)
//
//   // FIRST tx done.
//   // onto next.
//   await HST.transferFrom(accounts[2], accounts[2], 20, {from: accounts[1]})
//   const allowance013 = await HST.allowance.call(accounts[2], accounts[1])
//   assert.strictEqual(allowance013.toNumber(), 60)
//
//   const balance22 = await HST.balanceOf.call(accounts[2])
//   assert.strictEqual(balance22.toNumber(), 40)
//
//   const balance02 = await HST.balanceOf.call(accounts[2])
//   assert.strictEqual(balance02.toNumber(), 9960)
// })

// // should approve 100 of msg.sender & withdraw 50 & 60 (should fail).
// it('approvals: msg.sender approves accounts[1] of 100 & withdraws 50 & 60 (2nd tx should fail)', async () => {
//   await HST.approve(accounts[1], 100, {from: accounts[2]})
//   const allowance01 = await HST.allowance.call(accounts[2], accounts[1])
//   assert.strictEqual(allowance01.toNumber(), 100)
//
//   await HST.transferFrom(accounts[2], accounts[2], 50, {from: accounts[1]})
//   const allowance012 = await HST.allowance.call(accounts[2], accounts[1])
//   assert.strictEqual(allowance012.toNumber(), 50)
//
//   const balance2 = await HST.balanceOf.call(accounts[2])
//   assert.strictEqual(balance2.toNumber(), 50)
//
//   const balance0 = await HST.balanceOf.call(accounts[2])
//   assert.strictEqual(balance0.toNumber(), 9950)
//
//   // FIRST tx done.
//   // onto next.
//   await expectThrow(HST.transferFrom.call(accounts[2], accounts[2], 60, {from: accounts[1]}))
// })

// it('approvals: attempt withdrawal from account with no allowance (should fail)', function () {
//   return expectThrow(HST.transferFrom.call(accounts[2], accounts[2], 60, {from: accounts[1]}))
// })
//
// it('approvals: allow accounts[1] 100 to withdraw from accounts[2]. Withdraw 60 and then approve 0 & attempt transfer.', async () => {
//   HST.approve(accounts[1], 100, {from: accounts[2]})
//   HST.transferFrom(accounts[2], accounts[2], 60, {from: accounts[1]})
//   HST.approve(accounts[1], 0, {from: accounts[2]})
//   await expectThrow(HST.transferFrom.call(accounts[2], accounts[2], 10, {from: accounts[1]}))
// })
//
// it('approvals: approve max (2^256 - 1)', async () => {
//   await HST.approve(accounts[1], '115792089237316195423570985008687907853269984665640564039457584007913129639935', {from: accounts[2]})
//   const allowance = await HST.allowance(accounts[2], accounts[1])
//   assert(allowance.equals('1.15792089237316195423570985008687907853269984665640564039457584007913129639935e+77'))
// })
//
// it('events: should fire Transfer event properly', async () => {
//   const res = await HST.transfer(accounts[1], '2666', {from: accounts[2]})
//   const transferLog = res.logs.find(element => element.event.match('Transfer'))
//   assert.strictEqual(transferLog.args._from, accounts[2])
//   assert.strictEqual(transferLog.args._to, accounts[1])
//   assert.strictEqual(transferLog.args._value.toString(), '2666')
// })
//
// it('events: should fire Transfer event normally on a zero transfer', async () => {
//   const res = await HST.transfer(accounts[1], '0', {from: accounts[2]})
//   const transferLog = res.logs.find(element => element.event.match('Transfer'))
//   assert.strictEqual(transferLog.args._from, accounts[2])
//   assert.strictEqual(transferLog.args._to, accounts[1])
//   assert.strictEqual(transferLog.args._value.toString(), '0')
// })
//
// it('events: should fire Approval event properly', async () => {
//   const res = await HST.approve(accounts[1], '2666', {from: accounts[2]})
//   const approvalLog = res.logs.find(element => element.event.match('Approval'))
//   assert.strictEqual(approvalLog.args._owner, accounts[2])
//   assert.strictEqual(approvalLog.args._spender, accounts[1])
//   assert.strictEqual(approvalLog.args._value.toString(), '2666')
// })

