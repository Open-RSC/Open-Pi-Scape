# Open-Pi-Scape
Customized version of RSC Single Player for the Raspberry Pi 3 and above

You will want to have a bootable microSD card running a fresh install of CentOS 8 aarch64:
http://isoredirect.centos.org/centos/8-stream/isos/aarch64/

You can write to your microSD card using various utilities. Here is a great open source tool for any platform:
https://www.balena.io/etcher/


Once installed, perform OS updates and install OpenJDK, MariaDB (SQL server), and various utilities via:
```
sudo yum update -y && sudo yum install git wget htop mariadb adoptopenjdk-8-openj9 -y
```

Now, enable MariaDB to start up:
```
sudo systemctl enable --now mariadb
```


If you wish, configure MariaDB:
```
sudo mysql_secure_installation
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