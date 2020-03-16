packagelist.cran <- c('WikipediR',
                      'WikidataR', 
                      'WikidataQueryServiceR', 
                      'tibble',
                      'devtools',
                      'tidytext', 
                      'htmltidy', 
                      'dplyr', 
                      'xml2')
packagelist.git  <- c('chainsawriot/pediarr')
packagelist.git2 <- sapply(stringr::str_split(packagelist.git,pattern = "/"),tail,n=1)
install.packages(packagelist.cran[!(packagelist.cran %in% installed.packages()[,"Package"])])
install_github  (packagelist.git[!(packagelist.git2%in% installed.packages()[,"Package"])])
sapply(c(packagelist.cran,packagelist.git2), require, character.only = TRUE)

# Recommended object endings
# .qr  = Query result(s)
# .qid = Wikidata QID number(s)
# .qs  = Wikidata item(s) summary
# .q   = Wikidata item(s) in full
# .p   = Properties of a Wikidata item(s)
# .wh  = Wiki page in html
# .wx  = Wiki page in xml

# Functions ----------

is.qid <- function(x){grepl("^[Qq][0-9]+$",x)}
is.pid <- function(x){grepl("^[Pp][0-9]+$",x)}

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
    out <- lapply(lapply(lapply(lapply(x,"[[","mainsnak"),"[[","datavalue"),"[[","value"),"[[","id")
    names(out) <- lapply(lapply(lapply(x,"[[","mainsnak"),"[[","property"),"[[",1)
    out}
  get_names_from_properties_nest2 <- function(x){
    out <- lapply(x,get_item)
    out
  }
  get_names_from_properties_nest3.1 <- function(x){
    out <- lapply(lapply(lapply(x,"[[","labels"),"[[","en"),"[[","value")
    names(out) <- lapply(x,"[[","id")
    out
  }
  get_names_from_properties_nest3 <- function(x){
    out <- lapply(x,get_names_from_properties_nest3.1)
    out
  }
  
  property_values.qid <- lapply(properties,get_names_from_properties_nest1)
  property_values.q   <- lapply(property_values.qid,get_names_from_properties_nest2)
  property_names      <- lapply(property_values.q, get_names_from_properties_nest3)
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
person.qid <- qid_from_name(c("Thomas Shafee","Peter Murray Rust"))
person.q   <- get_item(person.qid)
person.occupations.p <- extract_claims(person.q,c("P106","P108"))
get_names_from_properties(person.occupations.p)


# Wikipedia tests -----------
# Get links from 'TIM barrel'
page.wlink <- page_links("en","wikipedia", page = "TIM barrel",clean_response = 1,limit = 1000)
unlist(lapply(page.wlink[[1]]$links, '[[' ,2))
# Get backlinks to 'TIM barrel'
page.wblink <- page_backlinks("en","wikipedia", page = "TIM barrel",clean_response = 1, namespaces=0 , limit = 1000)
unlist(lapply(page.wblink, '[[' ,3))
# Get content of 'TIM barrel'
page.wh <- page_content("en","wikipedia", page_name = "TIM barrel")


# WikiJournal content tests -----------
page.wh <- page_content("en","wikiversity", page_name = "WikiJournal of Science/The TIM barrel fold")
tidy_html.opts <- list(
  TidyDocType="html5",
  TidyMakeClean=TRUE,
  TidyHideComments=TRUE,
  TidyIndentContent=TRUE,
  TidyWrapLen=200
)
page.wx     <- read_xml(page.wh[[1]]$text$`*`)
tofind      <- "folding"
page.sub.wx <- grep(tofind, xml_find_all(page.wx, "//p"),value = TRUE)
xml_view(page.sub.wx,add_filter=TRUE, style="tomorrow-night-bright" )
