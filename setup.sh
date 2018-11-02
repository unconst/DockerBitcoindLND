
echo "Installing Docker."
curl -ssl https://get.docker.com | sh
sudo usermod -a -G docker $USER
docker --version
echo "Done."

echo "Installing Pip."
sudo apt-get -y install python-pip
sudo pip install docker-compose
docker-compose --version
echo "Done."

echo "Downloading Bitcoin Pruned Data."
git clone https://github.com/unconst/DockerBitcoindLND.git && cd DockerBitcoinLND
curl https://ipfs.io/ipfs/QmPdKgR6ifDNABPwHupEA7eEbhbpmGijsNKLrUA5pWELuQ > bitcoin.zip
unzip bitcoin.zip -d bitcoind/bitcoin
echo "Done."

echo "Setting LND_CONFIG and BITCOIN_CONFIG env vars."
export BITCOIN_CONFIG="`sed -E 's/$/\\\n/g' bitcoind/bitcoin.conf`"
export LND_CONFIG="`sed -E 's/$/\\\n/g' lnd/lnd.conf`"
source ~/.bashrc
echo -en $LND_CONFIG
echo -en $BITCOIN_CONFIG
echo "Done."

echo "Building docker containers."
sudo docker-compose up --build -d
alias lncli='docker exec -i -t lnd_container lncli'
alias bitcoin-cli='docker exec -i -t bitcoind_container bitcoin-cli'
echo "Done.




