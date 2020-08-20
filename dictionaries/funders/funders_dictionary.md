# Dictionary: Funders
## Created by: Vaishali Arora

### Source: Crossref.org

The CrossRef Funder Registry is an open registry of grant-giving organisation names and identifiers across the World.

Updated the dictionary on: June 19, 2020

Number of entries: 23355

### Creating the Dictionary 1 :
1. Create a text file (.txt) containing a list of funders that you are making a dicitonary for (accessed the list{.txt file} from CrossRef.org). Wikidata query service can also be used for the same.
2. Meanwhile, create a directory by giving command in the command prompt as : `mkdir mydictionaries` This is the ouput directory where you are going to get the dictionary.
3. Make two empty files in the created output directory **'mydictionaries'**, one as .html file and the other one as .xml file.
4. Open the command prompt and give the command as: `amidict -v --dictionary funders --directory mydictionaries --input funders.txt create --informat list --outformats xml,html`
5. `amidict`is a command suite for creating dictionaries.
6. The **input file** in the syntax is the file which was downloaded in Step 1.
7. After giving the command in Step 4, it took a while to create the dictionary.
8. Open the folder 'mydictionaries' in the system, the dictionary is created as both **xml** and **html** file.
9. The dictionary created is :   https://github.com/petermr/openVirus/blob/master/dictionaries/test/funder.xml

**Note**: The dictionary 1 has only two things : name and term.

**Dictionary validation using ami :**


`amidict --dictionary C:\Users\myPC\mydictionaries\funders(1).xml -v display --fields --validate`
```
Generic values (DictionaryDisplayTool)
================================
--testString        : d      null
--wikilinks         : d [Lorg.contentmine.ami.tools.AbstractAMIDictTool$WikiLink;@1ae7dc0
--fields            : m        []
--files             : d        []
--maxEntries        : d         3
--remote            : d [https://github.com/petermr/dictionary]
--validate          : m      true
--help              : d     false
--version           : d     false
--dictionary        : d [C:\Users\myPC\mydictionaries\funders(1).xml]
--directory         : d      null

Specific values (DictionaryDisplayTool)
================================
list all fields
dictionaries from C:\Users\myPC\ContentMine\dictionaries
```


### Creating the dictionary 2 :
1. To add more items to my dictionary funder, I changed the syntax in the CommandLine a little bit. 
2. This time I used the command : `amidict -v --dictionary funders --directory mydictionaries --input funderlist.txt create --informat list --outformats xml,html --wikilinks wikipedia, wikidata`
3. The dictionary created is again in two formats in the directory **mydictionaries**: one in **.xml**, the other one in **.html**
4. This dictionary contains name, term, wikidata ID, description.
5. The dictionary created is : https://github.com/petermr/openVirus/blob/master/dictionaries/funders/funders%20(1).xml
6. This dictionary has 13117 entries, probably because these items in the dictionary had a Wikidata ID and not all of them.

### Creating the dictionary 3 :
1. This one is created using SPARQL/Wikidata Query Service.
2. How is it created ?  ---- https://github.com/petermr/openVirus/wiki/Dictionaries:-creation-from-Wikidata
3. **SPARQL Query used :**

`#Funders`
`SELECT ?FunderLabel ?Country ?CountryLabel ?instanceofLabel  ?Funder ?crossrefid  WHERE {`
 ` ?Funder wdt:P3153 ?crossrefid .`
  `?Funder wdt:P31 ?instanceof .`
  `?Funder wdt:P17 ?Country .`
  
 
  `SERVICE wikibase:label { bd:serviceParam wikibase:language "en". }`
`}`
`LIMIT 20000000`


4. The dictionary created is : https://github.com/petermr/openVirus/blob/master/dictionaries/funders/funder.sparql.xml
5. In this case, the output is in the format **sparql.xml**
