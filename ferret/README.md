Note: This is experimental

There are two ways of running ferret, posting requests to a remote ferret service (this requires minimal setup) or running ferret locally

### installing `pip`
(How do I install this?) 
```
pm286macbook:workspace pm286$ curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 1825k  100 1825k    0     0  2944k      0 --:--:-- --:--:-- --:--:-- 2948k
pm286macbook:workspace pm286$ python get-pip.py
DEPRECATION: Python 2.7 reached the end of its life on January 1st, 2020. Please upgrade your Python as Python 2.7 is no longer maintained. pip 21.0 will drop support for Python 2.7 in January 2021. More details about Python 2 support in pip, can be found at https://pip.pypa.io/en/latest/development/release-process/#python-2-support
Defaulting to user installation because normal site-packages is not writeable
Collecting pip
  Downloading pip-20.1.1-py2.py3-none-any.whl (1.5 MB)
     |████████████████████████████████| 1.5 MB 1.7 MB/s 
Collecting wheel
  Downloading wheel-0.34.2-py2.py3-none-any.whl (26 kB)
Installing collected packages: pip, wheel
  WARNING: The scripts pip, pip2 and pip2.7 are installed in '/Users/pm286/Library/Python/2.7/bin' which is not on PATH.
  Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location.
  WARNING: The script wheel is installed in '/Users/pm286/Library/Python/2.7/bin' which is not on PATH.
  Consider adding this directory to PATH or, if you prefer to suppress this warning, use --no-warn-script-location.
Successfully installed pip-20.1.1 wheel-0.34.2
```
Not sure this worked

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
