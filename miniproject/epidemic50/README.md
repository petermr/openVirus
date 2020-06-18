# 50-article test corpus


## how this was created 

```
pm286macbook:miniproject pm286$ getpapers -q "viral epidemic" -k 50 -x -f epidemic50/log.txt -o epidemic50/
info: Saving logs to ./epidemic50/log.txt
info: Searching using eupmc API
info: Found 33379 open access results
warn: This version of getpapers wasn't built with this version of the EuPMC api in mind
warn: getpapers EuPMCVersion: 5.3.2 vs. 6.3 reported by api
info: Limiting to 50 hits
Retrieving results [==============================] 100% (eta 0.0s)
info: Done collecting results
info: limiting hits
info: Saving result metadata
info: Full EUPMC result metadata written to eupmc_results.json
info: Individual EUPMC result metadata records written
info: Extracting fulltext HTML URL list (may not be available for all articles)
info: Fulltext HTML URL list written to eupmc_fulltext_html_urls.txt
info: Got XML URLs for 50 out of 50 results
info: Downloading fulltext XML files
Downloading files [==============================] 100% (50/50) [3.6s elapsed, eta 0.0]
info: All downloads succeeded!
```
`Thu 18 Jun 2020 18:39:05 BST`

