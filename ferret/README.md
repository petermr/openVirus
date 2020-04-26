Note: This is experimental

Currently Ferret runs inside a python code this may be moved to golang later

To install Ferret read the documentation on https://github.com/MontFerret/ferret/ and https://github.com/petermr/openVirus/wiki/Ferret

In your terminal start chrome 

    chrome --remote-debugging-port=9222
    
Set your FERRET environment variable

    export FERRET="path/to/ferret/directory"

To search for terms on biorxiv run the following command

    python search_biorxiv.py "n95 masks"

This produces an `n95_dois.txt` file which you can pass to the scraper (currently scrapes biorxiv and springer pages)

    python scrape.py n95_dois.txt

