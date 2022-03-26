# BlockRoulette
BlockRoulette is a decentralized game of Roulette on the Ethereum blockchain utilizing `Chainlink`s verifiable randomness function. BlockRoulette uses it's own ERC20 compliant `BRT` token. We follow normal Roulette conventions wherever possible. We are currently developing support for players betting on:
1. Specific Numbers
2. Even/Odd
3. Color

This list is subject to revision in the future and may possibly be expanded to include
1. High/Low
2. First 12, Second 12, Third 12


## Next Steps
1. Create RouletteContract contract
2. Wireframe nessecary functions
3. Decide on randomness implementation

## Deviations from typical Roulette conventions
While we follow typical Roulette conventions wherever possible, we do make a couple notable deviations. We use an American Roulette board, one with 1-36, 0 and 00. Odds and payout schedule can be found [here](https://www.onlinegambling.com/casino/roulette/bets-payouts/). 

## Development Technologies
We developed BlockRoulette using the [Remix](https://remix-ide.readthedocs.io/en/latest/) IDE, [Ganache](https://trufflesuite.com/docs/ganache/overview) and [MetaMask](https://docs.metamask.io/guide/#account-management). 

## Resources
[Roulette](https://en.wikipedia.org/wiki/Roulette) is a game of chance. In our implementation, there is no notion of Roulette wheel number sequence, as all numbers are generated pseudorandomly by Chainlink's Verifiable Randomness Function.