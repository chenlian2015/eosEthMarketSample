一.
第一个初版已经基本研发出来，包括:
OCLotteryContract.sol//抽奖合约
OCLPublicAddress.sol//欧链公共地址合约
OCMarket.sol//欧链市场合约
OCMarketInterface.sol//市场接口合约(目前只提供了随机数chuli)
OCRandomContract.sol//随机数合约
ThirdPartyVoter.sol//随机种子提供者合约

二.
目前在testrpc+truffle+geth本地服务已经测试通过，可以正常抽奖(抽奖人参与数量以及参与一次的费用，随机种子数量以及提供一次正确种子被采纳的奖励。在代码中均可灵活配置)

三.
安全方面以及部分执行异常还没有考虑，防止账户eth丢失还需细化

四.
下一步添加一个web页面，让大家参与可视化抽奖，目前抽奖结果需要专业技术人员才能看懂……^_^
