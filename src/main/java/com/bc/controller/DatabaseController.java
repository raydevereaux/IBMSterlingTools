package com.bc.controller;

import java.io.IOException;
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
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bc.project.util.BuildDate;
import com.bc.sterling.service.DatabaseService;

@Controller("DatabaseController")
public class DatabaseController {

	@Autowired
	@Qualifier("databaseService")
	private DatabaseService databaseService;
	
	@RequestMapping("/databaseHome.do")
	public String home(ModelMap map, HttpServletRequest request) {

		String userId = request.getUserPrincipal().getName();
		request.setAttribute("buildTimestamp", BuildDate.getBuildDate());
		return "DatabaseHome";
	}
	
	@RequestMapping("/databaseConnect.do")
	public @ResponseBody Map<String,Object> databaseConnect(@RequestBody String jsonString
			   , HttpServletRequest request
			   , Model model) {
		String userId = request.getUserPrincipal().getName();
		Map<String, Object> rtnMap = new TreeMap<String, Object>();
		try {
		JSONObject json = new JSONObject(jsonString);
			String type    = json.getString("type");
			String rowId   = json.getString("rowId");
			String server  = json.getString("server");
			String schema  = json.getString("schema");
			String dbUser  = json.getString("dbUser");
			String dbPass  = json.getString("dbPass");
			Map<String,String> sqlQueryResult = databaseService.getDBServerData(type, server, schema, dbUser, dbPass);
			rtnMap.put("rowId", rowId);
			rtnMap.put("sqlQuery", sqlQueryResult);
		} catch (JSONException je) {
			rtnMap.put("JSONException", je.getMessage());
		} catch (Exception e) {
			rtnMap.put("Exception", e.getMessage());
		}
		if (rtnMap.size()==0) {
			rtnMap.put("myUserId", userId);
		}
		return rtnMap;
	}
	
	@RequestMapping("/updateServerList.do")
	public @ResponseBody Map<String,Object> updateServerList(@RequestBody String jsonString
			   , HttpServletRequest request
			   , Model model) throws JSONException, IOException {
		String userId = request.getUserPrincipal().getName();
		JSONObject json = new JSONObject(jsonString);
		json.put("userId", userId);
		Map<String,String> result = databaseService.updateServerList(json, userId);
		Map<String, Object> rtnMap = new TreeMap<String, Object>();
		rtnMap.put("result", result);
		return rtnMap;
	}
	
	@RequestMapping("/getServerList.do")
	public @ResponseBody List<Map<String, String>> getServerList(@RequestBody String jsonString
			   , HttpServletRequest request
			   , Model model) throws JSONException, IOException {
		String userId = request.getUserPrincipal().getName();
		List<Map<String, String>> rtnList = databaseService.getServerList(userId);
		return rtnList;
	}

}
