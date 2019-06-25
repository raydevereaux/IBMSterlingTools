package com.bc.util.rest;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.http.Header;
import org.apache.http.client.methods.HttpRequestBase;

import com.bc.util.http.HttpResultCodes;

public class FormatStatus {

	//comment
	public static String jsonMessage(HttpRequestBase request,Exception e, String url, Integer responseCode, String reqMethod) {
		String json = FormatStatus.jsonMessage(request, e, url, responseCode, reqMethod, "default");
		return json;
	}
	
	public static String jsonMessage(HttpRequestBase request,Exception e, String url, Integer responseCode, String reqMethod, String compressionStatus) {
		
		String message = e.getMessage();
		String disposition = "Failure";
		if (responseCode >= 200 && responseCode <= 300) {
			if ("{".equals(message.substring(0, 1))) {
				disposition = "Warning";
			} else {
				disposition = "Success";
			}
		} else if (message==null||responseCode<0) {
			disposition = "Bcc Fatal";
			message = "'No Connection'";
		}
		Header[] header = request.getAllHeaders();
		String javaVer = System.getProperty("java.version");
		String timestamp = new SimpleDateFormat("yyyy-MM-dd.HH.mm.ss.SSS").format(new Date());
		String statusMsg = HttpResultCodes.httpStatus.get(responseCode.toString());
		StringBuffer result = new StringBuffer();
		result.append("{");
		result.append("'HttpStatusCode': '" + responseCode + "',");
		result.append("'Java': 'v"+javaVer+"',");
		result.append("'Timestamp': '"+timestamp+"',");
		result.append("'Method': '"+request.getMethod()+"',");
		result.append("'ReqMethod': '"+reqMethod+"',");
		result.append("'URL': '" + url + "',");
		result.append("'HttpHeaders': {");
		for (int i=0;i<header.length;i++) {
			result.append("'"+header[i].getName()+"':'"+header[i].getValue()+"'");
			if (i<header.length-1) {
				result.append(",");
			}
		}
		result.append("},");
		result.append("'HttpStatusMsg': '"+statusMsg+"',");
		result.append("'Disposition': '"+disposition+"',");
		result.append("'Compression': '"+compressionStatus+"',");
		result.append("'Message':"+message+"");
		result.append("}");	
		return result.toString().replace("'", "\"");
	}
}
