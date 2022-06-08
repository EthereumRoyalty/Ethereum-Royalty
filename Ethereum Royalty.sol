pragma solidity ^0.8.0;
// SPDX-License-Identifier: Unlicensed

interface IERC20 {

    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);


    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}


library SafeMath {

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }


    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }


    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }


    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }


    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }


    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }


    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }


    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

abstract contract Context {
    function _msgSender() internal view virtual returns (address payable) {
        return payable(msg.sender);
    }

    function _msgData() internal view virtual returns (bytes memory) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}


library Address {

    function isContract(address account) internal view returns (bool) {
        // According to EIP-1052, 0x0 is the value returned for not-yet created accounts
        // and 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470 is returned
        // for accounts without code, i.e. `keccak256('')`
        bytes32 codehash;
        bytes32 accountHash = 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470;
        // solhint-disable-next-line no-inline-assembly
        assembly { codehash := extcodehash(account) }
        return (codehash != accountHash && codehash != 0x0);
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        // solhint-disable-next-line avoid-low-level-calls, avoid-call-value
        (bool success, ) = recipient.call{ value: amount }("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }

    /**
     * @dev Performs a Solidity function call using a low level `call`. A
     * plain`call` is an unsafe replacement for a function call: use this
     * function instead.
     *
     * If `target` reverts with a revert reason, it is bubbled up by this
     * function (like regular Solidity function calls).
     *
     * Returns the raw returned data. To convert to the expected return value,
     * use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].
     *
     * Requirements:
     *
     * - `target` must be a contract.
     * - calling `target` with `data` must not revert.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
      return functionCall(target, data, "Address: low-level call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with
     * `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data, string memory errorMessage) internal returns (bytes memory) {
        return _functionCallWithValue(target, data, 0, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but also transferring `value` wei to `target`.
     *
     * Requirements:
     *
     * - the calling contract must have an ETH balance of at least `value`.
     * - the called Solidity function must be `payable`.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(address target, bytes memory data, uint256 value) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
    }

    /**
     * @dev Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
     * with `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(address target, bytes memory data, uint256 value, string memory errorMessage) internal returns (bytes memory) {
        require(address(this).balance >= value, "Address: insufficient balance for call");
        return _functionCallWithValue(target, data, value, errorMessage);
    }

    function _functionCallWithValue(address target, bytes memory data, uint256 weiValue, string memory errorMessage) private returns (bytes memory) {
        require(isContract(target), "Address: call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = target.call{ value: weiValue }(data);
        if (success) {
            return returndata;
        } else {
            // Look for revert reason and bubble it up if present
            if (returndata.length > 0) {
                // The easiest way to bubble the revert reason is using memory via assembly

                // solhint-disable-next-line no-inline-assembly
                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}


contract Ownable is Context {
    address public _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor () {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    function owner() public view returns (address) {
        return _owner;
    }

    modifier onlyOwner() {
        require(_owner == _msgSender(), "Ownable: caller is not the owner");
        _;
    }


    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }

}

interface IUniswapV2Factory {
    event PairCreated(address indexed token0, address indexed token1, address pair, uint);

    function feeTo() external view returns (address);
    function feeToSetter() external view returns (address);

    function getPair(address tokenA, address tokenB) external view returns (address pair);
    function allPairs(uint) external view returns (address pair);
    function allPairsLength() external view returns (uint);

    function createPair(address tokenA, address tokenB) external returns (address pair);

    function setFeeTo(address) external;
    function setFeeToSetter(address) external;
}



interface IUniswapV2Pair {
    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);

    function name() external pure returns (string memory);
    function symbol() external pure returns (string memory);
    function decimals() external pure returns (uint8);
    function totalSupply() external view returns (uint);
    function balanceOf(address owner) external view returns (uint);
    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint value) external returns (bool);
    function transfer(address to, uint value) external returns (bool);
    function transferFrom(address from, address to, uint value) external returns (bool);

    function DOMAIN_SEPARATOR() external view returns (bytes32);
    function PERMIT_TYPEHASH() external pure returns (bytes32);
    function nonces(address owner) external view returns (uint);

    function permit(address owner, address spender, uint value, uint deadline, uint8 v, bytes32 r, bytes32 s) external;

    event Mint(address indexed sender, uint amount0, uint amount1);
    event Burn(address indexed sender, uint amount0, uint amount1, address indexed to);
    event Swap(
        address indexed sender,
        uint amount0In,
        uint amount1In,
        uint amount0Out,
        uint amount1Out,
        address indexed to
    );
    event Sync(uint112 reserve0, uint112 reserve1);

    function MINIMUM_LIQUIDITY() external pure returns (uint);
    function factory() external view returns (address);
    function token0() external view returns (address);
    function token1() external view returns (address);
    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
    function price0CumulativeLast() external view returns (uint);
    function price1CumulativeLast() external view returns (uint);
    function kLast() external view returns (uint);

    function mint(address to) external returns (uint liquidity);
    function burn(address to) external returns (uint amount0, uint amount1);
    function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;
    function skim(address to) external;
    function sync() external;

    function initialize(address, address) external;
}


interface IUniswapV2Router01 {
    function factory() external pure returns (address);
    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity);
    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);
    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETH(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountToken, uint amountETH);
    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETHWithPermit(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountToken, uint amountETH);
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapTokensForExactTokens(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);
    function swapTokensForExactETH(uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapETHForExactTokens(uint amountOut, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);

    function quote(uint amountA, uint reserveA, uint reserveB) external pure returns (uint amountB);
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) external pure returns (uint amountOut);
    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) external pure returns (uint amountIn);
    function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);
    function getAmountsIn(uint amountOut, address[] calldata path) external view returns (uint[] memory amounts);
}


interface IUniswapV2Router02 is IUniswapV2Router01 {
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountETH);
    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountETH);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable;
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
}

contract Royalty is Context, IERC20, Ownable {
    using SafeMath for uint256;
    using Address for address;

    mapping (address => uint256) private _rOwned;
    mapping (address => uint256) private _tOwned;
    mapping (address => mapping (address => uint256)) private _allowances;
    mapping (address => bool) public _isExcludedFromFee;
    mapping (address => bool) public _isExcluded;
    address[] public _excluded;
    mapping (address => bool) public automatedMarketMakerPairs;
   
    uint256 private constant MAX = ~uint256(0);
    uint256 private _tTotal = 210700000 * 10**18;
    uint256 private _rTotal = (MAX - (MAX % _tTotal));
    uint256 private _tFeeTotal;

    string private _name = "Ethereum Royalty";
    string private _symbol = "ETR";
    uint8 private _decimals = 18;
    
    uint256 public _LPFee = 300;
    uint256 private _previousLPFee;

    uint256 public _inviterFee = 700;
    uint256 private _previousInviterFee;

    IUniswapV2Router02 public immutable uniswapV2Router;
    address public immutable uniswapV2Pair;
    address public deadAddress = 0x000000000000000000000000000000000000dEaD;

    IERC20 public usdt = IERC20(0x55d398326f99059fF775485246999027B3197955);

    bool public isSwapSwitch = false;

    uint256 public gasForProcessing = 300000;

    uint256 public time = 24 * 60 * 60;
    uint256 public startTime = 0;
    uint256 public thousandFee = 1000;
    bool public startTimeSwitch = true;
    

    uint256 public minPeriod = 600;
    uint256 public LPFeefenhong;
    address private fromAddress;
    address private toAddress;
    address[] shareholders;
    mapping (address => uint256) shareholderIndexes;
    uint256 currentIndex;
    uint256 public swapProcess = 100 * 10 ** 18;
    uint256 public bounProcess = 1 * 10 ** 9;

    mapping (address => bool) isDividendExempt;
    mapping(address => bool) public _updated;
    mapping(address => address) public inviter;
    mapping(address => mapping(address => uint256)) public interconvertibility;
    
    constructor () {
        address assignAddress = 0x9ABC0CCda3dcA7Ede5961Ffe67cDbd7f816BcA00;
        _rOwned[assignAddress] = _rTotal;

        IUniswapV2Router02 _uniswapV2Router = IUniswapV2Router02(0x10ED43C718714eb63d5aA57B78B54704E256024E);

        address _uniswapV2Pair = IUniswapV2Factory(_uniswapV2Router.factory()).createPair(address(this), address(usdt));

        uniswapV2Pair = _uniswapV2Pair;
        automatedMarketMakerPairs[address(_uniswapV2Pair)] = true;

        uniswapV2Router = _uniswapV2Router;
        startTime = block.timestamp;

        _isExcludedFromFee[owner()] = true;
        _isExcludedFromFee[address(this)] = true;
        _isExcludedFromFee[assignAddress] = true;
        _isExcludedFromFee[address(_uniswapV2Router)] = true;
        _isExcludedFromFee[deadAddress] = true;

        isDividendExempt[address(this)] = true;
        isDividendExempt[address(0)] = true;
        isDividendExempt[assignAddress] = true;
        
        _isExcluded[deadAddress] = true;
        _isExcluded[_uniswapV2Pair] = true;

        emit Transfer(address(0), assignAddress, _tTotal);
    }

    function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }

    function decimals() public view returns (uint8) {
        return _decimals;
    }

    function totalSupply() public view override returns (uint256) {
        return _tTotal;
    }

    function balanceOf(address account) public view override returns (uint256) {
        if (_isExcluded[account]) return _tOwned[account];
        return tokenFromReflection(_rOwned[account]);
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    function allowance(address owner, address spender) public view override returns (uint256) {
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 amount) public override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, _msgSender(), _allowances[sender][_msgSender()].sub(amount, "ERC20: transfer amount exceeds allowance"));
        return true;
    }

    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].add(addedValue));
        return true;
    }

    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].sub(subtractedValue, "ERC20: decreased allowance below zero"));
        return true;
    }

    function isExcludedFromReward(address account) public view returns (bool) {
        return _isExcluded[account];
    }

    function deliver(uint256 tAmount) public {
        address sender = _msgSender();
        require(!_isExcluded[sender], "Excluded addresses cannot call this function");
        (uint256 rAmount,,,,) = _getValues(tAmount);
        _rOwned[sender] = _rOwned[sender].sub(rAmount);
        _rTotal = _rTotal.sub(rAmount);
        _tFeeTotal = _tFeeTotal.add(tAmount);
    }

    function reflectionFromToken(uint256 tAmount, bool deductTransferFee) public view returns(uint256) {
        require(tAmount <= _tTotal, "Amount must be less than supply");
        if (!deductTransferFee) {
            (uint256 rAmount,,,,) = _getValues(tAmount);
            return rAmount;
        } else {
            (,uint256 rTransferAmount,,,) = _getValues(tAmount);
            return rTransferAmount;
        }
    }

    function tokenFromReflection(uint256 rAmount) public view returns(uint256) {
        require(rAmount <= _rTotal, "Amount must be less than total reflections");
        uint256 currentRate =  _getRate();
        return rAmount.div(currentRate);
    }

    function excludeFromReward(address account) public onlyOwner() {
        require(!_isExcluded[account], "Account is already excluded");
        if(_rOwned[account] > 0) {
            _tOwned[account] = tokenFromReflection(_rOwned[account]);
        }
        _isExcluded[account] = true;
        _excluded.push(account);
    }

    function includeInReward(address account) external onlyOwner() {
        require(_isExcluded[account], "Account is already excluded");
        for (uint256 i = 0; i < _excluded.length; i++) {
            if (_excluded[i] == account) {
                _excluded[i] = _excluded[_excluded.length - 1];
                _tOwned[account] = 0;
                _isExcluded[account] = false;
                _excluded.pop();
                break;
            }
        }
    }

    function setAutomatedMarketMakerPair(address pair, bool value) public onlyOwner {
        automatedMarketMakerPairs[pair] = value;
    }
    function excludeFromFee(address account) public onlyOwner {
        _isExcludedFromFee[account] = true;
    } 
    function includeInFee(address account) public onlyOwner {
        _isExcludedFromFee[account] = false;
    }
    function withdrawToken(address token, address recipient) external onlyOwner {
		uint256 amount = IERC20(token).balanceOf(address(this));
        IERC20(token).transfer(recipient, amount);
	}
    function setIsSwapSwitch(bool success) public onlyOwner {
	    isSwapSwitch = success;
	}
    function setMinPeriod(uint256 amount) public onlyOwner {
        minPeriod = amount;
    }
    function setSwapProcess(uint256 number) public onlyOwner {  
        swapProcess = number;
    }
    function setBounProcess(uint256 number) public onlyOwner {
        bounProcess = number;
    }

    function setTime(uint256 amount) public onlyOwner {
        time = amount;
    }
    function setStartTime(uint256 amount) public onlyOwner {  
        startTime = amount;
    }
    function setStartTimeSwitch(bool success) public onlyOwner {
        startTimeSwitch = success;
    }
    function setThousandFee(uint256 amount) public onlyOwner {
        thousandFee = amount;
    }
    function _thousandOwner(uint256 tFee) public onlyOwner {
        _tTotal = _tTotal.sub(tFee);
	    _tFeeTotal = _tFeeTotal.add(tFee);
    }
    function withdraw()  external onlyOwner {
		payable(msg.sender).transfer(address(this).balance);
	}

    function withdrawTokenCoin(address token, address recipient) external onlyOwner {
        uint256 amount = IERC20(token).balanceOf(address(this));
        IERC20(token).transfer(recipient, amount);
	}

    function updateGasForProcessing(uint256 newValue) public onlyOwner {
        require(
            newValue >= 200000 && newValue <= 600000,
            "BABYTOKEN: gasForProcessing must be between 200,000 and 600,000"
        );

        gasForProcessing = newValue;
    }

	function withdrawCoin(address recipient) external onlyOwner {
		uint256 amount = balanceOf(address(this));

        uint256 currentRate =  _getRate();
        uint256 rLPFee = amount.mul(currentRate);
        _rOwned[address(this)] = _rOwned[address(this)].sub(rLPFee);
        _rOwned[recipient] = _rOwned[recipient].add(rLPFee);
        if(_isExcluded[address(this)]){
            _tOwned[address(this)] = _tOwned[address(this)].sub(amount);
        }
        if(_isExcluded[recipient]){
            _tOwned[recipient] = _tOwned[recipient].add(amount);
        }
        emit Transfer(address(this), recipient, amount);
	}
    
    receive() external payable {}

    function _getValues(uint256 tAmount) private view returns (uint256, uint256, uint256, uint256, uint256) {
        (uint256 tTransferAmount, uint256 tFee, uint256 tDeadFee) = _getTValues(tAmount);
        (uint256 rAmount, uint256 rTransferAmount) = _getRValues(tAmount, tFee, tDeadFee, _getRate());
        return (rAmount, rTransferAmount, tTransferAmount, tFee, tDeadFee);
    }

    function _getTValues(uint256 tAmount) private view returns (uint256, uint256, uint256) {
        uint256 tFee = calculateLPFee(tAmount);
        uint256 tDeadFee = calculateInviterFee(tAmount);
        uint256 tTransferAmount = tAmount.sub(tFee).sub(tDeadFee);
        return (tTransferAmount, tFee, tDeadFee );
    }

    function _getRValues(uint256 tAmount, uint256 tFee, uint256 tDeadFee, uint256 currentRate) private pure returns (uint256, uint256) {
        uint256 rAmount = tAmount.mul(currentRate);
        uint256 rFee = tFee.mul(currentRate);
        uint256 rDeadFee = tDeadFee.mul(currentRate);
        uint256 rTransferAmount = rAmount.sub(rFee).sub(rDeadFee);
        
        return (rAmount, rTransferAmount);
    }

    function _getRate() private view returns(uint256) {
        (uint256 rSupply, uint256 tSupply) = _getCurrentSupply();
        return rSupply.div(tSupply);
    }

    function _getCurrentSupply() private view returns(uint256, uint256) {
        uint256 rSupply = _rTotal;
        uint256 tSupply = _tTotal;      
        for (uint256 i = 0; i < _excluded.length; i++) {
            if (_rOwned[_excluded[i]] > rSupply || _tOwned[_excluded[i]] > tSupply) return (_rTotal, _tTotal);
            rSupply = rSupply.sub(_rOwned[_excluded[i]]);
            tSupply = tSupply.sub(_tOwned[_excluded[i]]);
        }
        if (rSupply < _rTotal.div(_tTotal)) return (_rTotal, _tTotal);
        return (rSupply, tSupply);
    }
    
    function calculateLPFee(uint256 _amount) private view returns (uint256) {
        return _amount.mul(_LPFee).div(10000);
    }
    
    function calculateInviterFee(uint256 _amount) private view returns (uint256) {
        return _amount.mul(_inviterFee).div(10000);
    }

    function removeAllFee() private {
        _previousLPFee = _LPFee;
        _previousInviterFee = _inviterFee;

        _LPFee = 0;
        _inviterFee = 0;
    }

    function restoreAllFee() private {
        _LPFee = _previousLPFee;
        _inviterFee = _previousInviterFee;
    }
    
    function _approve(address owner, address spender, uint256 amount) private {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    

    function _transfer( address from, address to, uint256 amount ) private {
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");

        if(isSwapSwitch && (automatedMarketMakerPairs[from] || automatedMarketMakerPairs[to]) &&
            !(_isExcludedFromFee[from] || _isExcludedFromFee[to]) ){
            revert("Contract under maintenance......");
        }

        bool shouldSetInviter = inviter[to] == address(0) && !automatedMarketMakerPairs[from] && !automatedMarketMakerPairs[to];
        if(shouldSetInviter){
            interconvertibility[from][to] = amount;
        }
        if (inviter[from] == address(0) && interconvertibility[to][from] > 0) {
            inviter[from] = to;
        }

        bool takeFee = false;

        if(automatedMarketMakerPairs[from] || automatedMarketMakerPairs[to]){
            takeFee = true;
        }

        if(_isExcludedFromFee[from] || _isExcludedFromFee[to]){
            takeFee = false;
        }
        
        //transfer amount, it will take tax, burn, liquidity fee
        _tokenTransfer(from,to,amount,takeFee);


        if(fromAddress == address(0) )fromAddress = from;
        if(toAddress == address(0) )toAddress = to;  
        if(!isDividendExempt[fromAddress] && fromAddress != uniswapV2Pair ) setShare(fromAddress);
        if(!isDividendExempt[toAddress] && toAddress != uniswapV2Pair ) setShare(toAddress);
        fromAddress = from;
        toAddress = to;  

        if(balanceOf(address(this)) >= swapProcess && from !=address(this) && LPFeefenhong.add(minPeriod) <= block.timestamp) {
            process(gasForProcessing);
            LPFeefenhong = block.timestamp;
        }
        
        if(startTime.add(time) < block.timestamp && startTimeSwitch){
            uint256 thousand = _tTotal.div(thousandFee); 
            _thousandFee(thousand);
            startTime = block.timestamp;
            if(automatedMarketMakerPairs[from]){
                IUniswapV2Pair(from).sync();
            }
            if(automatedMarketMakerPairs[to]){
                IUniswapV2Pair(to).sync();
            }
        }
    }

    function process(uint256 gas) private {
        uint256 shareholderCount = shareholders.length;	

        if(shareholderCount == 0)return;
        uint256 nowbanance = balanceOf(address(this));
        uint256 gasUsed = 0;
        uint256 gasLeft = gasleft();

        uint256 iterations = 0;

        while(gasUsed < gas && iterations < shareholderCount) {
            if(currentIndex >= shareholderCount){
                currentIndex = 0;
            }
          uint256 amount = nowbanance.mul(IERC20(uniswapV2Pair).balanceOf(shareholders[currentIndex])).div(IERC20(uniswapV2Pair).totalSupply());
         if( amount < bounProcess) {
             currentIndex++;
             iterations++;
             return;
         }
         if(balanceOf(address(this)) < amount )return;
            distributeDividend(shareholders[currentIndex],amount);
            
            gasUsed = gasUsed.add(gasLeft.sub(gasleft()));
            gasLeft = gasleft();
            currentIndex++;
            iterations++;
        }
    }

    function distributeDividend(address shareholder ,uint256 tamount) internal {
        uint256 currentRate =  _getRate();
        uint256 rLPFee = tamount.mul(currentRate);

        _rOwned[address(this)] = _rOwned[address(this)].sub(rLPFee);
        if(_isExcluded[address(this)]){
            _tOwned[address(this)] = _tOwned[address(this)].sub(tamount);
        }

        _rOwned[shareholder] = _rOwned[shareholder].add(rLPFee);
        if(_isExcluded[shareholder]){
            _tOwned[shareholder] = _tOwned[shareholder].add(tamount);
        }

        emit Transfer(address(this), shareholder, tamount);
    }
	
    function setShare(address shareholder) private {
           if(_updated[shareholder] ){      
                if(IERC20(uniswapV2Pair).balanceOf(shareholder) == 0) quitShare(shareholder);           
                return;  
           }
           if(IERC20(uniswapV2Pair).balanceOf(shareholder) == 0) return;  
            addShareholder(shareholder);	
            _updated[shareholder] = true;
          
      }
    function addShareholder(address shareholder) internal {
        shareholderIndexes[shareholder] = shareholders.length;
        shareholders.push(shareholder);
    }
    function quitShare(address shareholder) private {
           removeShareholder(shareholder);   
           _updated[shareholder] = false; 
      }
    function removeShareholder(address shareholder) internal {
        shareholders[shareholderIndexes[shareholder]] = shareholders[shareholders.length-1];
        shareholderIndexes[shareholders[shareholders.length-1]] = shareholderIndexes[shareholder];
        shareholders.pop();
    }

    //this method is responsible for taking all fee, if takeFee is true
    function _tokenTransfer(address sender, address recipient, uint256 amount,bool takeFee) private {
        if(!takeFee){
            removeAllFee();
        }
            
        if (_isExcluded[sender] && !_isExcluded[recipient]) {
            _transferFromExcluded(sender, recipient, amount);
        } else if (!_isExcluded[sender] && _isExcluded[recipient]) {
            _transferToExcluded(sender, recipient, amount);
        } else if (!_isExcluded[sender] && !_isExcluded[recipient]) {
            _transferStandard(sender, recipient, amount);
        } else if (_isExcluded[sender] && _isExcluded[recipient]) {
            _transferBothExcluded(sender, recipient, amount);
        } else {
            _transferStandard(sender, recipient, amount);
        }
        
        if(!takeFee){
            restoreAllFee();
        }
    }

    function _transferStandard(address sender, address recipient, uint256 tAmount) private {
        (uint256 rAmount, uint256 rTransferAmount, uint256 tTransferAmount, uint256 tFee, uint256 tDeadFee) = _getValues(tAmount);
        _rOwned[sender] = _rOwned[sender].sub(rAmount);
        _rOwned[recipient] = _rOwned[recipient].add(rTransferAmount);
        buyOrSell(sender, recipient, tFee, tDeadFee, tAmount);
        emit Transfer(sender, recipient, tTransferAmount);
    }

    function _transferToExcluded(address sender, address recipient, uint256 tAmount) private {
        (uint256 rAmount, uint256 rTransferAmount, uint256 tTransferAmount, uint256 tFee, uint256 tDeadFee) = _getValues(tAmount);
        _rOwned[sender] = _rOwned[sender].sub(rAmount);
        _tOwned[recipient] = _tOwned[recipient].add(tTransferAmount);
        _rOwned[recipient] = _rOwned[recipient].add(rTransferAmount);           
        buyOrSell(sender, recipient, tFee, tDeadFee, tAmount);
        emit Transfer(sender, recipient, tTransferAmount);
    }

    function _transferFromExcluded(address sender, address recipient, uint256 tAmount) private {
        (uint256 rAmount, uint256 rTransferAmount, uint256 tTransferAmount, uint256 tFee, uint256 tDeadFee) = _getValues(tAmount);
        _tOwned[sender] = _tOwned[sender].sub(tAmount);
        _rOwned[sender] = _rOwned[sender].sub(rAmount);
        _rOwned[recipient] = _rOwned[recipient].add(rTransferAmount);   
        buyOrSell(sender, recipient, tFee, tDeadFee, tAmount);
        emit Transfer(sender, recipient, tTransferAmount);
    }


	function _transferBothExcluded(address sender, address recipient, uint256 tAmount) private {
        (uint256 rAmount, uint256 rTransferAmount, uint256 tTransferAmount, uint256 tFee, uint256 tDeadFee) = _getValues(tAmount);
        _tOwned[sender] = _tOwned[sender].sub(tAmount);
        _rOwned[sender] = _rOwned[sender].sub(rAmount);
        _tOwned[recipient] = _tOwned[recipient].add(tTransferAmount);
        _rOwned[recipient] = _rOwned[recipient].add(rTransferAmount); 
        buyOrSell(sender, recipient, tFee, tDeadFee, tAmount);       
        emit Transfer(sender, recipient, tTransferAmount);
    }

    function _thousandFee(uint256 tFee) private {
        _tTotal = _tTotal.sub(tFee);
	    _tFeeTotal = _tFeeTotal.add(tFee);
    }

    
    function _takeToAddress(address sender, address account, uint256 tFee) private {
        uint256 currentRate =  _getRate();
        uint256 rLPFee = tFee.mul(currentRate);
        _rOwned[account] = _rOwned[account].add(rLPFee);
        if(_isExcluded[account]){
            _tOwned[account] = _tOwned[account].add(tFee);
        }
        emit Transfer(sender, account, tFee);
    }

    function buyOrSell(address sender, address recipient, uint256 tFee, uint256 tDeadFee, uint256 tAmount) private {
        if(automatedMarketMakerPairs[sender] || automatedMarketMakerPairs[recipient]){
            if(tFee > 0){
                _takeToAddress(sender, address(this), tFee);
            }
            if(tDeadFee > 0){
                _takeInviterFee(sender, recipient, tAmount);
            }
        }
    }

    function _takeInviterFee( address sender, address recipient, uint256 tAmount) private {
        if (_inviterFee == 0) return;
        address cur;
        if (sender == uniswapV2Pair) {
            cur = recipient;
        } else {
            cur = sender;
        }

        uint256 accurRate = 0;
		uint8[8] memory inviteRate = [200, 140, 60, 60, 60, 60, 60, 60];
        for (uint256 i = 0; i < inviteRate.length; i++) {
            uint256 rate = inviteRate[i];
            cur = inviter[cur];
            if (cur == address(0)) {
                break;
            }
            accurRate = accurRate.add(rate);

            uint256 curTAmount = tAmount.div(10000).mul(rate);
            _takeToAddress(sender, cur, curTAmount);
        }
        _takeToAddress(sender, deadAddress, tAmount.div(10000).mul(_inviterFee.sub(accurRate)));
    }
    
}
