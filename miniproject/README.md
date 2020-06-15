# miniprojects for interns

## background

PROJECT
This project is primarily to test the software. DO NOT ASSUME THE RESULTS ARE MORE GENERALLY USEFUL (i.e. don't tell the world you have made a medical breakthrough - we don't have enough data or knowledge.)
The project consists of 
* creating a query, running it, and refining the query iteratively.
* downloading up to 1000 articles (your CProject)
* searching them with 3-6 dictionaries for co-occurrence
* manually evaluating how useful co-occurrence is
* refining dictionaries
* repeat

## ideas for projects
* face masks in viral epidemics
* drugs used in viral epidemics
* vaccines and viral epidemics
* organizations and funders in viral epidemics
* timeline of usage of dictionary terms in scholpub (cf Google trends)

# machine-learning projects
This requires good data (i.e. well indexed by dictionaries). It normally requires significant manual input. 
Read https://en.wikipedia.org/wiki/Training,_validation,_and_test_sets.

## binary supervised classifier 

For a binary classifier (A or not-A) we need:
* *formal agreement on how a human distinguishes A from not-A.* We did this for chemical / not-a-chemical with OSCAR 
(https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3205045/) and made 
a 30-page guidebook. We then tested it with 3 annotators (expert chemists). They agreed 92% of the time. That means the software 
can never do better than that! "Is a gold ring a chemical?" People disagree!
### a human-annotated data set.  The training set should be representative of the documents we want to index automatically. if we train on `medrxiv` then
we may have to retrain on `biorxiv`. This will be split into 3.
#### training set
This will be used to create our model, e.g. with a ML package like Keras. 
#### test set
How well does the model work? the test set allows a score to evaluate the performance. The model will then be refined, iteratively. This
could be with different parameters, facets, etc.
At this stage the metrics ar NOT a good indication of model quality. We have to use a fresh set to *validate*
#### validation
This should be an unbiased metric using data which has not been used in the previous two steps.

## unsupervised classification

