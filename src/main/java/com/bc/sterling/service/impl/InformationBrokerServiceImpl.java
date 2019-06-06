package com.bc.sterling.service.impl;

import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import com.bc.sterling.service.InformationBrokerService;
import com.bc.sterling.service.dao.InformationBrokerDao;
import com.bc.user.bean.integrationbroker.IBWebCtrl;
import com.bc.user.bean.integrationbroker.IBWebRestUrl;

@Component("informationBrokerService")
public class InformationBrokerServiceImpl implements InformationBrokerService {

	@Autowired
	@Qualifier("informationBrokerDao")
	public InformationBrokerDao informationBrokerDao;

	@Override
	public String postIbWebCntl(IBWebCtrl ctrl, String userId) throws JSONException {
		
		IBWebRestUrl requestUrl = new IBWebRestUrl();
		requestUrl.securityToken = ctrl.securityToken;
		requestUrl.senderID = "bcllc";
		requestUrl.receiverID = "bcllc";
		requestUrl.docType = "ctrl";
		String objName = ctrl.BC_EXECOBJNAME;
		ctrl.BC_EXECOBJNAME = objName;
		
		JSONObject jsonObject = new JSONObject(ctrl.toString());
		String myJson = jsonObject.toString();

		String result = new String();
		try {
			result = informationBrokerDao.sendPostRequest(requestUrl, myJson);
		} catch (Exception e) {
			result = e.toString();
		}
		return result;
	}
	
	@Override
	public String postIbWebCntl(String json, String userId) throws JSONException {
		
		IBWebRestUrl requestUrl = new IBWebRestUrl();
		JSONObject jsonObj = new JSONObject(json);
		String securityToken = jsonObj.getString("securityToken");
		String serverDomain = jsonObj.getString("serverDomain");
		requestUrl.securityToken = securityToken;
		requestUrl.setServerDomain(serverDomain);
		requestUrl.senderID = "bcllc";
		requestUrl.receiverID = "bcllc";
		requestUrl.docType = "ctrl";
		System.out.println(json);
		String result = new String();
		try {
			result = informationBrokerDao.sendPostRequest(requestUrl, json);
		} catch (Exception e) {
			result = e.toString();
		}
		return result;
	}
	
	@Override
	public String execIbWebCntl(String urlJson, String userId) throws JSONException {

		JSONObject jsonObj = new JSONObject(urlJson);

		IBWebRestUrl reqUrl = new IBWebRestUrl();
		reqUrl.securityToken = jsonObj.getString("securityToken");
		reqUrl.setServerDomain(jsonObj.getString("serverDomain"));
		reqUrl.ibInstance    = jsonObj.getString("ibInstance");
		reqUrl.ibNode        = jsonObj.getString("ibNode");
		reqUrl.serviceType   = jsonObj.getString("serviceType");
		reqUrl.serviceMethod = jsonObj.getString("serviceMethod");
		reqUrl.replyType     = jsonObj.getString("replyType");
		reqUrl.senderID      = jsonObj.getString("senderID");
		reqUrl.receiverID    = jsonObj.getString("receiverID");
		reqUrl.docType       = jsonObj.getString("docType");
		reqUrl.xref          = jsonObj.getString("xref");
		reqUrl.seqNo         = jsonObj.getString("seqNo");
		reqUrl.targetSystem  = jsonObj.getString("targetSystem");
		reqUrl.targetApp     = jsonObj.getString("targetApp");
		reqUrl.targetProc    = jsonObj.getString("targetProc");
		
		String result = new String();
		try {
			if ("post".equals(reqUrl.serviceMethod.toLowerCase())||"repost".equals(reqUrl.serviceMethod.toLowerCase())||"put".equals(reqUrl.serviceMethod.toLowerCase())) {
				String payload = jsonObj.getString("payload");
				System.out.println("replyType="+reqUrl.replyType);
				// payload = "this is line one\nthis is line two\nthis is line three";
				System.out.println("payload="+payload);
				result = informationBrokerDao.sendPostRequest(reqUrl, payload);
			} else {
				System.out.println(reqUrl.urlForGet());
				result = informationBrokerDao.sendGetRequest(reqUrl);
			}
		} catch (Exception e) {
			result = e.toString();
		}
		return result;
	}

	@Override
	public String updWebNotifyList(String json, String userId) throws JSONException {
		IBWebRestUrl requestUrl = new IBWebRestUrl();
		JSONObject jsonObj = new JSONObject(json);
		String securityToken = jsonObj.getString("securityToken"); //"bWlkZGxld2FyZTpCaGxhaDJycA==";
		String serverDomain = jsonObj.getString("serverDomain"); //"hprd";
		requestUrl.securityToken = securityToken;
		requestUrl.setServerDomain(serverDomain);
		requestUrl.senderID = "bcllc";
		requestUrl.receiverID = "bcllc";
		requestUrl.docType = "notify";
		System.out.println(json);
		String result = new String();
		try {
			result = informationBrokerDao.sendPostRequest(requestUrl, json);
		} catch (Exception e) {
			result = e.toString();
		}
		return result;
	}
	
	@Override
	public String updUpdtWebLog(String json, String userId) throws JSONException {
		IBWebRestUrl requestUrl = new IBWebRestUrl();
		JSONObject jsonObj = new JSONObject(json);
		String securityToken = jsonObj.getString("securityToken");
		String serverDomain = jsonObj.getString("serverDomain");
		String xRef = jsonObj.getString("xRef");
		requestUrl.securityToken = securityToken;
		requestUrl.serviceMethod = "patch";
		requestUrl.setServerDomain(serverDomain);
		requestUrl.senderID = "b2btools";
		requestUrl.receiverID = "bcllc";
		requestUrl.docType = "weblog";
		requestUrl.replyType = "json";
		requestUrl.xref = xRef;
		requestUrl.targetSystem = "b2b";
		String result = new String();
		try {
			result = informationBrokerDao.sendPostRequest(requestUrl, json);
		} catch (Exception e) {
			result = e.toString();
		}
		return result;
	}
}
