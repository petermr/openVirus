# script to run Docker 
(from Stuart Bowe)

In order to run getpapers from a docker container the following Dockerfile may be used:

```

FROM node:slim

WORKDIR /usr/src/app

RUN npm install --global getpapers

```
This may be run from terminal using the following shell script
```
#!/usr/bin/env bash

docker build -t paper_getter .

docker run -it --rm --name get-papers \
 -v $(pwd)/results:/results \
 paper_getter \
 getpapers -o /results --query 'c4 photosynthesis flaveria'
Here the query is set by docker run. This also sets the folder the results will be stored in using the mounted volume. This allows for queries to be run automatically if desired.
```
