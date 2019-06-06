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
import com.bc.user.bean.integrationbroker.IBWebCtrl;

public class OracleWebCtrlList_sproc extends MSSQLBaseStoredProcedure {

	protected static final String SPROC_NAME = "dbo.OracleWebCtrlList_v1";

	public OracleWebCtrlList_sproc(DataSource ds) {
		super(ds);
        setSql(SPROC_NAME);

        declareParameter(new SqlParameter("@userId", Types.VARCHAR));
        declareParameter(new SqlParameter("@linkedServer", Types.VARCHAR));
        declareParameter(new SqlParameter("@senderId", Types.VARCHAR));
        declareParameter(new SqlParameter("@receiverId", Types.VARCHAR));
        declareParameter(new SqlParameter("@docType", Types.VARCHAR));
		declareParameter(new SqlReturnResultSet("rs", new RowMapper<IBWebCtrl>() {

			@Override
			public IBWebCtrl mapRow(ResultSet rs, int rowNum) throws SQLException {
				IBWebCtrl bean = new IBWebCtrl();
				bean.serverDomain = rs.getString("server");
				bean.BC_REFID = rs.getString("BC_REFID");
				bean.BC_SENDERID = rs.getString("BC_SENDERID");
				bean.BC_RECEIVERID = rs.getString("BC_RECEIVERID");
				bean.BC_DOCTYPE = rs.getString("BC_DOCTYPE");
				bean.BC_EXECTYPE = rs.getString("BC_EXECTYPE");
				bean.BC_EXECSTATUS = rs.getString("BC_EXECSTATUS");
				bean.BC_EXECOBJNAME = rs.getString("BC_EXECOBJNAME");
				bean.BC_CTRL_SEQCHECK = rs.getString("BC_CTRL_SEQCHECK");
				bean.BC_CTRL_SEQNUMBER = rs.getString("BC_CTRL_SEQNUMBER");
				bean.BC_NOTIFY_REFID = rs.getString("BC_NOTIFY_REFID");
				bean.BC_REPLYTYPE = rs.getString("BC_REPLYTYPE");
				bean.BC_RESTRICT_ACCESS = rs.getString("BC_RESTRICT_ACCESS");
				bean.BC_CREATE_JTIME = rs.getString("BC_CREATE_JTIME");
				return bean;
			}
			
		}
				
		));
        this.compile();
	}
	
    public List<IBWebCtrl> execute(String serverDomain, String senderId, String receiverId, String docType, String userId) {

    	Map<String, Object> params = this.getInputParamsMap();
        params.put("@userId",userId);
        params.put("@linkedServer",serverDomain);
        params.put("@senderId", senderId);
        params.put("@receiverId",receiverId);
        params.put("@docType",docType);
        Map<String, Object> resultsMap = super.execute(params);         
    	@SuppressWarnings("unchecked")
		List<IBWebCtrl> rtnList = (List<IBWebCtrl>) resultsMap.get("rs");
        return rtnList;
 }
	


}
