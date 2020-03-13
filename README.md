# openVirus
aggregation of scholarly publications and extracted knowledge on viruses and epidemics.

## background
The world faces (and will continue to face) viral epdemics which arise suddenly and where scientific/medical knowledge is a critical resource. Despite over 100 Billion USD on medical research worldwide much knowledge is behind publisher paywalls and only available to rich universities. Moreover it is usually badly published, dispersed without coherent knowledge tools. It particularly disadvantages the Global South.

This project aims to use modern tools, especially Wikidata (and Wikpedia) , R, Java, textmining, with semantic tools to create a modern integrated resource of all current published information on viruses and their epidemics. It relies on collaboration and gifts of labour and knowledge.

## goals

* to collect all freely visible scientific/medical publications on COVID, viral epidemics and transform them to uniform form.
* to use Natural Language Processing (NLP) and textmining so machines can extract meaning from the articles.
* to build dictionaries of terms related to viruses and viral epidemics for (a) search (b) classification (c) understanding.
* to collect knowedge and publish it in EWikiJournal of Medicine (a peer-reviewed journal with an emphasis on review)

## how we will work

This is a digital knowledge-based project (i.e. no laboratory or clinical work). It is open to all who are prepared to contribute components of the system. 

Some examples of the skills and knowledge required are:
* Wikimedia (esp. Wikipedia, Wikidata, Wiki technology, WikiJournal)
* scholarly publications including preprints
* Scraping web pages and building metadata
* SPARQL/RDF , XML, JSON
* Textmining , supervised and unsupervised
* virology
* epidemiology
* computation
* societal aspects of disease (e.g.  public health policy).
* language translation (with a scientific emphasis)
* Git and Github
* Open collaborative projects

Our initial framework is based on simple dictionaries and ontologies (e.f. RDF, XML), public sources of scientific articles (especially preprints and country-specific inclusivity (e.g. Latin America , Redalyc, SciELO)). Current software is mainly Java, R, Node, Python but as the data are exposed as text files a variety of tools can be used).

## scope

Initially we will use papers retrieved by "coronavirus" . Typical results are:

* EuropePubMedCentral (EPMC) 6563 papers
* biorxiv preprints ca 400
* medrxiv ca 300
* SciELO ...
* Redalyc ...

### languages and countries

COVID19 is a global emergency and it's critical that knowledge is gloabl, not centered on the North Antlantic regions. We want to see other languages and other nations involved. As a start we are developing a scraper for Latin American OpenAccess publications, initially the Redalyc server.

## tasks

We will list tasks on https://github.com/petermr/openVirus/issues . These are things we have to do including components, integration, bugs, tutorials, etc.
There may soon be a large number of "Open" Issues - this should be seen as positive - some issues are ongoing and don't get closed.




