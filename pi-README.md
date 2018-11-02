
# 0. Required Equipment
1. Raspberry Pi3 (Pi) 
2. 16G SSD card
3. Host Computer.

# 1. Setup Raspbian on a Micro SD card.

1. Download the Raspbian Lite image from raspberrypi.org.
1. Unzip it then write to your micro SD card.
1. Copying to SD drive. **

```bash (Host)
wget https://downloads.raspberrypi.org/raspbian_lite_latest
unzip 2018-04-18-raspbian-stretch-lite.zip
sudo dd bs=4M if=2018-04-18-raspbian-stretch-lite.img of=/dev/sdb conv=fsync
```

** A good way to determine which drive your SD card is by running `sudo fdisk -l` before and after plugging it in. Use that drive in the of= (output file) of the dd command. **

After this command finishes you should have a bootable microsd card that can go into the pi by attaching a monitor and keyboard. The default username and password is pi:raspberry.

# 2. Install Git

```bash (Pi)
sudo apt-get update
sudo apt update
sudo apt-get install git
```

# 3. Setup wifi (optional) for SSH

```bash (Pi)
sudo raspi-config
```

A configuration window will open: Select Networking  Options , Navigate to enter you SSID and wifi , Choose Yes, Select Ok, Choose Finish

# 4. Setup SSH

1. Bring up Raspbian Config UI.

```bash (Pi)
sudo raspi-config
```

A configuration window will open: Select Interfacing Options , Navigate to and select SSH , Choose Yes, Select Ok, Choose Finish

1. Enable SSH on boot.
2. Start SSH.

```bash
sudo systemctl enable ssh
sudo systemctl start ssh
```

**Note** Search the network for your Pi:
```bash (Pi)
ifconfig
```

```bash (Host)
sudo nmap -sS -p 22 192.168.0.0/24
// Should show port 22 (ssh port) as open
```


