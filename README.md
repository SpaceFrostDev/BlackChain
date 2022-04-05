<h1 align="center">BlockRoulette</h1>  

BlockRoulette is a decentralized game of Roulette created by SpaceFrostDev and CaseyThayer on the Ethereum blockchain. We follow normal American Roulette conventions wherever possible. We are currently the following betting strategies:
1. Specific Number 1-36
2. Even/Odd
3. Color
4. High/low

<h3 align="left">Payout Function</h3>
We follow American Roulette payout function.
1. Specific Number 35:1
2. Even Odd 1:1
3. Color 1:1
4. High/Low 1:1

<h3 align="left">Player Instructions</h3>

## Deviations from typical Roulette conventions
While we follow typical Roulette conventions wherever possible, we do make a couple notable deviations. We use an American Roulette board, one with 1-36, 0 and 00. Odds and the payout schedule we closely replicate can be found [here](https://www.onlinegambling.com/casino/roulette/bets-payouts/). 

## Development Technologies
We developed BlockRoulette using the [Remix](https://remix-ide.readthedocs.io/en/latest/) IDE, [Ganache](https://trufflesuite.com/docs/ganache/overview) and [MetaMask](https://docs.metamask.io/guide/#account-management). 

## Resources
[Roulette](https://en.wikipedia.org/wiki/Roulette) is a game of chance. In our implementation, there is no notion of Roulette wheel number sequence, as all numbers are generated pseudorandomly by `keccak256` hashing some hard-to-guess but **NOT** cryptographically secure random inputs.