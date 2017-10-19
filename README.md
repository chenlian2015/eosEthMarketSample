本地环境方案篇

第一步安装环境(每个软件都有自己的官文安装方式)

1.安装testrpc
https://github.com/ethereumjs/testrpc

2.安装geth
https://ethereum.github.io/go-ethereum/install/

3.安装truffle
https://github.com/trufflesuite/truffle

4.安装intellij的solidity插件

5.用git 下载抽奖相关代码
https://github.com/chenlian2015/eosEthMarketSample.git


第二步运行步骤
在控制台1
testrpc

在控制台2
geth attach rpc:http://localhost:8545

在控制台3
.在控制台2运行命令“eth”
将获取所有以太坊测试账号,复制其中一个账号到编译eosEthMarketSample项目下的truffle.js文件下的from字段

.编译eosEthMarketSample“truffle compile”

.部署eosEthMarketSample到testrpc环境"truffle migrate"

.将部署的OLPublicAddressAbstraction的地址覆替换到eosEthMarketSample的代码中

.再次重新部署整个项目"truffle migrate"

.将OCLotteryContract OCMarket OLRandomContract ThirdPartyVoter的部署地址替换到humanStandardToken.js文件中去

.truffle test运行测试代码

第三步抽奖和随机数提供环节
按照humanStandardToken.js文件中的说明执行即可


代码结构篇

一.
第一个初版已经基本研发出来，包括:

OCLotteryContract.sol//抽奖合约

OLPublicAddress.sol//欧链公共地址合约

OCMarket.sol//欧链市场合约

OLMarketInterface.sol//市场接口合约(目前只提供了随机数chuli)

OLRandomContract.sol//随机数合约

ThirdPartyVoter.sol//随机种子提供者合约
