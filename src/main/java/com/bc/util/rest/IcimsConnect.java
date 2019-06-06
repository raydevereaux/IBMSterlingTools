package com.bc.util.rest;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

//import org.apache.commons.net.util.Base64;
import org.apache.http.Header;
import org.apache.http.HttpException;
import org.apache.http.HttpResponse;
import org.apache.http.HttpResponseInterceptor;
import org.apache.http.RequestLine;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPatch;
import org.apache.http.client.protocol.RequestAddCookies;
import org.apache.http.client.protocol.RequestDefaultHeaders;
import org.apache.http.client.protocol.RequestProxyAuthentication;
import org.apache.http.client.protocol.RequestTargetAuthentication;
import org.apache.http.client.protocol.ResponseProcessCookies;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.protocol.BasicHttpProcessor;
import org.apache.http.protocol.HTTP;
import org.apache.http.protocol.HttpContext;
import org.apache.http.protocol.RequestConnControl;
import org.apache.http.protocol.RequestContent;
import org.apache.http.protocol.RequestExpectContinue;
import org.apache.http.protocol.RequestTargetHost;
import org.apache.http.protocol.RequestUserAgent;


public class IcimsConnect {

	public Boolean print = false;
	public String securityToken;
	public Map<String, String> headerMap = new HashMap<String, String>();
	
	public static void main(String[] args) {

		IcimsConnect icimsConnect = new IcimsConnect();
		try {
			//String url = "https://api.icims.com/customers/8533/people/30711";
			//String payload = "{'folder': {'value': 'HM:Active'},'logingroup': 12,'middlename': 'James','lastname': 'Ross','firstname': 'Clifford'}".replace("'", "\"");
			//String userPass = "boiseapiuser:F$C74n8Xm;Y!UfA";
			String securityToken = "Ym9pc2VhcGl1c2VyOkYkQzc0bjhYbTtZIVVmQQ==";
			//icimsConnect.addHeader("Content-Encoding", "gzip");
			//icimsConnect.addHeader("Content-Length", len);
			//icimsConnect.addHeader("Accept", "application/json");
			//icimsConnect.addHeader("Accept-Encoding", "gzip");
			//icimsConnect.addHeader("Vary", "Accept-Encoding");
			//icimsConnect.addHeader("Content-Language", "en-US,us");
			//icimsConnect.addHeader("Content-Type","application/x-www-form-urlencoded");
			//icimsConnect.addHeader("Content_Encoding", "identity");
			//icimsConnect.setObjClass("icimsConnect", icimsConnect);
			//icimsConnect.print = true;
			//icimsConnect.setSecurityToken("Basic "+securityToken);
			//icimsConnect.addHeader("Content-Type", "application/json");
			//icimsConnect.sendPatchDefault(url, payload);
			String token = icimsConnect.getSecurityToken(securityToken); 
			System.out.println(token);
		} catch (Exception e) {
			e.printStackTrace();
		}
        
	}
	
	public IcimsConnect() {
		super();
	}

	public String sendPatchDefault(String url, String payload) throws Exception {

		String reqMethod = this.getClass().getName()+".sendPatchDefault";
		CloseableHttpClient httpClient = HttpClientBuilder.create().build();
		int responseCode = -500;
		HttpPatch patch = new HttpPatch(url);
		patch.setHeader("Authorization", this.securityToken);
		this.setHttpHeader(patch);
		RequestLine method = patch.getRequestLine();
		StringEntity stringEntity = new StringEntity(payload);
		patch.setEntity(stringEntity);
		String result = new String();
		try {
			HttpResponse response =  httpClient.execute(patch);
			responseCode = response.getStatusLine().getStatusCode();
			StringBuilder httpMsg = new StringBuilder();
			if (responseCode >= 200&&responseCode <=300) {
				try {
					String line = "";
					BufferedReader rd = new BufferedReader(new InputStreamReader(response.getEntity().getContent()));
					while ((line = rd.readLine()) != null) {httpMsg.append(line);}
				} catch(Exception ignore) {
					this.print = true;
				}
				if (httpMsg.toString().length()==0) {
					result = (FormatStatus.jsonMessage(patch, new Exception("'No Provider Messages'"), url, responseCode, reqMethod));
				} else {
					result = (FormatStatus.jsonMessage(patch, new Exception(httpMsg.toString()), url, responseCode, reqMethod));
				}
			} else {
				result = (FormatStatus.jsonMessage(patch, new Exception("'Operation did not connect'"), url, responseCode, reqMethod));
			}
		} catch (Exception e) {
			result =(FormatStatus.jsonMessage(patch, e, url, responseCode, reqMethod));
			e.printStackTrace();
			this.print = true;
		}
		if (print) {
			System.err.println("patch Method:\t" +this.getClass().getName()+ ".sendPatchDefault");
			System.err.println("patch Url:\t"+url);
			System.err.println("patch Payload:\t"+payload);
			System.err.println("patch Result:\t"+result);
		}
		return result;
	}
	
