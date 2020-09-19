**My SPARQL output:** https://github.com/petermr/openVirus/blob/master/dictionaries/funders/funder.sparql.xml

**To convert SPARQL output to ami, I used this command and the output came out was:** 
```

C:\Users\EXPERT SOLUTION>amidict -vv --dictionary funder --directory mydictionaries --input funder.sparql.xml create --informat wikisparqlxml --sparqlmap wikidataID=Funder,wikidataURL=Funder,term=FunderLabel,name=FunderLabel,_country=CountryLabel,_crossrefid=crossrefid,description=FunderDescription,wikipediaPage=Funder,wikipediaURL=wikipedia
Version:
Generic values (DictionaryCreationTool)
================================
--testString        : d      null
--wikilinks         : d [Lorg.contentmine.ami.tools.AbstractAMIDictTool$WikiLink;@15b810e
--datacols          : d      null
--hrefcols          : d      null
--informat          : m wikisparqlxml
--linkcol           : d      null
--namecol           : d      null
--outformats        : d [Lorg.contentmine.ami.tools.AbstractAMIDictTool$DictionaryFileFormat;@cf93bb
--query             : d      null
--sparqlmap         : m {wikidataID=Funder, wikidataURL=Funder, term=FunderLabel, name=FunderLabel, _country=CountryLabel, _crossrefid=crossrefid, description=FunderDescription, wikipediaPage=Funder, wikipediaURL=wikipedia}
--sparqlquery       : d      null
--synonyms          : d      null
--template          : d      null
--termcol           : d      null
--termfile          : d      null
--terms             : d      null
--transformName     : d        {}
--wptype            : d      null
--input             : d      null
--inputnamelist     : d      null
--help              : d     false
--version           : d     false
--dictionary        : d  [funder]
--directory         : d mydictionaries
Specific values (DictionaryCreationTool)
================================
--testString        : d      null
--wikilinks         : d [Lorg.contentmine.ami.tools.AbstractAMIDictTool$WikiLink;@15b810e
--datacols          : d      null
--hrefcols          : d      null
--informat          : m wikisparqlxml
--linkcol           : d      null
--namecol           : d      null
--outformats        : d [Lorg.contentmine.ami.tools.AbstractAMIDictTool$DictionaryFileFormat;@cf93bb
--query             : d      null
--sparqlmap         : m {wikidataID=Funder, wikidataURL=Funder, term=FunderLabel, name=FunderLabel, _country=CountryLabel, _crossrefid=crossrefid, description=FunderDescription, wikipediaPage=Funder, wikipediaURL=wikipedia}
--sparqlquery       : d      null
--synonyms          : d      null
--template          : d      null
--termcol           : d      null
--termfile          : d      null
--terms             : d      null
--transformName     : d        {}
--wptype            : d      null
--input             : d      null
--inputnamelist     : d      null
--help              : d     false
--version           : d     false
--dictionary        : d  [funder]
--directory         : d mydictionaries
dictionaryName: funder
{Funder=[wikidataID, wikidataURL, wikipediaPage], crossrefid=[_crossrefid], FunderLabel=[term, name], FunderDescription=[description], CountryLabel=[_country], wikipedia=[wikipediaURL]}
sparqlVariables [Funder, FunderLabel, FunderDescription, Country, CountryLabel, instanceofLabel, crossrefid, wikipedia]
sparqlNameByAmiName: {_country=CountryLabel, wikidataID=Funder, name=FunderLabel, description=FunderDescription, term=FunderLabel, wikidataURL=Funder, wikipediaPage=Funder, _crossrefid=crossrefid, wikipediaURL=wikipedia}
amiNames [_country, wikidataID, name, description, term, wikidataURL, wikipediaPage, _crossrefid, wikipediaURL]
WS>[_country, wikidataID, name, description, term, wikidataURL, wikipediaPage, _crossrefid, wikipediaURL]
Personal ami name: _country
Personal ami name: _crossrefid
[_country, _crossrefid, description, name, term, wikidataID, wikidataURL, wikipediaPage, wikipediaURL]
search: [CountryLabel, Funder, FunderLabel, FunderDescription, FunderLabel, Funder, Funder, crossrefid, wikipedia]
target: [Funder, FunderLabel, FunderDescription, Country, CountryLabel, instanceofLabel, crossrefid, wikipedia]
java.lang.NullPointerException
        at java.util.ArrayList.addAll(Unknown Source)
        at org.contentmine.ami.tools.dictionary.WikidataSparql.checkWikidataVariables(WikidataSparql.java:84)
        at org.contentmine.ami.tools.dictionary.WikidataSparql.readSparqlVariablesAndCreateMapping(WikidataSparql.java:122)
        at org.contentmine.ami.tools.dictionary.WikidataSparql.readSparqlCreateDictionary(WikidataSparql.java:109)
        at org.contentmine.ami.tools.dictionary.DictionaryCreationTool.createAndWriteDictionary(DictionaryCreationTool.java:411)
        at org.contentmine.ami.tools.dictionary.DictionaryCreationTool.runSub(DictionaryCreationTool.java:318)
        at org.contentmine.ami.tools.AbstractAMIDictTool.runSpecifics(AbstractAMIDictTool.java:433)
        at org.contentmine.ami.tools.AbstractAMIDictTool.runCommands(AbstractAMIDictTool.java:97)
        at org.contentmine.ami.tools.AbstractAMIDictTool.call(AbstractAMIDictTool.java:78)
        at org.contentmine.ami.tools.AbstractAMIDictTool.call(AbstractAMIDictTool.java:55)
        at picocli.CommandLine.executeUserObject(CommandLine.java:1933)
        at picocli.CommandLine.access$1100(CommandLine.java:145)
        at picocli.CommandLine$RunLast.executeUserObjectOfLastSubcommandWithSameParent(CommandLine.java:2332)
        at picocli.CommandLine$RunLast.handle(CommandLine.java:2326)
        at picocli.CommandLine$RunLast.handle(CommandLine.java:2291)
        at picocli.CommandLine$AbstractParseResultHandler.execute(CommandLine.java:2159)
        at org.contentmine.ami.tools.AMIDict.enhancedLoggingExecutionStrategy(AMIDict.java:160)
        at picocli.CommandLine.execute(CommandLine.java:2058)
        at org.contentmine.ami.tools.AMIDict.main(AMIDict.java:87)
        ```
## To be reviewed by PMR.
