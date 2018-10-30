Instructions to set up raspberry pi merchant point from scratch.
It's business time.

# 0. Required Equipment
1. Raspberry Pi3
1. 16GB sd card
1. A Ubuntu laptop or computer

# 1. Setup Raspbian on a Micro SD card

1. Download the Raspbian Lite image from raspberrypi.org.
1. Unzip it then write to your micro SD card.
1. Copying to SD drive. **

```bash
wget https://downloads.raspberrypi.org/raspbian_lite_latest
unzip 2018-04-18-raspbian-stretch-lite.zip
sudo dd bs=4M if=2018-04-18-raspbian-stretch-lite.img of=/dev/sdb conv=fsync
```

** A good way to determine which drive your SD card is by running `sudo fdisk -l` before and after plugging it in. Use that drive in the of= (output file) of the dd command. **

After this command finishes you should have a bootable microsd card that can go into the pi by attaching a monitor and keyboard. The default username and password is pi:raspberry.

# 2. Install Git

```bash
sudo apt-get update
sudo apt update
sudo apt-get install git
```

# 3. Setup wifi (optional) for SSH

1. Add the following lines to your /etc/network/interfaces.
```
auto lo

iface lo inet loopback
iface eth0 inet dhcp

allow-hotplug wlan0
auto wlan0

iface wlan0 inet dhcp
      wpa-ssid "<your wifi SSID name>"
      wpa-psk "<your wifi password>""
```

# 4. Setup SSH

1. Bring up Raspbian Config UI.

```bash
sudo raspi-config
````

A configuration window will open: Select Interfacing Options , Navigate to and select SSH , Choose Yes, Select Ok, Choose Finish

1. Enable SSH on boot.
2. Start SSH.

```bash
sudo systemctl enable ssh
sudo systemctl start ssh
```

**Note** Search the network for your Pi:
```bash (from pi)
ifconfig
```

```bash
sudo nmap -sS -p 22 192.168.0.0/24
```

# 5. Install Docker on your Pi.
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

# 6. Install Docker-Compose on your Pi
Docker-compose is used to build and connect our backends.

1. Install python-pip.
1. Pip install docker-compose.
1. Confirm the install.

```bash
sudo apt-get -y install python-pip
sudo pip install docker-compose
docker-compose --version
```

# 7. Setup PI Environment.
A fresh PI is not capable of holding the entire unpruned Bitcoin blockchain.
Instead, we copy over pruned block data.

1. Clone this Git repo
1. Copy the pruned block data into bitcoind/data
1. Set ENV vars for the containers.

```bash
git clone https://github.com/unconst/DockerBitcoindLND.git && cd DockerBitcoinLND
export RPCUSER=<your username> && export RPCPASS=<your password>
```

# 8. Download pruned bitcoin data from IPFS

1. Curl the pruned bitcoin data.
1. Unzip the bitcoin data to .bitcoin
```bash
curl https://ipfs.io/ipfs/QmPdKgR6ifDNABPwHupEA7eEbhbpmGijsNKLrUA5pWELuQ > bitcoind/bitcoin.zip
unzip bitoind/bitcoin.zip -d bitcoins/.bitcoin
```

# 9. Build LND and Bitcoin config envirnoment variable.
```bash
export BITCOIN_CONFIG="`sed -E 's/$/\\\n/g' bitcoind/bitcoin.conf`"
export LND_CONFIG="`sed -E 's/$/\\\n/g' lnd/lnd.conf`"
```

# 9. Compose the Backend.

1. Compose

```bash
sudo docker-compose up
alias lndcli='docker exec -i -o lnd_container lncli'
alias bitcoin-cli='docker exec -i -o bitcoind_container bitcoin-cli'
```
