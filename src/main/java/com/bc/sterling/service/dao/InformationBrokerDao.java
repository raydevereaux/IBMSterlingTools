package com.bc.sterling.service.dao;

import com.bc.user.bean.integrationbroker.IBWebRestUrl;

public interface InformationBrokerDao {

	public String sendGetRequest(IBWebRestUrl requestUrl) throws Exception;
	public String sendPostRequest(IBWebRestUrl requestUrl, String ibPayload) throws Exception;
	public void sendPostAsync(IBWebRestUrl requestUrl, String ibPayload) throws Exception;

}
