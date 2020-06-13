batch=doaj_article_data_2020-06-07
cd $batch
for f in *.json
do
	filename=${f%%.*} 
	rm -R $filename
	mkdir $filename
	/datadrive/splitter/linux-x64/DOAJSplitter ${filename}.json $filename
	sudo su - solr -c "/datadrive/solr/solr/bin/post -c doaj /datadrive/${batch}/${filename}"
	rm ${filename}.json
	echo $filename>>log.txt

done
