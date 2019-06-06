package com.bc.util.json;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

import org.json.JSONException;
import org.json.JSONObject;
import org.json.XML;

public class ConvertJSON {

	public static String toXml(String json) throws UnsupportedEncodingException, JSONException {

		JSONObject jsonObj = new JSONObject(URLDecoder.decode(json, "UTF-8"));
		String xml = XML.toString(jsonObj);

		return xml;
	}

	public static void main(String args[]) {
		String json0 = "{'operation': 'core/get','class': 'Person','key': 'SELECT Person WHERE email = raydevereaux@bc.com','output_fields': 'friendlyname, email, phone, status'}";
		String json1 = "{'addresses':[{'addresscity':'Medford','entry':4966,'addresszip':'97504','addressstate':{'id':'D41001040','abbrev':'OR','value':'Oregon'},'addresscountry':{'id':'D41001','abbrev':'US','value':'United States'},'addresstype':{'id':'D84002','formattedvalue':'Home','value':'Home'},'addressstreet1':'1101 Woodrow Lane Apt. 22','primary':true}],'firstname':'Kory','folder':{'id':'C16818','formattedvalue':'Emp:New Hire','value':'Emp:New Hire'},'phones':[{'phonetype':{'id':'D83002','formattedvalue':'Home','value':'Home'},'entry':4933,'phonenumber':'541/930-1121','primary':true}],'links':[{'rel':'self','title':'The current profile being viewed.','url':'https://api.icims.com/customers/8533/people/24835'}],'email':'koryallen@live.com','lastname':'Allen'}";
		String json2 = "{'operation' : 'core/get', 'class' : 'UserLDAP', 'key': 'SELECT UserLDAP WHERE login = ry', 'output_fields' : 'email'}";
		try {
			String xml = ConvertJSON.toXml(json2);
			System.out.println(xml);

		} catch (JSONException u) {
			System.out.println(u.getMessage());
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
