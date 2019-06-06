package com.bc.sterling.service.dao;

import java.util.List;
import java.util.Map;

import org.json.JSONObject;

import com.bc.user.bean.sterling.LockData;
import com.bc.user.bean.sterling.MDNData;
import com.bc.user.bean.sterling.MailboxAgingInfo;
import com.bc.user.bean.sterling.MailboxInfo;
import com.bc.user.bean.sterling.MailboxRouteInfo;
import com.bc.user.bean.sterling.MailboxRouteRequest;

public interface SterlingDao {

	public Integer deleteMailboxRouteInfo(Integer refId, String userId);
	public Integer insertMailboxRouteInfo(MailboxRouteInfo route, String userId);
	public Integer insertMailboxInfo(MailboxInfo route, String userId);
	public void updateMailboxRouteInfo(MailboxRouteInfo route, String userId);
	public List<MailboxInfo> getMailboxInfoList(String userId);
	public List<MailboxRouteInfo> getMailboxRouteInfoList(String userId);
	public MailboxRouteRequest selectMailboxRequest(MailboxRouteRequest request, String userId);
	public List<MailboxAgingInfo> getMailboxAgingList(String userId);

	public String getDbUrl(String userId);
	public List<Integer> getHaltedBusProc(String userId);
	public void updateExtractableMsg(Integer msgId, Integer msgCnt, String userId);
	public String UpdateBccLocks(String refId, String userId);
	public List<LockData> getBccLocksList(String delay);
	public List<MDNData> getPendingMDN(String userId);
	
	public List<MailboxRouteRequest> getSBIFileProcessRouteMapping(MailboxRouteRequest request, String userId);
	
	public Map<String,String> processDBServer(JSONObject json, String userId);
	public List<Map<String, String>> getBccDBServer(String userId);
}