pragma solidity ^0.5.0;

/*
@dev Betting Strategy Codes Table
    0: Player's strategy is betting on an exact number
    1: Even/odd
    2: Color
    3. High/Low
@dev Subcodes
    0: Subcode is exact number
    1: 0 is Even, 1 is Odd
    2. 0 is Red, 1 is Black
    3. 0 is Low, 1 is High
*/

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.3.0/contracts/math/SafeMath.sol";

contract Roulette {
    using SafeMath for uint256;
    uint8[] red = [1,3,5,7,9,12,14,16,18,19,21,23,25,27,30,32,34,36];
    uint8[] black = [2,4,6,8,10,11,13,15,17,20,22,24,26,28,29,31,33,35];
    uint256 houseBalance = 100_000_000_000_000_000;
    uint256 allBetTotal = 0;

    struct Bet{
        uint256 amount;    // Amount of bet in wei
        address payable player;
        uint8 betCode;     // See betting strategy codes table
        uint8 subCode;     // See subcodes
    }

    Bet[] public currentBets;    // Public array holding all current player bets

    constructor() public {
    }

    function placeBet(uint8 betCode, uint8 subCode) payable public {
        require(msg.value > 0); 
        require(betCode >= 0 && betCode <= 3);
        if (betCode == 0) {
            require(subCode >= 1 && subCode <= 35);
        }
        else {
            require(subCode == 0 || subCode == 1);
        }
        if (houseBalance <= msg.value.mul(2)) {
            houseBalance.add(msg.value.mul(2));
        }
        currentBets.push(Bet({amount: msg.value, player: msg.sender, 
                                betCode: betCode, subCode: subCode}));
        
        allBetTotal.add(msg.value);
    }
    /*
        Payout structure:
        0 - 36x
        1 - 2x
        2 - 2x
        3 - 2x

        A bet is valid when:
        1 - the value of the bet is correct (=Amount)
        2 - betCode is known (between 0 and 3)
        3 - subCode is known (between 0 and 3)
        4 - the option betted is valid
        5 - the bank has enough funds to pay the maximum potential winnings  
    } */

    function getCurrentBets() public view returns(uint, uint) {
        uint allBetTotal = 0;
		for (uint i = 0; i < currentBets.length; i++) {
			allBetTotal += currentBets[i].allBetTotal;
        
        return (allBetTotal, currentBets.length);
    }
    
    function spinWheel() public {
        // Pseudo-random number generation, imperfect but functional
        uint difficulty = block.difficulty; 
        Bet memory lastBet = currentBets[currentBets.length-1];
        uint randNum = uint(keccak256(abi.encodePacked(now, difficulty, 
            lastBet.betCode, lastBet.player, lastBet.subCode))) % 38;    // American Roulette

        for (uint i = 0; i < currentBets.length; i++) {
            bool isWin = false;
            Bet memory bet = currentBets[i];

            if (randNum != 0 && randNum != 37) {    // Player loses regardless of bet strat
                if (bet.betCode == 0) {
                    isWin = (randNum == bet.subCode);
                    if (isWin) { bet.amount = bet.amount.mul(35); }
                }
                if (bet.betCode == 1) {
                    isWin = (bet.subCode == (randNum % 2));
                    if (isWin) { bet.amount = bet.amount.mul(35); }
                }
                if (bet.betCode == 2) {
                    if (bet.subCode == 0) {    // bet on black
                        if (randNum <= 10 || (randNum>= 20 && randNum <= 28)) {
                            isWin = (randNum % 2 == 0); }   // If in range, must be even
                        else {
                            isWin = (randNum % 2 == 1); }   // If not in that range, must be odd
                    }
                    else {    // bet on red
                        if ((randNum >= 12 && randNum <= 18) || randNum >= 30) {
                            isWin = (randNum % 2 == 0); }
                        else { isWin = (randNum % 2 == 1); }
                    }

                    if (isWin) { bet.amount = bet.amount.mul(2); }
                }
                if (bet.betCode == 3) {    // bet high/low
                    if (bet.subCode == 0) { isWin = (randNum < 16); }
                    else { isWin = (randNum >= 16); }

                    if (isWin) { bet.amount = bet.amount.mul(35); }
                }
            }

            if (isWin) { bet.player.transfer(bet.amount); }
            else { houseBalance.add(bet.amount); }
        }

        // @dev Delete bets
        currentBets.length = 0;
        allBetTotal = 0;
        
    }
}

    function getCurrentBets() public view returns(uint256 betTotal, uint numBets) {
        return (allBetTotal, currentBets.length);
    }

    function spinWheel() public {
        // Pseudo-random number generation, imperfect but functional
        uint difficulty = block.difficulty; 
        Bet memory lastBet = currentBets[currentBets.length-1];
        uint randNum = uint(keccak256(abi.encodePacked(now, difficulty, 
            lastBet.betCode, lastBet.player, lastBet.subCode))) % 38;    // American Roulette

        for (uint i = 0; i < currentBets.length; i++) {
            bool isWin = false;
            Bet memory bet = currentBets[i];

            if (randNum != 0 && randNum != 37) {    // Player loses regardless of bet strat
                if (bet.betCode == 0) {
                    isWin = (randNum == bet.subCode);
                    if (isWin) { bet.amount = bet.amount.mul(35); }
                }
                if (bet.betCode == 1) {
                    isWin = (bet.subCode == (randNum % 2));
                    if (isWin) { bet.amount = bet.amount.mul(35); }
                }
                if (bet.betCode == 2) {
                    if (bet.subCode == 0) {    // bet on black
                        if (randNum <= 10 || (randNum>= 20 && randNum <= 28)) {
                            isWin = (randNum % 2 == 0); }   // If in range, must be even
                        else {
                            isWin = (randNum % 2 == 1); }   // If not in that range, must be odd
                    }
                    else {    // bet on red
                        if ((randNum >= 12 && randNum <= 18) || randNum >= 30) {
                            isWin = (randNum % 2 == 0); }
                        else { isWin = (randNum % 2 == 1); }
                    }

                    if (isWin) { bet.amount = bet.amount.mul(2); }
                }
                if (bet.betCode == 3) {    // bet high/low
                    if (bet.subCode == 0) { isWin = (randNum < 16); }
                    else { isWin = (randNum >= 16); }

                    if (isWin) { bet.amount = bet.amount.mul(35); }
                }
            }

            if (isWin) { bet.player.transfer(bet.amount); }
            else { houseBalance.add(bet.amount); }
        }

        // @dev Delete bets
        currentBets.length = 0;
        allBetTotal = 0;
        
    }
}