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

## Semantification and sectioning

It's very important to separate the sections of the document. Otherwise we get authors called "Zika" and "Mali" confusing disease and country.

### Syntax

#### JATS
`EuropePMC` emits JATS XML which is now our standard. It has ca. 300 tags, I have coded 250. The rest waits for bad movies to watch. There is an
* XSLT stylesheet. This needs rare tags adding.
* `ami` converter - with ca 250 Classes. This is preferred as it works faster and is more versatile. (XSLT is like LISP)

#### HTML
* **Scientist-authored documents** are normally OK. They need cleaning a bit.  Cleaning HTML in Java is horrible. Every time I get it working the library is discontinued. I think we use `HTMLUnit` at present (`Jsoup`, `HtmlTidy` are out-of-date - please prove me wrong.) There's an `HTMLFactory` in `ami` but it reflects this historical mess.
* **Publisher HTML** is among the worst "HTML" on the planet. It has (a) 90% of publishers junk which means we need a different stripper for each publisher. This general means locating the `html-body` section (though it won't be labelled) and (b) lazy-loading where HTML+JS loads more HTML+JS and so forth. For this you need `Chromium` or similar. (c) much of the content is paywalled. We need to find a way of detecting this.

#### PDF
AAAARGHHH! 
PDF is a nightmare. There is no way of reading it precisely. The characters anc eb ni yna rdoer. There are ligatures fl u ff y. Unknown ch?ract?rs. E x c e s s i v e l l a r g e s p a c e s or allruntogether. Hyphen-ation. Paragraphs? Tables? Graphics?? Suscripts H2O Cu2+ Font-sizes, styles, text as graphics strokes. multi-glyph characters. charactes as bitmaps. 
I have spent years and have one of the most comprehensive approaches.
Most author manuscripts are OK. Much publisher PDF makes you vomit.
* **ami** ami translates PDF to SVG characters and glyphs. It's probably the only Open deterministic tool that manages complete documents. But it's not complete and never will be.
* **pdfText2html** from `PDFBox`. All output is Unicode (no styles, tables, etc.) Probably the best Open text-based system. We have very good relations.
* **GROBID** machine-learning. Trained on scholarly publications. The gold standard. We have good relations. Not so good with tables or images. (but active)

All of these are in `ami`

#### Json
some sites emit metadata in Json. `ami` can read Json. May be able to create JATS from this.

### Sections
* **creation** .`ami` `section` creates identifies sections in `JATS` and split the documents. Normal HTML or PDF does not have semantic sections. GROBID may help.
* **searching** important to be able to search sections. ?Can Solr do this?

## Searches
`ami` has the following searches:
### dictionary-based
This is the default. It works but is unmaintainable. badly needs converting to the `picocli` syntax.
### word frequencies
Works but unmaintainable. Needs removing from `ami search` .
### species
Currently broken
### regex
Currently broken. This covers identifiers, genes, equipment, etc. 
### html conversion
`ami search` does a lazy conversion of JATS to HTML. Not a problem. Maybe this could be threaded in the background.
 
## display
### histograms
Crude barchart as part of `ami-search`
### cooccurrence
Crude svg plot in `ami-search`
### R, etc.
Thomas Shafee has done some cool stuff. 

## dictionaries
### need to review and redistribute and edit
more later.
















