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
	//Iniciation and fallback function
	constructor(address _daiAddress) public{
		dai = IERC20(_daiAddress);
	} 
	function() external payable{}

	//Mapping to show result, just keep address, anything else is stored
	mapping (address => uint) lastResult1;
	mapping (address => uint) lastResult2;
	mapping (address => uint) lastResult3;
	mapping (address => uint) lastResult4;
	mapping (address => uint) lastResult5;

	//Each of the following functions are used to acces to their personal result of each game
	function getLastResult() external view returns(uint256 _lastResult1){
		require (lastResult1[msg.sender] != 0, "No play, yet.");
		return(lastResult1[msg.sender]);
	}
	function getLastResult2() external view returns(uint256 _lastResult2){
		require (lastResult2[msg.sender] != 0, "No play, yet.");
		return(lastResult2[msg.sender]);
	}
	function getLastResult3() external view returns(uint256 _lastResult3){
		require (lastResult3[msg.sender] != 0, "No play, yet.");
		return(lastResult3[msg.sender]);
	}
	function getLastResult4() external view returns(uint256 _lastResult4){
		require (lastResult4[msg.sender] != 0, "No play, yet.");
		return(lastResult4[msg.sender]);
	}
	function getLastResult5() external view returns(uint256 _lastResult5){
		require (lastResult5[msg.sender] != 0, "No play, yet.");
		return(lastResult5[msg.sender]);
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
		//Creating a semi-random number
		uint256 x = uint256(keccak256(abi.encodePacked("chaos")));
		uint256 y ;
		x = x % (10 ** 16);
		x = x * uint256(now);
		x = x % (10 ** 1);
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
			y = 5 * (10 ** 17);
			dai.approve(address(this), y);
			dai.transferFrom(address(this), msg.sender, y);//Returns 0.2 Dai
		}
		if(x == 8){
			y = 6 * (10 ** 17);
			dai.approve(address(this), y);
			dai.transferFrom(address(this), msg.sender, y);//Retorns 2 Dai
		}
		if(x == 9){
			y = 5 * (10 ** 17);
			dai.approve(address(this), y);
			dai.transferFrom(address(this), msg.sender, y);//Retorns 0.5 Dai
		}
		lastResult1[msg.sender] = y;
		//Thanks to join our game
	}
	//Apple Drop function
	function appleDrop(uint256 _select, uint256 _amount) external{
		require(dai.balanceOf(msg.sender) >= _amount, "Not enought DAI");
		require(_amount > 0 && _amount <= (5 * unity), "Not between 0 and 5 DAI");
		//Approved first, we transfer the bet from msg.sender
		dai.transferFrom(msg.sender, address(this), _amount);
		//Creating a semi-random number between 1-9
		uint256 x = 0;
		uint256 y = 0;
		x = uint256(keccak256(abi.encodePacked("appleDrop")));
		x = x % (10 ** 16);
		x = x * uint256(now);
		x = x % (10 ** 1);
		if(x == 0){
			x = _amount;
		}
		//Three possible answer, three If's. Allways return doble if correct.
		//1 left || 2 center || 3 right
		if(1 <= x && x <= 3 && _select == 1){
			y = _amount * 2;
			dai.approve(address(this), y);
			dai.transferFrom(address(this), msg.sender, y);
			lastResult2[msg.sender] = y;
		}
		if(4 <= x && x <= 6 && _select == 2){
			y = _amount * 2;
			dai.approve(address(this), y);
			dai.transferFrom(address(this), msg.sender, y);
			lastResult2[msg.sender] = y;
		}
		if(7 <= x && x <= 9 && _select == 3){
			y = _amount * 2;
			dai.approve(address(this), y);
			dai.transferFrom(address(this), msg.sender, y);
			lastResult2[msg.sender] = y;
		}
		//If fail, lastResult2 = 1;
		if(y == 0){
			lastResult2[msg.sender] = 1;
		}
		//Thanks to join our game
	}
	//Rape Game function
	function rapeGame(uint256 _select, uint256 _amount) external{
		require(dai.balanceOf(msg.sender) >= _amount, "Not enought DAI");
		require(_amount > 0 && _amount <= (5 * unity), "Not between 0 and 5 DAI");
		//Approved first, we transfer the bet from msg.sender
		dai.transferFrom(msg.sender, address(this), _amount);
		//Creating a semi-random number between 0-9
		uint256 x = 0;
		uint256 y = 0;
		x = uint256(keccak256(abi.encodePacked("rapeGame")));
		x = x % (10 ** 16);
		x = x * uint256(now);
		x = x % (10 ** 1);
		//Five possible answer, five If's. Allways return per three if correct.
		//A || B || C || D || E
		if((0 == x || x == 1) && _select == 1){
			y = _amount * 3;
			dai.approve(address(this), y);
			dai.transferFrom(address(this), msg.sender, y);
			lastResult3[msg.sender] = y;
		}
		if((2 == x || x == 3) && _select == 2){
			y = _amount * 3;
			dai.approve(address(this), y);
			dai.transferFrom(address(this), msg.sender, y);
			lastResult3[msg.sender] = y;
		}
		if((4 == x || x == 5) && _select == 3){
			y = _amount * 3;
			dai.approve(address(this), y);
			dai.transferFrom(address(this), msg.sender, y);
			lastResult3[msg.sender] = y;
		}
		if((6 == x || x == 7) && _select == 4){
			y = _amount * 3;
			dai.approve(address(this), y);
			dai.transferFrom(address(this), msg.sender, y);
			lastResult3[msg.sender] = y;
		}
		if((8 == x || x == 9) && _select == 5){
			y = _amount * 3;
			dai.approve(address(this), y);
			dai.transferFrom(address(this), msg.sender, y);
			lastResult3[msg.sender] = y;
		}
		//If fail, lastResult3 = 1;
		if(y == 0){
			lastResult3[msg.sender] = 1;
		}
		//Thanks to join our game
	}
	//Cock Fight function
	function cockFight(uint256 _select, uint256 _amount) external{
		require(dai.balanceOf(msg.sender) >= _amount, "Not enought DAI");
		require(_amount > 0 && _amount <= (5 * unity), "Not between 0 and 5 DAI");
		//Approved first, we transfer the bet from msg.sender
		dai.transferFrom(msg.sender, address(this), _amount);
		//Creating a semi-random number between 1-9
		uint256 x = 0;
		uint256 y = 0;
		x = uint256(keccak256(abi.encodePacked("cockFight")));
		x = x % (10 ** 16);
		x = x * uint256(now);
		x = x % (10 ** 1);
		if(x == 0){
			x = _amount;
		}
		//Three possible answer, three If's. Allways return doble if correct.
		//1 left || 2 center || 3 right
		if(1 <= x && x <= 3 && _select == 1){
			y = _amount * 2;
			dai.approve(address(this), y);
			dai.transferFrom(address(this), msg.sender, y);
			lastResult4[msg.sender] = y;
		}
		if(4 <= x && x <= 6 && _select == 2){
			y = _amount * 2;
			dai.approve(address(this), y);
			dai.transferFrom(address(this), msg.sender, y);
			lastResult4[msg.sender] = y;
		}
		if(7 <= x && x <= 9 && _select == 3){
			y = _amount * 2;
			dai.approve(address(this), y);
			dai.transferFrom(address(this), msg.sender, y);
			lastResult4[msg.sender] = y;
		}
		//If fail, lastResult4 = 1;
		if(y == 0){
			lastResult4[msg.sender] = 1;
		}
		//Thanks to join our game
	}
	//Smurf Day function
	function smurfDay(uint256 _select, uint256 _amount) external{
		require(dai.balanceOf(msg.sender) >= _amount, "Not enought DAI");
		require(_amount > 0 && _amount <= (5 * unity), "Not between 0 and 5 DAI");
		//Approved first, we transfer the bet from msg.sender
		dai.transferFrom(msg.sender, address(this), _amount);
		//Creating a semi-random number between 0-9
		uint256 x = 0;
		uint256 y = 0;
		x = uint256(keccak256(abi.encodePacked("smurfDay")));
		x = x % (10 ** 16);
		x = x * uint256(now);
		x = x % (10 ** 1);
		//One If all power, easy if semi-random number is the same as selected you win. Allways return per five if correct.
		//0 || 1 || 2 || 3 || 4 || 5 || 6 || 7 || 8 || 9 
		if(x == _select){
			y = _amount * 5;
			dai.approve(address(this), y);
			dai.transferFrom(address(this), msg.sender, y);
			lastResult5[msg.sender] = y;
		}
		//If fail, lastResult5 = 1;
		if(y == 0){
			lastResult5[msg.sender] = 1;
		}
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

//Thanks to check this out, it's important that we keep a basic understanding on those games we play and put money on it, for that Ethereum BlockChain is one of the best ways.
//See you on other DAPP ;)
}


