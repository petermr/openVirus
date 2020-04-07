# Architecture

An evolving overview of the ContentMine architecture, used for openVirus. This architecture has eveolved over many years but the CProject, and pipeline are now fairly stable. NOTE: this is OpenNotebook so we record it as it happens

![text](./assets/architecture20200407.png)

# Overview
The flow is L2R. documents in the source are read/crawled, processed, cleaned, annotated, searched and collected for analysis

## Source 
(SI = "Supplemental/Supporting Info/Data").

These are the collections of documents we ingest. They are VERY varied in format, but reasonably coherent in abstract structure. Several are not routinely indexed by commercial academic search engines.

NOTE: some of these we may consume and index and remain pointing at online source. Otehrs we may import the whole raw dump and process.

### Theses
These are often undervalued as sources of knowledge. In fact much research is done by graduate students and recorded in greater detail than the "final publication", which often never happens. So we expect quite a lot of new stuff. And theses *are* peer-revieed by examiners! 
Typical sources:
* CORE. UK ane other theses. Requires a login, so lower priority.
* HAL. French repository. Easy to crawl and search.
* British Library / EThOS. Andy Jackson working on this - top priority.

Format: Usually PDF (unstructured) or DOCX (semi-structured)
Supplemental Info: Occasionally

### Preprints
Very exciting. Prime targets 
* `arXiv` (needs dump as crawlers discouraged). PDF (possibly TeX or Word)
* `biorxiv`, `medrXiv` : crawlable. HTML and PDF, +SI. (expect XML soon).
*  COS-type preprints, chemRxiv. Lower priority. No scraper yet. 

### Open publishers
Royal Society has made all its pubs openly visible. We've agreed to scrape them. No scraper yet (needs headless).

### Latin America and non-EN journals
Working with Redalyc to index Mexican OpenAccess literature. Need scraper.

### EPMC
WE alreday use this - `getpapers` uses its API. No specific work required. HTML, PDF and (I think) Suppdata

### DOAJ
Nearly 4 million abstracts. Ready to do unsupervised indexing with SOLR. Later can use Facets.







