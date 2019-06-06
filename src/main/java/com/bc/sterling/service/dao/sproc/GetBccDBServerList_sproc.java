package com.bc.sterling.service.dao.sproc;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.sql.DataSource;

import org.json.JSONObject;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.core.SqlReturnResultSet;

import com.bc.sterling.base.dao.MSSQLBaseStoredProcedure;
import com.bc.user.bean.sterling.MailboxInfo;

public class GetBccDBServerList_sproc extends MSSQLBaseStoredProcedure {

	private static final SimpleDateFormat df = new SimpleDateFormat("MM/dd/yyyy.HH.mm.ss.hhh");;
	protected static final String SPROC_NAME = "dbo.GetBccDBServerList";
	/**
	 * @param ds
	 */ 
	public GetBccDBServerList_sproc(DataSource ds) {
		super(ds);
        setSql(SPROC_NAME);

        declareParameter(new SqlParameter("@userId", Types.VARCHAR));
		declareParameter(new SqlReturnResultSet("rs", new RowMapper<Map<String, String>>() {

			@Override
			public Map<String, String> mapRow(ResultSet rs, int rowNum) throws SQLException {
				Map<String, String> ba = new TreeMap<String,String>();
				ba.put("refId",rs.getString("refId")); 
				ba.put("server",rs.getString("server")); 
				ba.put("dbInstance",rs.getString("dbInstance"));
				ba.put("jdbcType",rs.getString("jdbcType"));
				ba.put("createTimestamp",df.format(rs.getDate("createTimestamp")));

				return ba;
			}
			
		}
				
		));
        this.compile();
	}
	
    public List<Map<String, String>> execute(String userId) {

        Map<String, Object> resultsMap = super.execute(userId);
        @SuppressWarnings("unchecked")
        List<Map<String, String>> rs = (List<Map<String, String>>) resultsMap.get("rs");
        
        return rs;
 }
	


}
