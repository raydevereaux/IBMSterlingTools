package com.bc.controller;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bc.sterling.service.GenericRestService;
import com.bc.sterling.service.InformationBrokerService;
import com.bc.sterling.service.OracleService;
import com.bc.user.bean.integrationbroker.IBWebCtrl;
import com.bc.user.bean.integrationbroker.IBWebNotify;
import com.bc.user.bean.integrationbroker.IBWeblog;
import com.bc.util.json.ConvertJSON;
import com.bc.util.json.ConvertXML;
import com.bc.util.rest.IcimsConnect;

@Controller("OracleAjaxController")
public class OracleAjaxController {

	public static final String xmlVer = "<?xml version='1.0' encoding='UTF-8'?>";
	private DateFormat dateFormater = new SimpleDateFormat("MM/dd/yyyy");
	
	@Autowired
	@Qualifier("oracleService")
	private OracleService oracleService;

	@Autowired
	@Qualifier("informationBrokerService")
	private InformationBrokerService informationBrokerService;

	@Autowired
	@Qualifier("genericRestService")
	private GenericRestService genericRestService;
	
	@RequestMapping(value = "/queryDate.do")
	public @ResponseBody List<IBWeblog> queryDate(@RequestBody String jsonString
												 ,HttpServletRequest request
												 , Model model) throws JSONException {

		String userId = request.getUserPrincipal().getName();
		List<IBWeblog> ibWeblogList = new ArrayList<IBWeblog>();
		JSONObject json  = new JSONObject(jsonString);
		String serverDomain = json.getString("serverDomain");
		try {
			Date queryDate = dateFormater.parse(json.getString("queryDate"));
			ibWeblogList = oracleService.getWeblogList(serverDomain, queryDate, userId);
		} catch (ParseException e) {
			ibWeblogList = oracleService.getWeblogList(serverDomain, new Date(), userId);
		}

		return ibWeblogList;
	}

	@RequestMapping(value = "/queryCounts.do")
	public @ResponseBody Map<String,String> queryCounts(@RequestBody String jsonString
			 				 ,HttpServletRequest request
			 				 ,Model model) throws JSONException, ParseException {

		String userId = request.getUserPrincipal().getName();
		Map<String,String> ibWeblogMap = new HashMap<String,String>();
		JSONObject json  = new JSONObject(jsonString);
		try {
			Date queryDate = dateFormater.parse(json.getString("queryDate"));
			ibWeblogMap = oracleService.getWeblogMap(queryDate, userId); 
		} catch (ParseException e) {
			ibWeblogMap = oracleService.getWeblogMap(new Date(), userId); 
		}

		return ibWeblogMap;
	}

	@RequestMapping(value = "/updWebNotify.do")
	public @ResponseBody List<String> updWebNotify(@RequestBody String jsonString
			 ,HttpServletRequest request
			 ,Model model) throws JSONException, ParseException {

		String userId = request.getUserPrincipal().getName();
		List<String> rtnList = new ArrayList<String>();
		try {
			String rtn = informationBrokerService.updWebNotifyList(jsonString, userId);
			rtnList.add(rtn);
		} catch (Exception e) {
			rtnList.add(e.getMessage());
			e.printStackTrace();
			throw e;
		}

		return rtnList;
	}

	@RequestMapping(value = "/execIbWebNotify.do")
	public @ResponseBody List<IBWebNotify> getWebNotify(@RequestBody String jsonString
			   , HttpServletRequest request
			   , Model model) throws JSONException, IOException {

		String userId = request.getUserPrincipal().getName();
		System.out.println(userId+" execIbWebNotify.do "+ jsonString);
		JSONObject json = new JSONObject(jsonString);
		String serverDomain  = json.getString("serverDomain");
		List<IBWebNotify> rtn = oracleService.getWebNotifyList(serverDomain, userId);
		return rtn;
	}

	@RequestMapping(value = "/getNotifyOptions.do")
	public @ResponseBody List<IBWebNotify> getNotifyOptions(@RequestBody String jsonString
			   , HttpServletRequest request
			   , Model model) throws JSONException, IOException {

		String userId = request.getUserPrincipal().getName();
		System.out.println("getNotifyOptions.do");
		System.out.println(jsonString);
		JSONObject json  = new JSONObject(jsonString);
		String serverDomain = json.getString("serverDomain");
		List<IBWebNotify> rtn = oracleService.getNotifyOptionList(serverDomain, userId);
		return rtn;
	}
	
	@RequestMapping(value = "/icimsPost.do")
	public @ResponseBody List<String> icimsPost(@RequestBody String jsonString
			   , HttpServletRequest request
			   , Model model) throws JSONException, IOException {

		String userId = request.getUserPrincipal().getName();
		List<String> rtnList = new ArrayList<String>();
		rtnList.add(genericRestService.execIcimsPost(jsonString, userId));
		return rtnList;
	}

