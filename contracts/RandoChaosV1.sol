pragma solidity ^0.5.0;

//Basic library
import "./Migrations.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

//Here start RandoChaos version 1
//I hope you enjoy the game, if want to read or reuse that code you are free to go.
contract RandoChaosV1 is Migrations{
 	//Declaration of DAI and unity parameter
	IERC20 dai;
	uint256 unity = 10 ** 18;
	uint256 maxId;
	uint256 maxWinMult;
	uint256[][] lastResult;
	//Iniciation and fallback function
	constructor(address _daiAddress) public{
		dai = IERC20(_daiAddress);
		maxId = 0;
		maxWinMult = 5;
	} 
	function() external payable{}
/*
	//Mapping to show result, just keep address, anything else is stored
	mapping (address => uint256) lastResult1;
	mapping (address => uint256) lastResult2;
	mapping (address => uint256) lastResult3;
	mapping (address => uint256) lastResult4;
	mapping (address => uint256) lastResult5;
	mapping (address => uint256) lastResult6;
	mapping (address => uint256) lastResult7;
	mapping (address => uint256) lastResult8;
	mapping (address => uint256) lastResult9;
*/
	//User help to do random number
	mapping (address => uint256) userNum;
	mapping (uint256 => address) userAddress;
	

	//Each of the following functions are used to acces to their personal result of each game
	function getLastResult(uint256 _game) external view returns(uint256 _lastResult){
		return(lastResult[userNum[msg.sender]][_game]);
	}

	//% of crazy rulette
	function checkPercent(uint256 _amount, uint256 _winMultiply) public view returns(uint256 _tantpercent){
		uint256 x;
		uint256 y;
		uint256 auxf;
		x = 100 * _amount;
		y = _amount * _winMultiply;
		auxf = y % 10;
		auxf = (y - auxf) / 10;
		y = y + auxf;
		auxf = x % y;
		x = (x - auxf) / y;
		return x;
	}
	
	//Random number
	function addUser() public{
		if(userNum[msg.sender] == 0){
			userNum[msg.sender] = maxId;
			userAddress[maxId] = msg.sender;
			maxId++;
		}
	}
	function random(uint256 _help) public returns(uint256 _result){
		addUser();
		uint256 x = uint256(keccak256(abi.encodePacked("chaos")));
		uint256 blockHashNow = uint256(blockhash(block.number - 1));
		x = (x % 100) * (uint256(now) % 100);
		x = x % maxId;
		x = uint256(userAddress[x]);
		x = (blockHashNow % 1000) * (x % 1000);
		x = (x % 1000) * (uint256(block.coinbase) % 1000);
		if(_help == 1){
			x = x % 10;
		}
		if(_help == 2){
			x = x % 100;
		}
		return (x);
	}

	//Now comes Game functions, every name has a number asociated as seen before on getLastResult
	//1 -> Rulette
	//2 -> appleDrop
	//3 -> rapeGame
	//4 -> cockfight
	//5 -> smurfDay

	//Rulette function
	function rulette() external{
		require (dai.balanceOf(msg.sender) >= unity, "No enought DAI");
		addUser();
		//Creating a semi-random number
		uint256 x = random(1);
		uint256 y = 0;
		//Transfering 1 DAI to this contract as the payment
		//Approve must go first
		dai.transferFrom(msg.sender, address(this), unity);
		//Each result has a case
		if(x == 0){
			y = unity;
			dai.transferFrom(address(this), msg.sender, y);//Returns 1 Dai
		}		
		if(x == 1){
			y = 4 * (10 ** 17);
			dai.approve(address(this), y);
			dai.transferFrom(address(this), msg.sender, y);//Returns 0.4 Dai
		}
		if(x == 2){
			y = 2 * (10 ** 17);
			dai.approve(address(this), y);
			dai.transferFrom(address(this), msg.sender, y);//Returns 0.2 Dai
		}
		if(x == 3){
			y = 65 * (10 ** 16);
			dai.approve(address(this), y);
			dai.transferFrom(address(this), msg.sender, y); //Returns 0.65 Dai
		}
		if(x == 4){
			y = 45 * (10 ** 16);
			dai.approve(address(this), y);
			dai.transferFrom(address(this), msg.sender, y);//Returns 0.45 Dai
		}
		if(x == 5){
			y = 2 * (10 ** 18);
			dai.approve(address(this), y);
			dai.transferFrom(address(this), msg.sender, y);//Returns 2 Dai
		}
		if(x == 6){
			y = 8 * (10 ** 17);
			dai.approve(address(this), y);
			dai.transferFrom(address(this), msg.sender, y); //Returns 0.8 Dai
		}
		if(x == 7){
			y = 2 * (10 ** 17);
			dai.approve(address(this), y);
			dai.transferFrom(address(this), msg.sender, y);//Returns 0.2 Dai
		}
		if(x == 8){
			y = 2 * (10 ** 18);
			dai.approve(address(this), y);
			dai.transferFrom(address(this), msg.sender, y);//Retorns 2 Dai
		}
		if(x == 9){
			y = 5 * (10 ** 17);
			dai.approve(address(this), y);
			dai.transferFrom(address(this), msg.sender, y);//Retorns 0.5 Dai
		}
		lastResult[userNum[msg.sender]][1] = y;
		//Bonus point
		lastResult[userNum[msg.sender]][0] += y;
		//Thanks to join our game
	}
	//Function Random Bet x2
	function randomBet2(uint256 _game, uint256 _select, uint256 _amount) external{
		require(dai.balanceOf(msg.sender) >= _amount, "Not enought DAI");
		require(_amount > 0 && _amount <= (5 * unity), "Not between 0 and 5 DAI");
		//Approved first, we transfer the bet from msg.sender
		dai.transferFrom(msg.sender, address(this), _amount);
		//Creating a semi-random number between 1-9
		uint256 x = random(1);
		uint256 y = 1;
		if(x == 0){
			x = random(2);
			x = (x - (x % 10)) / 10;
		}
		//Three possible answer. Allways return doble if correct.
		if(1 <= x && x <= 3 && _select == 1){
			y = _amount * 2;
			dai.approve(address(this), y);
			dai.transferFrom(address(this), msg.sender, y);
		}
		if(4 <= x && x <= 6 && _select == 2){
			y = _amount * 2;
			dai.approve(address(this), y);
			dai.transferFrom(address(this), msg.sender, y);
		}
		if(7 <= x && x <= 9 && _select == 3){
			y = _amount * 2;
			dai.approve(address(this), y);
			dai.transferFrom(address(this), msg.sender, y);
		}
		lastResult[userNum[msg.sender]][_game] = y;
		//Thanks to join our game
	}
	//Function Random Bet x3
	function randomBet3(uint256 _game, uint256 _select, uint256 _amount) external{
		require(dai.balanceOf(msg.sender) >= _amount, "Not enought DAI");
		require(_amount > 0 && _amount <= (5 * unity), "Not between 0 and 5 DAI");
		//Approved first, we transfer the bet from msg.sender
		dai.transferFrom(msg.sender, address(this), _amount);
		//Creating a semi-random number between 1-9
		uint256 x = random(1);
		uint256 y = 1;
		//Five possible answer, five If's. Allways return per three if correct.
		if((0 == x || x == 1) && _select == 1){
			y = _amount * 3;
			dai.approve(address(this), y);
			dai.transferFrom(address(this), msg.sender, y);
		}
		if((2 == x || x == 3) && _select == 2){
			y = _amount * 3;
			dai.approve(address(this), y);
			dai.transferFrom(address(this), msg.sender, y);
		}
		if((4 == x || x == 5) && _select == 3){
			y = _amount * 3;
			dai.approve(address(this), y);
			dai.transferFrom(address(this), msg.sender, y);
		}
		if((6 == x || x == 7) && _select == 4){
			y = _amount * 3;
			dai.approve(address(this), y);
			dai.transferFrom(address(this), msg.sender, y);
		}
		if((8 == x || x == 9) && _select == 5){
			y = _amount * 3;
			dai.approve(address(this), y);
			dai.transferFrom(address(this), msg.sender, y);
		}
		lastResult[userNum[msg.sender]][_game] = y;
		//Thanks to join our game
	}
	//Function Random Bet x5
	function randomBet5(uint256 _game, uint256 _select, uint256 _amount) external{
		require(dai.balanceOf(msg.sender) >= _amount, "Not enought DAI");
		require(_amount > 0 && _amount <= (5 * unity), "Not between 0 and 5 DAI");
		//Approved first, we transfer the bet from msg.sender
		dai.transferFrom(msg.sender, address(this), _amount);
		//Creating a semi-random number between 1-9
		uint256 x = random(1);
		uint256 y = 1;
		//One If all power, easy if random number is the same as selected you win. Allways return per five if correct.
		if(x == _select){
			y = _amount * 5;
			dai.approve(address(this), y);
			dai.transferFrom(address(this), msg.sender, y);
		}
		lastResult[userNum[msg.sender]][_game] = y;
		//Thanks to join our game
	}

	//Crazy Rulette
	function crazyRulette(uint256 _amount, uint256 _winMultiply, uint256 _game) external{
		require(dai.balanceOf(msg.sender) >= _amount, "Not enought DAI");
		require(_amount > 0 && _amount <= (5 * unity), "Not between 0 and 5 DAI");
		require(_winMultiply <= maxWinMult, "Not allowed that multiplier");
		//Approved first, we transfer the bet from msg.sender
		dai.transferFrom(msg.sender, address(this), _amount);
		uint256 x = random(2) * unity;
		uint256 y = 1;
		uint256 perCent = checkPercent(_amount, _winMultiply);
		if(x <= perCent){
			y = _amount * _winMultiply;
			dai.approve(address(this), y);
			dai.transferFrom(address(this), msg.sender, y);
		}
		lastResult[userNum[msg.sender]][_game] = y;
		//Thanks to join our game
	}
	

	//Set Up
	//Take the benefits of the contract
	function takeBenefits() external onlyOwner{
		uint256 x = 0;
		x = uint256(dai.balanceOf(address(this)));//Reads balance of the contract
		dai.approve(msg.sender, x);
		dai.transferFrom(address(this), msg.sender, x);
		//Then approve & transfer all money to my account jeje		
	}
	//Change owner
	function newOwner(address _newOwnerAddres) external onlyOwner{
		changeOwner(_newOwnerAddres);
		//If I want to change my account I have this function on Migrations
	}
	function changeParams(uint256 _newMaxId, uint256 _newMaxWinMult) external onlyOwner{
		maxId =  _newMaxId;
		maxWinMult = _newMaxWinMult;
	}
	function getParams() external view onlyOwner returns(uint256 _maxId, uint256 _MaxWinMult){
		return(maxId, maxWinMult);
	}
	

//Thanks to check this out, it's important that we keep a basic understanding on those games we play and put money on it, for that Ethereum BlockChain is one of the best ways.
//See you on other DAPP !
}


