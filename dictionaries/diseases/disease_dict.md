# Disease Dictionary

Contributor : Lakshmi Devi Priya

The number of entries : >13800

Latest update on : 26 Oct 2020

All dictionary's Source : Wikidata and ICD-10 
## Valid Dictionary
* The valid `disease` dictionary is at https://github.com/petermr/openVirus/blob/master/cambiohack2020/dictionaries/disease.xml 
* This disease dictionary is multilingual with four languages and it was validated in respect to the `xml schema` at https://github.com/petermr/openVirus/blob/master/cambiohack2020/dictionaries/openVirus_schema.xsd
* For using in `ami search`, please refer https://github.com/petermr/openVirus/wiki/miniproject:-viral-epidemics-and-disease#using-valid-dictionary-for-ami-search
### ICD
ICD, which was adopted in 1967 by the WHO Nomenclature Regulations, is the foundation for the identification of health trends and statistics globally, and the international standard for reporting diseases and health conditions. It is the diagnostic classification standard for all clinical and research purposes. ICD-10 is the 10th edition. (11th edition is available online.)
## Creation of disease dictionary
### from SPARQL as text file
* A text document named disease was created in the local file of the system containing the names of the diseases. The names of the diseases were collected from Wikidata Query Service (SPARQL). While copying the names from Wikidata to the text document the special characters such as `-`,`'` were changed that leads to the alteration of diseases' names and hence the names in the text document were verified manually.
* The page on "helping to create a wikidata query" (https://www.wikidata.org/wiki/Wikidata:SPARQL_query_service/Query_Helper#How_to_create_a_Query) , helped to increase the number of results. The number of results previously obtained from the Wikidata Query Service was 13k but using the above page, the results obtained was 17k. (Thanks @VaishaliArora)
* Using the syntax `amidict -v --dictionary disease --directory dictionary --input disease.txt create --informat list --outformats xml,html --wikilinks wikipedia, wikidata` a dictionary was created (Thanks @Ambreen). The `--directory` describes the output folder where the dictionary is created in the system.
* The output shows much errors and warnings. The output directory consists of an xml and a html format files.
* The xml format disease dictionary is at https://github.com/petermr/openVirus/blob/master/dictionaries/diseases/disease_new.xml
* The html format disease dictionary is at https://github.com/petermr/openVirus/blob/master/dictionaries/diseases/disease_new.html

(_NOTE_: See also https://github.com/petermr/openVirus/wiki/Dictionary:-Diseases#preferring-xml-file)
### from SPARQL query 
#### i)as xml file
* The `manual rectifiction` is **not necessary** when downloaded as an xml file.
* The `disease` dictionary with _synonyms_ was created from the sparql query. 

(_NOTE_: The synonym dictionary of `disease` has some issues which are mentioned at https://github.com/petermr/openVirus/wiki/Dictionary:-Diseases#issues-and-doubts )
* The results shown in the sparql query is downloaded, by choosing the option 'sparql endpoint' in 'link', as an xml file named 'sparql' in the system.
* Using the syntax `amidict -v --dictionary disease --directory dic --input sparql create --informat wikisparqlxml` a synonym dictionary was created.
* The output xml format dictionary was created in the directory dic.
* The synonym dictionary created is at https://github.com/petermr/openVirus/blob/master/dictionaries/test/disease_synonym.xml
* This synonym dictionary is a little messey and needs to be prettified.
#### ii)the latest dictionary with ICD-10 codes
* The latest `disease` dictionary was created using the SPARQL query - https://w.wiki/Z7H (Thanks @Dheeraj - mini-project collaborator), and downloaded the results using `sparql endpoint` as an xml file named 'disease_icd10'.
* AMI was updated, hence a lot changed/updated from previous amidict syntax in creating dictionary.
* Using the syntax 
```amidict -vv --dictionary disease --directory dic --input disease create --informat wikisparqlxml --sparqlmap wikidataURL=wikidata,wikipediaPage=wikipedia,wikidataAltLabel=wikidataAltLabel,name=wikidataLabel,term=wikidataLabel,Description=wikidataDescription,_p494_icd10code=ICD_10 --transformName wikidataID=EXTRACT(wikidataURL,.*/(.*)) --synonyms=wikidataAltLabel```, the latest dictionary with ICD-10 codes was created.
* The `--sparqlmap` command's input changes with the names in accordance with the input file. Refer https://github.com/petermr/ami3/wiki/amidict:-wikisparql#full-input for more information.
* The latest `disease` dictionary is at https://github.com/petermr/openVirus/blob/master/dictionaries/diseases/disease.xml, though the synonyms in the dictionary needs iteration.
#### iii)the multilingual dictionary with 6 languages
* The multilingual `disease` dictionary with four languages was created using the SPARQL query - https://github.com/petermr/openVirus/blob/master/dictionaries/diseases/sparql_disease_snh16Oct (Thanks @Dheeraj - mini-project collaborator), and downloaded the results using `sparql endpoint` as an xml file named 'disease_lang'.
* Using the syntax ```amidict -vv --dictionary disease --directory dic --input sparql_disease_snh16Oct create --informat wikisparqlxml --sparqlmap wikidataURL=wikidata,wikipediaPage=wikipedia,altLabel=wikidataAltLabel,name=wikidataLabel,term=wikidataLabel,Description=wikidataDescription,_p494_icd10code=ICD_10,Hindi=hindiLabel,Hindi_description=hindi,Hindi_altLabel=hindiAltLabel,Tamil=tamilLabel,Tamil_description=tamil,Tamil_altLabel=tamilAltLabel,Portuguese=ptLabel,Portuguese_description=pt,Portuguese_altLabel=ptAltLabel,Kannada=knLabel,Kannada_altLabel=knAltLabel,Kannada_description=kn,Spanish=spanishLabel,Spanish_description=spanish,Spanish_altLabel=spanishAltLabel --transformName wikidataID=EXTRACT(wikidataURL,.*/(.*)) --synonyms=wikidataAltLabel```, the multilingual dictionary was created. (Thanks @Shweata)
* The multilingual `disease` dictionary is at https://github.com/petermr/openVirus/blob/master/dictionaries/diseases/disease_snh16Oct.xml

### Spanish dictionary
* A `Spanish disease` dictionary was created from the SPARQL query - https://w.wiki/i9R ( Thanks @Dheeraj)
* Using 
```amidict -vv --dictionary enfermedad --directory dic --input sparql_enfermedad create --informat wikisparqlxml --sparqlmap wikidataURL=wikidata,wikipediaPage=wikipedia,wikidataAltLabel=wikidataAltLabel,name=wikidataLabel,term=wikidataLabel,Description=wikidataDescription,_p494_icd10code=ICD_10 --transformName wikidataID=EXTRACT(wikidataURL,.*/(.*)) --synonyms=wikidataAltLabel```, the Spanish dictionary was created.
* The `Spanish disease` dictionary is at https://github.com/petermr/openVirus/blob/master/dictionaries/diseases/enfermedad.xml