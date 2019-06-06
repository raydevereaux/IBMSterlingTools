package com.bc.sterling.service.dao.impl;

import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.sql.DataSource;

import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.bc.sterling.base.dao.SQLBaseDaoImpl;
import com.bc.sterling.service.dao.SterlingDao;
import com.bc.sterling.service.dao.sproc.DeleteBccDBServer_sproc;
import com.bc.sterling.service.dao.sproc.DeleteMailboxRouteInfo_sproc;
import com.bc.sterling.service.dao.sproc.GetBccDBServerList_sproc;
import com.bc.sterling.service.dao.sproc.GetBccLockList_sproc;
import com.bc.sterling.service.dao.sproc.GetDbUrl_sproc;
import com.bc.sterling.service.dao.sproc.GetHaltedBusProc_sproc;
import com.bc.sterling.service.dao.sproc.GetMailboxAgingList_sproc;
import com.bc.sterling.service.dao.sproc.GetMailboxInfoList_sproc;
import com.bc.sterling.service.dao.sproc.GetMailboxRouteInfoList_sproc;
import com.bc.sterling.service.dao.sproc.GetPendingMDNList_sproc;
import com.bc.sterling.service.dao.sproc.InsertBccDBServer_sproc;
import com.bc.sterling.service.dao.sproc.InsertMailboxInfo_sproc;
import com.bc.sterling.service.dao.sproc.InsertMailboxRouteInfo_sproc;
import com.bc.sterling.service.dao.sproc.SBIFileProcessRouteMapping_sproc;
import com.bc.sterling.service.dao.sproc.SelectMailboxRequest_sproc;
import com.bc.sterling.service.dao.sproc.UpdateBccDBServer_sproc;
import com.bc.sterling.service.dao.sproc.UpdateBccLocks_sproc;
import com.bc.sterling.service.dao.sproc.UpdateExtractableMsg_sproc;
import com.bc.sterling.service.dao.sproc.UpdateMailboxRouteInfo_sproc;
import com.bc.user.bean.sterling.LockData;
import com.bc.user.bean.sterling.MDNData;
import com.bc.user.bean.sterling.MailboxAgingInfo;
import com.bc.user.bean.sterling.MailboxInfo;
import com.bc.user.bean.sterling.MailboxRouteInfo;
import com.bc.user.bean.sterling.MailboxRouteRequest;

@Repository("sterlingTstDao")
public class SterlingTstDaoImpl extends SQLBaseDaoImpl implements SterlingDao {

	@Autowired
	public SterlingTstDaoImpl(@Qualifier("SterlingDataSourceTst") DataSource ds) {
		super(ds);
	}

	@Override
	public Integer deleteMailboxRouteInfo(Integer refId, String userId) {

		DeleteMailboxRouteInfo_sproc logger = new DeleteMailboxRouteInfo_sproc(getDataSource());
		Integer rtnId = logger.execute(refId, userId);
		return rtnId;
	}
	
	@Override
	public Integer insertMailboxRouteInfo(MailboxRouteInfo route, String userId) {

		InsertMailboxRouteInfo_sproc logger = new InsertMailboxRouteInfo_sproc(getDataSource());
		Integer refId = logger.execute(route, userId);
		return refId;
	}

	@Override
	public Integer insertMailboxInfo(MailboxInfo mailbox, String userId) {

		InsertMailboxInfo_sproc logger = new InsertMailboxInfo_sproc(getDataSource());
		Integer mailboxId = logger.execute(mailbox, userId);
		return mailboxId;
	}
	
	@Override
	public List<MailboxInfo> getMailboxInfoList(String userId) {
		
		GetMailboxInfoList_sproc proc = new GetMailboxInfoList_sproc(getDataSource());
		List<MailboxInfo> rtnList = proc.execute(userId);
		return rtnList;
	}

	@Override
	public List<MailboxRouteInfo> getMailboxRouteInfoList(String userId) {
		
		GetMailboxRouteInfoList_sproc proc = new GetMailboxRouteInfoList_sproc(getDataSource());
		List<MailboxRouteInfo> rtnList = proc.execute(userId);
		return rtnList;
	}

	@Override
	public void updateMailboxRouteInfo(MailboxRouteInfo route, String userId) {

		UpdateMailboxRouteInfo_sproc proc = new UpdateMailboxRouteInfo_sproc(getDataSource());
		proc.execute(route, userId);
	}

	@Override
	public MailboxRouteRequest selectMailboxRequest(MailboxRouteRequest request, String userId) {

		SelectMailboxRequest_sproc logger = new SelectMailboxRequest_sproc(getDataSource());
		MailboxRouteRequest mrr = logger.execute(request, userId); 
		return mrr;
	}

	@Override
	public List<MailboxAgingInfo> getMailboxAgingList(String userId) {

		GetMailboxAgingList_sproc logger = new GetMailboxAgingList_sproc(getDataSource());
		 List<MailboxAgingInfo> agingList = logger.execute(userId); 
		return agingList;
	}
		
