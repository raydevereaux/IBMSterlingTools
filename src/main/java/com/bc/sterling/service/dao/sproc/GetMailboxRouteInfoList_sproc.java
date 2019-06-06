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
import com.bc.user.bean.sterling.MailboxRouteInfo;

public class GetMailboxRouteInfoList_sproc extends MSSQLBaseStoredProcedure {

	private static final SimpleDateFormat dF = new SimpleDateFormat("MM/dd/yyyy");
	private static final SimpleDateFormat dbF = new SimpleDateFormat("yyyy-MM-dd");
	protected static final String SPROC_NAME = "dbo.GetMailboxRouteInfoList";
	/**
	 * @param ds
	 */ 
	public GetMailboxRouteInfoList_sproc(DataSource ds) {
		super(ds);
        setSql(SPROC_NAME);

        declareParameter(new SqlParameter("@userId", Types.VARCHAR));
		declareParameter(new SqlReturnResultSet("rs", new RowMapper<MailboxRouteInfo>() {

			@Override
			public MailboxRouteInfo mapRow(ResultSet rs, int rowNum) throws SQLException {
				MailboxRouteInfo ba = new MailboxRouteInfo();
				ba.setRefId(rs.getInt("refId"));
				ba.setFileTemplate(rs.getString("fileTemplate")); 
				if (!ba.getFileTemplate().substring(0, 1).equals("/")) {
					ba.setFileTemplate(rs.getString("fileTemplate").toLowerCase());
				}
				ba.setMailboxId(rs.getInt("mailboxId")); 
				ba.setMailboxName(rs.getString("mailboxName")); 
				ba.setNameTemplate(rs.getString("nameTemplate"));
				ba.setGroupId(rs.getInt("groupId")); 
				ba.setBusCode(rs.getString("busCode"));  
				ba.setDocType(rs.getString("docType"));  
				ba.setLogging(rs.getString("logging"));    
				ba.setFileTrace(rs.getString("fileTrace"));
				ba.setMapName(rs.getString("mapName"));
				ba.setBpName(rs.getString("bpName"));    
				ba.seteMailDest(rs.getString("eMailDest"));  
				ba.setSubject(rs.getString("subject")); 
				ba.setDfDirIO(rs.getString("dfDirIO"));
				ba.setCreateTimestamp(rs.getDate("createTimestamp")); 

				return ba;
			}
			
		}
				
		));
        this.compile();
	}
	
    public List<MailboxRouteInfo> execute(String userId) {

        Map<String, Object> resultsMap = super.execute(userId);        
    	@SuppressWarnings("unchecked")
		List<MailboxRouteInfo> baList = (List<MailboxRouteInfo>) resultsMap.get("rs");
        return baList;
 }
	


}
