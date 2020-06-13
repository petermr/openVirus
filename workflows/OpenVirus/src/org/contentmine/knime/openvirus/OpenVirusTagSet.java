package org.contentmine.knime.openvirus;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.knime.ext.textprocessing.data.Tag;

public class OpenVirusTagSet implements org.knime.ext.textprocessing.data.TagBuilder {

	public static final String TAG_TYPE="OPENVIRUS";
	public static final String DEFAULT_TAG = OpenVirusTag.VIRUS.toString();
	private Map<String, Tag> m_tagMap;
	
	public OpenVirusTagSet()
	{
		m_tagMap = new HashMap<>();
		for(OpenVirusTag tagValue: OpenVirusTag.values() )
		{
			m_tagMap.put(tagValue.toString(), new Tag(tagValue.toString(), TAG_TYPE));
		}
	}
	@Override
	public List<String> asStringList() {
		List<String> list = new ArrayList<String>(m_tagMap.size());
		list.addAll(m_tagMap.keySet());
		return list;
	}

	@Override
	public Tag buildTag(String value) {
		Tag tag = m_tagMap.get(value);
		if(tag==null)
		{
			tag = m_tagMap.get(DEFAULT_TAG);
		}
		return tag;
	}

	@Override
	public Set<Tag> getTags() {
		Set<Tag> tagSet = new HashSet<Tag>(m_tagMap.size());
		tagSet.addAll(m_tagMap.values());
		return tagSet;
	}

	@Override
	public String getType() {
		return OpenVirusTagSet.TAG_TYPE;
	}

}
