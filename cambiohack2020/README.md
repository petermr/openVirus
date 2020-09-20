# Materials for Cambiohack 2020

These. materials are freely copyable (CC BY) . 

## Corpora
[minicorpora](./minicorpora/)

### viralEpidemics100

The search `getpapers -q "viral epidemic" -k 100 -x -o was run viralEpidemic100` and the results collected here.
100 papers downloaded from europepmc.org . Each contains metadata and XML, but no computed results.

[viralEpidemics100](./minicorpora/viralEpidemics100)

### viralEpidemics10
A subset of 10 of the above with `ami search --dictionary country drug` which shows the type of output

[viralEpidemics10](./minicorpora/viralEpidemics10)

## Dictionaries

dictionaries created by openVirus interns

### country

ISO 639 codes for all countries in Wikidata

The country dictinary enables ami search to output the frequency with which a country appears in the papers. When used along with other dictinaries, it gives relevant coocccurrences with regards to the terms in the other dictionary as well. This helps us in answering critcal questions like which countries do viral epidemics occur more frequently in?

_More information:_ 
- [Creation of the country dictionary](https://github.com/petermr/openVirus/blob/master/dictionaries/country/country_dict.md); 
- [Usage within a miniproject](https://github.com/petermr/openVirus/wiki/miniproject:-viral-epidemics-and-country); 
- [Dictionary creation from Wikidata](https://github.com/petermr/openVirus/blob/master/dictionaries/country/country_dict.md#dictionary-from-wikidata)
- [Country dictionary](./dictionaries/country.xml) 

### disease

ICD10 codes (diseases) in Wikidata

[disease](./dictionaries/disease.xml)

* For more details on dictionary, please visit this wiki page https://github.com/petermr/openVirus/wiki/Dictionary:-Diseases

* For viewing the `ami` results of the dictionary that was tested on a large corpus, please visit this page https://github.com/petermr/openVirus/tree/master/miniproject/disease

### drug

Drugs in Wikidata

[drug](./dictionaries/drug.xml)


### funder

Crossref funder IDs in Wikidata

[funder](./dictionaries/funder.xml)

### npi

non-pharmaceutical interventions for fighting epidemics (hand snowballed)

[npi](./dictionaries/npi.xml)

### testTrace

test and trace terminology (manually snowballed)

[testTrace](./dictionaries/testTrace.xml)

### virus

Viruses in Wikidata

[virus](./dictionaries/virus.xml)

### zoonosis

diseases transmitted by animals (manually snowballed)

[zoonosis](./dictionaries/zoonosis.xml)


