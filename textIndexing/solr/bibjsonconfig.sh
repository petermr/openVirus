# see https://doaj.org/api/v1/docs
DOAJ="http://localhost:8983/solr/doaj/schema"
curl -X POST -H 'Content-type:application/json' --data-binary '{
  "add-field":{
     "name":"bibjson.end_page",
     "type":"string",
     "stored":true,
     "indexed":true }
}' $DOAJ
curl -X POST -H 'Content-type:application/json' --data-binary '{
  "add-field":{
     "name":"bibjson.journal.language",
     "type":"string",
     "multiValued":true,
     "stored":true,
     "indexed":true }
}' $DOAJ
curl -X POST -H 'Content-type:application/json' --data-binary '{
  "add-field":{
     "name":"bibjson.journal.number",
     "type":"string",
     "stored":true,
     "indexed":true }
}' $DOAJ

curl -X POST -H 'Content-type:application/json' --data-binary '{
  "add-field":{
     "name":"bibjson.journal.volume",
     "type":"string",
     "stored":true,
     "indexed":true }
}' $DOAJ

curl -X POST -H 'Content-type:application/json' --data-binary '{
  "add-field":{
     "name":"bibjson.journal.issns",
     "type":"string",
     "stored":true,
     "indexed":true,
     "multiValued":true }
}' $DOAJ

curl -X POST -H 'Content-type:application/json' --data-binary '{
  "add-field":{
     "name":"bibjson.month",
     "type":"string",
     "stored":true,
     "indexed":true }
}' $DOAJ

curl -X POST -H 'Content-type:application/json' --data-binary '{
  "add-field":{
     "name":"bibjson.end_page",
     "type":"string",
     "stored":true,
     "indexed":true }
}' $DOAJ

curl -X POST -H 'Content-type:application/json' --data-binary '{
  "add-field":{
     "name":"bibjson.start_page",
     "type":"string",
     "stored":true,
     "indexed":true }
}' $DOAJ

curl -X POST -H 'Content-type:application/json' --data-binary '{
  "add-field":{
     "name":"bibjson.year",
     "type":"string",
     "stored":true,
     "indexed":true }
}' $DOAJ
curl -X POST -H 'Content-type:application/json' --data-binary '{
  "add-field":{
     "name":"bibjson.keywords",
     "type":"string",
     "stored":true,
     "indexed":true,
     "multiValued":true }
}' $DOAJ