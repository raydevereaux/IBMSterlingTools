package com.bc.sterling.service.dao.sproc;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.core.SqlReturnResultSet;

import com.bc.sterling.base.dao.MSSQLBaseStoredProcedure;
import com.bc.user.bean.integrationbroker.IBWeblog;

public class OracleWeblogList_sproc extends MSSQLBaseStoredProcedure {

	protected static final String SPROC_NAME = "dbo.OracleBCWeblogList_v1";

	public OracleWeblogList_sproc(DataSource ds) {
		super(ds);
        setSql(SPROC_NAME);

        declareParameter(new SqlParameter("@userId", Types.VARCHAR));
        declareParameter(new SqlParameter("@queryDate", Types.TIMESTAMP));
        declareParameter(new SqlParameter("@linkedServer", Types.VARCHAR));
		declareParameter(new SqlReturnResultSet("rs", new RowMapper<IBWeblog>() {

			@Override
			public IBWeblog mapRow(ResultSet rs, int rowNum) throws SQLException {
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
			
		}
				
		));
        this.compile();
	}
	
    public List<IBWeblog> execute(String linkedServer, Date queryDate, String userId) {

		List<IBWeblog> migList = executeServer(queryDate, "hmig", userId);
		List<IBWeblog> tstList = executeServer(queryDate, "htst", userId);
		List<IBWeblog> rtnList = new ArrayList<IBWeblog>();
		for (IBWeblog mig:migList) {
			rtnList.add(mig);
		}
		for (IBWeblog tst:tstList) {
			rtnList.add(tst);
		}
		Collections.sort(rtnList);
        return rtnList;
    }
	
    public List<IBWeblog> executeServer(Date queryDate, String linkedServer, String userId) {
    	Map<String, Object> params = this.getInputParamsMap();
        params.put("@userId",userId);
        params.put("@queryDate", queryDate);
        params.put("@linkedServer",linkedServer);
        Map<String, Object> resultsMap = super.execute(params);
    	@SuppressWarnings("unchecked")
		List<IBWeblog> rtnList = (List<IBWeblog>) resultsMap.get("rs");
        return rtnList;
    }

}
