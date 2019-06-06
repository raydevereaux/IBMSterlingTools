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
import com.bc.user.bean.sterling.MailboxInfo;

public class GetMailboxInfoList_sproc extends MSSQLBaseStoredProcedure {

	private static final SimpleDateFormat dF = new SimpleDateFormat("MM/dd/yyyy");
	private static final SimpleDateFormat dbF = new SimpleDateFormat("yyyy-MM-dd");
	protected static final String SPROC_NAME = "dbo.GetMailboxInfoList";
	/**
	 * @param ds
	 */ 
	public GetMailboxInfoList_sproc(DataSource ds) {
		super(ds);
        setSql(SPROC_NAME);

        declareParameter(new SqlParameter("@userId", Types.VARCHAR));
		declareParameter(new SqlReturnResultSet("rs", new RowMapper<MailboxInfo>() {

			@Override
			public MailboxInfo mapRow(ResultSet rs, int rowNum) throws SQLException {
				MailboxInfo ba = new MailboxInfo();
				ba.setMailboxId(rs.getInt("mailboxId")); 
				ba.setMailboxName(rs.getString("mailboxName")); 
				ba.setInOut(rs.getString("inOut"));
				ba.setCreateTimestamp(rs.getDate("createTimestamp")); 

				return ba;
			}
			
		}
				
		));
        this.compile();
	}
	
    public List<MailboxInfo> execute(String userId) {

        Map<String, Object> resultsMap = super.execute(userId);        
    	@SuppressWarnings("unchecked")
		List<MailboxInfo> baList = (List<MailboxInfo>) resultsMap.get("rs");
        return baList;
 }
	


}
