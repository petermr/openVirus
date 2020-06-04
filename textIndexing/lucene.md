# Lucene

Lucene is an index/query tool for text in documents. It is not a search engine or an annotator. 
This describes how it is used in AMI.

***Warning. Lucene is fairly low-level, and suffers from frequent revisions and API changes. documentation from 2018 and earlier 
may be seriously misleading. We use V 8.*.* and believe that anything earlier will give compile or run problems.***

Also the language can be confusing. A `TokenFilter` is a subclass of `TokenStream` and `Tokenizer` is also a subclass of
`TokenStream`.

# Philosophy

Lucene operations consist of:
* *analyzing the text and* creating `TokenStream`s. A token may depende on the discipline. Thus "Sodium Chloride" is two words but 
should be treated as a single token.
* *filtering*. Not all tokens are useful for *indexing*. Thus we normally discard "stop words" such as "the" , "it", which add noise
not insight.
* *creating an index* from the token stream.
* *creating a query*. Typically this could be a boolean expression. It may also have constraints such as proximity.


## analyzers 
These define the policy (e.g. which language, what a token is.)
From the docs (edited)


```
 * An Analyzer builds TokenStreams, which analyze text.  It thus represents a
 * policy for extracting index terms from text.
 * <p>
 * In order to define what analysis is done, subclasses must define their
 * TokenStreamComponents in #createComponents(String).
 * The components are then reused in each call to #tokenStream(String, Reader)}.
 * <p>
 * Simple example:
 * <pre class="prettyprint">
 * Analyzer analyzer = new Analyzer() {
 *   protected TokenStreamComponents createComponents(String fieldName) {
 *     Tokenizer source = new FooTokenizer(reader);
 *     TokenStream filter = new FooFilter(source);
 *     filter = new BarFilter(filter);
 *     return new TokenStreamComponents(source, filter);
 *   }
 *   protected TokenStream normalize(TokenStream in) {
 *     // Assuming FooFilter is about normalization and BarFilter is about
 *     // stemming, only FooFilter should be applied
 *     return new FooFilter(in);
 *   }
 * };
 ```
 ```
A Tokenizer is a TokenStream whose input is a Reader
```

## TokenStreams

Analyzers take the input documents and create `TokenStream`s . `createComponents()` is a callback from a subclassed `Analyzer`. (`fieldName` is ignored in this case). The `Tokenizer` 'source` isA `TokenStream`.

Typical Analyzers include:
```
org.apache.lucene.analysis.Analyzer.Analyzer()
org.contentmine.ami.tools.lucene.DefaultLuceneAnalyzer.DefaultLuceneAnalyzer(Version)
org.apache.lucene.analysis.nl.DutchAnalyzer.DutchAnalyzer(CharArraySet, CharArraySet, CharArrayMap<String>)
org.apache.lucene.collation.ICUCollationKeyAnalyzer.ICUCollationKeyAnalyzer(Collator)
org.apache.lucene.analysis.synonym.SynonymFilterFactory.inform(ResourceLoader)
org.apache.lucene.analysis.synonym.SynonymGraphFilterFactory.inform(ResourceLoader)
org.apache.lucene.analysis.core.KeywordAnalyzer.KeywordAnalyzer()
org.apache.lucene.analysis.core.SimpleAnalyzer.SimpleAnalyzer()
org.apache.lucene.analysis.StopwordAnalyzerBase.StopwordAnalyzerBase(CharArraySet)
org.apache.lucene.analysis.core.UnicodeWhitespaceAnalyzer.UnicodeWhitespaceAnalyzer()
org.apache.lucene.analysis.core.WhitespaceAnalyzer.WhitespaceAnalyzer(int)
```
There is a good account of Analyzers in their package docs org.apache.lucene.analysis.package-info
```
 * Text analysis. 
 * <p>API and code to convert text into indexable/searchable tokens.  Covers org.apache.lucene.analysis.Analyzer and related classes.</p>
 * <h2>Parsing? Tokenization? Analysis!</h2>
 
 * Lucene, an indexing and search library, accepts only plain text input.
 * <h2>Parsing</h2>
 
 * Applications that build their search capabilities upon Lucene may support documents in various formats &ndash; HTML, XML, PDF, Word &ndash; just to name a few.
 * Lucene does not care about the <i>Parsing</i> of these and other document formats, and it is the responsibility of the 
 * application using Lucene to use an appropriate <i>Parser</i> to convert the original format into plain text before passing that plain text to Lucene.
 * <h2>Tokenization</h2>
 * 
 * Plain text passed to Lucene for indexing goes through a process generally called tokenization. Tokenization is the process
 * of breaking input text into small indexing elements &ndash; tokens.
 * The way input text is broken into tokens heavily influences how people will then be able to search for that text. 
 * For instance, sentences beginnings and endings can be identified to provide for more accurate phrase 
 * and proximity searches (though sentence identification is not provided by Lucene).
 * 
 *   In some cases simply breaking the input text into tokens is not enough
 *   &ndash; a deeper <i>Analysis</i> may be needed. Lucene includes both
 *   pre- and post-tokenization analysis facilities.
 * 
 *   Pre-tokenization analysis can include (but is not limited to) stripping
 *   HTML markup, and transforming or removing text matching arbitrary patterns
 *   or sets of fixed strings.
 * </p>
 * <p>
 *   There are many post-tokenization steps that can be done, including 
 *   (but not limited to):
```