	@Override
	public String getDbUrl(String userId) {
		
		GetDbUrl_sproc sp = new GetDbUrl_sproc(getDataSource());
		String db = sp.execute(userId);		
		return db;
	}

	@Override
	public List<Integer> getHaltedBusProc(String userId) {
		
		GetHaltedBusProc_sproc sp = new GetHaltedBusProc_sproc(getDataSource());
		List<Integer> db = sp.execute(userId);		
		return db;
	}

	@Override
	public List<MailboxRouteRequest> getSBIFileProcessRouteMapping(MailboxRouteRequest request, String userId) {
		SBIFileProcessRouteMapping_sproc sp = new SBIFileProcessRouteMapping_sproc(getDataSource());
		List<MailboxRouteRequest> rtnList = sp.execute(request, userId);
		return rtnList;
	}

	@Override
	public void updateExtractableMsg(Integer msgId, Integer msgCnt, String userId) {

		UpdateExtractableMsg_sproc sp = new UpdateExtractableMsg_sproc(getDataSource());
		sp.execute(msgId,msgCnt, userId);
	}

	@Override
	public String UpdateBccLocks(String refId, String userId) {
		UpdateBccLocks_sproc sp = new UpdateBccLocks_sproc(getDataSource());
		String status = sp.execute(refId, userId);
		return status;
	}
	
	@Override
	public List<LockData> getBccLocksList(String delay) {
		GetBccLockList_sproc sp = new GetBccLockList_sproc(getDataSource());
		List<LockData> lockList = sp.execute(delay);
		return lockList;
	}
	
	@Override
	public List<MDNData> getPendingMDN(String userId) {
		GetPendingMDNList_sproc sp = new GetPendingMDNList_sproc(getDataSource());
		List<MDNData> mdnList = sp.execute(userId);
		return mdnList;
	}
	
	@Override
	public void setSqlDebug(Boolean sqlDebug) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Map<String, String> processDBServer(JSONObject json, String userId) {
		Map<String, String> rtnMap = new TreeMap<String, String>();
		try {
			String oper  = json.getString("oper");
			if ("insert".equalsIgnoreCase(oper)) {
				rtnMap = insertDBServer(json, userId);
			} else if ("update".equalsIgnoreCase(oper)) {
				rtnMap = updateDBServer(json, userId);
			} else if ("delete".equalsIgnoreCase(oper)) {
				rtnMap = deleteDBServer(json, userId);
			}
			rtnMap.put("oper",oper.toUpperCase());
		} catch (JSONException e) {
			rtnMap.put("JSONException",e.getMessage());
			rtnMap.put("Status","failure");
		}

		return rtnMap;
	}

	public Map<String, String> insertDBServer(JSONObject json, String userId) {
		Map<String, String> rtnMap = new TreeMap<String, String>();
		try {
			InsertBccDBServer_sproc sp = new InsertBccDBServer_sproc(getDataSource());
			Integer refId = sp.execute(json, userId);
			rtnMap.put("refId",refId.toString());
			rtnMap.put("Exception","none");
			rtnMap.put("Status","sucessful");
		} catch (JSONException e) {
			rtnMap.put("refId","0");
			rtnMap.put("Exception",e.getMessage());
			rtnMap.put("Status","failure");
			e.printStackTrace();
		}
		return rtnMap;
	}

	public Map<String, String> updateDBServer(JSONObject json, String userId) {
		Map<String, String> rtnMap = new TreeMap<String, String>();
		try {
			UpdateBccDBServer_sproc sp = new UpdateBccDBServer_sproc(getDataSource());
			sp.execute(json, userId);
			rtnMap.put("Exception","none");
			rtnMap.put("Status","sucessful");
		} catch (JSONException e) {
			rtnMap.put("Exception",e.getMessage());
			rtnMap.put("Status","failure");
			e.printStackTrace();
		}
		return rtnMap;
	}	

	public Map<String, String> deleteDBServer(JSONObject json, String userId) {
		Map<String, String> rtnMap = new TreeMap<String, String>();
		try {
			DeleteBccDBServer_sproc sp = new DeleteBccDBServer_sproc(getDataSource());
			sp.execute(json, userId);
			rtnMap.put("Exception","none");
			rtnMap.put("Status","sucessful");
		} catch (JSONException e) {
			rtnMap.put("Exception",e.getMessage());
			rtnMap.put("Status","failure");
			e.printStackTrace();
		}
		return rtnMap;
	}	
	
	@Override
	public List<Map<String, String>> getBccDBServer(String userId) {
		GetBccDBServerList_sproc sp = new GetBccDBServerList_sproc(getDataSource());
		List<Map<String, String>> json = sp.execute(userId);
		return json;
	}

}
