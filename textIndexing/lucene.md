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
Analyzers take the input documents and create `TokenStream`s 
