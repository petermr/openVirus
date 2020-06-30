# Diseases Dictionary
This dictionary was created from ICD-10.
The number of entries : 13046
Dictionary updated on : 30 June 2020
### ICD
ICD, which was adopted in 1967 by the WHO Nomenclature Regulations, is the foundation for the identification of health trends and statistics globally, and the international standard for reporting diseases and health conditions. It is the diagnostic classification standard for all clinical and research purposes. 
## Creation of diseases dictionary
* A text document named diseases was created in the local file of the system containing the names of the diseases. The names of the diseases were collected from Wikidata Query Service. While copying the names from Wikidata to the text document the special characters such as `-`,`'` were changed altering the diseases' names and hence the names in the text document were verified.
* Using the syntax `amidict -v --dictionary diseases --directory Dictionary --input diseases.txt create --informat list --outfrmats xml` a dictionary was created. The `--directory` describes the folder of output dictionary created in the system.
* The output shows much errors and warnings. The output directory consists of an xml format file.
* The diseases dictionary is at https://github.com/petermr/openVirus/blob/master/dictionaries/diseases/diseases.xml
### Test dictionary
* Primarily a test dictionary on diseases was created by following the above mentioned steps but with few diseaes' names.
* The test dictionary is at https://github.com/petermr/openVirus/blob/master/dictionaries/test/diseases.xml
