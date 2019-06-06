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

public class SBIFileProcessRouteMapping_sproc extends MSSQLBaseStoredProcedure {

	private static final SimpleDateFormat dF = new SimpleDateFormat("MM/dd/yyyy");
	private static final SimpleDateFormat dbF = new SimpleDateFormat("yyyy-MM-dd");
	protected static final String SPROC_NAME = "dbo.SBIFileProcessRouteMappingV1";
	/**
	 * @param ds
	 */ 
	public SBIFileProcessRouteMapping_sproc(DataSource ds) {
		super(ds);
        setSql(SPROC_NAME);

        declareParameter(new SqlParameter("@hostName",Types.VARCHAR));
        declareParameter(new SqlParameter("@busProcId",Types.VARCHAR));
        declareParameter(new SqlParameter("@busProcName",Types.VARCHAR));
        declareParameter(new SqlParameter("@srcMailbox",Types.VARCHAR));
        declareParameter(new SqlParameter("@filename",Types.VARCHAR));   
        declareParameter(new SqlParameter("@filesize",Types.VARCHAR));  
        declareParameter(new SqlParameter("@isaData",Types.VARCHAR));  
        declareParameter(new SqlParameter("@seqNo",Types.VARCHAR));  
		declareParameter(new SqlReturnResultSet("rs", new RowMapper<MailboxRouteRequest>() {

			@Override
			public MailboxRouteRequest mapRow(ResultSet rs, int rowNum) throws SQLException {
				MailboxRouteRequest ba = new MailboxRouteRequest();
				ba.setFileTemplate(rs.getString("fileTemplate")); 
				ba.setMailboxName(rs.getString("targetMailbox"));
				ba.nameTemplate = rs.getString("nameTemplate");
				ba.mapName = rs.getString("mapName");
				ba.setBusProcName(rs.getString("targetBPName"));
				ba.targetBPParm = rs.getString("targetBPParm");
				ba.setTargetFilename(rs.getString("targetFilename"));
				ba.eMailDest = rs.getString("eMailDest");

				ba.setBusProcParm(rs.getString("targetBPParm"));
				return ba;
			}
			
		}
				
		));
        this.compile();
	}
	
    public List<MailboxRouteRequest> execute(MailboxRouteRequest req, String userId) {

    	Map<String, Object> params = this.getInputParamsMap();
        params.put("@hostName",req.hostName);
        params.put("@busProcId",req.busProcId);
        params.put("@busProcName",req.busProcName);
        params.put("@srcMailbox",req.srcMailbox);
        params.put("@filename",req.fileName);
        params.put("@filesize",0);
        params.put("@isaData","send.recv.doc.cntl.t.r1,r2,r3");
        params.put("@seqNo","98");
        Map<String, Object> resultsMap = super.execute(params);        
    	@SuppressWarnings("unchecked")
		List<MailboxRouteRequest> rsList = (List<MailboxRouteRequest>) resultsMap.get("rs");
        return rsList;
 }
	


}
