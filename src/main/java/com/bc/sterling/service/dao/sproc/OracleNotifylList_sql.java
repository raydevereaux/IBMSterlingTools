package com.bc.sterling.service.dao.sproc;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.jdbc.core.RowMapper;

import com.bc.sterling.base.dao.MSSQLBaseStoredProcedure;
import com.bc.user.bean.integrationbroker.IBWebNotify;

public class OracleNotifylList_sql extends MSSQLBaseStoredProcedure {

	public OracleNotifylList_sql(DataSource ds) {
		super(ds);
	}
	
    public List<IBWebNotify> execute(String linkedServer,  String userId) {

    	String sql =""
    				+"select distinct '"+linkedServer+"' as server"
    	    		+",BC_NOTIFY_REFID"
    	    		+",BC_GROUPNAME"
    	    		+"  from PS_BC_IB_WEBNOTIFY"
    	    		+" order by BC_NOTIFY_REFID";
    	List<IBWebNotify> rtnList = getJdbcTemplate().query(sql, new Object[] {}, new RowMapper<IBWebNotify>(){
		public IBWebNotify mapRow(ResultSet rs, int line) throws SQLException {
			IBWebNotify bean = new IBWebNotify();
			bean.serverDomain = rs.getString("server");
			bean.BC_NOTIFY_REFID = rs.getString("BC_NOTIFY_REFID");
			bean.BC_NOTIFY_ITEM = new String();
			bean.BC_GROUPNAME = rs.getString("BC_GROUPNAME");
			bean.BC_EMAIL_ADDR = new String();
			bean.BC_EXECSTATUS  = new String();
			bean.BC_CREATE_JTIME = new String();
			return bean;
		}
		});
        return rtnList;
 }
	


}
