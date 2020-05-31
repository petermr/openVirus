# Creating Custom Tag Sets for openVirus
KNIME can do text analysis.  One of the features it supports is dictionary tagging.  We are currently building a set of dictionaries for this project.  It makes great sense to be able to reuse these in KNIME.

To tag text in KNIME, you need to do the following:

- Create a Document column in a workflow, such as by using the *Strings to Document* node
- Load  the dictionaries using the *XML Reader*
- Create a custom **tag set** for the tagger
- Tag the document with the tags.  Each dictionary corresponds to a custom tag type in the tag set.

As an aexample, the CEVOpen project implements a [custom tag set](https://github.com/petermr/CEVOpen/tree/master/workflows/CEVTagger) for KNIME.  The [CEVTagSet](https://github.com/petermr/CEVOpen/blob/master/workflows/CEVTagger/src/org/cevopen/cevtagset/CEVTagSet.java) class implements the tag set container, and the CEVTag implements the tags themselves
```java
package org.cevopen.cevtagset;

public enum CEVTag {

	ACTIVITY,
	COMPOUND,
	INSTRUMENT,
	PLANT,
	PLANTPART,
	PROCESS,
	TARGETORGANISM
}
```
You can build a corresponding tag set for OpenVirus following  the [standard KNIME process](https://www.knime.com/for-developers-integration-of-custom-tag-sets).
Once you have built the tags then you load them into the KNIME environment.  Copy the build jar files into the **KNIME/dropins** folder.  Can then use the tags in any texst processing component.
