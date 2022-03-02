# <img src="https://github.com/stinkyfi/DLacieTattoContracts/blob/main/images/NARCISSUS.png" width="500">

100 immutable supply NFT, used to get access to a special form. Win the Raffles and get a chance to cut the line.

Address: ```0xF8eAE98B903026FFc6Cf6C110FcA374A2f16CE82```

## Run Contract Locally

The first things you need to do are cloning this repository and installing its
dependencies:

```sh
git clone https://github.com/stinkyfi/DLacieTattoContracts.git
cd DegenDwarfs
npm install
```

Once installed, let's run Hardhat's testing network:

```sh
npx hardhat node
```

Then, on a new terminal, go to the repository's root folder and run this to
deploy your contract:

```sh
npx hardhat run scripts/deploy.js --network localhost
```

Validate Contract on Etherscan(Polyscan):
```sh
npx hardhat verify --network matic 0xF8eAE98B903026FFc6Cf6C110FcA374A2f16CE82 "Narcissus" "NCUS"
```
