package com.bc.sterling.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import com.bc.sterling.service.SterlingService;
import com.bc.sterling.service.dao.SterlingDao;
import com.bc.user.bean.sterling.LockData;
import com.bc.user.bean.sterling.MDNData;
import com.bc.user.bean.sterling.MailboxAgingInfo;
import com.bc.user.bean.sterling.MailboxInfo;
import com.bc.user.bean.sterling.MailboxRouteInfo;
import com.bc.user.bean.sterling.MailboxRouteRequest;

@org.springframework.context.annotation.Lazy
@Component("sterlingService")
public class SterlingServiceImpl implements SterlingService {

	//private static Log logger = LogFactory.getLog(SterlingServiceImpl.class);
	public static List<String> archiveList = new ArrayList<String>();
	static { //these are pick up mailboxes that dont need to be displayed all the time
		archiveList.add("/DeadLetter");
		archiveList.add("/HumanResources/Milliman");
		archiveList.add("/HumanResources/Principal");
		archiveList.add("/HumanResources/VSPVisionCare");
		archiveList.add("/Origami/PgpOut");
		archiveList.add("/SFGMilliman");
		archiveList.add("/SFGMilliman/Inbox");
	}
	
	@Autowired
	@Qualifier("sterlingTstDao")
	private SterlingDao sterlingTstDao;
	
	@Autowired
	@Qualifier("sterlingPrdDao")
	private SterlingDao sterlingPrdDao;

	// Override
	public Integer insertMailboxInfo(Boolean testMode, MailboxInfo log, String userId) {
		Integer refId = sterlingPrdDao.insertMailboxInfo(log, userId);
		return refId;
	}

	@Override
	public Integer deleteMailboxRouteInfo(Boolean testMode, Integer refId, String userId) { 
		Integer rtnId = 0;
		if (testMode) {
			rtnId = sterlingTstDao.deleteMailboxRouteInfo(refId, userId);
		} else {
			rtnId = sterlingPrdDao.deleteMailboxRouteInfo(refId, userId);
		}
		return rtnId;
	}

	@Override
	public Integer insertMailboxRouteInfo(Boolean testMode, MailboxRouteInfo log, String userId) {
		Integer refId = 0;
		if (testMode) {
			refId = sterlingTstDao.insertMailboxRouteInfo(log, userId);
		} else {
			refId = sterlingPrdDao.insertMailboxRouteInfo(log, userId);
		}
		return refId;
	}

	@Override
	public List<MailboxRouteInfo> getMailboxRouteInfoList(Boolean testMode, String userId) {

		List<MailboxRouteInfo> rtnList = null;
		if (testMode) {
			rtnList = sterlingTstDao.getMailboxRouteInfoList(userId);
		} else {
			rtnList = sterlingPrdDao.getMailboxRouteInfoList(userId);
		}
		return rtnList; 
	}

	@Override
	public List<MailboxInfo> getMailboxInfoList(Boolean testMode, String userId) {

		List<MailboxInfo> rtnList = null;
		if (testMode) {
			rtnList = sterlingTstDao.getMailboxInfoList(userId);
		} else {
			rtnList = sterlingPrdDao.getMailboxInfoList(userId);
		}
		return rtnList; 
	}
	
	@Override
	public void updateMailboxRouteInfo(Boolean testMode, MailboxRouteInfo mailboxRoute, String userId) {
		
		if (testMode) {
			sterlingTstDao.updateMailboxRouteInfo(mailboxRoute, userId);
		} else {
			sterlingPrdDao.updateMailboxRouteInfo(mailboxRoute, userId);
		}
	}
	
	@Override
	public MailboxRouteRequest selectMailboxRequest(Boolean testMode, MailboxRouteRequest request, String userId) {
		MailboxRouteRequest mrr = null;
		if (testMode) {
			mrr = sterlingTstDao.selectMailboxRequest(request, userId);
		} else {
			mrr = sterlingPrdDao.selectMailboxRequest(request, userId);
		}
		return mrr;
	}

