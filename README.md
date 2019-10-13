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

password: centos


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
over_voltage=4 #Electric power sent to CPU / GPU (4 = 1.3V)
disable_splash=1 # Disables the display of the electric alert screen
force_turbo=1
sdram_freq=600
boot_delay=1
gpu_mem=320
```

Once installed, perform OS updates and install OpenJDK, MariaDB (SQL server), and various utilities via:
```
yum update -y && sudo yum install git wget htop mariadb adoptopenjdk-8-openj9 -y
```

Now, enable MariaDB to start up:
```
systemctl enable --now mariadb
```


If you wish, configure MariaDB:
```
mysql_secure_installation
```


Next, ensure your verison of java is installed properly:
```
java -version
```


It should look something like:
```
openjdk version "13" 2019-09-17
OpenJDK Runtime Environment AdoptOpenJDK (build 13+33)
Eclipse OpenJ9 VM AdoptOpenJDK (build openj9-0.16.0, JRE 13 Linux amd64-64-Bit Compressed References 20190916_75 (JIT enabled, AOT enabled)
OpenJ9 - 867dab457
OMR - d4c85c31
JCL - 2858e3f001 based on jdk-13+33)
```

Now download the zip release of this repo - or clone it with Git.