	public String sendPatchCustom(String url, String payload) throws Exception {
		
		int responseCode = -500;
		String reqMethod = this.getClass().getName()+".sendPatchCustom";
		String compressionStatus = "enabled";
		HttpClientBuilder clientBuilder = HttpClients.custom();
		BasicHttpProcessor httpProcessor = this.getHttpProcessor();
		HttpClient client = clientBuilder.disableContentCompression().build();
		HttpPatch patch = new HttpPatch(url);
		patch.setHeader("Authorization", this.securityToken);
		this.setHttpHeader(patch);
		RequestLine method = patch.getRequestLine();
		StringEntity stringEntity = new StringEntity(payload);
		patch.setEntity(stringEntity);
		String result = new String();
		try {
			HttpResponse response = client.execute(patch);
			responseCode = response.getStatusLine().getStatusCode();
			StringBuilder httpMsg = new StringBuilder();
			if (responseCode >= 200 && responseCode <= 300) {
				try {
					String line = "";
					BufferedReader rd = new BufferedReader(new InputStreamReader(response.getEntity().getContent()));
					while ((line = rd.readLine()) != null) {httpMsg.append(line);}
				} catch (Exception ignore) {
					this.print = true;
				}
				if (httpMsg.toString().length() == 0) {
					result = (FormatStatus.jsonMessage(patch, new Exception("'No Provider Messages'"), url, responseCode, reqMethod, compressionStatus));
				} else {
					result = (FormatStatus.jsonMessage(patch, new Exception(httpMsg.toString()), url, responseCode, reqMethod, compressionStatus));
				}
			} else {
				result = (FormatStatus.jsonMessage(patch, new Exception("'Operation did not connect'"), url, responseCode, reqMethod, compressionStatus));
			}
		} catch (Exception e) {
			result = (FormatStatus.jsonMessage(patch, new Exception("'" + e.getMessage() + "'"), url, responseCode, reqMethod, compressionStatus));
			e.printStackTrace();
			this.print = true;
		}
		if (print) {
			System.err.println("patch Method:\t" +this.getClass().getName()+ ".sendPatchCustom");
			System.err.println("patch Url:\t" + url);
			System.err.println("patch Payload:\t" + payload);
			System.err.println("patch Result:\t" + result);
		}
		return result;
	}
	
	private void setHttpHeader(HttpPatch patch) {
		Iterator<String> it = this.headerMap.keySet().iterator();
		while (it.hasNext()) {
		    String name = it.next();
		    String value = this.headerMap.get(name);
			patch.setHeader(name, value);
		}
		
	}

	public String setObjClass(String key, Object obj) {

		this.addHeader(key, obj.getClass()+"");
		return obj.getClass()+"";
	}
	
	public BasicHttpProcessor getHttpProcessor() {

		HttpResponseInterceptor contentEncodingFixerInterceptor = new HttpResponseInterceptor()  {
		    @Override
		    public void process(HttpResponse response, HttpContext context) throws HttpException, IOException {
		        Header contentEncodingHeader = response.getFirstHeader(HTTP.CONTENT_ENCODING);
		        if(contentEncodingHeader != null && contentEncodingHeader.getValue().equalsIgnoreCase("none")) {
		            response.removeHeaders(HTTP.CONTENT_ENCODING);
		            response.addHeader(HTTP.CONTENT_ENCODING, "identity");
		        }
		    }
		};
		BasicHttpProcessor httpProcessor = new BasicHttpProcessor();
		httpProcessor.addInterceptor(contentEncodingFixerInterceptor);

		// Required protocol interceptors
		httpProcessor.addInterceptor(new RequestContent());
		httpProcessor.addInterceptor(new RequestTargetHost());
		httpProcessor.addInterceptor(new RequestDefaultHeaders());

		// Recommended protocol interceptors
		httpProcessor.addInterceptor(new RequestConnControl());
		httpProcessor.addInterceptor(new RequestUserAgent());
		httpProcessor.addInterceptor(new RequestExpectContinue());

		// HTTP state management interceptors
		httpProcessor.addInterceptor(new RequestAddCookies());
		httpProcessor.addInterceptor(new ResponseProcessCookies());

		// HTTP authentication interceptors
		httpProcessor.addInterceptor(new RequestTargetAuthentication());
		httpProcessor.addInterceptor(new RequestProxyAuthentication());

		return httpProcessor;
	}

	public void addHeader(String key, String value) {
		
		this.headerMap.put(key, value);
	}
	
	public void setSecurityToken(String securityToken) {
		//byte[] bytesEncoded = Base64.encodeBase64(securityToken.getBytes());
		//this.securityToken = new String(bytesEncoded);
		this.securityToken = securityToken;
	}
	
	public String getSecurityToken(String securityToken) {

		byte[] valueDecoded = null; // Base64.decodeBase64(securityToken);
		if (this.securityToken==null) {
			return "none:none";
		}
		return new String(valueDecoded);
	}
}