	@RequestMapping(value = "/callRest.do")
	public @ResponseBody List<String> callRest(@RequestBody String jsonString
			   , HttpServletRequest request
			   , Model model) throws JSONException, IOException {

		String userId = request.getUserPrincipal().getName();
		List<String> rtnList = new ArrayList<String>();
		rtnList.add(genericRestService.execRestRequest(jsonString, userId));
		return rtnList;
	}

	@RequestMapping(value = "/updUpdtWebLog.do")
	public @ResponseBody List<String> updUpdtWebLog(@RequestBody String jsonString
			   , HttpServletRequest request
			   , Model model) throws JSONException, IOException {

		String userId = request.getUserPrincipal().getName();
		JSONObject json = new JSONObject(jsonString);
		json.put("authUser", userId);
		json.put("authServer", request.getServerName());

		System.out.println("updUpdtWebLog.do");
		System.out.println(json.toString(2));
		List<String> rtnList = new ArrayList<String>();
		rtnList.add(informationBrokerService.updUpdtWebLog(json.toString(), userId));

		return rtnList;
	}
	
	@RequestMapping(value = "/getWebCtrl.do")
	public @ResponseBody List<IBWebCtrl> getWebCtrl(@RequestBody String jsonString
			   , HttpServletRequest request
			   , Model model) throws JSONException, IOException {

		String userId = request.getUserPrincipal().getName();
		JSONObject json = new JSONObject(jsonString);
		String serverDomain  = json.getString("serverDomain");
		String senderId  = json.getString("senderId");
		String receiverId  = json.getString("receiverId");
		String docType  = json.getString("docType");
		List<IBWebCtrl> rtn = oracleService.getWebCntlList(serverDomain, senderId, receiverId, docType, userId);
		return rtn;
	}

	@RequestMapping(value = "/updWebCtrl.do")
	public @ResponseBody List<String> getupdCtrl(@RequestBody String jsonString
			   , HttpServletRequest request
			   , Model model) throws JSONException, IOException {

		String userId = request.getUserPrincipal().getName();
		List<String> jsonResult = new ArrayList<String>();
		jsonResult.add(informationBrokerService.postIbWebCntl(jsonString, userId));

		return jsonResult;
	}
	
	@RequestMapping(value = "/execIbWebCntl.do")
	public @ResponseBody List<String> execIbWebCntl(@RequestBody String jsonString
			   , HttpServletRequest request
			   , Model model) throws JSONException, IOException {

		String userId = request.getUserPrincipal().getName();
		List<String> jsonResult = new ArrayList<String>();
		System.out.println("jsoonString="+jsonString);
		jsonResult.add(informationBrokerService.execIbWebCntl(jsonString, userId));
		return jsonResult;
	}
	
	@RequestMapping(value = "/xmlConvert.do")
	public @ResponseBody Map<String,String> xmlConvert(@RequestBody String data
			   , HttpServletRequest request
			   , Model model) throws JSONException, IOException {
		String userId = request.getUserPrincipal().getName();
		Map<String,String> result = new HashMap<String,String>();
		try {
			String xmlResult = new String();
			if ("{".equals(data.trim().substring(0,1))) {
				xmlResult = xmlVer+ConvertJSON.toXml(data);
			} else if ("<".equals(data.trim().substring(0,1))) {
				xmlResult = ConvertXML.toJson(data);
			} else {
				xmlResult = "no converstion";
			}
			//result.put("payload","<![CDATA["+xmlResult+"]]>");
			result.put("payload",xmlResult);
		} catch (Exception e) {
			JSONObject json = new JSONObject();
			json.put("userId", userId);
			json.put("serverName", request.getServerName());
			json.put("data", data);
			json.put("Exception", e.getMessage());
			result.put("payload",json.toString());
		}
		System.out.println("xmlConvert.do "+result.get("payload"));

		return result;
	}
	
	@RequestMapping(value = "/icimsPatch.do")
	public String icimsPatch(ModelMap map, HttpServletRequest request) throws Exception {
		
		String xxx = request.getInputStream().toString();
		IcimsConnect icimsConnect = new IcimsConnect();
		String url = "https://api.icims.com/customers/8533/people/30711";
		String payload = "{'folder': {'value': 'HM:Active'},'logingroup': 12,'middlename': 'James','lastname': 'Ross','firstname': 'Clifford'}".replace("'", "\"");
		String userPass = "boiseapiuser:F$C74n8Xm;Y!UfA";
		String securityToken = "Ym9pc2VhcGl1c2VyOkYkQzc0bjhYbTtZIVVmQQ==";
		icimsConnect.print = true;
		icimsConnect.setSecurityToken(securityToken);
		icimsConnect.addHeader("Content-Type", "application/json");
		String rtn = icimsConnect.sendPatchCustom(url, payload);
		map.put("payload", rtn);
		System.out.println("icimsPatch.do.payload"+rtn);

		return "restView";
	}
}
