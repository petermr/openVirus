#!/bin/bash/python
import json
import os
import sys
import subprocess
import urllib

URL = "https://www.biorxiv.org/search/"

if len(sys.argv) < 2:
   print("Please pass a search term")
   sys.exit()


ferret = os.getenv('FERRET')
search_term = sys.argv[1].split()[0]
query=urllib.quote(sys.argv[1])
query_url = URL+query

cmd = ferret + " --param=url:\\\""+query_url+"\\\" search.fql"
results = json.loads(subprocess.check_output(cmd, shell=True))
output_file = search_term+"_dois.txt"
with open(output_file, 'w') as outfile:
    for row in results:
         outfile.write(row["doi"].replace("doi: ", "")+"\n")

print("Wrote {} dois to {}".format(len(results), output_file))