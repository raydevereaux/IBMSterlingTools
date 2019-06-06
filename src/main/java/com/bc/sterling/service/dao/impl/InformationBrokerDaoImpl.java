package com.bc.sterling.service.dao.impl;

import java.io.BufferedReader;
import java.io.InputStreamReader;

import org.apache.http.HttpResponse;
import org.apache.http.RequestLine;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.springframework.stereotype.Repository;

import com.bc.sterling.service.dao.InformationBrokerDao;
import com.bc.user.bean.integrationbroker.IBWebRestUrl;

@Repository("informationBrokerDao")
public class InformationBrokerDaoImpl implements InformationBrokerDao {


	//public String bccService  = "https://erpwshr-t.bc.com/PSIGW/RESTListeningConnector/PSFT_HR/BCCSERVICE.v1/bcc";
	//public String bccServiceBase = "https://erpwshr-t.bc.com/PSIGW/RESTListeningConnector/PSFT_HR/BCCSERVICE.v1/boise/rest/rePost/echo/icims/bcllc/801/xref/100/mig/hr/applicant?json=";

	public String postUrl = new String();
	public String ibPayload = "{ 'newStatus':'9782', 'oldStatus':'1752', 'customerId':'1234', 'jobId':'1242', 'userId':'3', 'personId':'1364', 'links':[ { 'title':'Applicant Workflow', 'rel':'applicantWorkflow', 'url':'https://api.icims.com/customers/1234/applicantworkflows/2203' }, { 'title':'Job Profile', 'rel':'job', 'url':'https://api.icims.com/customers/1234/jobs/1242' }, { 'title':'Person Profile', 'rel':'person', 'url':'https://api.icims.com/customers/1234/people/1364' }, { 'title':'Posting User', 'rel':'user', 'url':'https://api.icims.com/customers/1234/people/3' } ], 'eventType':'WorkFlowStatusChangeEvent', 'systemId':'2203' }";

	@Override
	public String sendPostRequest(IBWebRestUrl requestUrl, String ibPayload) throws Exception {
		
		int responseCode = -500;
		CloseableHttpClient httpClient = HttpClientBuilder.create().build();
		String base = requestUrl.urlForPost();
		HttpPost post = new HttpPost(base);
		System.out.println(base);
		post.setHeader("Authorization", "Basic "+requestUrl.securityToken);
		post.setHeader("Content-type", "application/json");
		RequestLine method = post.getRequestLine();
		StringEntity stringEntity = new StringEntity(ibPayload);
		post.setEntity(stringEntity);
		StringBuffer result = new StringBuffer();
		try {
			HttpResponse response = httpClient.execute(post);
			responseCode = response.getStatusLine().getStatusCode();
			BufferedReader rd = new BufferedReader(new InputStreamReader(response.getEntity().getContent()));
			String line = "";
			while ((line = rd.readLine()) != null) {
				result.append(line+" ");
			}
			if (responseCode == 200) {
				//continue
			} else {
				Exception ex = new Exception("POST."+result.toString());
				result = new StringBuffer();
				result.append(jsonHttpErrorMessage(ex, base, responseCode, requestUrl.securityToken));
			}
		} catch (Exception e) {
			result.append(jsonHttpErrorMessage(e, base, responseCode, requestUrl.securityToken));
			e.printStackTrace();
			throw e;
		}
		return result.toString();
	}

	@Override
	public void sendPostAsync(IBWebRestUrl requestUrl, String ibPayload) throws Exception {

		CloseableHttpClient httpClient = HttpClientBuilder.create().build();
		String base = requestUrl.urlForPost();
		HttpPost post = new HttpPost(base);
		post.setHeader("Authorization", "Basic "+requestUrl.securityToken);
		post.setHeader("Content-type", "application/json");
		StringEntity stringEntity = new StringEntity(ibPayload);
		post.setEntity(stringEntity);
		try {
			httpClient.execute(post);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		System.out.println("Async Url");
		System.out.println(base);	
	}
	
	@Override
	public String sendGetRequest(IBWebRestUrl requestUrl) throws Exception {

		int responseCode = -500;
		CloseableHttpClient httpClient = HttpClientBuilder.create().build();
		String base = requestUrl.urlForGet();
		HttpGet get = new HttpGet(base);
		get.setHeader("Authorization", "Basic "+requestUrl.securityToken);
		get.setHeader("Content-type", "application/json");
		StringBuffer result = new StringBuffer();
		System.out.println("preResponse="+responseCode+":");
		try {
			HttpResponse response = httpClient.execute(get);
			responseCode = response.getStatusLine().getStatusCode();
			BufferedReader rd = new BufferedReader(new InputStreamReader(response.getEntity().getContent()));
			String line = "";
			while ((line = rd.readLine()) != null) {
				result.append(line+" ");
			}
			System.out.println("response="+responseCode+":");
			if (responseCode == 200) {
				//continue
			} else {
				Exception ex = new Exception("GET."+result.toString());
				result = new StringBuffer();
				result.append(jsonHttpErrorMessage(ex, base, responseCode, requestUrl.securityToken));
			}
		} catch (Exception e) {
			System.out.println("try error:"+result.toString());
			result.append(jsonHttpErrorMessage(e, base, responseCode, requestUrl.securityToken));
			e.printStackTrace();
			throw e;
		}
		System.out.println("Get  Url");
		System.out.println(base);
		return result.toString();
	}

	public String jsonHttpErrorMessage(Exception e, String base, Integer httpStatusCode, String authToken) {
	
		String message = "Post did not connect (default)";
		if (e!=null) {
			message = e.getMessage();
		}
		StringBuffer result = new StringBuffer();
		result.append("{");
		result.append("\"Disposition\": \"Message Not Processed\",");
		result.append("\"Status\": \"Exception\",");
		result.append("\"HttpStatusCode\": \"" + httpStatusCode + "\",");
		result.append("\"URL\": \"" + base + "\",");
		result.append("\"Message\":\""+message+"\" ");
		result.append("}");	
		return result.toString();
	}
	
	public void setIbPayload(String ibPayload) {
		this.ibPayload = ibPayload;
	}
	public void setPostUrl(String postUrl) {
		this.postUrl = postUrl;
	}
}
