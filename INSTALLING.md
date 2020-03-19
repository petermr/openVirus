# Installation and use

Initially we use the command line and well-known systems (Java, R, Text-editing). 

## AMI
The AMI system is a set of about 20 linked command-line tools for creating an AMI "CProject" - a set of directories with defined  names
and functions. For a tutorial see https://github.com/petermr/tigr2ess/tree/master/installation (which might be slightly out of date; 
if so please copy here and amend).

Ideally you should be able to checkout and compile Java under Maven. This creates a single deployable jar file with a series of scripts
to run under unix/macosx or Windows.

## JDK
install a Java JDK on your machine (JDK8 or higher)

Suggest 
https://howtodoinjava.com/maven/how-to-install-maven-on-windows/
or
https://www3.ntu.edu.sg/home/ehchua/programming/howto/JDK_Howto.html

Verify by typing:
```
javac
```
which should give help.

## Maven
Install maven

https://maven.apache.org/install.html

## checkout ami3

`cd` to where your software (will) live.
```
git clone https://github.com/petermr/ami3.git
```
should create `ami3/`
```
cd ami3
```
there should be a file `pom.xml`

## mvn
compile and install with
```
mvn install -Dmaven.test.skip=true 
```
this should create a file
`ami3/target/appassembler/`

## run
The files in 
`ami3/target/appassembler/bin` represent commands

Thus (on my machine)
`/Users/pm286/workspace/cmdev/ami3/target/appassembler/bin//ami-section`

will run `ami-section`.

Normally you will add 
`<mysoftware>/ami3/target/appassembler/bin/`
to your CLASSPATH where `<mysoftware>` is the `ami3` directory.

https://docs.oracle.com/javase/tutorial/essential/environment/paths.html



 
