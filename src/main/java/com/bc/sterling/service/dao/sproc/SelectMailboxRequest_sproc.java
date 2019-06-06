package com.bc.sterling.service.dao.sproc;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.core.SqlReturnResultSet;

import com.bc.sterling.base.dao.MSSQLBaseStoredProcedure;
import com.bc.user.bean.sterling.MailboxRouteRequest;

public class SelectMailboxRequest_sproc extends MSSQLBaseStoredProcedure {

	private static final SimpleDateFormat dF = new SimpleDateFormat("MM/dd/yyyy");
	private static final SimpleDateFormat dbF = new SimpleDateFormat("yyyy-MM-dd");
	protected static final String SPROC_NAME = "dbo.SelectRoutingInfo";
	/**
	 * @param ds
	 */ 
	public SelectMailboxRequest_sproc(DataSource ds) {
		super(ds);
        setSql(SPROC_NAME);

        declareParameter(new SqlParameter("@hostName",Types.VARCHAR));
        declareParameter(new SqlParameter("@busProcId",Types.VARCHAR));
        declareParameter(new SqlParameter("@busProcName",Types.VARCHAR));
        declareParameter(new SqlParameter("@srcMailbox",Types.VARCHAR));
        declareParameter(new SqlParameter("@filename",Types.VARCHAR));   
        declareParameter(new SqlParameter("@filesize",Types.INTEGER));   
		declareParameter(new SqlReturnResultSet("rs", new RowMapper<MailboxRouteRequest>() {

			@Override
			public MailboxRouteRequest mapRow(ResultSet rs, int rowNum) throws SQLException {
				MailboxRouteRequest ba = new MailboxRouteRequest();
				ba.setFileTemplate(rs.getString("fileTemplate")); 
				ba.setTargetFilename(rs.getString("targetFilename")); 
				ba.setFileName(rs.getString("filename"));  
				ba.setMailboxName(rs.getString("mailboxName"));
				ba.setGroupId(rs.getInt("groupId"));

				return ba;
			}
			
		}
				
		));
        this.compile();
	}
	
    public MailboxRouteRequest execute(MailboxRouteRequest req, String userId) {

    	Map<String, Object> params = this.getInputParamsMap();
        params.put("@hostName",req.hostName);
        params.put("@busProcId",req.busProcId);
        params.put("@busProcName",req.busProcName);
        params.put("@srcMailbox",req.srcMailbox);
        params.put("@filename",req.fileName);
        params.put("@filesize",0);
        Map<String, Object> resultsMap = super.execute(params);        
    	@SuppressWarnings("unchecked")
		List<MailboxRouteRequest> baList = (List<MailboxRouteRequest>) resultsMap.get("rs");
    	MailboxRouteRequest res = baList.size()==0?new MailboxRouteRequest():baList.get(0);
        res.setHostName(req.hostName);
        res.setBusProcId(req.busProcId);
        res.setBusProcName(req.busProcName);
        res.setSrcMailbox(req.srcMailbox);
        res.setFileName(req.fileName);
        return res;
 }
	


}
