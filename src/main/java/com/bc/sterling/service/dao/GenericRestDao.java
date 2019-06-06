package com.bc.sterling.service.dao;


public interface GenericRestDao {

	public String sendGetRequest(String url, String securityToken) throws Exception;
	public String sendPostRequest(String url, String payload, String securityToken) throws Exception;
	public String sendPatchRequest(String url, String payload, String securityToken) throws Exception;

}
