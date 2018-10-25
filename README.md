# Install Docker on your Pi.
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

# Install Docker-Compose on your Pi
Docker-compose is used to build and connect our backends.

1. Install python-pip.
1. Pip install docker-compose.
1. Confirm the install.

```bash
sudo apt-get -y install python-pip
sudo pip install docker-compose
docker-compose --version
```

# Setup PI Environment.
A fresh PI is not capable of holding the entire unpruned Bitcoin blockchain.
Instead, we copy over pruned block data.

1. Clone this Git repo
1. Copy the pruned block data into bitcoind/data
1. Set ENV vars for the containers.

```bash
git clone https://github.com/unconst/DockerBitcoindLND.git && cd DockerBitcoinLND
mkdir -p bitcoind/data && ...
export RPCUSER=<your username> && export RPCPASS=<your password>
```

# Compose the Backend.

1. Compose

```bash
sudo docker-compose up
```
