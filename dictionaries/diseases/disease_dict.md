# Disease Dictionary
This dictionary will be updated from ICD-10.

#### Tester : Lakshmi Devi Priya

The number of entries : 17223

Dictionary updated on : 04 July 2020
### ICD
ICD, which was adopted in 1967 by the WHO Nomenclature Regulations, is the foundation for the identification of health trends and statistics globally, and the international standard for reporting diseases and health conditions. It is the diagnostic classification standard for all clinical and research purposes. 
## Creation of disease dictionary
* A text document named disease was created in the local file of the system containing the names of the diseases. The names of the diseases were collected from Wikidata Query Service. While copying the names from Wikidata to the text document the special characters such as `-`,`'` were changed that leads to the alteration of diseases' names and hence the names in the text document were verified manually.
* The page on helping to create a wikidata query https://www.wikidata.org/wiki/Wikidata:SPARQL_query_service/Query_Helper#How_to_create_a_Query , helped to increase the number of results. The number of results previously obtained from the Wikidata Query Service was 13k but using the above page, the results obtained was 17k. (Thanks @VaishaliArora)
* Using the syntax `amidict -v --dictionary disease --directory dictionary --input disease.txt create --informat list --outformats xml,html --wikilinks wikipedia, wikidata` a dictionary was created (Thanks @Ambreen). The `--directory` describes the output folder where the is dictionary created in the system.
* The output shows much errors and warnings. The output directory consists of an xml format file.
* The disease dictionary is at https://github.com/petermr/openVirus/blob/master/dictionaries/diseases/disease_new.xml
### from SPARQL query
* The `disease` dictionary with _synonyms_ was created from the sparql query. (_NOTE_: The synonym dictionary of `disease` has some issues which are mentioned at https://github.com/petermr/openVirus/wiki/Dictionary:-Diseases#issues-and-doubts )
* The results shown in the sparql query is downloaded, by choosing the option 'sparql endpoint', as an xml file named 'sparql' in the system.
* Using the syntax `amidict -v --dictionary disease --directory dic --input sparql create --informat wikisparqlxml` a synonym dictionary was created.
* The output xml format dictionary was created in the directory dic.
* The synonym dictionary created is at https://github.com/petermr/openVirus/blob/master/dictionaries/test/disease_synonym.xml