	@Override
	public List<MailboxAgingInfo> getMailboxAgingList(Boolean testMode, String userId) {
		List<MailboxAgingInfo> rtnList  = null;
		if (testMode) {
			rtnList = sterlingTstDao.getMailboxAgingList(userId);
		} else {
			rtnList = sterlingPrdDao.getMailboxAgingList(userId);
		}
		return rtnList;
	}

	@Override
	public List<MailboxAgingInfo> getMailboxAgingList(Boolean testMode, String userId, String mailbox) {
		List<MailboxAgingInfo> queryList = null;
		if (testMode) {
			queryList = sterlingTstDao.getMailboxAgingList(userId);
		} else {
			queryList = sterlingPrdDao.getMailboxAgingList(userId);
		}
		List<MailboxAgingInfo> rtnList = new ArrayList<MailboxAgingInfo>();
		for (MailboxAgingInfo query:queryList) {
			if (query.mailboxName.equalsIgnoreCase(mailbox)) {
				rtnList.add(query);
			}
		}
		return rtnList;
	}
	
	@Override
	public Map<String, Integer> getAgingRuleMailboxes(Boolean testMode, String userId) {
		Map<String, Integer> statusMap = new TreeMap<String,Integer>();
		List<MailboxAgingInfo> boxList = this.getMailboxAgingList(testMode, userId);
		for (MailboxAgingInfo box:boxList) {
			if (box.ruleProc==null||box.ruleProc.trim().length()==0) {
				
			} else {
				if (statusMap.containsKey(box.mailboxName)) {
					Integer cnt = statusMap.get(box.mailboxName)+1;
					statusMap.put(box.mailboxName,cnt);
				} else {
					statusMap.put(box.mailboxName,1);
				}
			}
		}
		return statusMap;
	}

	@Override
	public Map<String, Integer> getAgingOrphanMailboxes(Boolean testMode, String userId) {
		Map<String, Integer> statusMap = new TreeMap<String,Integer>();
		List<MailboxAgingInfo> boxList = this.getMailboxAgingList(testMode, userId);
		for (MailboxAgingInfo box:boxList) {
			if (box.ruleProc==null||box.ruleProc.trim().length()==0) {
				if (statusMap.containsKey(box.mailboxName)) {
					Integer cnt = statusMap.get(box.mailboxName)+1;
					statusMap.put(box.mailboxName,cnt);
				} else {
					statusMap.put(box.mailboxName,1);
				}
			}
		}
		return statusMap;
	}
	
	@Override
	public Map<String, Integer> getAllMailboxes(Boolean testMode, String userId) {
		Map<String, Integer> statusMap = new TreeMap<String, Integer>();
		List<MailboxAgingInfo> boxList = this.getMailboxAgingList(testMode, userId);
		for (MailboxAgingInfo box : boxList) {
				if (statusMap.containsKey(box.mailboxName)) {
					Integer cnt = statusMap.get(box.mailboxName) + 1;
					statusMap.put(box.mailboxName, cnt);
				} else {
					statusMap.put(box.mailboxName, 1);
				}
		}
		return statusMap;
	}

	@Override
	public Map<String, Integer> getActiveMailboxes(Boolean testMode, String userId) {
		Map<String, Integer> statusMap = new TreeMap<String, Integer>();
		List<MailboxAgingInfo> boxList = this.getMailboxAgingList(testMode, userId);
		for (MailboxAgingInfo box : boxList) {
			//these are pick up mailboxes that dont need to be displayed all the time
			if (box.mailboxName.toLowerCase().indexOf("archive") == -1
			   &&!archiveList.contains(box.mailboxName)) { //skip archive/dead
				if (statusMap.containsKey(box.mailboxName)) {
					Integer cnt = statusMap.get(box.mailboxName) + 1;
					statusMap.put(box.mailboxName, cnt);
				} else {
					statusMap.put(box.mailboxName, 1);
				}
			}
		}
		return statusMap;
	}
	
