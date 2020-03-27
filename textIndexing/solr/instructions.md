# Introduction

[Solr](https://lucene.apache.org/solr/downloads.html) is a free text searching engine from the Apache project.  It is very flexible and fast and can process a variety of file formats.  We will use Solr to index and search files from **getpapers** and **ami**

# Setting up Solr
Getting a Solr server running is straightforward.  Solr runs best on Linux.  I use an Oracle VirtualBox VM with 120Gb disk space and 8Gb RAM, running 64 bit Ubuntu LTS 18.04
## Setting up the VirtualBox
1. [Download VirtualBox](https://www.virtualbox.org/wiki/Downloads)
2. [Download Ubuntu](https://ubuntu.com/#download)
3. Create an Ubuntu VM with 120Gb HDD (if you can spare it) and 8Gb RAM.  Call it **SOLR**.  Use the ISO you downloaded in step 2 to boot the machine.
4. Set up the VM to forward the 8983 port to the host OS
5. When the machine has installed and is running, log onto it.  Open a terminal window and install **node.js**, **npm**, **curl** and **getpapers** by typing the following commands
```bash
sudo apt update
sudo apt install nodejs
sudo apt install npm
npm install --global getpapers
sudo npm install --global getpapers
sudo apt install curl
```
6. Open the firewall on the machine
```bash
sudo ufw allow 8983
```
7. Create a working directory for **getpapers**
```bash
mkdir getpapers
chmod o+rwx getpapers
```
8. Install Java for **Solr**
```bash
sudo apt install default-jre
sudo apt install opendk-11-jre-headless
java -version
```
9. 


