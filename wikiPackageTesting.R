# Setup -------------------
packagelist.cran <- c('WikipediR',
                      'WikidataR', 
                      'WikidataQueryServiceR', 
                      'tibble',
                      'devtools',
                      'stringr',
                      'tidytext', 
                      'htmltidy', 
                      'dplyr',
                      'readr',
                      'xml2',
                      'lubridate',
                      'igraph',
                      'networkD3',
                      'dbscan')
packagelist.git  <- c('chainsawriot/pediarr',
                      'mattflor/chorddiag',
                      'garthtarr/edgebundleR')
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
                              qual.properties = NULL,
                              qual.values     = NULL,
                              format          = "api", # api, tibble or print
                              api.username    = "",
                              api.token       = "", # from https://tools.wmflabs.org/quickstatements/#/user
                              api.format      = "v1",
                              api.batchname   = "ts_API_test2",
                              api.submit      = TRUE
                              ){
  
  items           <- sapply(items,function(x){if(x!="LAST"){as_qid(x)}else{x}})
  properties      <- sapply(properties,as_pid)
  
  if (format=="api"){
    values          <- sapply(values,function(x){if(!(is.qid(x)|is.date(x)|is.quot(x))){paste0('$22',x,'$22')}else{x}})
  }
  if (format=="print"){
  values          <- sapply(values,function(x){if(!(is.qid(x)|is.date(x)|is.quot(x))){paste0('"',x,'"')}else{x}})
  }
  
  QS <- list(items,
             properties,
             values)
  QS.rowmax <- max(sapply(QS,length))
  QS.check  <- sapply(QS,length)==1|
    sapply(QS,length)==QS.rowmax
  if(!all(QS.check)){stop("not all quickstatement columns equal length")}
  QS.tib <- tibble(Item =  QS[[1]],
                   Prop =  QS[[2]],
                   Value = QS[[3]])
  
  # qualifiers properties and statements
  if(!is.null(qual.properties)|!is.null(qual.values)){
    qual.properties <- sapply(qual.properties,function(x){if(!is.null(x)){as_pid(x)}else{x}})
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
  if (format=="print"){
    write.table(QS.tib,quote = FALSE,row.names = FALSE,sep = "|")
  }
  if (format=="tibble"){
    return(QS.tib)
  }
  if (format=="api"){
    api.temp1 <- format_tsv(QS.tib)
    api.temp2 <- gsub("\t","%09",api.temp1) # Replace TAB with "%09"
    api.temp3 <- gsub("\n","%0A",api.temp2) # Replace end-of-line with "%0A"
    api.temp4 <- gsub(" ", "%20",api.temp3) # Replace space with "%20"
    api.temp5 <- gsub("\"","%22",api.temp4) # Replace double quote with "%22"
    api.data  <- gsub("/", "%2F",api.temp5) # Replace slash with "%2F"
    
    API.url <- paste0("https://tools.wmflabs.org/quickstatements/api.php",
                      "?action=",   "import",
                      "&submit=",   "1",
                      "&format=",   api.format,
                      "&batchname=",api.batchname,
                      "&username=", api.username,
                      "&token=",    api.token,
                      "&data=",     api.data)
    if(api.submit){
      browseURL(API.url)
    }else{
      return(API.url)
    }
  }
}

initials <- function(x,type="FLast"){
  if (type=="FLast"){
    gsub("^([A-Za-z]).* ([A-Za-z]*)", "\\1 \\2", x)
  }else{
    gsub("(.)\\S* *", "\\1", x)
  }
}

unspecial <- function(x){
  out <- x
  for(i in 1:ncol(x)){
    out[[i]] <- iconv(x[[i]],to = 'ASCII//TRANSLIT')
    if(Hmisc::all.is.numeric(x[[i]])){
      out[[i]] <- as.numeric(out[[i]])
    }else{
      out[[i]] <- as.factor(out[[i]])
    } 
  }
  return(as_tibble(out))
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

# Visualisations ------------
#> Data gathering ---------
author          <- "Q56324974"
employer        <- ""
employer.filter <- FALSE
sparql_query    <- paste0('# Egocentric co-author graph for an author
                          SELECT ?author1 ?author2 ?author1Label ?author2Label ?employer1Label ?employer2Label (COUNT(?work) AS ?count) WHERE {
                              # Find co-authors
                              ?work wdt:P50 wd:',author,', ?author1, ?author2 .
                              # Exclude self-links
                              FILTER   (?author1 != ?author2)
                              OPTIONAL {?author1 wdt:P108 ?employer1.}
                              OPTIONAL {?author2 wdt:P108 ?employer2.}
                              SERVICE  wikibase:label { bd:serviceParam wikibase:language "en,fr,de,ru,es,zh,jp". }
                          }
                            GROUP BY ?author1 ?author2 ?author1Label ?author2Label ?employer1Label ?employer2Label
                            ORDER BY DESC(?count)
                            LIMIT 10000')
articles.qr   <- unspecial(query_wikidata(sparql_query))
if(employer.filter){
  articles.qr <- articles.qr[articles.qr$employer1Label==employer&
                             articles.qr$employer2Label==employer,]   # filter by employer
}
articles.qr$author1Label <- ordered(articles.qr$author1Label,         # define factor order by most linked
                                    unique(names(sort(table(articles.qr$author1Label),TRUE))))
articles.qr   <- articles.qr[with(articles.qr, order(author1Label)),] # order all by that factor order
articles.qr.u <- t(apply(articles.qr[,3:4], 1, sort))                 # find reciprocal links and flip them
articles.qr   <- articles.qr[!duplicated(articles.qr.u),]             # remove flipped reciprocal links (now show up as duplicates)

articles.qr[,3:4] <- cbind(gsub("^([A-Za-z]).* ([A-Za-z]*)", "\\1 \\2", articles.qr$author1Label),
                           gsub("^([A-Za-z]).* ([A-Za-z]*)", "\\1 \\2", articles.qr$author2Label))
articles.qr

#> igraph calculations ------------
data <- articles.qr[order(articles.qr$count),]
g    <- graph_from_edgelist(as.matrix(data[,3:4]),
                        directed = 0) %>%
        set_edge_attr("weight", value = data$count)
clp  <- cluster_label_prop(g,weights = E(g)$weight)
hcl  <- hclust(dist(g[]))
hdb  <- hdbscan(dist(g[]),minPts = 3)
l    <- layout.graphopt(g,spring.length = E(g)$weight)

max.groups       <- max(clp$membership)
colours          <- RColorBrewer::brewer.pal(max.groups,'Dark2')
colours          <- viridis::plasma(max.groups)
colours          <- colorRampPalette(c('#ee4400','#ff0099','#440055','#000055','#006688','#005533'))(max.groups)
barplot(rep(1,length(colours)),col=colours,space=0,border=NA)
group.order      <- order(clp$membership,hdb$cluster)
group.colours    <- colours[clp$membership]
group.colours[1] <- "black"

#> Static network -----------
plot(#clp,
    g,
    vertex.size  = 10,
    edge.color   = colorRampPalette(c("#CCCCCC", "#444444"))(4)[1+log2(E(g)$weight)],
    edge.width   = log2(E(g)$weight)*3,
    vertex.color = group.colours[clp$membership],
    edge.curved  = 0.2,
    vertex.label = initials(V(g)$name,type="FML"),
    layout       = l)

#> Interactive D3 network ----------
xLinks <- data.frame(articles.qr[,c(3,4,7)])

unames <- iconv(clp$names,to = 'ASCII//TRANSLIT')

xLinks$author1Label <- as.factor(iconv(xLinks$author1Label,to = 'ASCII//TRANSLIT'))
xLinks$author2Label <- as.factor(iconv(xLinks$author2Label,to = 'ASCII//TRANSLIT'))

xNodes <- data.frame(name  = unames,
                     group = clp$membership,
                     size  = 1)

xLinks$author1Label <- ordered(xLinks$author1Label,unames)
xLinks$author2Label <- ordered(xLinks$author2Label,unames)

xLinks$author1Label<-as.numeric(xLinks$author1Label)-1
xLinks$author2Label<-as.numeric(xLinks$author2Label)-1
xLinks$count       <-as.numeric(xLinks$count)^2

forceNetwork(Links = data.frame(xLinks), Nodes = data.frame(xNodes),
             Source = "author1Label", Target = "author2Label",
             Value = "count", NodeID = "name",
             Group = "group", Nodesize="size",
             zoom = 1, opacity = 0.8,
             fontFamily = "sans-serif", fontSize = 20,
             linkColour = colorRampPalette(c(rgb(0,0,0,0.3),rgb(0,0,0,0.9)), alpha=TRUE)(max(E(g)$weight))[E(g)$weight],
             charge = -30,linkDistance = JS("function(d){return 50/(d.value^2)}"))

#> Interactive D3 chord ------------
data.grouped <- as.matrix(get.adjacency(g,attr = "weight",sparse = T))[group.order,group.order]
chorddiag(data.grouped,
          showTicks         = F,
          margin            = 80,
          groupnameFontsize = 12,
          groupnamePadding  = 10,
          groupPadding      = 1,
          groupColors       = group.colours[group.order],
          chordedgeColor    = '#00000011',
          groupedgeColor    = '#00000099')

# HTML content reading test -----------
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
