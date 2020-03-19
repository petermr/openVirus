# openVirus
aggregation of scholarly publications and extracted knowledge on viruses and epidemics.

## NOTE
This site is to develop knowledge resources and tools to help tackle the COVID19 outbreak. **It is NOT a guide to public information.** The actual content created from the site is drawn from reliable sources (journals, guidelines) but has **NOT been filtered or reviewed**.

### tech background 
All are welcome to participate. We assume a basic level of running programs (commandline, R, text editing) and - initially - won't be able to hand hold. However we know from experience that people can learn very fast, so feel free to dive in and try the tech.

### discipline background
This site is initially created by scientists in the bioscience/chemical area but without discipline knowledge of epidemiology, health care, virology, societal aspects, etc. . 

## background
The world faces (and will continue to face) viral epdemics which arise suddenly and where scientific/medical knowledge is a critical resource. Despite over 100 Billion USD on medical research worldwide much knowledge is behind publisher paywalls and only available to rich universities. Moreover it is usually badly published, dispersed without coherent knowledge tools. It particularly disadvantages the Global South.

This project aims to use modern tools, especially Wikidata (and Wikpedia), R, Java, textmining, with semantic tools to create a modern integrated resource of all current published information on viruses and their epidemics. It relies on collaboration and gifts of labour and knowledge.

## goals

* to collect all freely visible scientific/medical publications on [COVID19](https://www.wikidata.org/wiki/Q84263196), viral epidemics and transform them to uniform form.
* to use Natural Language Processing (NLP) and textmining so machines can extract meaning from the articles.
* to build dictionaries of terms related to viruses and viral epidemics for (a) search (b) classification (c) understanding.
* to collect knowedge and publish it in [WikiJournal of Medicine](www.wikijmed.org) (a peer-reviewed OA journal with an emphasis on review)

## how we will work

This is a digital knowledge-based project (i.e. no laboratory or clinical work). It is open to all who are prepared to contribute components of the system. 

Some examples of the skills and knowledge required within the project:
* Wikimedia (esp. Wikipedia, Wikidata, Wiki technology, WikiJournal)
* Scholarly publications including preprints
* Scraping web pages and building metadata
* SPARQL/RDF , XML, JSON
* Textmining , supervised and unsupervised
* Virology
* Epidemiology
* Computation
* Societal aspects of disease (e.g.  public health policy).
* Language translation (with a scientific emphasis)
* Git and Github
* Open collaborative projects

Our initial framework is based on simple dictionaries and ontologies (e.f. RDF, XML), public sources of scientific articles (especially preprints and country-specific inclusivity (e.g. Latin America , Redalyc, SciELO)). Current software is mainly Java, R, Node, Python but as the data are exposed as text files a variety of tools can be used).

## scope

Initially we will use papers retrieved by "coronavirus" . Typical results are:

* [Europe PubMedCentral](https://europepmc.org/) (EPMC): 6563 papers
* [biorxiv preprints](https://www.biorxiv.org/): ~400
* [medrxiv preprints](https://www.medrxiv.org/): ~300
* [SciELO](https://scielo.org/en/) ...
* [Redalyc](https://scielo.org/en/) ...

### languages and countries

COVID19 is a global emergency and it's critical that knowledge is global, not centered on the North Atlantic regions. We want to see other languages and other nations involved. As a start we are developing a scraper for Latin American OpenAccess publications, initially the Redalyc server.

## tasks

We will list tasks on [github.com/petermr/openVirus/issues](https://github.com/petermr/openVirus/issues). These are things we have to do including components, integration, bugs, tutorials, etc.
There may soon be a large number of "Open" Issues - this should be seen as positive - some issues are ongoing and don't get closed.

## Open Notebook publication

We are using the Open Notebook philosophy fo Jean-Claude Bradley and implicitly of Wikimedia content and of many Free/Open Software projects. Everything is posted publicly as soon as it is created. That means that every iteration is visible and will almost certainly contain bugs/errors. Each subsequent commit fixes some of these. We know from past experience that this is the quickest way to create high-quality content and also gives a feeling of communal ownership.
1. [Summary publication preprint](https://en.wikiversity.org/wiki/WikiJournal_Preprints/Aggregation_of_scholarly_publications_and_extracted_knowledge_on_COVID19_and_epidemics)
2. [Full open notebook](https://en.wikiversity.org/wiki/WikiJournal_Preprints/Aggregation_of_scholarly_publications_and_extracted_knowledge_on_COVID19_and_epidemics/Open_Notebook)




