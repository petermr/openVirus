# Running Ferret
Ferret needs to run as a server process on a dedicated VM, preferabley Linux.  I use Ubuntu for this.
Ferret now runs as a Docker process.  This makes installing and running very easy indeed.
## Installing Docker
- Log into Ubuntu
- Issue the command
```bash
 sudo apt install docker.io
 ```
 ## Running Ferret
 Once Docker is installed on your VM, then run Ferret directly:
 ```bash
 sudo docker run -d -p 8080:8080 montferret/worker:v1.1.0
 ```
 This will pull down the Docker image and run Ferret in a headless container.  Ferret now accepts HTTP POST commands on port 8080 to retrieve documents.
 
 The POST command body takes the form
 ```json
 { "text" :"RETURN {url:@url, doc:DOCUMENT(@url, {driver:'cdp'})}", "params": { 	"url":"https://www.medrxiv.org/content/10.1101/2020.05.12.20092270v1" 	} }
 ``` 
 where URL is obviously the document you want to retrieve
