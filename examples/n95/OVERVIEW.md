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
Now the output from processing the `CProject`
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

## Convert PDFs with ami-pdf

`ami-pdf` is very simple if you choose default values. Its output can be verbose and it would be useful to agree on levels and mechanism of output. Generally there are about 5-20 lines of output per `CTree`.

```
pm286macbook:n95 pm286$ ami-pdf -p .
```
Input options
```
Generic values (AMIPDFTool)
================================
-v to see generic values
oldstyle            true

Specific values (AMIPDFTool)
================================
maxpages            5
svgDirectoryName    svg/
outputSVG           true
imgDirectoryName    pdfimages/
outputPDFImages     true
parserDebug         AMI_BRIEF
```
now iterate over the `CTree`s . I'll separate them by newlines.

this next PDF doesn't exist (NEED better message).
```
AMIPDFTool cTree: 25411668
cTree: 25411668
>TRACE: null PDF for: 25411668
```
This next PDF is fairly typical. 
```
AMIPDFTool cTree: PMC1074505
cTree: PMC1074505
 max pages: 5 0                  // read 5 pages at a time
pages include: [0, 1, 2, 3, 4].  // page numbers for computer geeks (start at 0) BUG: Must change this
[1]0    [main] WARN  org.apache.pdfbox.pdmodel.font.PDType1Font  - Using fallback font Helvetica-Bold for Helvetica-Narrow-Bold
0 [main] WARN org.apache.pdfbox.pdmodel.font.PDType1Font  - Using fallback font Helvetica-Bold for Helvetica-Narrow-Bold
40   [main] WARN  org.apache.pdfbox.pdmodel.font.PDType1Font  - Using fallback font Helvetica for Helvetica-Narrow
40 [main] WARN org.apache.pdfbox.pdmodel.font.PDType1Font  - Using fallback font Helvetica for Helvetica-Narrow 
// these WARNings come from PDF Box. WEe need to switch them off
[2][3][4][5] 5                  // pages 2,3,4,5   // sorry this is human-counting
pages include: [5, 6, 7, 8, 9]. // more pages
[6][7][8][9][10]end:            // end of processing after 10 pages

AMIPDFTool cTree: PMC1550819
cTree: PMC1550819
 max pages: 5 0 
pages include: [0, 1, 2, 3, 4]
[1][2][.0]xArray ooo(69).       // ooo is a debug, ignore it 
[3][.0]xArray ooo(67)
[4][5] img  img  5              // img means we have found and saved an image
pages include: [5, 6, 7, 8, 9]
[6]end: 

...
...

AMIPDFTool cTree: PMC2040158
cTree: PMC2040158
 max pages: 5 0 
pages include: [0, 1, 2, 3, 4]
[1][.0][2][3][4][5][.0][.1] img  img  img  5  /// [.0][.1] means write image [0] image[1]
pages include: [5, 6, 7, 8, 9]
[6][7][8][9]xArray ooo(6)
end: 
...
```
until
```
AMIPDFTool cTree: PMC7081171
cTree: PMC7081171
 max pages: 5 0 
pages include: [0, 1, 2, 3, 4]
[1][2]end: 
AMIPDFTool cTree: PMC7081861
cTree: PMC7081861
 max pages: 5 0 
pages include: [0, 1, 2, 3, 4]
[1][2][3][4][5][.0][.1][.2][.3][.4][.5][.6]Exception in thread "main" java.lang.OutOfMemoryError: GC overhead limit exceeded
	at java.util.regex.Pattern.newSingle(Pattern.java:3360)
	at java.util.regex.Pattern.atom(Pattern.java:2233)
```
We've run out of memory.
BUG.

we managed to process 290 papers:
```
pm286macbook:n95 pm286$ ls -ld */pdfimages/ |wc
     294    2646   20580
```

We can run the rest...

