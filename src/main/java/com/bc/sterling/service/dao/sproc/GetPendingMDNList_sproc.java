package com.bc.sterling.service.dao.sproc;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.core.SqlReturnResultSet;

import com.bc.sterling.base.dao.MSSQLBaseStoredProcedure;
import com.bc.user.bean.sterling.MDNData;

public class GetPendingMDNList_sproc extends MSSQLBaseStoredProcedure {

	protected static final String SPROC_NAME = "dbo.GetPendingMDNList";

	public GetPendingMDNList_sproc(DataSource ds) {
		super(ds);
        setSql(SPROC_NAME);

        declareParameter(new SqlParameter("@hostName", Types.VARCHAR));
        declareParameter(new SqlParameter("@procId", Types.VARCHAR));
        declareParameter(new SqlParameter("@procName", Types.VARCHAR));
		declareParameter(new SqlReturnResultSet("rs", new RowMapper<MDNData>() {

			@Override
			public MDNData mapRow(ResultSet rs, int rowNum) throws SQLException {
				MDNData bean = new MDNData();
				bean.mailbox = rs.getString("mailbox");
				bean.partAs2Identifier = rs.getString("partAs2Identifier");
				bean.myAs2Identifier = rs.getString("myAs2Identifier");
				bean.mdnDisp = rs.getString("mdnDisp");
				bean.mdnStatus = rs.getString("mdnStatus");
				bean.contractIn = rs.getString("contractIn");
				bean.contractOut = rs.getString("contractOut");
				bean.createTimestamp = rs.getTimestamp("createTimestamp");

				return bean;
			}
			
		}
				
		));
        this.compile();
	}
	
    public List<MDNData> execute(String userId) {

    	Map<String, Object> params = this.getInputParamsMap();
        params.put("@hostName",userId);
        params.put("@procId","0");
        params.put("@procName","tomcat");
        Map<String, Object> resultsMap = super.execute(params);         
    	@SuppressWarnings("unchecked")
		List<MDNData> rtnList = (List<MDNData>) resultsMap.get("rs");
        return rtnList;
 }
	


}
