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

public class GetDbUrl_sproc extends MSSQLBaseStoredProcedure {

	private static final SimpleDateFormat dF = new SimpleDateFormat("MM/dd/yyyy");
	private static final SimpleDateFormat dbF = new SimpleDateFormat("yyyy-MM-dd");
	protected static final String SPROC_NAME = "dbo.GetDbUrl";
	/**
	 * @param ds
	 */ 
	public GetDbUrl_sproc(DataSource ds) {
		super(ds);
        setSql(SPROC_NAME);

        declareParameter(new SqlParameter("@userId", Types.VARCHAR));
		declareParameter(new SqlReturnResultSet("rs", new RowMapper<String>() {

			@Override
			public String mapRow(ResultSet rs, int rowNum) throws SQLException {
				String dbServer = rs.getString("dbServerName"); 

				return dbServer;
			}
			
		}
				
		));
        this.compile();
	}
	
    public String execute(String userId) {

        Map<String, Object> resultsMap = super.execute(userId);        
    	@SuppressWarnings("unchecked")
		List<String> baList = (List<String>) resultsMap.get("rs");
        return baList.get(0);
 }
	


}
