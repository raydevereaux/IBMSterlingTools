package com.bc.sterling.service.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.CannotGetJdbcConnectionException;
import org.springframework.stereotype.Component;

import com.bc.sterling.service.OracleService;
import com.bc.sterling.service.dao.OracleDao;
import com.bc.user.bean.integrationbroker.IBWebCtrl;
import com.bc.user.bean.integrationbroker.IBWebNotify;
import com.bc.user.bean.integrationbroker.IBWeblog;

@org.springframework.context.annotation.Lazy
@Component("oracleService")
public class OracleServiceImpl implements OracleService {

	private static Log logger = LogFactory.getLog(OracleServiceImpl.class);

	@Autowired
	@Qualifier("oracleHprdDao")
	private OracleDao oracleHprdDao;

	@Autowired
	@Qualifier("oracleHtstDao")
	private OracleDao oracleHtstDao;
	
	@Autowired
	@Qualifier("oracleHdevDao")
	private OracleDao oracleHdevDao;
	
	@Autowired
	@Qualifier("oracleHmigDao")
	private OracleDao oracleHmigDao;

	@Autowired
	@Qualifier("oracleBdevDao")
	private OracleDao oracleBdevDao;

	@Autowired
	@Qualifier("oracleBprdDao")
	private OracleDao oracleBprdDao;
	
	@Autowired
	@Qualifier("oracleBtstDao")
	private OracleDao oracleBtstDao;
	
	@Autowired
	@Qualifier("oracleBmignDao")
	private OracleDao oracleBmigDao;
	
	@Override
	public List<IBWeblog> getWeblogList(String serverDomain, Date queryDate, String userId) {
		List<IBWeblog> hPrdList = new ArrayList<IBWeblog>();
		List<IBWeblog> hTstList = new ArrayList<IBWeblog>();
		List<IBWeblog> hDevList = new ArrayList<IBWeblog>();
		List<IBWeblog> hMigList = new ArrayList<IBWeblog>();
		List<IBWeblog> bPrdList = new ArrayList<IBWeblog>();
		List<IBWeblog> bTstList = new ArrayList<IBWeblog>();
		List<IBWeblog> bDevList = new ArrayList<IBWeblog>();
		List<IBWeblog> bMigList = new ArrayList<IBWeblog>();
		if ("all".equals(serverDomain.toLowerCase())) {
			hPrdList = oracleHprdDao.getWeblogList("hprd",queryDate, userId);  // if prd is down, it needs to be fixed
			try {hTstList = oracleHtstDao.getWeblogList("htst",queryDate, userId);} catch (CannotGetJdbcConnectionException e) {}
			try {hDevList = oracleHdevDao.getWeblogList("hdev",queryDate, userId);} catch (CannotGetJdbcConnectionException e) {}
			try {hMigList = oracleHmigDao.getWeblogList("hmig",queryDate, userId);} catch (CannotGetJdbcConnectionException e) {}
		} else if ("hprd".equals(serverDomain.toLowerCase())) {
			hPrdList = oracleHprdDao.getWeblogList("hprd",queryDate, userId);
		} else if ("htst".equals(serverDomain.toLowerCase())) {
			hTstList = oracleHtstDao.getWeblogList("htst",queryDate, userId);
		} else if ("hdev".equals(serverDomain.toLowerCase())) {
			hDevList = oracleHdevDao.getWeblogList("hdev",queryDate, userId);
		} else if ("hmig".equals(serverDomain.toLowerCase())) {
			hMigList = oracleHmigDao.getWeblogList("hmig",queryDate, userId);
		} else if ("bprd".equals(serverDomain.toLowerCase())) {
			bPrdList = oracleBprdDao.getWeblogList("bprd",queryDate, userId);
		} else if ("btst".equals(serverDomain.toLowerCase())) {
			bTstList = oracleBtstDao.getWeblogList("btst",queryDate, userId);
		} else if ("bdev".equals(serverDomain.toLowerCase())) {
			bDevList = oracleBdevDao.getWeblogList("bdev",queryDate, userId);
		} else if ("bmig".equals(serverDomain.toLowerCase())) {
			hMigList = oracleBmigDao.getWeblogList("bmig",queryDate, userId);
		}
		List<IBWeblog> rtnList = new ArrayList<IBWeblog>();
		rtnList.addAll(hPrdList);
		rtnList.addAll(hTstList);
		rtnList.addAll(hDevList);
		rtnList.addAll(hMigList);
		rtnList.addAll(bMigList);
		rtnList.addAll(bDevList);
		rtnList.addAll(bTstList);
		rtnList.addAll(bPrdList);
		Collections.sort(rtnList);
		return rtnList;
	}
	
