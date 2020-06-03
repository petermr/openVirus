# Indexing, annotating,and searching; an overview

In openVirus we have several approaches and tools for enhancing knowledge and its discovery. 

## Documents
A document is a defined chunk of information, with an address or unique identifier allowing it to be retrieved 
(e.g. from a query or browse). Files in an `ami` `CProject` are all potentially documents (text, HTML, images, tables, etc.). 
A semantic file (HTML or XML) maye be split into sub documents. Solr and Lucene are primarily IE engines.

## Information retrieval (IR)
https://en.wikipedia.org/wiki/Information_retrieval
IR allows a document to be retrieved, e.g. from a search or index. At this level documents are monolithic blobs; 
there may be no indication of where in the document the information lies. IR often gives documents weights for relevance.

## Information Extraction (IE)
https://en.wikipedia.org/wiki/Information_extractio
IE extracts small chunks of semantic information from a document (words, numerica values, chemistry, etc.). Ideally the
information can be addressed within the document, e.g. by `xpath` or W3CAnnotation. AMI is an IE machine, as is OSCAR for chemistry.

## Annotation
https://en.wikipedia.org/wiki/Text_annotation
and
https://en.wikipedia.org/wiki/Web_annotation
Annotation is defined in the W3CAnnotation protocol https://www.w3.org/TR/annotation-model/ which we use in AMI. It identifies 
objects (normally words or phrases, but others are possible) and links them to an annotation (which may become hyperlinks).

# OpenVirus


In OpenVirus we have indexing, information extraction and annotation.
## Indexing
(please add links...)
### EThOS
Used by Andy Jackson for indexing theses with Solr
### DOAJ
Used by Clyde Davies for indexing DOAJ abstracts with Solr

## Information Extraction
## AMI
Used by `ami` to enhance `CProject` s , normally by creating additional annotation files.

### Classic AMI
Several hand-created analyzers in `ami search` 

### `ami lucene` .

Being developed from scratch using Lucene analyzers where possible.
(see [lucene](../lucene.md))



