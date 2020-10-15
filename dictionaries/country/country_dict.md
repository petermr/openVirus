# Country Dictionary 
**Tester:** Ambreen Hamadani

### Source of the Dictionary

This dictionary was created from a ISO Country list. 

### ISO

The International Organization for Standardization is an international Non Government, standard-setting body which promotes worldwide proprietary, industrial, and commercial standards. It is headquartered in Geneva, Switzerland, and works in 164 countries.

### Creation of the dictionary 
The country dictionary can be created using the following procedure: 

1. Create a textfile with the list of countries that you want to create a dictionary for. These may be acquired using the Wikidata Query Service. Each line of the text file should contain a single country. (This particular dictionary was created using the list of ISO countries available in wikipedia: https://en.wikipedia.org/wiki/List_of_ISO_3166_country_codes

2. Use the following command to create the dictionary
`amidict -v --dictionary country --directory country --input country.txt create --informat list --outformats xml,html`
(here --directory specifies the output directory) 

3. The output directory contains 2 files in xml and html format. Number of countries in the text file used as input: *249* ; Number of entries in the output dictionary: *249*

4. There were, however, multiple parse errors and a lot of debugging may be required eg: 
```
[Fatal Error] :1717:5: The element type "input" must be terminated by the matching end-tag "</input>".
1586319 [main] ERROR org.contentmine.ami.tools.AbstractAMIDictTool  - cannot parse wikipedia page for: zambia; cannot parse/read stream:
1586319 [main] ERROR org.contentmine.ami.tools.AbstractAMIDictTool  - cannot parse wikipedia page for: zambia; cannot parse/read stream:
[Fatal Error] :190:5: The element type "input" must be terminated by the matching end-tag "</input>".
<190/5>badline >                </div>
                </div>
Cannot add entry: nu.xom.ParsingException: The element type "input" must be terminated by the matching end-tag "</input>". at line 190, column 5
[Fatal Error] :2430:5: The element type "input" must be terminated by the matching end-tag "</input>".
1592212 [main] ERROR org.contentmine.ami.tools.AbstractAMIDictTool  - cannot parse wikipedia page for: zimbabwe; cannot parse/read stream:
1592212 [main] ERROR org.contentmine.ami.tools.AbstractAMIDictTool  - cannot parse wikipedia page for: zimbabwe; cannot parse/read stream:
[Fatal Error] :190:5: The element type "input" must be terminated by the matching end-tag "</input>".
<190/5>badline >                </div>
                </div>
Cannot add entry: nu.xom.ParsingException: The element type "input" must be terminated by the matching end-tag "</input>". at line 190, column 5
```

*IMPORTANT:* The input text file should not contain any errors. 



### Testing on a small number of countries
In order to test the query, only ten countries were taken within the test file to begin with
1. Canada
2. Japan
3. Norway
4. Wales
5. Ireland
6. United States of America
7. Denmark
8. Poland
9. Italy
10. Switzerland

Upon running the query as stated above, the following xml directory was retrieved: 

```
<?xml version="1.0" encoding="UTF-8"?>
<dictionary title="country_ten.txt">
 <entry term="canada" name="canada" id="CM.country.0"/>
 <entry term="denmark" name="denmark" id="CM.country.1"/>
 <entry term="ireland" name="ireland" id="CM.country.2"/>
 <entry term="italy" name="italy" id="CM.country.3"/>
 <entry term="japan" name="japan" id="CM.country.4"/>
 <entry term="norway" name="norway" id="CM.country.5"/>
 <entry term="poland" name="poland" id="CM.country.6"/>
 <entry term="switzerland" name="switzerland" id="CM.country.7"/>
 <entry term="united states of america" name="united states of america" id="CM.country.8"/>
 <entry term="wales" name="wales" id="CM.country.9"/>
 <query>('canada') OR ('denmark') OR ('ireland') OR ('italy') OR ('japan') OR ('norway') OR ('poland') OR ('switzerland') OR ('united states of america') OR ('wales')</query>
</dictionary>
```

### Testing on a country list acquired from Wikidata
1. Wikidata query was used to generate dictionary for those countries Countries that have sitelinks to en.wiki. For this purpose the following query in SPARQL was used: 
```
SELECT ?country ?countryLabel ?article WHERE {

    ?country wdt:P31 wd:Q3624078 . # sovereign state
    ?article schema:about ?country .
    ?article schema:isPartOf <https://en.wikipedia.org/>.

    SERVICE wikibase:label {
       bd:serviceParam wikibase:language "en"
    }
}
```
2. The list of countries was copied and pasted from the CSV file retrieved thus into a text file which was then used to create another dictionary.
3. The query ran with errors similar to the ones stated above. 
4. Number of countries in the text file used as input: *195* ; Number of entries in the output dictionary: *195*


### DICTIONARY FROM WIKIDATA: 

1. The following sparql query was used for the creation of the dictionary 
[SPARQL QUERY ](https://query.wikidata.org/#%23%23%20Select%20Query%20was%20used%20to%20retrieve%20specific%20results%20%28Country%20name%2C%20wiki%20data%20number%2C%20Synonyms%29%0ASELECT%20%3Fwikidata%20%3FwikidataLabel%20%28%3Fcode%20as%20%3F_iso3166%29%20%3Fwikipedia%20%28%3FwikidataAltLabel%20as%20%3Falt%29%20%3Fsynonym%20%3FwikidataDescription%20%20%28%3FwikidataLabel%20as%20%3Fterm%29%20%7B%20%0A%0A%23%23%20Forcing%20particular%20query%20execution%20order%0A%20%20hint%3AQuery%20hint%3Aoptimizer%20%22None%22%20.%20%0A%0A%23%23%20all%20ISO%20countries%20%0A%20%20%3Fwikidata%20wdt%3AP297%20%3Fcode.%0A%0A%23%23%20Optional%20details%20about%20the%20countries%20like%20links%20to%20wikipaedia%20pages%20for%20each%20country%20to%20be%20presented%20in%20a%20seperate%20column%0A%20%20OPTIONAL%20%7B%20%3Fwikipedia%20schema%3Aabout%20%3Fwikidata%3B%20schema%3AisPartOf%20%3Chttps%3A%2F%2Fen.wikipedia.org%2F%3E%20%7D%0A%20%20SERVICE%20wikibase%3Alabel%20%7B%0A%20%20%20%20bd%3AserviceParam%20wikibase%3Alanguage%20%22en%22.%0A%0A%23%23%20Selecting%20the%20prefered%20label%20%0A%20%20%20%20%3Fwikidata%20skos%3AaltLabel%20%3FwikidataAltLabel%20%3B%20rdfs%3Alabel%20%3FwikidataLabel%3B%20schema%3Adescription%20%20%3FwikidataDescription%20%20%20%20%20%20%20%20%20%20%0A%20%20%7D%20%0A%0A%23%23%20Making%20sure%20the%20RGI%20alphabets%20of%20the%20flags%20are%20not%20rendered%20as%20flags%20and%20they%20appear%20as%20simple%20alphabets%20by%20specifying%20the%20acceptable%20characters.%20%0A%20%20BIND%20%28REPLACE%28REPLACE%28%3FwikidataAltLabel%2C%20%22%28%2C%20%29%3F%5B%F0%9F%87%A6-%F0%9F%87%BF%5D%7B2%7D%22%2C%20%22%22%29%2C%20%22%5E%2C%20%22%2C%20%22%22%29%20AS%20%3Fsynonym%20%29%0A%7D%0A%0A%20ORDER%20BY%20%28%3FwikidataLabel%29)
This wwas saved as SPARQL endpoint

2. amidict was used to convert the dictionary into standard xml format
``` 
amidict -vv --dictionary country --directory ami_12_08_2020/amidict --input ami_12_08_2020/country.xml create --informat=wikisparqlxml --sparqlmap wikidata=wikidata,term=term,name=wikidataLabel,description=wikidataDescription,wikipedia=wikipedia,_iso3166=_iso3166 --synonyms=synonym
ami -p ami_12_08_2020\corpus_950 search --dictionary ami_12_08_2020\xml.xml
```


3. The dictionary was validated using the follorwing 
```
amidict --dictionary country --directory ami_12_08_2020/amidict10  display --validate
```











