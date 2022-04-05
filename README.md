<h1 align="center">BlockRoulette</h1>  

BlockRoulette is a decentralized game of Roulette created by SpaceFrostDev and CaseyThayer on the Ethereum blockchain. We follow normal American Roulette conventions wherever possible. We are currently the following betting strategies:
1. Specific Number 1-36
2. Even/Odd
3. Color
4. High/low

<h3 align="left">Payout Function</h3>  
Odds and the payout schedule we closely replicate can be found [here](https://www.onlinegambling.com/casino/roulette/bets-payouts/). We follow American Roulette payout function.  

1. Specific Number 35:1  
2. Even Odd 1:1  
3. Color 1:1  
4. High/Low 1:1

<h3 align="left">Player Instructions</h3>  

1. Use the placeBet tab to place a bet or multiple bets
2. Spin the roulette wheel, getting paid from your winning bets
3. There is no step 3, enjoy :)


<h3 align="left">Deviation from conventions</h3>  
While we follow typical Roulette conventions wherever possible, we do make a couple notable deviations. Firstly, we use an American Roulette board with numbers 1-36, 0 and 00. Secondly, we don't implement all possible betting strategies. For example, in our game, you can't bet on a row, or the first third. 

<h3 align="left">Pseudo Random Number Generation</h3>  
PRNG is achieved using SHA3 and some hard-to-know but NOT cryptographically secure random input.

## Development Technologies
We developed BlockRoulette using the [Remix](https://remix-ide.readthedocs.io/en/latest/) IDE, [Ganache](https://trufflesuite.com/docs/ganache/overview) and [MetaMask](https://docs.metamask.io/guide/#account-management). 

## Resources
[Roulette](https://en.wikipedia.org/wiki/Roulette) is a game of chance. In our implementation, there is no notion of Roulette wheel number sequence, as all numbers are generated pseudorandomly by `keccak256` hashing some hard-to-guess but **NOT** cryptographically secure random inputs.