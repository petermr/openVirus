# Setup -------------------
packagelist.cran <- c('WikipediR',
                      'WikidataR', 
                      'WikidataQueryServiceR', 
                      'tibble',
                      'devtools',
                      'tidytext', 
                      'htmltidy', 
                      'dplyr',
                      'readr',
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

is.qid  <- function(x){grepl("^[Qq][0-9]+$",x)}
is.pid  <- function(x){grepl("^[Pp][0-9]+$",x)}
is.date <- function(x){grepl("[0-9]{1,4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}",x)}
is.quot <- function(x){grepl("^\".+\"$",x)}

as_qid <- function(x){if(!all(is.qid(x))){WikidataR::find_item(x)[[1]]$id}else{x}}
as_pid <- function(x){if(!all(is.pid(x))){WikidataR::find_property(x)[[1]]$id}else{x}}

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
  return(article.qid)
}

qid_from_name <- function(name  = 'Thomas Shafee',
                          limit = 100){
  qid_from_name_nest1 <- function(x){lapply(x,"[[","id")}
  item.qs  <- lapply(name,find_item, limit=limit)
  item.qid <- lapply(item.qs,qid_from_name_nest1)
  names(item.qid) <- name
  item.qid <- unlist(item.qid)
  return(item.qid)
}

list_properties <- function (item,
                             names=FALSE){
  properties.p <- lapply(lapply(item,"[[","claims"),names)
  if(names){
    if(length(item)==1){
      names(properties.p) <- unlist(lapply(lapply(lapply(get_property(properties.p),"[[","labels"),"[[","en"),"[[","value"))
    }
  }
  return(properties.p)
}

get_names_from_properties <- function(properties){
  get_names_from_properties_nest1 <- function(x){
    out <- lapply(lapply(lapply(lapply(x,"[[","mainsnak"),"[[","datavalue"),"[[","value"),"[[","id")
    names(out) <- lapply(lapply(lapply(x,"[[","mainsnak"),"[[","property"),"[[",1)
    return(out)
  }
  get_names_from_properties_nest2 <- function(x){
    out <- lapply(x,get_item)
    return(out)
  }
  get_names_from_properties_nest3.1 <- function(x){
    out <- lapply(lapply(lapply(x,"[[","labels"),"[[","en"),"[[","value")
    names(out) <- lapply(x,"[[","id")
    return(out)
  }
  get_names_from_properties_nest3 <- function(x){
    out <- lapply(x,get_names_from_properties_nest3.1)
    return(out)
  }
  
  property_values.qid <- lapply(properties,get_names_from_properties_nest1)
  property_values.q   <- lapply(property_values.qid,get_names_from_properties_nest2)
  property_names      <- lapply(property_values.q, get_names_from_properties_nest3)
  property_names      <- lapply(lapply(property_names,unlist),enframe,name = "QID") 
  return(property_names)
}

as_quickstatement <- function(items,
                              properties,
                              values,
                              qual.properties=NULL,
                              qual.values=NULL){
  
  items           <- sapply(items,function(x){if(x!="LAST"){as_qid(x)}else{x}})
  properties      <- sapply(properties,as_pid)
  values          <- sapply(values,function(x){if(!(is.qid(x)|is.date(x)|is.quot(x))){paste0('"',x,'"')}else{x}})
  
  QS <- list(items,
             properties,
             values)
  QS.rowmax <- max(sapply(QS,length))
  QS.check  <- sapply(QS,length)==1|
    sapply(QS,length)==QS.rowmax
  if(!all(QS.check)){stop("not all quickstatement columns equal length")}
  QS.tib <- tibble(Item = QS[[1]],
                   Prop = QS[[2]],
                   Value = QS[[3]])
  
  # qualifiers properties and statements
  if(!is.null(qual.properties)|!is.null(qual.values)){
    qual.properties <- sapply(qual.properties,function(x){if(!is.null(x)){as_pid(X)}else{x}})
    qual.values     <- sapply(qual.values,function(x){if(!(is.qid(x)|is.date(x)|is.quot(x))){paste0('"',x,'"')}else{x}})
    
    QSq <- list(qual.properties,
                qual.values)
    QSq.rowmax <- max(sapply(c(QS,QSq),length))
    QSq.check  <- sapply(c(QS,QSq),length)==1|
      sapply(c(QS,QSq),length)==QSq.rowmax
    if(!all(QSq.check)){stop("incorrect number of qualifiers provided")}
    
    QS.tib <- add_column(QS.tib,
                         qual.Prop  = QSq[[1]],
                         qual.Value = QSq[[2]])
  }
  
  write.table(QS.tib,quote = FALSE,row.names = FALSE,sep = "|")
}

