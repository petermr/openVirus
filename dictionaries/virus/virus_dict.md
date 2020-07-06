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
- The output dictionary here https://github.com/petermr/openVirus/blob/master/dictionaries/virus/virus.xml
- It consists of 135 entries in xml format

#### Using Wikidata Query Service on SPARQL
