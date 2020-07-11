## Dictionary: virus
Source of this dictionary is ICTV (International Committee on Taxonomy of Viruses) and Wikipedia

#### ICTV
The International Committee on Taxonomy of Viruses authorizes and organizes the taxonomic classification of and the nomenclatures for viruses. The ICTV has developed a universal taxonomic scheme for viruses, and thus has the means to appropriately describe, name, and classify every virus that affects living organisms.

### Tester
Kareena Singh 

### Creating the dictionary

#### Using a text file
- Create a text file (virus.txt) in notepad in your system containing the list of all the viruses (vertebrate). The source of the list was ICTV and Wikipedia. It contained the viruses that cause human diseases.
- Use the following command to create the dictionary `amidict -v --dictionary virus --directory virus --input virus.txt create --informat list --outformats xml`  (here --directory specifies the output directory)
- The output showed much errors and warnings.
- The output dictionary here https://github.com/petermr/openVirus/blob/master/dictionaries/virus/virus_terms.xml
- It consists of 125 entries in xml format

#### Using Wikidata Query Service on SPARQL
- Go to https://www.wikidata.org/wiki/Wikidata:Main_Page and click on 'Query Service' at the left column. This will redirect you to Wikidata Query Service page where you can create your SPARQL query.
- For creating a query on SPARQL, follow these instructions https://www.wikidata.org/wiki/Wikidata:SPARQL_query_service/Query_Helper anf filter your query.
- Once you have made your query, Run / Execute your query (Make sure to increase the result limit upto 10000 or above as per your choice by editing the 'LIMIT' option)
- Once you get the results, Click on 'Link' and then "SPARQL endpoint' . This will let you download your SPARQL file. Open it using Notepad and Upload it as your dictionary file. 
- Here is the output dictionary https://github.com/petermr/openVirus/blob/master/dictionaries/virus/virus_SPARQL

#### For creating a dictionary containing wikidata Q number and wikipedia links
- Download the .json file of your SPARQL query results and save it in your directory( eg:  in the virus folder as virus.json) 
- Go to the command prompt and navigate to where `ami3` is . and give the command `amidict -v --dictionary virus --directory virus --input virus.json create --informat list --outformats xml,html --wikilinks wikipedia, wikidata`
- Output will give you dictionary in both xml and html formats in the directory you provided.
- Here is the output dictionary https://github.com/petermr/openVirus/blob/master/dictionaries/virus/virus_wikidata.xml







