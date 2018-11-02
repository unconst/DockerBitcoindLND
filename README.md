This repo contains the code and steps needed to set up a lightning and Bitcoin Node on a Raspberry Pi micro computer.

# 0. Required Equipment
1. Raspberry Pi3 (Pi) with internet connectivity.
1. Docker (Step 1)
1. Docker-Compose (Step 2)

**Note** Steps for setting up a Pi are in pi-README.md 

# 1. Install Docker on your Pi.
We use Docker on our Raspberry Pi because it allows us to containerize the our
LND and Bitcoind background services.

1. Install Docker on our Pi.
1. Add the current user (pi) into the docker user group.
1. Confirm the install.

```bash
curl -ssl https://get.docker.com | sh
sudo usermod -a -G docker $USER
docker --version
```

# 2. Install Docker-Compose on your Pi
Docker-compose is used to build and connect our backends.

1. Install python-pip.
1. Pip install docker-compose.
1. Confirm the install.

```bash
sudo apt-get -y install python-pip
sudo pip install docker-compose
docker-compose --version
```

# 3. Download this reposititory and pruned bitcoin data from IPFS
A fresh PI is not capable of holding the entire unpruned Bitcoin blockchain.
Instead, to speed up the process of syncing the blockchain we pull a pruned version from IPFS.
**Note** it is dangerous to use our pruned data since we could have corrupted the pruned files.
It is better to sync and prune your own files and copy them across.

1. Clone this Git repo
1. Download the Pruned data from IPFS
1. Unzip the data into the bitcoind/bitcoin folder.

```bash
git clone https://github.com/unconst/DockerBitcoindLND.git && cd DockerBitcoinLND
curl https://ipfs.io/ipfs/QmPdKgR6ifDNABPwHupEA7eEbhbpmGijsNKLrUA5pWELuQ > bitcoin.zip
unzip bitcoin.zip -d bitcoind/bitcoin
```

# 4. Build LND and Bitcoin config envirnoment variable.
The configs for Lnd and Bitcoind are stored in bitcoind/bitcoin.conf and lnd/lnd.conf. We pipe these into the docker containers using environment variables.
In order to change the configs, merely edit them and rerun the commands below.

1. Set BITCOIN_CONFIG
1. Set LND_CONFIG

```bash
export BITCOIN_CONFIG="`sed -E 's/$/\\\n/g' bitcoind/bitcoin.conf`"
export LND_CONFIG="`sed -E 's/$/\\\n/g' lnd/lnd.conf`"
```

# 5. Compose the Backend.

1. Compose and build the containers.
1. Alias the lncli.
1. Alias the bitcoind cli.

```bash
sudo docker-compose up --build
alias lndcli='docker exec -i -t lnd_container lncli'
alias bitcoin-cli='docker exec -i -t bitcoind_container bitcoin-cli'
```

# 6. Wait for Nodes to sync.
After this step you will need to wait for the Bitcoin container to finish syncing. Check this progress through the logs.

```bash
docker logs bitcoind_container
```




