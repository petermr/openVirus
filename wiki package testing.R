library('WikipediR')
library('WikidataR')
library('WikidataQueryServiceR')
library('tibble')
library('tidytext')
library('htmltidy')
library('dplyr')
library('xml2')

# Recommended object endings
# .qr  = Query results
# .qid = Wikidata QID number
# .qs  = Wikidata item summary
# .q   = Wikidata item in full 


# WikidataQueryServiceR -----------
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

qid_from_DOI <- function(DOI = '10.15347/WJM/2019.001'){
  sparql_query <- paste('SELECT ?DOI WHERE {?DOI wdt:P356 "',
                        DOI,
                        '"}',
                        sep='')
  article.qr <- as_tibble(query_wikidata(sparql_query))
  article.qid <- tail(stringr::str_split(article.qr,pattern = "/")[[1]],n=1)
  article.qid
}

qid_from_name <- function(name  = 'Thomas Shafee',
                          limit = 100){
  item.qs <- find_item(name, limit=limit)
  # Report it's id
  item.qid <- unlist(lapply(item.qs,"[[","id"))
  item.qid
}

property_from_Q <- function(item,
                            PID){
  property.p <- lapply(lapply(lapply(item,"[[",6),"[[",property),as.tibble)
}


# Get full item for 38382414
ts.q <- get_item(ts.qid)
# Report all data for those Ps
as_tibble(ts.q[[1]]$claims$P106) 
# Report its P106s (occupations)
ts.q[[1]]$claims$P106$mainsnak$datavalue$value$id
# Extract its P106s and P108s (occupations and employers)
ts.occupation_employer.qs <- extract_claims(ts.wd,c('P106','P108'))
# Report all data for those Ps
lapply(ts.occupation_employer.qs[[1]], as_tibble)
# Report those P106s and P108s 
lapply(lapply(lapply(lapply(ts.occupation_employer.qs[[1]], '[[', 1), '[[', 4), '[[', 1), '[[', 3)

# Find item for 'Thomas Shafee'
ts.qs <- find_item("Thomas Shafee")
# Report it's id
ts.qid <- ts.qs[[1]]$id
# Get full item for 38382414
ts.q <- get_item(ts.qid)
# Report all data for those Ps
as_tibble(ts.q[[1]]$claims$P106) 
# Report its P106s (occupations)
ts.q[[1]]$claims$P106$mainsnak$datavalue$value$id
# Extract its P106s and P108s (occupations and employers)
ts.occupation_employer.qs <- extract_claims(ts.wd,c('P106','P108'))
# Report all data for those Ps
lapply(ts.occupation_employer.qs[[1]], as_tibble)
# Report those P106s and P108s 
lapply(lapply(lapply(lapply(ts.occupation_employer.qs[[1]], '[[', 1), '[[', 4), '[[', 1), '[[', 3)

# WikipediR -----------
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