# Edited function from WikidataR ---------
extract_claims <- function (items,
                            claims){
  claims <- sapply(claims,as_pid)
  output <- lapply(items, function(x, claims) {
    return(lapply(claims, function(claim, obj) {
      which_match <- which(names(obj$claims) == claim)
      if (!length(which_match)) {
        return(NA)
      }
      return(obj$claims[[which_match[1]]])
    }, obj = x))
  }, claims = claims)
  return(output)
}


# Wikidata tests -----------
# Get WikiJMed articles and their peer review URLs https://w.wiki/K6S
sparql_query <- 'SELECT ?Article ?ArticleLabel ?DOI ?peer_review_URL WHERE {
  SERVICE wikibase:label { bd:serviceParam wikibase:language "[AUTO_LANGUAGE],en". }
  ?Article wdt:P1433 wd:Q24657325.
  OPTIONAL { ?Article wdt:P356 ?DOI. }
  OPTIONAL { ?Article wdt:P7347 ?peer_review_URL. }}
LIMIT 10000'
articles.qr <- as_tibble(query_wikidata(sparql_query))
articles.qr

# Get a specific article and its main topics
article.qid      <- qid_from_DOI(c('10.15347/WJM/2017.007','10.15347/WJM/2019.001','10.15347/WJM/2019.003','10.15347/WJM/2019.007'))
article.q        <- get_item(article.qid)
article.topics.p <- extract_claims(article.q, "main topic")
get_names_from_properties(article.topics.p)

# Get full item for "Thomas Shafee"
person.qs  <- find_item("Thomas Shafee")
person.qid <- qid_from_name(c("Thomas Shafee","Peter Murray Rust"))
person.q   <- get_item(person.qid)
person.occupations.p <- extract_claims(person.q,c("occupation","employer"))
get_names_from_properties(person.occupations.p)


# Wikipedia tests -----------
# Get links from wiki page
page.wlink <- page_links("en","wikipedia", page = "Western African Ebola virus epidemic",clean_response = 1,limit = 1000)
unlist(lapply(page.wlink[[1]]$links, '[[' ,2))
# Get backlinks to 'TIM barrel'
page.wblink <- page_backlinks("en","wikipedia", page = "Western African Ebola virus epidemic",clean_response = 1, namespaces=0 , limit = 1000)
unlist(lapply(page.wblink, '[[' ,3))
# Get content of 'TIM barrel'
page.wh <- page_content("en","wikipedia", page_name = "Western African Ebola virus epidemic")
# full wikimarkup
cat(pediarr::pediafulltext("Western African Ebola virus epidemic",format="wikimarkup"))
# List pages in category
pediarr::pediacategory("Category:Viral respiratory tract infections")

# Quickstatements test ------------
sparql_query <- 'SELECT ?Article ?ArticleLabel ?JLabel ?T ?peer_review_URL WHERE {
  SERVICE wikibase:label { bd:serviceParam wikibase:language "[AUTO_LANGUAGE],en". }
  ?Article wdt:P1433 wd:Q24657325.
  OPTIONAL { ?Article wdt:P1433 ?J. }
  OPTIONAL { ?Article wdt:P1476 ?T. }
  OPTIONAL { ?Article wdt:P7347 ?peer_review_URL. }}
LIMIT 10000'
articles.qr <- as_tibble(query_wikidata(sparql_query))
articles.qr <- articles.qr[articles.qr$peer_review_URL=="",] #omit those with review URLs listed
review.URLs <- paste0('https://en.wikiversity.org/wiki/Talk:',
                      articles.qr$JLabel,
                      "/",
                      articles.qr$T
                     )
review.URLs <- gsub(" ","_",review.URLs)

as_quickstatement(items=sapply(sapply(articles.qr$Article,pattern = "/",stringr::str_split),tail,1),
                  properties="Peer review URL",
                  values=review.URLs)

# WikiJournal content tests -----------
page.wh <- page_content("en","wikiversity", page_name = "WikiJournal of Medicine/Western African Ebola virus epidemic")
tidy_html.opts <- list(
  TidyDocType="html5",
  TidyMakeClean=TRUE,
  TidyHideComments=TRUE,
  TidyIndentContent=TRUE,
  TidyWrapLen=200
)
page.wx     <- read_xml(page.wh[[1]]$text$`*`)
tofind      <- "Nigeria"
paste(sep="","found ",length(grep(tofind, xml_find_all(page.wx, "//p")))," paragraphs containing the search term: '",tofind,"'")
page.sub.wx <- grep(tofind, xml_find_all(page.wx, "//p"),value = TRUE)
xml_view(page.sub.wx,add_filter=TRUE, style="tomorrow-night-bright" )
