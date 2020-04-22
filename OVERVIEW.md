# Overview of the OpenVirus project
This document: https://github.com/petermr/openVirus/blob/master/OVERVIEW.md

***particularly relevant to the EU Hackathon this weekend.***

# Vision
Everyone , **not just experts**, wants and needs access to the scientific/medical literature. 
This project makes it simple. We provide quick methods of finding millions of relevant documents and extracting the relevant knowledge.

## EU Hackathon
We've entered a team "ContentMine" for the EU hackathon (2020-04-24:26)on COVID. Team "ContentMine" under http://euvsvirus.org. We believe that our community and its resources can play a small part in this great effort. This document reflects our offering at 2020-04-21. Our systems are ContentMine's `getpapers` and `AMI`. The hackathon will generate questions to answer, create and share resources, make personal connections. 
# Methodology
**To download large amounts of Open publications, unify the semantics, filter, annotate, re-use, reaggregate, compute**
More specifically:
* find a number of Open sources (repositories, publishers, theses, NGO gray literature, government publications, etc.)
* build crawler/readers for these and translate into universal form (JATS, originally from NIH) widely used in biomedical publications). 
* add semantics so machines can understand the articles.
* search and annotate with a large number of bespoke dictionaries (word lists)
* link everything (bibliography, annotations) to Wikidata

We'll refer to the toolkit as `AMI` as nearly all services can be accessed through it.

# Non-EN language
We believe there are mnany vital documents not in English. Countries which have suffered epidemics have experience of healthcare and social behaviour which will be critically useful to the world. The Western publishing industry and many in academia often regard non-EN as of minor importance and do not index it.
We wish to explore non-EN resources, such as HAL (FR) and the ES/PT resources in Latin America (Redalyc) . We believe that the basic infrastructure is Unicode-friendly. Wikidata can be used to equivalence terms in many languages. The large NaturalLanguageProcessing packages (e.g. OpenNLP) have support for DE, FR, ES, PT and several more.
We are particularly keen to engage with non-EN citizens who may have national resources of value. 
We welcome volunteers who can take this forward.

# Goals
We want to know **your** problems, to see how the literature can help. Two existing examples:
* **Experience of humans tissue samples and surfaces.**
A collaborator (from a non-EN country) asks:
<quote>... collect as many scientific articles as possible regarding the persistence of Covid-19 in different surfaces and materials that are commonly studied in a forensic setting, such as samples obtained from autopsies (skin, bones and body fluids), porous and non-porous surfaces and textiles.</quote>
This is exactly the sort of question we welcome. We would ask them to collect some sample documents. We'd extract the relevant words, make dictionaries and search millions of documents.

* **Efficacy of masks.**
Dan (volunteer on this project) is actually making masks in Makespace. He wants to know the efficacy of masks and how it depends on the type of mask and use. Things like materials, diseases, environments will all be important.

# Our Unique Points
This is not a search system like Google or commercial scientific searches. It's a wrapper round several major repositories, some (e.g. biorxiv, or Latin America, or theses) which aren't used in some systems and where there is no bulk download and analysis (note GoogleScholar prevents bulk download by citizens). Note also that many systems give you no choice about the material searched and often limit the type of query.

## Automation
Most search systems give you a list of hits you have to click through. We automate the clicking, up to thousands of hits so you can ask complex questions. You either get immediate sample results or run queries in the background. It completely changes the way you think.
## Single point of contact and single interface
The current "publishing system" is totally fragmented. There are 100+ scientific publishers, all of whom delight in having individual web sites and competing against each other. This is Babel. To search the whole literature you have to go to each publisher in turn and navigate an arcane system which is never friendly to mass downloads (even when that's legal). We solve that by doing the hard work so you don't have to.
## Semantic Content
A PDF document is incredibly difficult for machines to interpret. There are no words, sentences, paragraphs, sections, chapters. The human brain can reconstruct them, machines can't. Except we can. It's not perfect but it's very usable. We add these things back as HTML. 
### Sectioned Fulltext
Scetions are really important. Was the disease mentioned in the introduction or the results? Was the country in the methods (e.g. where the research took place) or in the funders?
### Tagging and Dictionaries
What does "zoonotic" mean? or "nosocomial"? Many citizens (including me) have to look these words up. Our system does this automatically.
### AMI-Wikidata 
Wikidata (think "data from Wikipedia") is the most powerful universal Open meta/data resource on the planet. It's got nearly 100 million objects defined and referenced - countries, people, diseases, drugs, treatments, poverty, human rights, ... and Wikidata is built into the system so it interprets the article for you. 
## Sources
There are many sources which are underutilised because most people don't know about them. How many citizens know where to find UK theses? FR theses? and when they find them how to get machines to read them. AMI knows about these and we've been (tediously!) building interfaces for each. So far we've got about 10 in the current system - the main ones listed here.
### EuropePMC
The "gold standard" https://europepmc.org. A collection of millions of open access biomedical papers. This is the system w suggest you start with. You can download 500 articles a minute (with good connection) and analyze them in a few minutes.
### biorxiv
A few years old, Biorxiv is the worlds preprint server for biomedical and becoming increasingly popular by the daya. Many recent articles are now published there within 24 hours of being submitted. CAVEAT: They aren't peer-reviewed but obvious rubbish (like 5G phones) will be removed.
### medrxiv
Same as biorxiv but for medical articles. Between biorxiv and medrxiv there are 1200+ open preprints on coronavirus (rather a lot recently on speculative drug design - my field - but hey).
### DOAJ. 4 million, abstracts all linkable to fulltext
### Theses . (in development) 100,000 UK theses
### HAL, French repository
## Dictionaries
Besides explaining scientific terms, dictionaries have the major functions:
* tagging terms to help further computation (Natural Language Processing, Machine Learning, etc.)
* linking to Wikidata for even more semantic background
* translating into different human languages.
AMI dictionaries are often quick to create especially if there is a good Wikipedia resource or a list of words already in Wikidata. We have built 50+ dictionaries in a distributed system so that anyone can choose their own subset or even create their own.
## Reconfigurable Toolset (AMI)
AMI is a Toolkit with many functions. Think "Unix for scholarly knowledge", Its workflow is :
* read from source/s
* standardise, transform, search, index, tag, etc.
* output to other tools, publish, etc.
AMI is platform-independent; it uses standards wherever possible (UNIX, Java and other OS, W3C (XML, HTML, SVG, CSS, etc.), JATS,) and standard F/OSS libraries and EXES's. Major wrapped tools are Apache, PDFBox, Grobid, Tesseract, GOCR, curl). It is probably more versatile than any other Open tool in extracting knowledge from scholarly publications.
## Extensible
AMI is extensible. It has been bolted into many sources, and outputs (e.g. Jupyter, R, KNIME...)
![image](https://user-images.githubusercontent.com/10074162/79960906-e66e7b00-847d-11ea-8202-c4b31cbe7da4.png)


# Exploration
AMI is well suited for exploration. Come up with an idea, search, transform and see if anything comes out. We want YOUR ideas in the hackathon, please!


