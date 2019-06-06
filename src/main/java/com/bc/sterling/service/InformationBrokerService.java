package com.bc.sterling.service;

import org.json.JSONException;

import com.bc.user.bean.integrationbroker.IBWebCtrl;


public interface InformationBrokerService {

	public String postIbWebCntl(IBWebCtrl json, String userId) throws JSONException;
	public String postIbWebCntl(String json, String userId) throws JSONException;
	public String execIbWebCntl(String urlJson, String userId) throws JSONException;
	public String updWebNotifyList(String json, String userId) throws JSONException;
	public String updUpdtWebLog(String json, String userId) throws JSONException;
}
