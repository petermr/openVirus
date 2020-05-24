import csv
import json
import requests
import sys
from urllib.parse import urlparse


MEDRXIV_URL = "https://www.medrxiv.org/search/"
FERRET_CONTAINER = "https://ferret-worker-pucbyp2omq-ue.a.run.app/"


def run_ferret_query(query, output_file):
    """ Runs a ferret query against medrxiv and returns the URLs of the pdfs as output. """
    print(f"Running query \"{query}\" on medrxiv")
    url = urlparse(MEDRXIV_URL + query).geturl()

    fql_file = "fql/medrxiv_search_download.fql"
    with open(fql_file) as infile:
        fql = infile.read()


    PARAMS = {
        "text" : fql,
        "params": {
            "url":url,
        }
    }
    r = requests.post(FERRET_CONTAINER, json=PARAMS)
    pdf_links = r.json()
    with open(output_file, "w") as output:
        for link in pdf_links:
            output.write(link+"\n")


if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("Please pass a query:\n\tpython medrix_pdf_links.py query outputfile")
        sys.exit(0)
    else:
        query = sys.argv[1]
    if len(sys.argv) < 3:
        output_file = f"{sys.argv[1].replace(' ','_')}_results.txt"
        print(f"No output file set, saving to {output_file}")
    else:
        output_file = sys.argv[2]
    run_ferret_query(query, output_file)
