This repo contains the a docker-compose.yml and corresponding Dockerfiles which together run a lightning node over a local pruned Bitcoin Node on a Raspberry Pi micro computer. Phew!
Very useful for setting uo small micro services which can accept and make lightning payments. Hope you enjoy.

# 0. Required Equipment
1. Raspberry Pi3 (Pi) with internet connectivity.
1. Docker (Step 1)
1. Docker-Compose (Step 2)

**Note** Steps for setting up a Pi are in pi-README.md 

# 1. Install Docker on your Pi.
Docker is used to contanerize the LND and Bitcoind background services.

1. Install Docker..
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
# DOWNLOAD THE PRUNED DATA (HOWEVER YOU WANT) into bitcoin.zip
unzip bitcoin.zip -d bitcoind/bitcoin_data
```

# 4. Build LND and Bitcoin config envirnoment variable.
The configs for Lnd and Bitcoind are stored in bitcoind/bitcoin.conf and lnd/lnd.conf. 


# 5. Compose the Backend.

1. Compose and build the containers.
1. Alias the lncli.
1. Alias the bitcoind cli.

```bash
sudo docker-compose up --build
sudo alias lndcli='docker exec -i -t lnd_container lncli'
sudo alias bitcoin-cli='docker exec -i -t bitcoind_container bitcoin-cli'
```

# 6. Wait for Nodes to sync.
After this step you will need to wait for the Bitcoin container to finish syncing. Check this progress through the logs.

```bash
docker logs bitcoind_container
docker logs lnd_container
```




