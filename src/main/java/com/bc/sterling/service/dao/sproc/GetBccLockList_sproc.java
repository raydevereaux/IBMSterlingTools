package com.bc.sterling.service.dao.sproc;

import java.io.File;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.core.SqlReturnResultSet;

import com.bc.sterling.base.dao.MSSQLBaseStoredProcedure;
import com.bc.user.bean.sterling.LockData;

public class GetBccLockList_sproc extends MSSQLBaseStoredProcedure {

	protected static final String SPROC_NAME = "dbo.GetBccLockList";
	public static SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy.HH.mm.ss.hhh");

	public GetBccLockList_sproc(DataSource ds) {
		super(ds);
        setSql(SPROC_NAME);

        declareParameter(new SqlParameter("@delay", Types.VARCHAR));
		declareParameter(new SqlReturnResultSet("rs", new RowMapper<LockData>() {

			@Override
			public LockData mapRow(ResultSet rs, int rowNum) throws SQLException {
				LockData bean = new LockData();
				bean.refId = rs.getString("refId");
				bean.itemName = rs.getString("itemName");
				bean.userName = rs.getString("userName");
				bean.absTimestamp = sdf.format(new Date(rs.getLong("absTimestamp"))); //rs.getString("absTimestamp");
				bean.timeout = rs.getString("timeout");
				bean.systemName = rs.getString("systemName");
				bean.clearOnStartup = rs.getString("clearOnStartup");
				bean.reviewed = rs.getString("reviewed");
				bean.createTimestamp = rs.getTimestamp("createTimestamp");

				return bean;
			}
			
		}
				
		));
        this.compile();
	}
	
    public List<LockData> execute(String userId) {

    	Map<String, Object> params = this.getInputParamsMap();
        params.put("@delay","0");
        Map<String, Object> resultsMap = super.execute(params);         
    	@SuppressWarnings("unchecked")
		List<LockData> rtnList = (List<LockData>) resultsMap.get("rs");
        return rtnList;
 }
	


}
