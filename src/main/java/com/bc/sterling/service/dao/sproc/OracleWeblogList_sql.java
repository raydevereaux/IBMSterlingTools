package com.bc.sterling.service.dao.sproc;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.jdbc.core.RowMapper;

import com.bc.sterling.base.dao.MSSQLBaseStoredProcedure;
import com.bc.user.bean.integrationbroker.IBWeblog;

public class OracleWeblogList_sql extends MSSQLBaseStoredProcedure {

	public OracleWeblogList_sql(DataSource ds) {
		super(ds);
	}
	
    public List<IBWeblog> execute(String linkedServer, Date queryDate, String userId) {
	
    	String sql =""
    			+"select '"+linkedServer+"' as server"
    			+"      ,BC_REFID"
    			+"      ,BC_SRCNAME"
    			+"      ,BC_SERVICETYPE"
    			+"      ,BC_REST_METHOD"
    			+"      ,BC_REPLYTYPE"
    			+"      ,BC_SENDERID"
    			+"      ,BC_RECEIVERID"
    			+"      ,BC_DOCTYPE"
    			+"      ,BC_SRCSEQNO"
    			+"      ,BC_SRCXREF"
    			+"      ,BC_TARGET_SYSTEM"
    			+"      ,BC_TARGET_APP"
    			+"      ,BC_TARGET_PROC"
    			+"      ,BC_SERVICE_OPER"
    			+"      ,BC_SERVICE_VER"
    			+"      ,BC_FINAL_STATUS"
    			+"      ,BC_USERNAME"
    			+"      ,BC_CREATE_JTIME"
    			+"      ,BC_COMPLETE_JTIME"
    			+"      ,BC_REQUEST_URL"
    			+"      ,BC_REQUEST"
    			+"      ,BC_RESPONSE"
    			+"      ,BC_EXCEPTION"
    			+"  from SYSADM.PS_BC_IB_WEBLOG";
    			if (queryDate==null) {
    				//continue
    			} else {
    				String createDate = new SimpleDateFormat("yyyy-MM-dd").format(queryDate);
        			sql = sql+" where substr(BC_CREATE_JTIME,1,10) = '"+createDate+"'";
    			}
                

    	List<IBWeblog> rtnList = getJdbcTemplate().query(sql, new Object[] {}, new RowMapper<IBWeblog>(){
		public IBWeblog mapRow(ResultSet rs, int line) throws SQLException {
    			IBWeblog bean = new IBWeblog();
    			bean.server = rs.getString("server");
    			bean.refId = rs.getString("BC_REFID");
    			bean.srcName = rs.getString("BC_SRCNAME");
    			bean.serviceType = rs.getString("BC_SERVICETYPE");
    			bean.methodName = rs.getString("BC_REST_METHOD");
    			bean.replyType = rs.getString("BC_REPLYTYPE");
    			bean.senderID = rs.getString("BC_SENDERID");
    			bean.receiverID = rs.getString("BC_RECEIVERID");
    			bean.docType = rs.getString("BC_DOCTYPE");
    			bean.srcSeqNo = rs.getString("BC_SRCSEQNO");
    			bean.srcXref = rs.getString("BC_SRCXREF");
    			bean.targetSystem = rs.getString("BC_TARGET_SYSTEM");
    			bean.targetApp = rs.getString("BC_TARGET_APP");
    			bean.targetProc = rs.getString("BC_TARGET_PROC");
    			bean.serviceOperation = rs.getString("BC_SERVICE_OPER");
    			bean.version = rs.getString("BC_SERVICE_VER");
    			bean.finalStatus = rs.getString("BC_FINAL_STATUS");
    			bean.userName = rs.getString("BC_USERNAME");
    			bean.createTimestamp = rs.getString("BC_CREATE_JTIME");
    			bean.completeTimestamp = rs.getString("BC_COMPLETE_JTIME");
    			bean.requestUrl = rs.getString("BC_REQUEST_URL");
    			bean.origRequest = rs.getString("BC_REQUEST");
    			bean.finalResponse = rs.getString("BC_RESPONSE");
    			bean.execException = rs.getString("BC_EXCEPTION");
    			return bean;
    		}
		});
        return rtnList;
	}
}
