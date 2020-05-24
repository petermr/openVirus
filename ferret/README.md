Note: This is experimental

Primary URL
https://github.com/petermr/openVirus/tree/ferret/ferret

Purpose
Creates a text file containing links to pdf files for each query against Medrxiv

Summary
This code uses Ferret to run queries in Medrxiv and saves the urls of the pdfs in a text file
There are two ways of running Ferret, either by posting requests to a remote ferret service (this requires minimal setup) or running ferret locally

### Running Medrxiv using the Ferret Service
This script is written in python3 and requires installing the `requests` package
    
    pip install requests

Run the following command:

    python medrxiv_pdf_links.py "n95 masks fabric social distancing"

This will save the urls of all the pdfs to a `n95_masks_fabric_social_distancing_results.txt` file 

### Running Ferret locally (faster)
To install Ferret read the documentation on https://github.com/MontFerret/ferret/ and https://github.com/petermr/openVirus/wiki/Ferret

Set an alias for your ferret variable

    alias ferret="path/to/ferret/directory"

Start chrome 

    chrome --remote-debugging-port=9222
    
Run ferret

    ferret --param=url:\"https://www.medrxiv.org/search/n95%252Bmasks\" --param=dir:\"n95\" fql/medrxiv_search_download.fql
