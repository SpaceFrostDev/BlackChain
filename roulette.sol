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
    uint8 state;    // This state of the roulette board
    uint pot;       // Total pot

    struct Bet{
        uint256 amount;    // Amount of bet in wei
        address player;
        uint8 betCode;     // See betting strategy codes table
        uint8 subCode;     // See subcodes
    }

    Bet[] public currentBets;    // Publicly viewable array holding all current player bets


/*
@dev TODO constructor
@dev TODO placeBet()
@dev TODO generateRandomNum()

Payout schedule, running pot, multiple bets can be adjusted in version 1
V0.1 simply takes one bet and doubles the players money no matter what their betting strategy
*/
}