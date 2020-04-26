#!/bin/bash/python
import json
import os
import sys
import subprocess


if len(sys.argv) < 2:
   print("Please pass a doi file")
   sys.exit()

    
biorxiv_scraper = "get_data_biorxiv.fql"
springer_scraper = "get_data_springer.fql"
ferret = os.getenv('FERRET')
print(ferret)
with open("results.jsonl", 'w') as outfile:
    with open(sys.argv[1]) as infile:
        for line in infile.readlines():
            line = line.replace("\n", "")
            try:
                cmd = ferret + " --param=url:\\\""+line+"\\\" " + biorxiv_scraper 
                outfile.write(subprocess.check_output(cmd, shell=True))
            except:
                cmd = ferret + " --param=url:\\\""+line+"\\\" " + springer_scraper 
                outfile.write(subprocess.check_output(cmd, shell=True))    
print("Wrote output to results.jsonl")