# Install Docker
Now we are getting to the point. Installing docker on our Raspberry Pi so we can containerize all of our applications. Installing Docker on our Pi is really very simple

```bash
curl -ssl https://get.docker.com | sh
```

This will take a little while… 5 minutes or more. Once that is complete, we will
add the current user (pi) into the docker user group.

```bash
sudo usermod -a -G docker $USER
```

and then confirm the install with a simple version command

```bash
docker --version
```

Docker is installed and functioning.

# Install docker-compose
Installing Docker on our Raspberry Pi with get.docker.com does not automatically install docker-compose. Here is how to get docker-compose onto our Pi.

Install python-pip

```bash
sudo apt-get -y install python-pip
```

now pip install docker-compose

```bash
sudo pip install docker-compose
```

Once again, confirm the install with a simple version command

```bash
docker-compose --version
```

Technically have now accomplished out goals. Docker and Docker Compose are installed on our Raspberry Pi and we can SSH using ssh keys for authentication. If you want to stop here, I don’t blame you! The following steps are optional, but they are things I always do.
