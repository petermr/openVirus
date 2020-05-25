import csv
import json
import os
import requests
import shutil
import sys
from urllib.parse import urlparse
from tqdm import tqdm

MEDRXIV_URL = "https://www.medrxiv.org/search/"
FERRET_CONTAINER = "https://ferret-worker-pucbyp2omq-ue.a.run.app/"
MEDRXIV_FQL = "fql/medrxiv_search_download.fql"
URL_FILE = "urls.txt"
CHUNK_SIZE = 2000

def run_ferret_query(query: str, output_folder: str):
    """ Runs a ferret query against medrxiv and downloads the pdfs to an output folder. """
    print(f"Running query \"{query}\" against medrxiv")
    print(f"Saving results to output_folder: {output_folder}/")
    url = urlparse(MEDRXIV_URL + query).geturl()

    with open(MEDRXIV_FQL) as infile:
        fql = infile.read()


    PARAMS = {
        "text" : fql,
        "params": {
            "url":url,
        }
    }
    r = requests.post(FERRET_CONTAINER, json=PARAMS)
    pdf_links = r.json()
    links_file = os.path.join(output_folder, URL_FILE)
    with open(links_file, "w") as output:
        for link in pdf_links:
            output.write(link+"\n")

    print(f"Found {len(pdf_links)} documents, urls of pdfs stored in {links_file}")
    print("Downloading...")
    for pdf_link in tqdm(pdf_links):
        pdf_file = os.path.join(output_folder, pdf_link.rsplit("/")[-1])
        r = requests.get(url, stream=True)
        with open(pdf_file, 'wb') as fd:
            for chunk in r.iter_content(CHUNK_SIZE):
                fd.write(chunk)
        

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("Please pass a query:\n\tpython medrix_pdf_links.py query outputfile")
        sys.exit(0)
    else:
        query = sys.argv[1]
    if len(sys.argv) < 3:
        output_folder = f"{sys.argv[1].replace(' ','_')}"
    else:
        output_folder = sys.argv[2]
    if os.path.exists(output_folder):
        shutil.rmtree(output_folder)
    os.mkdir(output_folder)
    run_ferret_query(query, output_folder)