### Post-tokenization (Filters)
<ul>
    <li><a href="http://en.wikipedia.org/wiki/Stemming">Stemming</a> &ndash; 
        Replacing words with their stems. 
        For instance with English stemming "bikes" is replaced with "bike"; 
        now query "bike" can find both documents containing "bike" and those containing "bikes".
    </li>
    <li><a href="http://en.wikipedia.org/wiki/Stop_words">Stop Words Filtering</a> &ndash; 
        Common words like "the", "and" and "a" rarely add any value to a search.
        Removing them shrinks the index size and increases performance.
        It may also reduce some "noise" and actually improve search quality.
    </li>
    <li><a href="http://en.wikipedia.org/wiki/Text_normalization">Text Normalization</a> &ndash; 
        Stripping accents and other character markings can make for better searching.
    </li>
    <li><a href="http://en.wikipedia.org/wiki/Synonym">Synonym Expansion</a> &ndash; 
        Adding in synonyms at the same token position as the current word can mean better 
        matching when users search with words in the synonym set.
    </li>
</ul>

### clarification
 <ul>
    <li>
      The Analyzer} is a
      <strong>factory</strong> for analysis chains. <code>Analyzer</code>s don't
      process text, <code>Analyzer</code>s construct <code>CharFilter</code>s, <code>Tokenizer</code>s, and/or
      <code>TokenFilter</code>s that process text. An <code>Analyzer</code> has two tasks: 
      to produce TokenStream}s that accept a
      reader and produces tokens, and to wrap or otherwise
      pre-process {@link java.io.Reader} objects.
    </li>
    <li>
    The CharFilter} is a subclass of
   {@link java.io.Reader} that supports offset tracking.
    </li>
    <li>TheTokenizer}
      is only responsible for <u>breaking</u> the input text into tokens.
    </li>
    <li>TheTokenFilter} modifies a
    stream of tokens and their contents.
    </li>
    <li>
      Tokenizer} is a TokenStream}, 
      but Analyzer} is not.
    </li>
    <li>
      Analyzer} is "field aware", but 
      Tokenizer} is not. Analyzer}s may
      take a field name into account when constructing the TokenStream}.
    </li>
  </ul>

To summarise:
* We create specific `Analyzer`s for different types of docs. These could be languages (`DutchAnalyzer`), or possibly `ChemicalAnalyzer` using OSCAR).
* These create `TokenStream`s which
* can create further `TokenStream`s , often by modifying the Tokens (Stemming, case-change) or adding others (Synonyms)
* can be `Filter`ed to remove tokens (Stopwords)

