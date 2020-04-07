# Introduction to Solr

[Solr](https://lucene.apache.org/solr/downloads.html) is a free text searching engine from the Apache project.  It is very flexible, fast and can process a variety of file formats.  

Solr analyses documents, extracting words and terms, and building indexes for fast retrieval.  You can also call its query engine through simple GET requests.  Solr can handle free text, rich documents such as PDFs or Word documents, and structured text such as XML and JSON.

We will use Solr to index and search files from **getpapers** and **ami**.  **getpapers** can download article body text as both PDF and XML files, both of which Solr takes in its stride.

# Setting up Solr
Getting a Solr server running is straightforward.  Solr runs best on Linux.  I use an Oracle VirtualBox VM with 120Gb disk space and 8Gb RAM, running 64 bit Ubuntu LTS 18.04.

**N.B:  Don't be tempted to use a Docker build for Solr. Running in a container makes issuing commands very difficult.  This manual build process is only slightly more difficult than using the Docker approach.**

## Setting up Solr on the VirtualBox
1. [Download VirtualBox](https://www.virtualbox.org/wiki/Downloads) and install it.
2. [Download Ubuntu](https://ubuntu.com/#download)
3. Create an Ubuntu VM with 120Gb HDD (if you can spare it) and 8Gb RAM.  Call it **SOLR**.  Use the ISO you downloaded in step 2 to boot the machine.
4. Set up the VM to forward the 8983 port to the host OS
5. When the machine has installed and is running, log onto it.  Open a terminal window and install **node.js**, **npm** and **getpapers** by typing the following commands
```bash
sudo apt update
sudo apt install nodejs
sudo apt install npm
sudo npm install --global getpapers
```
6. Open the firewall on the machine so that other processes can access Solr
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
# check that Java is installed
java -version
```
9. Once you have Java installed then it's time to set up Solr.  
First, type `cd /opt`.  Then in this directory, download the 
build archive as root user, untar it and install the service:
```bash
sudo wget https://archive.apache.org/dist/lucene/solr/8.3.1/solr-8.3.1.tgz
sudo tar xzf solr-8.3.1.tgz solr-8.3.1/bin/install_solr_service.sh --strip-components=2
sudo bash ./install_solr_service.sh solr-8.3.1.tgz
```
10. Now start the service and create a Solr core called **getpapers**:
```bash
sudo service solr start
sudo su - solr -c "/opt/solr/bin/solr create -c getpapers -n data_driven_schema_configs"
```
11. Check the core is running by browsing to **http://localhost:8983** and selecting it in the **Core Selector** dropdown on the sidebar.

# Indexing documents
Solr uses the `bin/post` command to index documents.  You point the command at a directory and Solr does the rest.  If you set up your core with the **data_driven_schema_configs** option then Solr will decide how to go about indexing the


Let's assume you are going to search for papers on COVID-19.  The following commands will retrieve papers and index them in Solr:
```bash
getpapers -q  -x -p "COVID-19" -o getpapers/covid19 # the -x and -p switches download the fult text as XML and PDFs
sudo su - solr -c "/opt/solr/bin/post -c getpapers /home/clyde/getpapers"
```
Solr adds all the files in **getpapers** and subdirectories to its index.  If a file exists then it simply overwrites the index information.

# Searching with Solr

1. Navigate to `http://localhost8983`.  You should see the administration screen
2. Select the `getpapers` core in the core selector.
3. Click the Query link in the sidebar
4. Enter `abstractText:coronavirus` in the **q** box on the query screen
5. The server displays  JSON summarising the search results

Congratulations!  You now have a fully-functioning Solr server with full search capability.  

# Housekeeping
## Trashing a core

You can delete a core with the command:
```bash
sudo su - solr -c "/opt/solr/bin/solr delete -c <core name> "
```
This is useful if things get messy.

# Setting up the field definitions in Solr
Creating a data-definition driven index in Solr (which is what we did above) has its problems.  It is fine for getting started with Solr but no good for production work.  If you [index the DOAJ BibJson material](../DOAJSplitter/DOAJSplitter/README.md) you will find it will refuse to index certain documents.  This is because when it first encounters a new JSON property it makes assumptions about the data type.  

If it first encounters a **bibjson.start_page** property which is a number then it will assume that the field is an integer and create a Solr field for that type.  Subsequent fields containg alpha characters cause the indexing to fail.

I created the DOAJ collection using a data-driven schema, and then redircted the error output:
```powershell
sudo su - solr -c "/opt/solr/bin/post -c getpapers /home/clyde/getpapers" 2> errlog.txt
```
This produces a *very* large file.  To isolate these erroring fields, I used:
```bash
grep -Po 'Error adding field \K.*?(?=msg)' errlog.txt >errcodes.txt
```
**errcodes.txt** then contains a set of records that look like
```bash
'bibjson.journal.number'='10-2'
'bibjson.journal.number'='11/12'
'bibjson.journal.number'='9-10'
'bibjson.month'='August'
'bibjson.journal.number'='default'
'bibjson.journal.volume'='XLII-2-W7'
'bibjson.month'='April'
'bibjson.start_page'='e107818'
'bibjson.start_page'='e0167796'
'bibjson.journal.number'='special issue 1'
'bibjson.start_page'='e0131387'
'bibjson.month'='May'
'bibjson.month'='March'
'bibjson.start_page'='e0119159'
'bibjson.month'='March'
'bibjson.journal.number'='C'
'bibjson.journal.number'='2-3'
'bibjson.journal.volume'='Volume 12'
'bibjson.journal.number'='default'
'bibjson.month'='October'
'bibjson.journal.number'='default'
'bibjson.journal.number'='SP'
'bibjson.journal.number'='شماره سی و سوم - بهار 85'
'bibjson.end_page'='e017'
'bibjson.journal.number'='1-4'
'bibjson.month'='January'
'bibjson.journal.number'='سال سوم - شماره دوازدهم - زمستان 79'
```
Obviously we need to set the fields above to a sensible Solr type, such as free text. Then we create an empty schema and then define the fields.  After tha, we re-index the collection

## Identifying erroring field names
The following command will list the field names that cause errors
```bash
 grep -Po "bibjson\..*?(?=')" errcodes.txt |less|sort|uniq
 ```

 This yields
```
bibjson.end_page
bibjson.journal.number
bibjson.journal.volume
bibjson.month
bibjson.start_page
bibjson.year
```
## Defining the fields
Trash the original core **doaj** as above and re-index the existing documents
Create a new core **doaj** using the command
```bash
sudo su - solr -c "/opt/solr/bin/solr create -c doaj -n data_driven_schema_configs"
```
As this new core uses a managed schema we must create the above fields using the [Schema API](https://lucene.apache.org/solr/guide/6_6/schema-api.html).  We do this by using  **bin/post** commands with JSON parameters defining the fields.  (The Schema API is pretty horrible:  all commands need to be POSTed to the engine)

In the terminal window issue the following commands

```bash
curl -X POST -H 'Content-type:application/json' --data-binary '{
  "add-field":{
     "name":"bibjson.end_page",
     "type":"string",
     "stored":true,
     "indexed":true }
}' http://localhost:8983/solr/doaj/schema

curl -X POST -H 'Content-type:application/json' --data-binary '{
  "add-field":{
     "name":"bibjson.journal.number",
     "type":"string",
     "stored":true,
     "indexed":true }
}' http://localhost:8983/solr/doaj/schema

curl -X POST -H 'Content-type:application/json' --data-binary '{
  "add-field":{
     "name":"bibjson.journal.volume",
     "type":"string",
     "stored":true,
     "indexed":true }
}' http://localhost:8983/solr/doaj/schema

curl -X POST -H 'Content-type:application/json' --data-binary '{
  "add-field":{
     "name":"bibjson.month",
     "type":"string",
     "stored":true,
     "indexed":true }
}' http://localhost:8983/solr/doaj/schema

curl -X POST -H 'Content-type:application/json' --data-binary '{
  "add-field":{
     "name":"bibjson.start_page",
     "type":"string",
     "stored":true,
     "indexed":true }
}' http://localhost:8983/solr/doaj/schema

curl -X POST -H 'Content-type:application/json' --data-binary '{
  "add-field":{
     "name":"bibjson.year",
     "type":"string",
     "stored":true,
     "indexed":true }
}' http://localhost:8983/solr/doaj/schema
```

Reindex the BibJson records
```bash
sudo su - solr -c "/opt/solr/bin/post -c doaj /home/Clyde/doaj"  2> errlog.txt
```
