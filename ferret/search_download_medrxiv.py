#!/bin/bash/python
import json
import os
import sys
import subprocess
import urllib

URL = "https://www.medrxiv.org/search/"

if len(sys.argv) < 2:
   print("Please pass a search term")
   sys.exit()


if len(sys.argv) < 3:
    output_folder = "pdf_downloads"
    print("No output folder set, using "+output_folder)
else:
    output_folder = sys.argv[2]


ferret = os.getenv('FERRET')
if ferret is None:
   print("Please make sure FERRET is installed and set as an environment variable\n\t export FERRET='path/to/ferret'")
   sys.exit()

search_term = sys.argv[1].split()[0]
query=urllib.quote(sys.argv[1])
query_url = URL+query
fql_file = "medrxiv_search_download.fql"
print("Running file " +fql_file+" downloading files to "+output_folder)
cmd = ferret + " --param=url:\\\""+query_url+"\\\"  --param=dir:\\\""+output_folder+"\\\" " + fql_file
subprocess.check_output(cmd, shell=True)
