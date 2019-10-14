# Open-Pi-Scape
Customized version of RSC Single Player for the Raspberry Pi 3 and above

You will want to have a bootable microSD card running a fresh install of CentOS aarch64:
http://isoredirect.centos.org/altarch/7/isos/armhfp/CentOS-Userland-7-armv7hl-RaspberryPI-GNOME-1908-sda.raw.xz

You can write to your microSD card using various utilities. Here is a great open source tool for any platform:
https://www.balena.io/etcher/


See this guide:
https://wiki.centos.org/SpecialInterestGroup/AltArch/armhfp?action=show&redirect=SpecialInterestGroup%2FAltArch%2FArm32#head-0f62978700d6645d09caddc100a5d1aa2cbdac1f

First, SSH into your Pi and use the default credentials:
```
ssh root@YOUR_PI's_IP_ADDRESS
```

SSH user password: centos


You will need to expand the filesystem to use the entire microSD card:
```
/usr/bin/rootfs-expand
```

You next should turbo / overclock your Pi as it is generally pretty slow otherwise:
https://haydenjames.io/raspberry-pi-3-overclock/
```
yum install -y nano
nano /boot/config.txt
```

Paste the following:
```
core_freq=500 # GPU Frequency
arm_freq=1350 # CPU Frequency
over_voltage=4 # Electric power sent to CPU / GPU (4 = 1.3V)
disable_splash=1 # Disables the display of the electric alert screen
force_turbo=1
sdram_freq=600
boot_delay=1
# gpu_mem=320 # Reserved memory for GPU
```


Once installed, perform OS updates and install MariaDB (SQL server), and various utilities via:
```
yum update -y && sudo yum install git wget mariadb mariadb-server ant screen -y
```

Enable MariaDB to start up:
```
systemctl enable --now mariadb
```

Verify Java is installed correctly:
```
java -version
```

It should look something like:
```
openjdk version "1.8.0_222"
OpenJDK Runtime Environment (build 1.8.0_222-b10)
OpenJDK Zero VM (build 25.222-b10, interpreted mode)
```

Now download the zip release of this repo - or clone it with Git.
```
git clone https://gitlab.openrsc.com/open-rsc/Open-Pi-Scape.git && cd Open-Pi-Scape
```


Set the root user's password to "root" instead of the default and it being blank:
```
mysql -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('root');"
```

Create the database(s) and import:
```
mysql -uroot -proot -e "create database openrsc;" && mysql openrsc < Required/openrsc_game_server.sql && mysql openrsc < Required/openrsc_game_players.sql

mysql -uroot -proot -e "create database cabbage;" && mysql cabbage < Required/cabbage_game_server.sql && mysql cabbage < Required/cabbage_game_players.sql
```

Open the firewall ports:
```
firewall-cmd --zone=public --add-port=80/tcp --permanent
firewall-cmd --zone=public --add-port=443/tcp --permanent
firewall-cmd --zone=public --add-port=43594/tcp --permanent
firewall-cmd --zone=public --add-port=43595/tcp --permanent
firewall-cmd --zone=public --add-port=43596/tcp --permanent
firewall-cmd --zone=public --add-port=43597/tcp --permanent
firewall-cmd --zone=public --add-port=43598/tcp --permanent
firewall-cmd --zone=public --add-port=43599/tcp --permanent
firewall-cmd --reload 
```

Start the game server:
```
screen

ant -f Required/server/build.xml runserver
```

Press CTRL + A + D to leave the screen view and keep the server running in the background.

To resume viewing, type:
```
screen -r
```