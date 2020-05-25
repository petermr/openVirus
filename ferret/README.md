Note: This is experimental

Primary URL
https://github.com/petermr/openVirus/tree/ferret/ferret

Purpose
Downloads pdf files for each query against Medrxiv

Summary
This code uses python and Ferret to download pdfs for queries against Medrxiv.
There are two ways of running Ferret, either by posting requests to a remote ferret service (this requires minimal setup) or running ferret locally

### Running Medrxiv using the Ferret Service
This script is written in python3, which can be downloaded from here:

    https://www.python.org/downloads/

Once python has been installed and setup, run this command in your `openVirus/ferret` directory to download the requirements
    
    pip install -r requirements.txt

And finally, run the following command to run a query against medrxiv and download pdfs:

    python medrxiv_pdf_links.py "n95 masks fabric social distancing"

This will save the pdfs to a local `n95_masks_fabric_social_distancing` folder 

### Running Ferret locally (faster)
To install Ferret read the documentation on https://github.com/MontFerret/ferret/ and https://github.com/petermr/openVirus/wiki/Ferret

Set an alias for your ferret variable

    alias ferret="path/to/ferret/directory"

Start chrome 

    chrome --remote-debugging-port=9222
    
Run ferret

    ferret --param=url:\"https://www.medrxiv.org/search/n95%252Bmasks\" --param=dir:\"n95\" fql/medrxiv_search_download.fql
