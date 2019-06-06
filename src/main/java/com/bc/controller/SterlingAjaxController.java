package com.bc.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bc.sterling.service.SterlingService;
import com.bc.sterling.service.WebserviceSoap;
import com.bc.user.bean.sterling.MailboxRouteInfo;
import com.bc.user.bean.sterling.MailboxRouteRequest;

@Controller("SterlingAjaxController")
public class SterlingAjaxController {

	@Autowired
	@Qualifier("sterlingService")
	private SterlingService sterlingService;

	@Autowired
	@Qualifier("webserviceSoap")
	private WebserviceSoap webserviceSoap;
	
	@RequestMapping("/refreshMbx.do")
	public @ResponseBody Map<String,Integer> refreshMbx(@RequestBody String jsonString
			   											,HttpServletRequest request
														, Model model) throws JSONException {

		JSONObject json = new JSONObject(jsonString);
		String dbUrl = json.getString("dbUrl");
		Boolean testMode = MailboxRouteInfo.getTestMode(dbUrl);
		String userId = request.getUserPrincipal().getName();
		Map<String,Integer> mbxMessageMap = new TreeMap<String,Integer>();
		String listMode = json.getString("listMode");
		try {
			if (listMode==null||listMode.trim().length()==0) {
				mbxMessageMap = sterlingService.getActiveMailboxes(testMode, userId);
			} else if ("All".equalsIgnoreCase(listMode)) {
				mbxMessageMap = sterlingService.getAllMailboxes(testMode, userId);
			} else if ("Archive".equalsIgnoreCase(listMode)) {
				mbxMessageMap = sterlingService.getArchiveMailboxes(testMode, userId);
			} else if ("orphan".equalsIgnoreCase(listMode)) {
				mbxMessageMap = sterlingService.getAgingOrphanMailboxes(testMode, userId);
			} else if ("pending".equalsIgnoreCase(listMode)) {
				mbxMessageMap = sterlingService.getAgingRuleMailboxes(testMode, userId);
			} else {
				mbxMessageMap = sterlingService.getActiveMailboxes(testMode, userId);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return mbxMessageMap;
	}

	@RequestMapping(value = "/lockReview.do")
	public @ResponseBody Map<String,String> lockReview(@RequestBody String jsonString
										   , HttpServletRequest request
										   , Model model) throws JSONException {

		JSONObject json = new JSONObject(jsonString);
		String dbUrl = json.getString("dbUrl");
		Boolean testMode = MailboxRouteInfo.getTestMode(dbUrl);
		String userId = request.getUserPrincipal().getName();
		String refId = json.getString("refId");
		String status = sterlingService.updateBccLocks(testMode, refId, userId);
		Map<String,String> statusMap = new HashMap<String,String>();
		statusMap.put("status",status);
		statusMap.put("refId",refId);
		return statusMap;
	}

	@RequestMapping(value = "/updateExtractableMsg.do")
	public @ResponseBody Map<String,String> updateExtractableMsg(@RequestBody String jsonString
			   , HttpServletRequest request
			   , Model model) throws JSONException {

		JSONObject json = new JSONObject(jsonString);
		String dbUrl = json.getString("dbUrl");
		Boolean testMode = MailboxRouteInfo.getTestMode(dbUrl);
		String userId = request.getUserPrincipal().getName();
		Integer msgId  = json.getInt("msgId");
		Integer msgCnt = json.getInt("msgCnt");
		Map<String,String> map = new HashMap<String,String>();
		try {
			sterlingService.updateExtractableMsg(testMode, msgId, msgCnt, userId);
			map.put("status","success");
		} catch (Exception e) {
			map.put("status","error");
			map.put("error", e.getMessage());
		}
		return map;
	}

	@RequestMapping(value = "/webserviceSoap.do")
	public @ResponseBody Map<String,String> webserviceSoap(@RequestBody String jsonString
			   , HttpServletRequest request
			   , Model model) throws JSONException, IOException {
		
		Map<String,String> map = new HashMap<String,String>();
		String userId = request.getUserPrincipal().getName();
		JSONObject json = new JSONObject(jsonString);
		String msgName = json.getString("msgName");
		String mode    = json.getString("mode");
		Boolean prod = "prod".equalsIgnoreCase(mode)?true:false;
		String serverName = request.getServerName()==null||request.getServerName().trim().length()==0?"default":request.getServerName();
		String firstNode = serverName.indexOf(".")==-1?serverName:serverName.substring(0,serverName.indexOf("."));
		String reqName = msgName==null||msgName.trim().length()==0?firstNode+'.'+userId+".txt":msgName+"."+firstNode+'.'+userId+".txt";
		String filename = reqName.replace("${", "").replace("}", "");
		
		String result = webserviceSoap.sendRequest(prod, filename);
		if (result==null||result.trim().length()==0) {result = webserviceSoap.getResponseCode().toString();}
		String webServiceSoap = result.replaceAll("[ ]{2,}","");
		webServiceSoap = webServiceSoap.replaceAll("><",">\n<");
		webServiceSoap = webServiceSoap.replaceAll("<soapenv:Envelope", "\n<soapenv:Envelope");
		map.put("WebserviceSoap",webServiceSoap);
		return map;
	}

	@RequestMapping("/mbxRoutingTest.do")
	public @ResponseBody List<MailboxRouteRequest> mbxRoutingTest(@RequestBody String jsonString
			   , HttpServletRequest request
			   , Model model) throws JSONException, IOException {

		JSONObject json = new JSONObject(jsonString);
		String dbUrl = json.getString("dbUrl");
		Boolean testMode = MailboxRouteInfo.getTestMode(dbUrl);
		String userId = request.getUserPrincipal().getName();
		String srcMailbox  = json.getString("srcMailbox");
		String filename  = json.getString("filename");
		MailboxRouteRequest req = new MailboxRouteRequest();
		req.setBusProcId("00000000"); //random number
		req.setBusProcName(request.getLocalName());
		req.setSrcMailbox(srcMailbox);
		req.setFileName(filename.trim());
		req.setHostName(request.getServerName());
		List<MailboxRouteRequest> respList = sterlingService.getSBIFileProcessRouteMapping(testMode, req, userId);
		return respList;
	}

	@RequestMapping("/deleteTemplate.do")
	public @ResponseBody Integer deleteTemplate(@RequestBody String jsonString
			   , HttpServletRequest request
			   , Model model) throws JSONException, IOException {

		JSONObject json  = new JSONObject(jsonString);
		String dbUrl = json.getString("dbUrl");
		Integer refId = json.getInt("refId");
		Boolean testMode = MailboxRouteInfo.getTestMode(dbUrl);
		String userId = request.getUserPrincipal().getName();
		MailboxRouteInfo form = new MailboxRouteInfo(testMode);
		Integer rtnId = sterlingService.deleteMailboxRouteInfo(testMode, refId, userId);
		return rtnId;
	}
}
