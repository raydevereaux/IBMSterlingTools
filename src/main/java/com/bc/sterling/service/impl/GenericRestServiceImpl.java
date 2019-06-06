package com.bc.sterling.service.impl;

import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import com.bc.sterling.service.GenericRestService;
import com.bc.sterling.service.dao.GenericRestDao;
import com.bc.util.json.IcimsJsonMsgs;

@Component("genericRestService")
public class GenericRestServiceImpl implements GenericRestService {

	public IcimsJsonMsgs icimsJsonMsgs = new IcimsJsonMsgs();
	public String icimsToken = "Ym9pc2VhcGl1c2VyOkYkQzc0bjhYbTtZIVVmQQ==";
	public String icims = "boiseapiuser:F$C74n8Xm;Y!UfA";
	
	@Autowired
	@Qualifier("genericRestDao")
	public GenericRestDao genericRestDao;

	@Override
	public String execIcimsPost(String msgType, String userId) throws JSONException {
		String url = icimsJsonMsgs.getPersonUrl(null);
		String payload = icimsJsonMsgs.CreatePersonJson();
		String result = "";
		try {
			result = genericRestDao.sendPostRequest(url, payload, icimsToken);
		} catch (Exception e) {
			result= e.getMessage();
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public String execIcimsGet(String userId) {
		String url = "https://api.icims.com/customers/8533/people/504";
		String result = "";
		try {
			result = genericRestDao.sendGetRequest(url, icimsToken);
		} catch (Exception e) {
			result= e.getMessage();
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public String execRestRequest(String jsonMsg, String userId) throws JSONException {

		System.out.println(jsonMsg);
		String result = "";
		JSONObject jsonObj = new JSONObject(jsonMsg);
		String method        = jsonObj.getString("method").toLowerCase();
		String url           = jsonObj.getString("url");
		String payload       = jsonObj.getString("payload");
		String securityToken = jsonObj.getString("securityToken");
		try {
			if ("get".equals(method)) {
				result = genericRestDao.sendGetRequest(url, securityToken);
			} else if ("post".equals(method)) {
				System.out.println(payload);
				result = genericRestDao.sendPostRequest(url, payload, securityToken);
			} else {
				System.out.println("methodError:"+method+":");
			}
		} catch (Exception e) {
			result= e.getMessage();
			e.printStackTrace();
		}
		return result;
	}
	
}