We then have a cleaned `TokenStream` for indexing or other `AMI` operations.

NOTE: I am not sure how much the token streams remember the document context (e.g. the pre- and post- fields surrounding the token. This is important for annotation.

## indexing 

A Lucene index is composed of Fields (check this??). It will not normally store data. A Field is pre-defined by the creator of the index
```
    private void getFields() {
        IndexReader indexReader = getIndexReader();
	    for (int i = 0; i < indexReader.numDocs(); i++) {
	        Document doc = null;
			try {
				doc = indexReader.document(i);
			} catch (IOException e) {
				LOG.error("Cannot read doc: " + doc, e);
				continue;
			}
	        List<IndexableField> fields = doc.getFields();
	        for (IndexableField field : fields) {
	            // use these to get field-related data:
	            IndexableFieldType fieldType = field.fieldType();
				System.out.println("field: " + field.name()+" | "+fieldType.toString());
	        }
	    }
    }
```
The normal point of an index is to be able to locate Documents rapidly (but not necessarily support Information Extraction). I don't know how much is stored other than the document. The Fields have values (e.g. "author" or "title") and can support tokens (`TextField`) or whole phrases (`StringField`)

## annotation
AMI is designed to annotate documents, by identifying words and phrases, giveing them IDs and linking them to annotation. Here's a typical example.
```
<?xml version="1.0" encoding="UTF-8"?>
<results title="country">
 <result pre="Z.C.) from the General Secretariat of Research and Technology of" exact="Greece" post="as well as from the Public Benefit Foundation Alexander"/>
</results>
```
The `country` dictionary has been used to tag words, here "Greece". The match is in context with the "pre" and "post" text. The value "Greece" and the dictionary ("country") can be automatically linked to Wikidata.

The `analyzer` produces a `TokenStream` and its contents are matched against dictionaries. 
This may be one of the end-points.

## index and search
Lucene will normally use the `TokenStream` to generate an index. This index can be rapidly searched by a `Query` This returns the documents. I am not clear whether this is all, or whether Lucene keeps counts of hits per document. I doubt it preserves context. We may have to point to the annotations, even index them.

The search involves building a boolean Query and running it against the index. Here's a simple example:
```
	@Test
	public void testLuceneSearch() throws Exception {
		String index = "target/lucene/battery10";

// read the index; this has already been created with Fields
	    IndexReader reader = DirectoryReader.open(FSDirectory.open(Paths.get(index)));
	    IndexSearcher searcher = new IndexSearcher(reader);
// we'll use the "contents" field full-text and look for "lithium"     
	    String field = "contents";
	    String line = "lithium";
	    int hitsPerPage = 20;
	    
	    Query query = LuceneUtils.createQuery(field, line);
	      
	    // Collect enough docs to show 5 pages
		TopDocs results = searcher.search(query, 5 * hitsPerPage);
		ScoreDoc[] hits = results.scoreDocs;
		
		int numTotalHits = Math.toIntExact(results.totalHits.value);
		System.out.println(numTotalHits + " total matching documents");		
		
  // get the hits 
		hits = searcher.search(query, numTotalHits).scoreDocs;

// analyze the first doc to show what it has
		Document doc1 = searcher.doc(hits[0].doc);
		System.out.println("fields "+doc1.getFields());
  
// and list all the docs which hit...  
		for (int i = 0; i < hits.length; i++) {
	
			Document doc = searcher.doc(hits[i].doc);
			String path = doc.get("path");
			String title = doc.get("title");
			String modified = doc.get("modified");
			String contents = doc.get("contents");
			System.out.println(path+" | " + title + " | " + contents + " | " + modified);
		}
	
	}

```


## `AMILuceneTool`

`AMILuceneTool` has Options for
* `index` or `update` create/modify index
* `query` run a query against the index
* `fields` liast the fields in the index
  
 
