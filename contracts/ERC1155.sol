pragma solidity ^0.8.2;

contract ERC1155 {

    event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);

    event TransferSingle(address indexed _operator, address indexed _from, address indexed _to, uint256 _tokenId, uint256 _amount);

    event TransferBatch(address indexed _operator, address indexed _from, address indexed _to, uint256[] _tokenIds, uint256[] _amounts);

    mapping (uint256 => mapping(address => uint256)) internal _balances;

    mapping (address => mapping (address => bool)) internal _approvals;

    function balanceOf(address account, uint256 tokenId) public view returns (uint256) {
        require(account != address(0), "Address is zero");
        return _balances[tokenId][account];
    }

    function balanceOfBatch(address[] memory accounts, uint256[] memory ids) public view returns (uint256[] memory) {
        require(accounts.length == ids.length, "Accounts and IDs array size do not match");
        uint256[] memory batchBalances = new uint256[](accounts.length);
        for (uint256 i = 0; i < accounts.length; i++){
            batchBalances[i] = balanceOf(accounts[i], ids[i]);
        }
        return batchBalances;
    }

    function isApprovalForAll(address owner, address operator) public view returns (bool) {
        return _approvals[owner][operator];
    }

    function setApprovalForAll(address owner, address operator, bool approved) public {
        _approvals[owner][operator] = approved;
        emit ApprovalForAll(owner, operator, approved);
    }

    function _transfer(address from, address to, uint256 id, uint256 amount) internal {
        uint256 fromBalance = balanceOf(from, id);
        require(fromBalance >= amount, "Insufficient balance!");
        _balances[id][from] = fromBalance - amount;
        _balances[id][to] += amount;
    }

    function safeTransferFrom(address from, address to, uint256 id, uint256 amount) public {
        require(from == msg.sender || isApprovalForAll(from, msg.sender), "msg.sender is not the owner or approved for transfer");
        require(to != address(0), "Address is zero.");
        _transfer(from, to, id, amount);
        emit TransferSingle(msg.sender, from, to, id, amount);
        require(_checkOnERC1155Received(), "Receiver not implemented");
    }

    function _checkOnERC1155Received() internal pure returns(bool){
        return true;
    }

    function safeBatchTransferFrom(address from, address to, uint256[] memory ids, uint256[] memory amounts) public {
        require(from == msg.sender || isApprovalForAll(from, msg.sender), "msg.sender is not the owner or approved for transfer");
        require(to != address(0), "Address is zero.");
        require(ids.length == amounts.length, "Size of ids and amounts do not match!");
        for (uint256 i = 0; i < ids.length; i++){
            uint256 id = ids[i];
            uint256 amount = amounts[i];
            _transfer(from, to, id, amount);
        }
        emit TransferBatch(msg.sender, from, to, ids, amounts);
        require(_checkOnBatchERC1155Received(), "Receiver not implemented");
    }

    function _checkOnBatchERC1155Received() internal pure returns(bool){
        return true;
    }

    function supportsInterface(bytes4 interfaceId) public pure virtual returns(bool) {
        return interfaceId == 0xd9b67a26;
    } 

}