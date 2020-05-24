Note: This is experimental

There are two ways of running ferret, posting requests to a remote ferret service (this requires minimal setup) or running ferret locally

### installing `pip`
(How do I install this?) 
I think on `python3` the command is `pip3`


### Running Medrxiv using the Ferret Service
This script is written in python3 and requires installing the `requests` package
```    
    pip install requests
```
Run the following command:
(PMR:  `medrxiv_pdf_links.py` is in the top-level of this repo)

```
    python medrxiv_pdf_links.py "n95 masks fabric social distancing"
```
This will save the urls of all the pdfs to the `n95_masks_fabric_social_distancing_results.txt` file 

### Running ferret locally (faster)
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

### test on MACOSX (PMR)
```
pip3 install requests
Collecting requests
  Downloading https://files.pythonhosted.org/packages/1a/70/1935c770cb3be6e3a8b78ced23d7e0f3b187f5cbfab4749523ed65d7c9b1/requests-2.23.0-py2.py3-none-any.whl (58kB)
  ...
  https://files.pythonhosted.org/packages/e1/e5/df302e8017440f111c11cc41a6b432838672f5a70aa29227bf58149dc72f/urllib3-1.25.9-py2.py3-none-any.whl (126kB)
     |████████████████████████████████| 133kB 27.5MB/s 
Installing collected packages: chardet, idna, certifi, urllib3, requests
Successfully installed certifi-2020.4.5.1 chardet-3.0.4 idna-2.9 requests-2.23.0 urllib3-1.25.9
```
then running Ferret:
```
pm286macbook:ferret pm286$ python3 medrxiv_pdf_links.py "n95 masks fabric social distancing"
No output file set, saving to n95_masks_fabric_social_distancing_results.txt
Running query "n95 masks fabric social distancing" on medrxiv
```
This has created the list of URLs. Download one to check
```
pm286macbook:ferret pm286$ curl https://www.medrxiv.org/content/10.1101/2020.04.17.20069567v4.full.pdf > 10.1101_2020.04.17.20069567v4.full.pdf
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 5608k    0 5608k    0     0   277k      0 --:--:--  0:00:20 --:--:--  424k
```
and check there is something there (5MB)
```
pm286macbook:ferret pm286$ ls -lt 10.1101_2020.04.17.20069567v4.full.pdf 
-rw-r--r--  1 pm286  staff  5742750 24 May 23:10 10.1101_2020.04.17.20069567v4.full.pdf
```
