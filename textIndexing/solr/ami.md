#  Using ami with Solr

Search for n95 and mask

See [PMRs basic intro]() for basics

## Setting up

### Install ami
make a directory to hold the software
```bash
    sudo apt install git
    mkdir software/ami
    mkdir software
    cd software
    mkdir ami
    cd ami
    git clone https://github.com/petermr/ami-jars.git
```

add AMI to the PowerShell profile
```bash
    pwsh
    code $profile
    $env:PATH += ":~/software/ami/ami-jars/ami20190917a/bin" #note the case!
```

### Install norma
```bash
wget https://github.com/ContentMine/norma/releases/download/v0.2.26/norma_0.1.SNAPSHOT_all.deb
sudo dpkg -i norma_0.1.SNAPSHOT_all.deb
```
## Searching

Run the search
```bash
    getpapers -q "(N95) AND (mask)" -o n95 -f n95/log.txt -x -p
```
Then **ami**
```
ami-search -p n95 --dictionary country disease funders
```

To add them to Solr
```bash
sudo su - solr -c "/opt/solr/bin/post -c mycore /home/clyde/getpapers/coronavirus" 2>n95.err.txt 1>n95.log.txt
```
The redirects pipe the error and log output to two separate files.

More interested in what fials for now rather than what succeeds.
