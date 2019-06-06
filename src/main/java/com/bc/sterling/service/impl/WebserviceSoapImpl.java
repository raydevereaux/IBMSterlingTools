package com.bc.sterling.service.impl;

import java.io.IOException;

import org.springframework.stereotype.Component;

import com.bc.sterling.service.WebserviceSoap;

@Component("webserviceSoap")
public class WebserviceSoapImpl implements WebserviceSoap {

	public Integer responseCode = new Integer("0");
	
	@Override
	public Integer getResponseCode() {
		return this.responseCode;
	}
	
	@Override
	public String sendRequest(Boolean prod, String filename) throws IOException {

		String url = "http://bouxsbi04.bc.com:8120/soap-new?service=SbiMbxPost";
		if (prod) {url = "http://bouxsbi03.bc.com:8120/soap-new?service=SbiMbxPost";}
		StringBuilder sb = new StringBuilder();
	    StringBuilder rsb = new StringBuilder();
	    return rsb.toString();

	}
	
/*

		sb.append("<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"");
		sb.append(" xmlns:req=\"http://www.bc.com/sbipostservice/mbx/Request\">");
		sb.append("   <soapenv:Header/>");
		sb.append("   <soapenv:Body>");
		sb.append("      <req:SbiMbxRequest>");
		sb.append("         <req:reqfile>");
		sb.append("            <req:filePath></req:filePath>");
		sb.append("            <req:fileName>"+filename+"</req:fileName>");
		sb.append("            <req:fileSrc>SoapUI</req:fileSrc>");
		sb.append("            <req:fileSize>10</req:fileSize>");
		sb.append("            <req:fileBody><![CDATA[this is a test]]></req:fileBody>");
		sb.append("         </req:reqfile>");
		sb.append("      </req:SbiMbxRequest>");
		sb.append("   </soapenv:Body>");
		sb.append("</soapenv:Envelope>");
		String xmlString = sb.toString();

		CloseableHttpClient httpClient = HttpClientBuilder.create().build();
	    HttpPost post = new HttpPost(url);

	    // add header
	    post.setHeader("User-Agent", "tomcat/webservice");

	    List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
	    urlParameters.add(new BasicNameValuePair("xml", xmlString));

	    post.setEntity(new UrlEncodedFormEntity(urlParameters));

	    HttpResponse response = httpClient.execute(post);
	    System.out.println("\nSending 'POST' request to URL : " + url);
	    System.out.println("Post parameters : " + post.getEntity());
	    System.out.println("Response Code : " +  response.getStatusLine().getStatusCode());
	    this.responseCode = response.getStatusLine().getStatusCode();

	    BufferedReader rd = new BufferedReader(new InputStreamReader(response.getEntity().getContent()));

	    StringBuffer result = new StringBuffer();
	    String line = "";
	    while ((line = rd.readLine()) != null) {
	        result.append(line);
	    }

	    StringBuilder rsb = new StringBuilder();
	    rsb.append("<WebserviceUrl>"+url+"</WebserviceUrl>");
	    rsb.append(xmlString);
	    rsb.append(result.toString());
 */
}
