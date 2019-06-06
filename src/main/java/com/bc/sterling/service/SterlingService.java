package com.bc.sterling.service;

import java.util.List;
import java.util.Map;

import com.bc.user.bean.sterling.LockData;
import com.bc.user.bean.sterling.MDNData;
import com.bc.user.bean.sterling.MailboxAgingInfo;
import com.bc.user.bean.sterling.MailboxInfo;
import com.bc.user.bean.sterling.MailboxRouteInfo;
import com.bc.user.bean.sterling.MailboxRouteRequest;

public interface SterlingService {


	//public Integer insertMailboxInfo(MailboxInfo mailbox, String userId);
	public Integer deleteMailboxRouteInfo(Boolean testMode, Integer refId, String userId);
	public Integer insertMailboxRouteInfo(Boolean testMode, MailboxRouteInfo mailboxRoute, String userId);
	public void updateMailboxRouteInfo(Boolean testMode, MailboxRouteInfo mailboxRoute, String userId);
	public List<MailboxInfo> getMailboxInfoList(Boolean testMode, String userId);
	public List<MailboxRouteInfo> getMailboxRouteInfoList(Boolean testMode, String userId);
	public MailboxRouteRequest selectMailboxRequest(Boolean testMode, MailboxRouteRequest request, String userId);
	public List<MailboxAgingInfo> getMailboxAgingList(Boolean testMode, String userId);
	public List<MailboxAgingInfo> getMailboxAgingList(Boolean testMode, String userId, String mailbox);
	public List<MailboxAgingInfo> getMailboxMessageList(Boolean testMode, String userId, String mailboxName);
	public Map<String,Integer> getAgingRuleMailboxes(Boolean testMode, String userId);
	public Map<String, Integer> getAgingOrphanMailboxes(Boolean testMode, String userId);
	public Map<String, Integer> getAllMailboxes(Boolean testMode, String userId);
	public Map<String, Integer> getActiveMailboxes(Boolean testMode, String userId);
	public Map<String, Integer> getArchiveMailboxes(Boolean testMode, String userId);
	
	public String getDbUrl(Boolean testMode);
	public List<Integer> getHaltedBusProc(Boolean testMode);
	public List<MailboxRouteRequest> getSBIFileProcessRouteMapping(Boolean testMode, MailboxRouteRequest request, String userId);
	public void updateExtractableMsg(Boolean testMode, Integer msgId, Integer msgCnt, String userId);
	public Map<String, Integer> getMDNMbxCount(Boolean testMode, String userId);
	public String updateBccLocks(Boolean testMode, String refId, String userId);
	public List<LockData> getBccLocksList(Boolean testMode, String delay);
	public List<MDNData> getPendingMDN(Boolean testMode, String userId);
}
