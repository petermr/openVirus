# Welcome to the page!


**Dictionary:** Funder (All the funders across the globe)

**Author:** Vaishali Arora

**Updated on:** September 18, 2020

**Source:** Crossref

**Number of entries:** ~17k

**Method:** SPARQL/Wikidata Query Service

**Attributes in there:** term, name, description, WikdataID, wikidataURL, wikipedia URL, crossrefID, country, synonyms

**SPARQL query used:** 


```
#Funders
 SELECT DISTINCT ?Funder ?FunderLabel ?FunderDescription ?FunderAltLabel ?Country ?CountryLabel ?instanceofLabel ?crossrefid ?wikipedia WHERE {
   ?Funder wdt:P3153 ?crossrefid;
     wdt:P31 ?instanceof;
     wdt:P17 ?Country.
   OPTIONAL { ?wikipedia schema:about ?Funder; schema:isPartOf <https://en.wikipedia.org/> }
   SERVICE wikibase:label { bd:serviceParam wikibase:language "en". }
 }
 LIMIT 20000000
 ```
 
**SPARQL output:** https://github.com/petermr/openVirus/blob/master/dictionaries/funders/sparql2ami/funder.sparql.xml
 
**SPARQL output refined using ami SPARQL mapping:**
 
**Syntax used:** 
 ```
 amidict -vv --dictionary disease --directory mydictionaries --input funder.sparql.xml create --informat wikisparqlxml --sparqlmap wikidataURL=Funder,term=FunderLabel,name=FunderLabel,country=CountryLabel,crossrefid=crossrefid,description=FunderDescription,wikipediaURL=wikipedia,wikidataURL=Funder --transformName wikidataID=EXTRACT(wikidataURL,.*/(.*)) --synonyms=wikidataAltLabel
 ```
 
 **Final dictionary:** https://github.com/petermr/openVirus/blob/master/dictionaries/funders/sparql2ami/funder.xml
 
