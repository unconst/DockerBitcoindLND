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

# Install docker-compose on your Pi
Docker-compose is used to build and connect our backends.

1. Install python-pip.
1. Pip install docker-compose.
1. Confirm the install.

```bash
sudo apt-get -y install python-pip
sudo pip install docker-compose
docker-compose --version
```
