# Dictionary: Funders
## Created by: Vaishali Arora

### Source: CrossRef.org

The CrossRef Funder Registry is an open registry of grant-giving organisation names and identifiers across the World.

Updated the dictionary on: June 19, 2020

Number of entries: 23355

### Creating the Dictionary:
1. Create a text file (.txt) containing a list of funders that you are making a dicitonary for (accessed the list{.txt file} from CrossRef.org. Wikidata query service can also be used for the same.
2. Meanwhile, create a directory by giving command in the command prompt as : `mkdir mydictionaries` This is the ouput directory where you are going to get the dictionary.
3. Make two empty files in the created output directory **'mydictionaries'**, one as .html file and the other one as .xml file.
4. Open the command prompt and give the command as: `amidict -v --dictionary funders --directory mydictionaries --input funders.txt create --informat list --outformats xml,html`
5. `amidict`is a command suite for creating dictionaries.
6. The **input file** in the syntax is the file which was downloaded in Step 1.
7. After giving the command in Step 4, it took a while to create the dictionary.
8. Open the folder 'mydictionaries' in the system, the dictionary is created as both **xml** and **html** file.
