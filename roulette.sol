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


contract Roulette {
    using SafeMath for uint256;
    uint8[] red = [1,3,5,7,9,12,14,16,18,19,21,23,25,27,30,32,34,36];
    uint8[] black = [2,4,6,8,10,11,13,15,17,20,22,24,26,28,29,31,33,35];
    uint256 houseBalance = 0;

    struct Bet{
        uint256 amount;    // Amount of bet in wei
        address player;
        uint8 betCode;     // See betting strategy codes table
        uint8 subCode;     // See subcodes
    }

    Bet[] public currentBets;    // Public array holding all current player bets

    constructor() public {
        // Intentionally left blank
    }

    function spinWheel() public {
        // Pseudo-random number generation, highly imperfect but functional
        uint difficulty = block.difficulty;
        bytes32 blockHash = blockhash(block.number-1);
        Bet memory lastBet = currentBets[currentBets.length-1];
        uint randNum = uint(keccak256(abi.encodePacked(now, difficulty, blockHash, 
            lastBet.betCode, lastBet.player, lastBet.subCode))) % 38;    // American Roulette

        for (uint i = 0; i < currentBets.length; i++) {
            bool isWin = false;
            Bet memory bet = currentBets[i];

            // Switch statement from C++ would be ideal
            if (randNum == 37 || randNum == 38){    // Player loses regardless of bet strat
                break;
            }
            if (bet.betCode == 0) {
                isWin = (randNum == bet.subCode);
            }
            if (bet.betCode == 1) {
                isWin = (bet.subCode == (randNum % 2));
            }
            if (bet.betCode == 2) {
                if (bet.subCode == 0) {    // bet on black
                    if (randNum <= 10 || (randNum>= 20 && randNum <= 28)) {
                        isWin = (randNum % 2 == 0);    // If in range, must be even
                    }
                    else {
                        isWin = (randNum % 2 == 1);    // If not in that range, must be odd
                    }
                }
                else {    // bet on red
                    if ((randNum >= 12 && randNum <= 18) || randNum >= 30) {
                        isWin = (randNum % 2 == 0);
                    }
                    else {
                        isWin = (randNum % 2 == 1);
                    }
                }
            }
            if (bet.betCode == 3) {    // bet high/low
                if (bet.subCode == 0) {
                    isWin = (randNum < 16);
                }
                else {
                    isWin = (randNum >= 16);
                }
            }

            if (isWin) {
                bet.amount = bet.amount.mul(2);    // @dev Payout function
                bet.player.transfer(bet.amount);
            }
            else {
                houseBalance.add(bet.amount);
            }
        }

        // @dev Delete bets
        currentBets.length = 0;
    }

/*
@dev v1.0 TODO
- payout function improvement
*/
}