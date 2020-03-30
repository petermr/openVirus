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
### output
The directory `n95` is the `CProject`.
Note each paper creates a directory (`CTree`) with metadata, PDF and XML. Some PDF and/or XML are missing 
because the repository doesn't have thme.
```
n95/
├── 25411668
│   └── eupmc_result.json
├── PMC1074505
│   ├── eupmc_result.json
│   ├── fulltext.pdf
│   └── fulltext.xml
├── PMC1550819
│   ├── eupmc_result.json
│   ├── fulltext.pdf
│   └── fulltext.xml
...
├── PMC2532878
│   ├── eupmc_result.json
│   └── fulltext.xml
```
## search

We search with builtin dictionaries `country`, `disease`, `funders` .
```
ami-search -p n95/ --dictionary country disease funders
```
Echo input parameters
These quite a lot of debug, and we've snipped it.

```
Generic values (AMISearchTool)
================================
-v to see generic values
oldstyle            true

Specific values (AMISearchTool)
================================
oldstyle             true
strip numbers        false
wordCountRange       (20,1000000)
wordLengthRange      (1,20)

dictionaryList       [country, disease, funders]
dictionaryTop        null
dictionarySuffix     [xml]

```
cProject: n95
legacy cmd> word(frequencies)xpath:@count>20~w.stopwords:pmcstop.txt_stopwords.txt
legacy cmd> search(country)
legacy cmd> search(disease)
legacy cmd> search(funders)
```
Here the XML is being converted to HTML. About 2 per sec, Only needs to be done once.
```
!25411668 .PMC1074505 PMC1550819 PMC1562405 PMC1824729 PMC2040158 PMC2072829 PMC2440799 PMC2532878 PMC2600302 PMC2600382 
PMC7100832 113487 [main] DEBUG org.contentmine.ami.plugins.word.WordCollectionFactory  - no words found to extract
113487 [main] DEBUG org.contentmine.ami.plugins.word.WordCollectionFactory  - no words found to extract
```
some documents are very small and some are huge, hence these diagnostics. Ignore them. Dots represent documents
```
.................................................................................
large document (505) for PMC3266527 truncated to 500 sections
......................................................................................
create data tables
rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr
```
