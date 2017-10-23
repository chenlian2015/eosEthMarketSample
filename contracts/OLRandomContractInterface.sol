pragma solidity ^0.4.15;


contract OLRandomContractInterface {
    /*
    one random number perhaps applied to multi requests
    @param callBackAddress  the address to receive random number
    */
    function requestOneUUID(address callBackAddress) payable {}

    /*
    randdom number needs seed and hash, every random number, needs 3 different hashes from different sender,
    when hash count is enough(3 count),then you can provide seed which relevant to the hash you just provide.
    every random number,one provider only can provide one seed and one hash(seed)
    */
    function sendOnlyHash(bytes32 hash) public {}

    /*
    hash(seed) must be equel to hash, or else,you perhaps be added to blacklist
    */
    function sendSeedAndHash(bytes32 seed, bytes32 hash) public payable {}

    /*
    if you have provide seed for current random number generator procedure,you will wait for the next random number procedure,
    if no random number procedure, you also have no chance to provide sedd & hash(seed)
    @return hasChanceToProvideSeedHash means current user weather or not has chance to provide seed or hash(seed).
    */
    function currentStatus() public returns (bool hasChanceToProvideSeedHash){}

    /*
    @return uint ,the count of random number need to be generated
    */
    function getCurrentNeedsCount() public returns (uint){}
}