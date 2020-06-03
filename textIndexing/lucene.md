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
      The {@link org.apache.lucene.analysis.Analyzer} is a
      <strong>factory</strong> for analysis chains. <code>Analyzer</code>s don't
      process text, <code>Analyzer</code>s construct <code>CharFilter</code>s, <code>Tokenizer</code>s, and/or
      <code>TokenFilter</code>s that process text. An <code>Analyzer</code> has two tasks: 
      to produce {@link org.apache.lucene.analysis.TokenStream}s that accept a
      reader and produces tokens, and to wrap or otherwise
      pre-process {@link java.io.Reader} objects.
    </li>
    <li>
    The {@link org.apache.lucene.analysis.CharFilter} is a subclass of
   {@link java.io.Reader} that supports offset tracking.
    </li>
    <li>The{@link org.apache.lucene.analysis.Tokenizer}
      is only responsible for <u>breaking</u> the input text into tokens.
    </li>
    <li>The{@link org.apache.lucene.analysis.TokenFilter} modifies a
    stream of tokens and their contents.
    </li>
    <li>
      {@link org.apache.lucene.analysis.Tokenizer} is a {@link org.apache.lucene.analysis.TokenStream}, 
      but {@link org.apache.lucene.analysis.Analyzer} is not.
    </li>
    <li>
      {@link org.apache.lucene.analysis.Analyzer} is "field aware", but 
      {@link org.apache.lucene.analysis.Tokenizer} is not. {@link org.apache.lucene.analysis.Analyzer}s may
      take a field name into account when constructing the {@link org.apache.lucene.analysis.TokenStream}.
    </li>
  </ul>


## indexing 
The 
`AMILuceneTool` has
 
