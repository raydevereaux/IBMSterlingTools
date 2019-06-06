package com.bc.sterling.service;

import org.json.JSONException;

public interface GenericRestService {

	public String execIcimsPost(String msgType, String userId) throws JSONException;
	public String execIcimsGet(String userId) throws JSONException;
	public String execRestRequest(String jsonMsg, String userId) throws JSONException;
}
