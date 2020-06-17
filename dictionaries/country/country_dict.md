# Country Dictionary 

### Source of the Dictionary

This dictionary was created from a ISO Country list. 

### ISO

The International Organization for Standardization is an international Non Government, standard-setting body which promotes worldwide proprietary, industrial, and commercial standards. It is headquartered in Geneva, Switzerland, and works in 164 countries.

### Creation of the dictionary 
The country dictionary can be created using the following procedure: 
1. Create a textfile with the list of countries that you want to create a dictionary for. These may be acquired using the Wikidata Query Service. Each line of the text file should contain a single country.

2. Use the following command to create the dictionary
`amidict -v --dictionary country --directory country --input country.txt create --informat list --outformats xml,html`
(here --directory specifies the output directory) 

3. The output directory contains 2 files in xml and html format. 

4. There were, however, multiple errors and a lot of debugging may be required. The input file should not contain any errors. 

5. The output dictionary for further testing: https://github.com/petermr/openVirus/blob/master/dictionaries/test/country.xml



