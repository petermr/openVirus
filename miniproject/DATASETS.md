# datasets

## original dataset
Originally ran the query:
```
getpapers -q "viral epidemic" -k 50 -x -f epidemic50/log.txt -o epidemic50/
```
But this retrieved so many COVID papers that we decided to remove all

## epidemic50noCov
### query
```
getpapers -q "(viral epidemic) NOT COVID NOT SARS-Cov NOT coronavirus " -k 50 -x -f epidemic50/log.txt -o epidemic50noCov/
```
downloaded the XML.

### search with dictionaries
```
ami -p epidemic50noCov search --dictionary country disease inn funders tropicalVirus
```

creates 
```
├── commonest.dataTables.html
├── count.dataTables.html
├── entries.dataTables.html
├── eupmc_fulltext_html_urls.txt
├── eupmc_results.json
├── full.dataTables.html
├── log.txt
├── search.country.count.xml
├── search.country.documents.xml
├── search.country.snippets.xml
├── search.disease.count.xml
├── search.disease.documents.xml
├── search.disease.snippets.xml
├── search.funders.count.xml
├── search.funders.documents.xml
├── search.funders.snippets.xml
├── search.inn.count.xml
├── search.inn.documents.xml
├── search.inn.snippets.xml
├── search.tropicalVirus.count.xml
├── search.tropicalVirus.documents.xml
├── search.tropicalVirus.snippets.xml
├── word.frequencies.count.xml
├── word.frequencies.documents.xml
└── word.frequencies.snippets.xml
```
and
```

├── __cooccurrence
│   ├── allPlots.svg
│   ├── country
│   │   ├── histogram.csv
│   │   └── histogram.svg
│   ├── country-country
│   │   ├── cooccur.csv
│   │   └── cooccur.svg
│   ├── country-disease
│   │   ├── cooccur.csv
│   │   └── cooccur.svg
```