	@Override
	public Map<String,String> getWeblogMap(Date queryDate, String userId) {
		Map<String,String> rtnMap = new HashMap<String,String>();
		List<IBWeblog> hPrdList = new ArrayList<IBWeblog>();
		List<IBWeblog> hTstList = new ArrayList<IBWeblog>();
		List<IBWeblog> hDevList = new ArrayList<IBWeblog>();
		List<IBWeblog> hMigList = new ArrayList<IBWeblog>();
		List<IBWeblog> bPrdList = new ArrayList<IBWeblog>();
		List<IBWeblog> bTstList = new ArrayList<IBWeblog>();
		List<IBWeblog> bDevList = new ArrayList<IBWeblog>();
		List<IBWeblog> bMigList = new ArrayList<IBWeblog>();
		try {hPrdList = oracleHprdDao.getWeblogList("hprd",queryDate, userId);} catch (CannotGetJdbcConnectionException e) {}
		try {hTstList = oracleHtstDao.getWeblogList("htst",queryDate, userId);} catch (CannotGetJdbcConnectionException e) {}
		try {hDevList = oracleHdevDao.getWeblogList("hdev",queryDate, userId);} catch (CannotGetJdbcConnectionException e) {}
		try {hMigList = oracleHmigDao.getWeblogList("hmig",queryDate, userId);} catch (CannotGetJdbcConnectionException e) {}
		try {bPrdList = oracleBprdDao.getWeblogList("bprd",queryDate, userId);} catch (CannotGetJdbcConnectionException e) {}
		try {bTstList = oracleBtstDao.getWeblogList("btst",queryDate, userId);} catch (CannotGetJdbcConnectionException e) {}
		try {bDevList = oracleBdevDao.getWeblogList("bdev",queryDate, userId);} catch (CannotGetJdbcConnectionException e) {}
		try {bMigList = oracleBmigDao.getWeblogList("bmig",queryDate, userId);} catch (CannotGetJdbcConnectionException e) {}
		rtnMap.put("hprd", hPrdList.size()+"."+getExceptionSum(hPrdList));
		rtnMap.put("htst", hTstList.size()+"."+getExceptionSum(hTstList));
		rtnMap.put("hdev", hDevList.size()+"."+getExceptionSum(hDevList));
		rtnMap.put("hmig", hMigList.size()+"."+getExceptionSum(hMigList));
		rtnMap.put("bmig", bMigList.size()+"."+getExceptionSum(bMigList));
		
		rtnMap.put("bprd", bPrdList.size()+"."+getExceptionSum(bPrdList));
		rtnMap.put("btst", bTstList.size()+"."+getExceptionSum(bTstList));
		rtnMap.put("bdev", bDevList.size()+"."+getExceptionSum(bDevList));
		rtnMap.put("bmig", bMigList.size()+"."+getExceptionSum(bMigList));
		Integer totRows = hPrdList.size()+hTstList.size()+hDevList.size()+hMigList.size()+bMigList.size()
				        + bPrdList.size()+bTstList.size()+bDevList.size()+bMigList.size();
		Integer errRows = getExceptionSum(hPrdList)+getExceptionSum(hTstList)+getExceptionSum(hDevList)+getExceptionSum(hMigList)+getExceptionSum(bMigList)
					    + getExceptionSum(bPrdList)+getExceptionSum(bTstList)+getExceptionSum(bDevList)+getExceptionSum(bMigList);

		rtnMap.put("all", totRows+"."+errRows);
		return rtnMap;
	}

	public Integer getExceptionSum(List<IBWeblog> weblogList) {
		Integer es = 0;
		for (IBWeblog weblog :weblogList) {
			if (weblog.getReviewException()) {
				es = es + 1;
			}
		}
		return es;
	}
	
