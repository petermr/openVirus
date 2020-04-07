# Instructions for indexing DOAJ in Solr
I'm assuming you are working on a Linux machine.  I tend to use Windows for my day-to-day-work but Linux is the preferred environment for this work.  The commands that follow are mostly cross-platform, save for the downloading and unzipping.
## Download the archive
```bash
https://doaj.org/public-data-dump/article
mv article article.tar.gz
gzip -d article.tar.gz
tar -xvf article.tar
```
You will now have a folder containing the data files named  **doaj_article_data_yyyy-mm-dd**.  Delete the **article.tar.gz** after the unarchiving:  we don't need it now.
## Installing the prerequisites
- Install the .NET Core from Microsoft by following [these instructions](https://docs.microsoft.com/en-us/dotnet/core/install/linux-package-manager-ubuntu-1804).
- Install [PowerShell 7.0](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-linux?view=powershell-7)

## Installing the utility
- Clone or pull the latest version of the [openVirus repo](https://github.com/petermr/openVirus/tree/master/textIndexing/DOAJSplitter) to your home directory with **git**
- Start PowerShell with `pwsh`
- The DOAJSplitter resides in `~/openVirus/textIndexing/DOAJSplitter/DOAJSplitter/bin/Release/netcoreapp3.1/linux-x64`.  
- Change to this directory
```bash
cd ~/openVirus/textIndexing/DOAJSplitter/DOAJSplitter/bin/Release/netcoreapp3.1/linux-x64
```
- `chmod 777 ./DOAJSplitter` to make it executable
- `nano $PROFILE` then add the line:
```powershell
Set-Alias doajsplitter "~/openVirus/textIndexing/DOAJSplitter/DOAJSplitter/bin/Release/netcoreapp3.1/linux-x64/DOAJSplitter"
```
to allow invocation of the utility with the command `doajsplitter`
- Exit and restart Powershell

## Running the utility
Once set up you can split up the DOAJ files

- `cd doaj_article_data_yyyy-mm-dd` (substituting the correct date numbers)
- `mkdir ~/doaj` to hold the output files
- `dir *.json|ForEach-Object {doajsplitter $_ ../doaj}`

You should end up with 4.7 million JSON files, each named after the reference ID field.
