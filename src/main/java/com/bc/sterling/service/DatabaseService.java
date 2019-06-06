package com.bc.sterling.service;

import java.util.List;
import java.util.Map;

import org.json.JSONObject;

public interface DatabaseService {
	
	public Map<String,String> getDBServerData(String type, String server, String schema, String dbUser, String dbPass);
	public Map<String,String> getMSSqlServerList(String server, String schema, String dbUser, String dbPass);
	public Map<String,String> getOracleList(String server, String schema, String dbUser, String dbPass);
	public Map<String,String> getDB2List(String server, String schema, String dbUser, String dbPass);
	public Map<String,String> getMySqlList(String server, String schema, String userId, String password);
	public  Map<String,String> updateServerList(JSONObject json, String userId);
	public  List<Map<String, String>> getServerList(String userId);
}