	@Override
	public List<IBWebCtrl> getWebCntlList(String serverDomain, String senderId, String receiverId, String docType, String userId) {
		
		List<IBWebCtrl> rtn = new ArrayList<IBWebCtrl>();
		if ("hprd".equals(serverDomain.toLowerCase())) {
			rtn = oracleHprdDao.getWebCntlList(serverDomain, senderId, receiverId, docType, userId);
		} else if ("htst".equals(serverDomain.toLowerCase())) {
			rtn = oracleHtstDao.getWebCntlList(serverDomain, senderId, receiverId, docType, userId);	
		} else if ("hdev".equals(serverDomain.toLowerCase())) {
			rtn = oracleHdevDao.getWebCntlList(serverDomain, senderId, receiverId, docType, userId);
		} else if ("hmig".equals(serverDomain.toLowerCase())) {
			rtn = oracleHmigDao.getWebCntlList(serverDomain, senderId, receiverId, docType, userId);			
		} else if ("bprd".equals(serverDomain.toLowerCase())) {
			rtn = oracleBprdDao.getWebCntlList(serverDomain, senderId, receiverId, docType, userId);			
		} else if ("btst".equals(serverDomain.toLowerCase())) {
			rtn = oracleBtstDao.getWebCntlList(serverDomain, senderId, receiverId, docType, userId);	
		} else if ("bdev".equals(serverDomain.toLowerCase())) {
			rtn = oracleBdevDao.getWebCntlList(serverDomain, senderId, receiverId, docType, userId);	
		} else if ("bmig".equals(serverDomain.toLowerCase())) {
			rtn = oracleBmigDao.getWebCntlList(serverDomain, senderId, receiverId, docType, userId);	
		} else {
			System.out.println("serverDomain :"+serverDomain+": blank/empty");
		}
		return rtn;
	}

	@Override
	public List<IBWebNotify> getWebNotifyList(String serverDomain, String userId) {
		
		List<IBWebNotify> rtn = new ArrayList<IBWebNotify>();
		if ("hprd".equals(serverDomain.toLowerCase())) {
			rtn = oracleHprdDao.getWebNotifyList(serverDomain, userId);
		} else if ("htst".equals(serverDomain.toLowerCase())) {
			rtn = oracleHtstDao.getWebNotifyList(serverDomain, userId);	
		} else if ("hdev".equals(serverDomain.toLowerCase())) {
			rtn = oracleHdevDao.getWebNotifyList(serverDomain, userId);	
		} else if ("hmig".equals(serverDomain.toLowerCase())) {
			rtn = oracleHmigDao.getWebNotifyList(serverDomain, userId);		
		} else if ("bmig".equals(serverDomain.toLowerCase())) {
			rtn = oracleBmigDao.getWebNotifyList(serverDomain, userId);	
		} else if ("bprd".equals(serverDomain.toLowerCase())) {
			rtn = oracleBprdDao.getWebNotifyList(serverDomain, userId);	
		} else if ("btst".equals(serverDomain.toLowerCase())) {
			rtn = oracleBtstDao.getWebNotifyList(serverDomain, userId);	
		} else if ("bdev".equals(serverDomain.toLowerCase())) {
			rtn = oracleBdevDao.getWebNotifyList(serverDomain, userId);	
		} else {
			System.out.println("serverDomain :"+serverDomain+": blank/empty");
		}
		return rtn;
	}
	
	@Override
	public List<IBWebNotify> getNotifyOptionList(String serverDomain, String userId) {
		
		List<IBWebNotify> rtnList = new ArrayList<IBWebNotify>();
		if ("hprd".equals(serverDomain.toLowerCase())) {
			rtnList = oracleHprdDao.getNotifyList(serverDomain, userId);
		} else if ("htst".equals(serverDomain.toLowerCase())) {
			rtnList = oracleHtstDao.getNotifyList(serverDomain, userId);
		} else if ("hdev".equals(serverDomain.toLowerCase())) {
			rtnList = oracleHdevDao.getNotifyList(serverDomain, userId);
		} else if ("hmig".equals(serverDomain.toLowerCase())) {
			rtnList = oracleHmigDao.getNotifyList(serverDomain, userId);		
		} else if ("bmig".equals(serverDomain.toLowerCase())) {
			rtnList = oracleBmigDao.getNotifyList(serverDomain, userId);			
		} else if ("bprd".equals(serverDomain.toLowerCase())) {
			rtnList = oracleBprdDao.getNotifyList(serverDomain, userId);	
		} else if ("btst".equals(serverDomain.toLowerCase())) {
			rtnList = oracleBtstDao.getNotifyList(serverDomain, userId);
		} else if ("bdev".equals(serverDomain.toLowerCase())) {
			rtnList = oracleBdevDao.getNotifyList(serverDomain, userId);
		} else {
			System.out.println("serverDomain :"+serverDomain+": blank/empty");
		}
		return rtnList;
	}
}
