package com.bc.sterling.service.dao.impl;

import java.io.BufferedReader;
import java.io.InputStreamReader;

import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.methods.StringRequestEntity;
import org.apache.http.HttpResponse;
import org.apache.http.RequestLine;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.springframework.stereotype.Repository;

import com.bc.sterling.service.dao.GenericRestDao;
import com.bc.util.http.HttpResultCodes;

@Repository("genericRestDao")
public class GenericRestDaoImpl implements GenericRestDao {

	@Override
	public String sendGetRequest(String url, String securityToken) throws Exception {

		int responseCode = -500;
		CloseableHttpClient httpClient = HttpClientBuilder.create().build();
		String base = url;
		HttpGet get = new HttpGet(base);
		get.setHeader("Authorization", "Basic "+securityToken);
		get.setHeader("Content-type", "application/json");
		StringBuffer result = new StringBuffer();
		try {
			HttpResponse response = httpClient.execute(get);
			responseCode = response.getStatusLine().getStatusCode();
			if (responseCode >= 200&&responseCode <=300) {
				BufferedReader rd = new BufferedReader(new InputStreamReader(response.getEntity().getContent()));
				String line = "";
				while ((line = rd.readLine()) != null) {
					result.append(line);
				}
			} else {
				result.append(jsonHttpErrorMessage(null, base, responseCode, securityToken));
			}
		} catch (Exception e) {
			result.append(jsonHttpErrorMessage(e, base, responseCode,  securityToken));
			e.printStackTrace();
			throw e;
		}
		System.out.println("get Url");
		System.out.println(base);
		System.out.println("result");
		System.out.println(result);
		return result.toString();
	}

	@Override
	public String sendPostRequest(String url, String payload, String securityToken) throws Exception {
		
		int responseCode = -500;
		CloseableHttpClient httpClient = HttpClientBuilder.create().build();
		String base = url;
		HttpPost post = new HttpPost(base);
		post.setHeader("Authorization", "Basic "+securityToken);
		post.setHeader("Content-type", "application/json");
		RequestLine method = post.getRequestLine();
		StringEntity stringEntity = new StringEntity(payload);
		post.setEntity(stringEntity);
		StringBuffer result = new StringBuffer();
		try {
			HttpResponse response = httpClient.execute(post);
			responseCode = response.getStatusLine().getStatusCode();
			System.out.println("contentLength="+response.getEntity().getContentLength()+":");
			if (responseCode >= 200&&responseCode <=300) {
				BufferedReader rd = new BufferedReader(new InputStreamReader(response.getEntity().getContent()));
				String line = "";
				while ((line = rd.readLine()) != null) {
					result.append(line);
				}
			} else {
				result.append(jsonHttpErrorMessage(null, base, responseCode, securityToken));
			}
		} catch (Exception e) {
			result.append(jsonHttpErrorMessage(e, base, responseCode, securityToken));
			e.printStackTrace();
			//throw e;
		}
		System.out.println("post Url");
		System.out.println(base);
		System.out.println(payload);
		System.out.println("result");
		System.out.println(result);
		return result.toString();
	}

	public static void main(String[] args) {
		System.out.println("go");
	}
	
	@Override
	public String sendPatchRequest(String url, String payload, String securityToken) throws Exception {
		
		HttpClient client = null; //new HttpClient();
		int responseCode = -500;
	    PostMethod patch = new PostMethod(url+ "?_HttpMethod=PATCH");
		patch.setRequestHeader("Authorization", "Basic "+securityToken);
		patch.setRequestHeader("Content-type", "application/json");
	    
	    patch.setRequestEntity(new StringRequestEntity(payload,"application/json", "UTF-8"));
		StringBuffer result = new StringBuffer();
		try {
			responseCode = 0; //client.executeMethod(patch);
			if (responseCode >= 200&&responseCode <=300) {
				//continue
			} else {
				result.append(jsonHttpErrorMessage(null, url, responseCode, securityToken));
			}
		} catch (Exception e) {
			result.append(jsonHttpErrorMessage(e, url, responseCode, securityToken));
			e.printStackTrace();
			//throw e;
		}
		System.out.println("patch Url");
		System.out.println(url);
		System.out.println("patch payload");
		System.out.println(payload);
		System.out.println("patch result");
		System.out.println(result);
		return result.toString();
	}
	
	public String jsonHttpErrorMessage(Exception e, String base, Integer responseCode, String authToken) {
	
		String message = "Operation did not connect";
		if (e!=null) {
			message = e.getMessage()+" (try/catch)";
		} else if (authToken==null||authToken.trim().length()==0) { 
			message = "Post Authentication Token empty";
		} else   { 
			message = HttpResultCodes.httpStatus.get(responseCode.toString());
		}
		StringBuffer result = new StringBuffer();
		result.append("{");
		result.append("\"Status\": \"Exception\",");
		result.append("\"HttpStatusCode\": \"" + responseCode + "\",");
		result.append("\"Disposition\": \"Message Not Processed\",");
		result.append("\"Message\":\""+message+"\",");
		result.append("\"URL\": \"" + base + "\" ");
		result.append("}");	
		return result.toString();
	}

}
