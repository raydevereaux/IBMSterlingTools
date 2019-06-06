package com.bc.sterling.service.dao.sproc;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.jdbc.core.RowMapper;

import com.bc.sterling.base.dao.MSSQLBaseStoredProcedure;
import com.bc.user.bean.integrationbroker.IBWebNotify;

public class OracleWebNotifyList_sql extends MSSQLBaseStoredProcedure {

	public OracleWebNotifyList_sql(DataSource ds) {
		super(ds);
	}
	
    public List<IBWebNotify> execute(String linkedServer, String userId) {

    	String sql =""
    				+"select '"+linkedServer+"' as server"
    	    		+",BC_NOTIFY_REFID"
    	    		+",BC_NOTIFY_ITEM"
    				+",BC_GROUPNAME"
    				+",BC_EMAIL_ADDR"
    				+",BC_EXECSTATUS"
    				+",BC_CREATE_JTIME"
    				+" from SYSADM.PS_BC_IB_WEBNOTIFY";
    		sql = sql+" where 1 = 1 ";
    		sql = sql+" order by BC_NOTIFY_REFID ";

    	List<IBWebNotify> rtnList = getJdbcTemplate().query(sql, new Object[] {}, new RowMapper<IBWebNotify>(){
		public IBWebNotify mapRow(ResultSet rs, int line) throws SQLException {
				IBWebNotify bean = new IBWebNotify();
				bean.serverDomain = rs.getString("server");
				bean.BC_NOTIFY_REFID = rs.getString("BC_NOTIFY_REFID");
				bean.BC_NOTIFY_ITEM = rs.getString("BC_NOTIFY_ITEM");
				bean.BC_GROUPNAME = rs.getString("BC_GROUPNAME");
				bean.BC_EMAIL_ADDR = rs.getString("BC_EMAIL_ADDR");
				bean.BC_EXECSTATUS = rs.getString("BC_EXECSTATUS");
				bean.BC_CREATE_JTIME = rs.getString("BC_CREATE_JTIME");
    			return bean;
    		}
		});
        return rtnList;
 }
	


}
