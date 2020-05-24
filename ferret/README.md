Note: This is experimental

There are two ways of running ferret, posting requests to a remote ferret service (this requires minimal setup) or running ferret locally

### Running Medrxiv using the Ferret Service
This script is written in python3 and requires installing the `requests` package
    
    pip install requests

Run the following command:

    python medrxiv_pdf_links.py "n95 masks fabric social distancing"

This will save the urls of all the pdfs to the `n95_masks_fabric_social_distancing_results.txt` file 

### Running ferret locally (faster)
To install Ferret read the documentation on https://github.com/MontFerret/ferret/ and https://github.com/petermr/openVirus/wiki/Ferret

Set an alias for your ferret variable

    alias ferret="path/to/ferret/directory"

Start chrome 

    chrome --remote-debugging-port=9222
    
Run ferret

    ferret --param=url:\"https://www.medrxiv.org/search/n95%252Bmasks\" --param=dir:\"n95\" fql/medrxiv_search_download.fql
