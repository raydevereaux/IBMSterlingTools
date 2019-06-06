package com.bc.sterling.service.dao.impl;

import java.util.Date;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.bc.sterling.base.dao.SQLBaseDaoImpl;
import com.bc.sterling.service.dao.OracleDao;
import com.bc.sterling.service.dao.sproc.OracleNotifylList_sql;
import com.bc.sterling.service.dao.sproc.OracleUpdateWeblog_sproc;
import com.bc.sterling.service.dao.sproc.OracleWebCtrlList_sql;
import com.bc.sterling.service.dao.sproc.OracleWebNotifyList_sql;
import com.bc.sterling.service.dao.sproc.OracleWeblogList_sql;
import com.bc.sterling.service.dao.sproc.OracleWeblog_sproc;
import com.bc.user.bean.integrationbroker.IBWebCtrl;
import com.bc.user.bean.integrationbroker.IBWebNotify;
import com.bc.user.bean.integrationbroker.IBWeblog;

@Repository("oracleHtstDao")
public class OracleHTstDaoImpl extends SQLBaseDaoImpl implements OracleDao {

	@Autowired
	public OracleHTstDaoImpl(@Qualifier("HtstPeoplesoftDS") DataSource ds) {
		super(ds);
	}


	@Override
	public List<IBWeblog> getWeblogList(String serverDomain, Date queryDate, String userId) {

		OracleWeblogList_sql proc = new OracleWeblogList_sql(getDataSource());
		List<IBWeblog> rtnList = proc.execute(serverDomain, queryDate, userId);
		return rtnList;
	}

	@Override
	public IBWeblog getWeblog(String refId, String userId) {

		OracleWeblog_sproc proc = new OracleWeblog_sproc(getDataSource());
		IBWeblog rtn = proc.execute( refId, userId);
		return rtn;
	}

	@Override
	public void updateWeblogList(String refId, String status, String userId) {

		OracleUpdateWeblog_sproc proc = new OracleUpdateWeblog_sproc(getDataSource());
		proc.execute(refId, status, userId);
	}

	@Override
	public List<IBWebCtrl> getWebCntlList(String serverDomain, String senderId, String receiverId, String docType, String userId) {
		OracleWebCtrlList_sql proc = new OracleWebCtrlList_sql(getDataSource());
		List<IBWebCtrl> rtn = proc.execute(serverDomain, senderId, receiverId, docType, userId);
		return rtn;
	}

	@Override
	public void setSqlDebug(Boolean sqlDebug) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<IBWebNotify> getWebNotifyList(String serverDomain, String userId) {
		OracleWebNotifyList_sql proc = new OracleWebNotifyList_sql(getDataSource());
		List<IBWebNotify> rtn = proc.execute(serverDomain, userId);
		return rtn;
	}

	@Override
	public List<IBWebNotify> getNotifyList(String serverDomain, String userId) {
		OracleNotifylList_sql proc = new OracleNotifylList_sql(getDataSource());
		List<IBWebNotify> rtn = proc.execute(serverDomain, userId);
		return rtn;
	}
}
