package com.bc.sterling.service.dao;

import java.util.Date;
import java.util.List;

import com.bc.user.bean.integrationbroker.IBWebCtrl;
import com.bc.user.bean.integrationbroker.IBWebNotify;
import com.bc.user.bean.integrationbroker.IBWeblog;

public interface OracleDao { 
	public IBWeblog getWeblog(String refId, String userId);
	public List<IBWeblog> getWeblogList(String serverDomain, Date queryDate, String userId);
	public void updateWeblogList(String refId, String status, String userId);
	public List<IBWebCtrl> getWebCntlList(String serverDomain, String senderId, String receiverId, String docType, String userId);
	public List<IBWebNotify> getWebNotifyList(String serverDomain, String userId);
	public List<IBWebNotify> getNotifyList(String serverDomain, String userId);
}