	@Override
	public Map<String, Integer> getArchiveMailboxes(Boolean testMode, String userId) {
		Map<String, Integer> statusMap = new TreeMap<String,Integer>();
		List<MailboxAgingInfo> boxList = this.getMailboxAgingList(testMode, userId);
		for (MailboxAgingInfo box:boxList) {
			if (box.mailboxName.toLowerCase().indexOf("archive") > 0
			  ||archiveList.contains(box.mailboxName)) {
				if (statusMap.containsKey(box.mailboxName)) {
					Integer cnt = statusMap.get(box.mailboxName)+1;
					statusMap.put(box.mailboxName,cnt);
				} else {
					statusMap.put(box.mailboxName,1);
				}
			}
		}
		return statusMap;
	}
	
	@Override
	public List<MailboxAgingInfo> getMailboxMessageList(Boolean testMode, String userId, String mailboxName) {
		List<MailboxAgingInfo> boxList = this.getMailboxAgingList(testMode, userId);
		return boxList;
	}
	
	@Override
	public String getDbUrl(Boolean testMode) {
		
		String conn = null;
		if (testMode) {
			conn = sterlingTstDao.getDbUrl("system");
		} else {
			conn = sterlingPrdDao.getDbUrl("system");
		}
		String[] connList = conn.split(";");
		return connList[0];
	}

	@Override
	public List<Integer> getHaltedBusProc(Boolean testMode) {
		
		List<Integer> conn = null;
		if (testMode) {
			conn = sterlingTstDao.getHaltedBusProc("system");
		} else {
			conn = sterlingPrdDao.getHaltedBusProc("system");
		}
		return conn;
	}

	@Override
	public List<MailboxRouteRequest> getSBIFileProcessRouteMapping(Boolean testMode, MailboxRouteRequest request, String userId) {
		List<MailboxRouteRequest> rtnList = null;
		if (testMode) {
			rtnList =sterlingTstDao.getSBIFileProcessRouteMapping(request, userId);
		} else {
			rtnList =sterlingPrdDao.getSBIFileProcessRouteMapping(request, userId);
		}
		return rtnList;
	}

	@Override
	public void updateExtractableMsg(Boolean testMode, Integer msgId, Integer msgCnt, String userId) {
		if (testMode) {
			sterlingTstDao.updateExtractableMsg(msgId, msgCnt, userId);
		} else {
			sterlingPrdDao.updateExtractableMsg(msgId, msgCnt, userId);
		}
	}

	@Override
	public Map<String, Integer> getMDNMbxCount(Boolean testMode, String userId) {
		
		Map<String, Integer> countMap = new HashMap<String, Integer>();
		List<MDNData> mdnList = null;
		if (testMode) {
			mdnList = sterlingTstDao.getPendingMDN(userId);
		} else {
			mdnList = sterlingPrdDao.getPendingMDN(userId);
		}
		for (MDNData mdn:mdnList) {
			Integer cnt = new Integer(1);
			if (countMap.containsKey(mdn.mailbox)) {
				cnt = countMap.get(mdn.mailbox).intValue() +1;
			}
			countMap.put(mdn.mailbox, cnt);
		}
		
		return countMap;
	}
	
	@Override
	public String updateBccLocks(Boolean testMode, String refId, String userId) {
		
		String status = null;
		if (testMode) {
			status = sterlingTstDao.UpdateBccLocks(refId, userId);
		} else {
			status = sterlingPrdDao.UpdateBccLocks(refId, userId);
		}
		
		return status;
	}
	
	@Override
	public List<LockData> getBccLocksList(Boolean testMode, String delay) {
		
		List<LockData> lockList = null;
		if (testMode) {
			lockList = sterlingTstDao.getBccLocksList(delay);
		} else {
			lockList = sterlingPrdDao.getBccLocksList(delay);
		}
		
		return lockList;
	}
	
	@Override
	public List<MDNData> getPendingMDN(Boolean testMode, String userId) {
		
		List<MDNData> mdnList = null;
		if (testMode) {
			mdnList = sterlingTstDao.getPendingMDN(userId);
		} else {
			mdnList = sterlingPrdDao.getPendingMDN(userId);
		}
		
		return mdnList;
	}

}
