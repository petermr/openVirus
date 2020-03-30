# Search for N95 (masks) on EuropePMC

## getpapers 

search for "N95" and "mask" , output to `n95` directory, keep the log and download XML and PDF

```
getpapers -q "(N95) AND (mask)" -o n95 -f n95/log.txt -x -p
info: Saving logs to ./n95/log.txt
info: Searching using eupmc API
info: Found 377 open access results
warn: This version of getpapers wasn't built with this version of the EuPMC api in mind
warn: getpapers EuPMCVersion: 5.3.2 vs. 6.2 reported by api
Retrieving results [==============================] 100% (eta 0.0s)
info: Done collecting results
info: Saving result metadata
info: Full EUPMC result metadata written to eupmc_results.json
info: Individual EUPMC result metadata records written
info: Extracting fulltext HTML URL list (may not be available for all articles)
info: Fulltext HTML URL list written to eupmc_fulltext_html_urls.txt
warn: Article with pmcid "PMC7087729" was not Open Access (therefore no XML)
... snipped
warn: Article with pmcid "PMC4098517" was not Open Access (therefore no XML)
info: Got XML URLs for 353 out of 377 results
info: Downloading fulltext XML files
Downloading files [====================] 100% (353/353) [34.2s elapsed, eta 0.0]
info: All downloads succeeded!
warn: Article with pmcid "PMC6755768" had no fulltext PDF url
... snipped
warn: Article with pmcid "PMC4098517" had no fulltext PDF url
info: Downloading fulltext PDF files
Downloading files [===================] 100% (329/329) [158.6s elapsed, eta 0.0]
info: All downloads succeeded!
```
