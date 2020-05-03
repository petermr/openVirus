# medrxiv search tool

## Purpose
To search `medrxiv` , download the hits, and search locally with dictionaries.
To create indexes of articles using dictionaries.

## Benefits
Most citizens do not know of Medrxiv, and certainly not how to search it.
Many scientists will still click through hits one-by-one.

## Timeline
Can we do this and share the news at https://csvconf.com? May 13-14?

# Plan

To build a chain of tools customised for citizens to:
* search `medriv` using their webpage
* download a few hundred hits
* translate PDF to structured form. (might cache this?)
* index with `amidict` s
* analyze and display using `R` or `D3` or similar tools.
* promote the results.

## vision
It would be possible to batch this as a single command or script. "Wireframe"
```
ami download tool=ferret sites=medrxiv,biorxiv query="social distancing and epidemics" year="2000-*" limit=400 hitlist=true pdf=true project=med2000soc // exists as ferret, not wrapped
ami -p=$current pdfbox --html; grobid
ami search --dictionary=country,healthlaw,epidemic,virus,disease 
ami display tool=R types=barplot,wordcloud,correlation dicts=$current // this does not exist
```
This can be layered on top of Ferret, and R. It (hopefully) protects the new user to use a single syntax , simpler than what is out there.

# Tasks
We need the following . All are at least in prototype:
* `medrxiv` and `biorxiv` `Ferret`s
* PDF to text 
* text indexer
* update of `dataTables` with better pointers and bibliography
* index dataTable cells with Wikidata, not Wikipedia
* add some display/demos
* make video
 
 ## prerequisites
All software should be aimed at `alpha` testers. , mainly the members of this Slack group. We should assume:
* computer literacy
* patience
* determination

So Example: I would like to run the `Ferret` demo for `medrxiv` . We need to know:

* what to install
* what OS's work and which give problems (e.g. `MacOSX and Ferret`)
* how to run a proof-of-installation 
* how to run a real job.
* limitations

That goes for everything.

# Current status

**PLEASE FILL THIS IN**

## Downloads

### general

#### query syntax. 
APIs have different query syntaxes (e.g. UUencoding, brackets, quotes, dates).

#### metadata
Metadata is a horrible mess. Gnerally uses a mixture of Dublin Core, Highwire, (probably) Crossref, amnd JATS.
But manageable.

#### limits
We must make the default a manageable number like 200 hits.



### Ferret
This has been announced as working in prototype. 

We need a Ferret page.
* needs integration into `cproject` structure
* needs docs
* needs tests


### ami download
This is not the preferred solution. It wraps `curl`.
* it works within `ami` and so is `cproject`-compatible

It has problems:
* slow (I think)
* doesn't do `PDF` download (I think this is a timing/`curl` problem
* doesn't do iterative redirects

## 






