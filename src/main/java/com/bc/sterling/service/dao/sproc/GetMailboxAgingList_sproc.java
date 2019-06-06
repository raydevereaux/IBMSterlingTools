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
import com.bc.user.bean.sterling.MailboxAgingInfo;

public class GetMailboxAgingList_sproc extends MSSQLBaseStoredProcedure {

	private static final SimpleDateFormat dF = new SimpleDateFormat("MM/dd/yyyy");
	private static final SimpleDateFormat tF = new SimpleDateFormat("MM/dd/yyyy HH.mm.ss.SSS");
	protected static final String SPROC_NAME = "dbo.GetMailboxAgingList";
	/**
	 * @param ds
	 */ 
	public GetMailboxAgingList_sproc(DataSource ds) {
		super(ds);
        setSql(SPROC_NAME);

        declareParameter(new SqlParameter("@userId", Types.VARCHAR));
		declareParameter(new SqlReturnResultSet("rs", new RowMapper<MailboxAgingInfo>() {

			@Override
			public MailboxAgingInfo mapRow(ResultSet rs, int rowNum) throws SQLException {
				MailboxAgingInfo bean = new MailboxAgingInfo();
				bean.setMessageId(rs.getInt("MESSAGE_ID"));
				bean.setMessageName(rs.getString("msgName"));
				bean.setExtCount(rs.getInt("extCount"));
				bean.setMailboxName(rs.getString("mailboxName"));
				bean.setMessageTimestamp(rs.getTimestamp("messageTimeStamp"));
				bean.setMessageFmtTimestamp(tF.format(bean.messageTimestamp));
				bean.setUserId(rs.getString("userId"));
				bean.setAgedTotal(rs.getInt("agedTotal"));
				bean.setAgedMins(rs.getInt("agedMins"));
				bean.setAgedHours(rs.getInt("agedHours"));
				bean.setAgedDays(rs.getInt("agedDays"));
				bean.setRuleProc(rs.getString("ruleProc"));

				return bean;
			}
			
		}
				
		));
        this.compile();
	}
	
    public List<MailboxAgingInfo> execute(String userId) {

        Map<String, Object> resultsMap = super.execute(userId);        
    	@SuppressWarnings("unchecked")
		List<MailboxAgingInfo> baList = (List<MailboxAgingInfo>) resultsMap.get("rs");
        return baList;
 }
	


}
