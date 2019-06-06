package com.bc.util.json;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

import org.json.JSONException;
import org.json.JSONObject;
import org.json.XML;

public class ConvertXML {

	public static String toJson(String xml) throws UnsupportedEncodingException, JSONException {

		JSONObject xml2JSON = XML.toJSONObject(URLDecoder.decode(xml, "UTF-8"));
		String json = xml2JSON.toString();

		return json;
	}

	public static void main(String args[]) throws JSONException {
		String xml0 = "<output_fields>friendlyname, email, phone, status</output_fields><operation>core/get</operation><class>Person</class><key>SELECT Person WHERE email = raydevereaux@bc.com</key>";
		try {
			String json = ConvertXML.toJson(xml0);
			System.out.println(json);
		} catch (UnsupportedEncodingException u) {
			System.out.println(u.getMessage());
		}
	}

}
