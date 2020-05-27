Note: This is experimental

**Primary URL**:
https://github.com/petermr/openVirus/tree/ferret/ferret

**Purpose**:
Downloads pdf files for each query against Medrxiv

**Summary**:
This code uses python and Ferret to download pdfs for queries against Medrxiv.
There are two ways of running Ferret, either by posting requests to a remote ferret service (this requires minimal setup) or running ferret locally


### Running Medrxiv using the Dockerised Ferret Service

#### Download python and pip
This script is written in python3, which can be downloaded from here:

    https://www.python.org/downloads/

It also requires pip which can be downloaded from here:

    https://pip.pypa.io/en/stable/installing/


#### Install requirements and run the script
Once python has been installed and setup, run this command in your `openVirus/ferret` directory to download the requirements
    
    pip install -r requirements.txt

And finally, run the following command to run a query against medrxiv and download pdfs:

    python medrxiv_pdf_links.py "n95 masks fabric social distancing"

This will save the pdfs to a local `n95_masks_fabric_social_distancing` folder 

#### test on MACOSX (PMR)
```
pip install -r requirements.txt
Collecting requests
  Downloading https://files.pythonhosted.org/packages/1a/70/1935c770cb3be6e3a8b78ced23d7e0f3b187f5cbfab4749523ed65d7c9b1/requests-2.23.0-py2.py3-none-any.whl (58kB)
  ...
  https://files.pythonhosted.org/packages/e1/e5/df302e8017440f111c11cc41a6b432838672f5a70aa29227bf58149dc72f/urllib3-1.25.9-py2.py3-none-any.whl (126kB)
     |████████████████████████████████| 133kB 27.5MB/s 
Installing collected packages: chardet, idna, certifi, urllib3, requests
Successfully installed certifi-2020.4.5.1 chardet-3.0.4 idna-2.9 requests-2.23.0 urllib3-1.25.9
```
then running the Python script:
```
pm286macbook:ferret pm286$ python3 medrxiv_pdf_links.py "n95 masks fabric social distancing"
Running query "n95 masks fabric social distancing" on medrxiv
Saving results to n95_masks_fabric_social_distancing/
Found 17 documents, urls of pdfs stored in n95_masks_fabric_social_distancing/urls.txt
Downloading...
100%|█████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 17/17 [00:25<00:00,  1.52s/it]

```
This has downloaded pdfs


### Running Ferret locally (faster)
To install Ferret read the documentation on https://github.com/MontFerret/ferret/ and https://github.com/petermr/openVirus/wiki/Ferret

Set an alias for your ferret variable
```
    alias ferret="path/to/ferret/directory"
```
Start chrome 
```
    chrome --remote-debugging-port=9222
```    
Run ferret
```
ferret --param=url:\"https://www.medrxiv.org/search/n95%252Bmasks\" --param=dir:\"n95\" fql/medrxiv_search_download.fql
```