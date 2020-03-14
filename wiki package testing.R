library('WikipediR')
library('WikidataR')
library('WikidataQueryServiceR')
library('tibble')
library('tidytext')
library('htmltidy')
library('dplyr')
library('xml2')

# Recommended object endings
# .qr  = Query result(s)
# .qid = Wikidata QID number(s)
# .qs  = Wikidata item(s) summary
# .q   = Wikidata item(s) in full
# .p   = Properties of a Wikidata item(s)

# Functions ----------

qid_from_DOI <- function(DOI = '10.15347/WJM/2019.001'){
  qid_from_DOI_nest1 <- function(x){paste('SELECT ?DOI WHERE {?DOI wdt:P356 "',
                                          x,
                                          '"}',
                                          sep='')}
  qid_from_DOI_nest2 <- function(x){tail(stringr::str_split(x,pattern = "/")[[1]],n=1)}
  sparql_query <- lapply(DOI,qid_from_DOI_nest1)
  article.qr   <- lapply(query_wikidata(sparql_query),as_tibble)
  names(article.qr)<-DOI
  article.qid  <- unlist(lapply(article.qr,qid_from_DOI_nest2))
  article.qid
}

qid_from_name <- function(name  = 'Thomas Shafee',
                          limit = 100){
  qid_from_name_nest1 <- function(x){lapply(x,"[[","id")}
  item.qs  <- lapply(name,find_item, limit=limit)
  item.qid <- lapply(item.qs,qid_from_name_nest1)
  names(item.qid) <- name
  item.qid <- unlist(item.qid)
  item.qid
}

list_properties <- function (item,
                             names=FALSE){
  properties.p <- lapply(lapply(item,"[[","claims"),names)
  if(names){
    if(length(item)==1){
      names(properties.p) <- unlist(lapply(lapply(lapply(get_property(properties.p),"[[","labels"),"[[","en"),"[[","value"))
    }
  }
  properties.p 
}

get_names_from_properties <- function(properties){
  get_names_from_properties_nest1 <- function(x){
    out <- lapply(lapply(lapply(x,"[[","labels"),"[[","en"),"[[","value")
    names(out) <- lapply(x,"[[","id")
    out
    }
  property_values.qid <- lapply(lapply(lapply(lapply(lapply(properties,"[[",1),"[[","mainsnak"),"[[","datavalue"),"[[","value"),"[[","id")
  property_values.q   <- lapply(property_values.qid,get_item)
  property_names      <- lapply(property_values.q, get_names_from_properties_nest1)
  property_names      <- lapply(lapply(property_names,unlist),enframe,name = "QID")
  property_names
}



# Wikidata tests -----------
# Get WikiJMed articles and their peer review URLs https://w.wiki/K6S
sparql_query <- 'SELECT ?Article ?ArticleLabel ?DOI ?peer_review_URL WHERE {
  SERVICE wikibase:label { bd:serviceParam wikibase:language "[AUTO_LANGUAGE],en". }
  ?Article wdt:P1433 wd:Q24657325.
  OPTIONAL { ?Article wdt:P356 ?DOI. }
  OPTIONAL { ?Article wdt:P7347 ?peer_review_URL. }
}
LIMIT 10000'
articles.qr <- as_tibble(query_wikidata(sparql_query))
articles.qr

# Get a specific article and its main topics
article.qid      <- qid_from_DOI('10.15347/WJM/2019.001')
article.q        <- get_item(article.qid)
article.topics.p <- extract_claims(article.q, "P921")
get_names_from_properties(article.topics.p)

# Get full item for "Thomas Shafee"
person.qs  <- find_item("Thomas Shafee")
person.qid <- qid_from_name(c("Thomas Shafee","Rohan Lowe"))
person.q   <- get_item(person.qid)
person.occupations.p <- extract_claims(person.q,c("P106","P108"))
get_names_from_properties(person.occupations.p)


# Wikipedia tests -----------
# Get links from 'TIM barrel'
TIM.wlink <- page_links("en","wikipedia", page = "TIM barrel",clean_response = 1,limit = 1000)
unlist(lapply(TIM.wlink[[1]]$links, '[[' ,2))
# Get backlinks to 'TIM barrel'
TIM.wblink <- page_backlinks("en","wikipedia", page = "TIM barrel",clean_response = 1, namespaces=0 , limit = 1000)
unlist(lapply(TIM.wblink, '[[' ,3))
# Get content of 'TIM barrel'
TIM.wh <- page_content("en","wikipedia", page_name = "TIM barrel")
cat(tidy_html(TIM.wh, option=opts))
TIM.wx <- read_xml(TIM.w[[1]]$text$`*`)
if(interactive()) {xml_tree_view(TIM.wx)}
htmltidy::xml_view(TIM.wx,add_filter=TRUE, style="tomorrow-night-bright" )