```
pm286macbook:n95 pm286$ ami-pdf -p .

Generic values (AMIPDFTool)
================================
-v to see generic values
oldstyle            true

Specific values (AMIPDFTool)
================================
maxpages            5
svgDirectoryName    svg/
outputSVG           true
imgDirectoryName    pdfimages/
outputPDFImages     true
parserDebug         AMI_BRIEF
AMIPDFTool cTree: 25411668
cTree: 25411668
>TRACE: null PDF for: 25411668
```
it now skips the `CTree`s we have already done ...
```
AMIPDFTool cTree: PMC1074505
cTree: PMC1074505
make skipped AMIPDFTool cTree: PMC1550819
cTree: PMC1550819
make skipped AMIPDFTool cTree: PMC1562405
cTree: PMC1562405
...
```
now we pick up on the unprocessed `CTree`s
```
cTree: PMC7080064
make skipped AMIPDFTool cTree: PMC7081171
cTree: PMC7081171
make skipped AMIPDFTool cTree: PMC7081861
cTree: PMC7081861
 max pages: 5 0 
pages include: [0, 1, 2, 3, 4]
[1][2][3][4][5][.0][.1][.2][.3][.4][.5][.6]large SVG: (341939) PageSerial [page=4, subPage=null]
 img  img  img  img  img  img  img  5 
pages include: [5, 6, 7, 8, 9]
[6][7]end: 

...
```
AMIPDFTool cTree: PMC7100231
cTree: PMC7100231
 max pages: 5 0 
pages include: [0, 1, 2, 3, 4]
[1][.0]tokenList>1000: 1909
tokenList>1000: 1556
[.1][.2][.3][.4][.5][.6][.7][.8]tokenList>1000: 5328
pp: 690 [.9][.10][.11][.12][.13][.14][.15][.16][.17][.18]tokenList>1000: 5129
pp: 751 [.19]tokenList>1000: 4608
pp: 684 [.20][.21][.22]tokenList>1000: 3160
[2][3]tokenList>1000: 1909
tokenList>1000: 1556
tokenList>1000: 2682
tokenList>1000: 2539
tokenList>1000: 2278
tokenList>1000: 3160
 img  img  img  img  img  img  img  img  img  img  img  img  img  img  img  img  img  img  img  img  img  img  img end: 
AMIPDFTool cTree: PMC7100244
cTree: PMC7100244
>TRACE: null PDF for: PMC7100244
AMIPDFTool cTree: PMC7100528
cTree: PMC7100528
>TRACE: null PDF for: PMC7100528
AMIPDFTool cTree: PMC7100832
cTree: PMC7100832
>TRACE: null PDF for: PMC7100832
```
finished...


## output from ami-pdf

Here's a typical `CTree` after `ami-pdf` has created both `pdfimages/` and `svg/` directories.
Note that these directories have been added to the existing `CTree` - you can see i can become 
quite big.

```
── PMC1550819
│   ├── eupmc_result.json
│   ├── fulltext.pdf
│   ├── fulltext.xml
│   ├── pdfimages
│   │   ├── image.2.1.57_298.107_403.png
│   │   └── image.3.1.57_298.108_387.png
│   ├── results
│   │   ├── search
│   │   │   ├── country
│   │   │   │   └── results.xml
│   │   │   ├── disease
│   │   │   │   └── results.xml
│   │   │   └── funders
│   │   │       └── results.xml
│   │   └── word
│   │       └── frequencies
│   │           ├── results.html
│   │           └── results.xml
│   ├── scholarly.html
│   ├── search.country.count.xml
│   ├── search.country.snippets.xml
│   ├── search.disease.count.xml
│   ├── search.disease.snippets.xml
│   ├── search.funders.count.xml
│   ├── search.funders.snippets.xml
│   ├── svg
│   │   ├── fulltext-page.0.svg
│   │   ├── fulltext-page.1.svg
│   │   ├── fulltext-page.2.svg
│   │   ├── fulltext-page.3.svg
│   │   ├── fulltext-page.4.svg
│   │   └── fulltext-page.5.svg
│   ├── word.frequencies.count.xml
│   └── word.frequencies.snippets.xml
```

### pdfimages/ subdirectory
```
│   ├── pdfimages
│   │   ├── image.2.1.57_298.107_403.png
│   │   └── image.3.1.57_298.108_387.png
```
Each image is extracted into PNG files . The name is made up of
```
image.<page>.<index>.<xmin>_<xmax>.<ymin>_<ymax>.png
```
`index` counts from 1.. for images in each page. Somwetimes this gets up to several 
hundred. The x/y coordinates allow us to reposition the bitmap precisely later.

### svg/ subdirectory
```
│   ├── svg
│   │   ├── fulltext-page.0.svg
│   │   ├── fulltext-page.1.svg
│   │   ├── fulltext-page.2.svg
│   │   ├── fulltext-page.3.svg
│   │   ├── fulltext-page.4.svg
│   │   └── fulltext-page.5.svg
```
These SVG documents contain all the characters and all the vector graohics, organized as pages. We can analyze them later.

