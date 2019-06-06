package com.bc.sterling.service.dao.sproc;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.jdbc.core.RowMapper;

import com.bc.sterling.base.dao.MSSQLBaseStoredProcedure;
import com.bc.user.bean.integrationbroker.IBWebCtrl;

public class OracleWebCtrlList_sql extends MSSQLBaseStoredProcedure {

	public OracleWebCtrlList_sql(DataSource ds) {
		super(ds);
	}
	
    public List<IBWebCtrl> execute(String linkedServer, String senderId, String receiverId, String docType, String userId) {

    	String sql =""
    				+"select distinct '"+linkedServer+"' as server"
    				+",a.BC_REFID"
    				+",a.BC_SENDERID"
    				+",a.BC_RECEIVERID"
    				+",a.BC_DOCTYPE"
    				+",a.BC_EXECTYPE"
    				+",a.BC_EXECSTATUS"
    				+",a.BC_EXECOBJNAME"
    				+",a.BC_CTRL_SEQCHECK"
    				+",a.BC_CTRL_SEQNUMBER"
    				+",a.BC_NOTIFY_REFID"
    				+",a.BC_REPLYTYPE"
    				+",a.BC_RESTRICT_ACCESS"
    				+",a.BC_CREATE_JTIME";
    			sql = sql+ ",b.BC_GROUPNAME";
    			sql = sql+" from SYSADM.PS_BC_IB_WEBCTRL a";
    			sql = sql+"  LEFT OUTER JOIN SYSADM.PS_BC_IB_WEBNOTIFY b";
    			sql = sql+"    ON a.BC_NOTIFY_REFID = b.BC_NOTIFY_REFID";
    		sql = sql+" where 1 = 1 "
                ;
    	if (senderId!=null&&senderId.trim().length()>0) {sql = sql+" and BC_SENDERID = '"+senderId+"' ";}
    	if (receiverId!=null&&receiverId.trim().length()>0) {sql = sql+" and BC_RECEIVERID = '"+receiverId+"' ";}
    	if (docType!=null&&docType.trim().length()>0) {sql = sql+" and BC_DOCTYPE = '"+docType+"' ";}
    	sql = sql+" order by BC_REFID, BC_SENDERID, BC_RECEIVERID, BC_DOCTYPE";
    	//System.out.println(sql);
    	List<IBWebCtrl> rtnList = getJdbcTemplate().query(sql, new Object[] {}, new RowMapper<IBWebCtrl>(){
		public IBWebCtrl mapRow(ResultSet rs, int line) throws SQLException {
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
				bean.BC_GROUPNAME = rs.getString("BC_GROUPNAME");
				if (bean.BC_GROUPNAME==null||bean.BC_GROUPNAME.trim().length()==0) {
    				bean.BC_GROUPNAME = "----";
				}
    			return bean;
    		}
		});
        return rtnList;
 }
	


}
