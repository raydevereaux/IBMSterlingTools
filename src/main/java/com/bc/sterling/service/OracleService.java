package com.bc.sterling.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.bc.user.bean.integrationbroker.IBWebCtrl;
import com.bc.user.bean.integrationbroker.IBWebNotify;
import com.bc.user.bean.integrationbroker.IBWeblog;

public interface OracleService {
	
	//public IBWeblog getWeblog(String refId, String userId);
	public List<IBWeblog> getWeblogList(String serverDomain,Date queryDate, String userId);
	public Map<String,String> getWeblogMap(Date queryDate, String userId);
	public List<IBWebCtrl> getWebCntlList(String serverDomain, String senderId, String receiverId, String docType, String userId);
	public List<IBWebNotify> getWebNotifyList(String serverDomain, String userId);
	public List<IBWebNotify> getNotifyOptionList(String serverDomain, String userId);
}
