package com.bc.sterling.service.impl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import com.bc.sterling.service.DatabaseService;
import com.bc.sterling.service.dao.SterlingDao;

@org.springframework.context.annotation.Lazy
@Component("databaseService")
public class DatabaseServiceImpl implements DatabaseService {

	public String version = System.getProperty("java.version");

	@Autowired
	@Qualifier("sterlingPrdDao")
	private SterlingDao sterlingPrdDao;
	
	public static void main(String[] args) throws SQLException {
		mainDb2();
	}

    public static void mainDb2() throws SQLException {

        try { 
            //Class.forName("com.ibm.db2.jdbc.app.DB2Driver");
            Class.forName("com.ibm.db2.jcc.DB2Driver");
        	String dbURL = "jdbc:db2:boslxdb04t.bc.com:50001:momd"; 
        	dbURL = "Server=boslxdb04t:50001;Database=momd;UID=webfocus;PWD=O2b4Tagain;CurrentSchema=momd;"; 
        	String strUserID = "webfocus";
        	String strPassword = "O2b4Tagain";

            //Connection myConnection=DriverManager.getConnection(dbURL,strUserID,strPassword);
            Connection myConnection=DriverManager.getConnection(dbURL); //),strUserID,strPassword);

            Statement sqlStatement = myConnection.createStatement();
            String sql = "select current timestamp as timestamp from sysibm.sysdummy1 ";  
            ResultSet myResultSet = sqlStatement.executeQuery(sql);
            while (myResultSet.next()) {
                System.out.println("mainDb2 " + myResultSet.getString(1));
            }
            myResultSet.close();
            myConnection.close();

        } catch (Exception e) {
            System.out.println(e);
        }       
    }
	
    public static void mainMySql() throws SQLException {

        try { 
        	String dbURL = "jdbc:mysql://bouxmysql2:50012/itop?autoReconnect=true&useSSL=false";
        	String strUserID = "mySql";
        	String strPassword = "admin1MySQL";

            Connection myConnection=DriverManager.getConnection(dbURL,strUserID,strPassword);

            Statement sqlStatement = myConnection.createStatement();
            String sql = "Select NOW() ";  
            ResultSet myResultSet = sqlStatement.executeQuery(sql);
            while (myResultSet.next()) {
                System.out.println("mainMySql " + myResultSet.getString(1));
            }
            myResultSet.close();
            myConnection.close();

        } catch (Exception e) {
            System.out.println(e);
        }       
    }

    public static void mainOracle() throws SQLException {

        try { 
//String dbURL = "jdbc:oracle:thin:@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=bouxdora02.bc.com)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=HTST)))";
String dbURL = "jdbc:oracle:thin:@(DESCRIPTION= (ADDRESS=(PROTOCOL=tcp)(HOST=bouxdora02.bc.com)(PORT=1521)) (CONNECT_DATA=(SID=HTST)))";
String strUserID = "IB_OQ";
String strPassword = "B01se17";

            Connection myConnection=DriverManager.getConnection(dbURL,strUserID,strPassword);

            Statement sqlStatement = myConnection.createStatement();
            String sql = "Select sysdate from DICTIONARY where rownum < 2 ";  
            ResultSet myResultSet = sqlStatement.executeQuery(sql);
            while (myResultSet.next()) {
                System.out.println("mainOracle " + myResultSet.getString(1));
            }
            myResultSet.close();
            myConnection.close();

        } catch (Exception e) {
            System.out.println(e);
        }       
    }    
    public static void mainSqlServer() {

        // Create a variable for the connection string.
        String connectionUrl = "jdbc:sqlserver://bosdsql14.bc.com:1433;databaseName=b2bbcstat;user=SIadmin;password=SIadmin$07";
		
        String sql = "SELECT top 1 getDate() as curDate";

		Connection conn = null;
		Statement stmt  = null;
		ResultSet rset  = null;
		try {
			conn = DriverManager.getConnection(connectionUrl);
			stmt = conn.createStatement();
			rset = stmt.executeQuery(sql);
			while (rset.next()) {
				System.out.println("mainSqlServer "+rset.getString(1));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {rset.close();} catch (SQLException e) {}
			try {stmt.close();} catch (SQLException e) {}
			try {conn.close();} catch (SQLException e) {}
		}
	}
  
    @Override
	public Map<String,String> getDBServerData(String type, String server, String schema, String dbUser, String dbPass) {
    	Map<String,String> rtnMap = new TreeMap<String,String>();

 		if ("jdbc:sqlserver".equalsIgnoreCase(type)) {
 			rtnMap = getMSSqlServerList(server, schema, dbUser, dbPass);
 		} else if ("jdbc:oracle:thin".equalsIgnoreCase(type)) {
 			rtnMap = getOracleList(server, schema, dbUser, dbPass);
 		} else if ("jdbc:db2".equalsIgnoreCase(type)) {
 			rtnMap = getDB2List(server, schema, dbUser, dbPass);
 		} else if ("jdbc:mySql".equalsIgnoreCase(type)) {
 			rtnMap = getMySqlList(server, schema, dbUser, dbPass);
 		}
		
    	return rtnMap;
    }
	@Override
	public Map<String,String> getMSSqlServerList(String server, String schema, String dbUser, String dbPass) {

        String connectionUrl = "jdbc:sqlserver://"+server+";databaseName="+schema;
		String defaultSQL = "SELECT getDate() as curDate";

		Connection conn = null;
		Statement stmt  = null;
		ResultSet rset  = null;
		Map<String,String> rtnMap = new TreeMap<String,String>();
		rtnMap.put("connection", connectionUrl);
		rtnMap.put("execSql", defaultSQL);
		rtnMap.put("userId", dbUser);
		try {
			conn = DriverManager.getConnection(connectionUrl, dbUser, dbPass);
			stmt = conn.createStatement();
			rset = stmt.executeQuery(defaultSQL);
			while (rset.next()) {
				rtnMap.put("result", rset.getString(1));
			}
			rtnMap.put("status","pass");
			rtnMap.put("SQLException","none");
		} catch (SQLException e) {
			rtnMap.put("status","fail");
			rtnMap.put("SQLException",e.getMessage());
			return rtnMap;
		} finally {
			if (rset!=null) {try {rset.close();} catch (SQLException e) {}}
			if (stmt!=null) {try {stmt.close();} catch (SQLException e) {}}
			if (conn!=null) {try {conn.close();} catch (SQLException e) {}}
		}

		return rtnMap;
	}

	@Override
	public Map<String,String> getOracleList(String server, String schema, String dbUser, String dbPass) {

		String connectionUrl = "jdbc:oracle:thin:@(DESCRIPTION= (ADDRESS=(PROTOCOL=tcp)(HOST="+server+")(PORT=1521)) (CONNECT_DATA=(SID="+schema+")))";
        String defaultSQL = "select current_timestamp FROM DUAL";
        
		Connection conn = null;
		Statement stmt  = null;
		ResultSet rset  = null;
		Map<String,String> rtnMap = new TreeMap<String,String>();
		rtnMap.put("connection", connectionUrl);
		rtnMap.put("execSql", defaultSQL);
		rtnMap.put("userId", dbUser);
		try {
			conn = DriverManager.getConnection(connectionUrl,dbUser,dbPass);
			stmt = conn.createStatement();
			rset = stmt.executeQuery(defaultSQL);
			while (rset.next()) {
				rtnMap.put("result", rset.getString(1));
			}
			rtnMap.put("status","pass");
			rtnMap.put("SQLException","none");
		} catch (SQLException e) {
			rtnMap.put("status","fail");
			rtnMap.put("SQLException",e.getMessage());
			return rtnMap;
		} finally {
			if (rset!=null) {try {rset.close();} catch (SQLException e) {}}
			if (stmt!=null) {try {stmt.close();} catch (SQLException e) {}}
			if (conn!=null) {try {conn.close();} catch (SQLException e) {}}
		}

		return rtnMap;

    }
	@Override
	public Map<String,String> getDB2List(String server, String schema, String dbUser, String dbPass) {

		String connectionUrl = "jdbc:db2://"+server+"/"+schema;
		String defaultSQL = "Select current timestamp as timestamp from sysibm.sysdummy1"; 

		Connection conn = null;
		Statement stmt  = null;
		ResultSet rset  = null;
		Map<String,String> rtnMap = new TreeMap<String,String>();
		rtnMap.put("connection", connectionUrl);
		rtnMap.put("execSql", defaultSQL);
		rtnMap.put("userId", dbUser);
		try {
			conn = DriverManager.getConnection(connectionUrl,dbUser,dbPass);
			stmt = conn.createStatement();
			rset = stmt.executeQuery(defaultSQL);
			while (rset.next()) {
				rtnMap.put("result", rset.getString(1));
			}
			rtnMap.put("status","pass");
			rtnMap.put("SQLException","none");
		} catch (SQLException e) {
			rtnMap.put("status","fail");
			rtnMap.put("SQLException",e.getMessage());
			return rtnMap;
		} finally {
			if (rset!=null) {try {rset.close();} catch (SQLException e) {}}
			if (stmt!=null) {try {stmt.close();} catch (SQLException e) {}}
			if (conn!=null) {try {conn.close();} catch (SQLException e) {}}
		}

		return rtnMap;
	}

	@Override
	public Map<String,String> getMySqlList(String server, String schema, String dbUser, String dbPass) {
		String connectionUrl = "jdbc:mysql://"+server+"/"+schema+"?useSSL=false";
        String defaultSQL = "Select now();"; 

		Connection conn = null;
		Statement stmt  = null;
		ResultSet rset  = null;
		Map<String,String> rtnMap = new TreeMap<String,String>();
		rtnMap.put("connection", connectionUrl);
		rtnMap.put("execSql", defaultSQL);
		rtnMap.put("userId", dbUser);
		try {
			conn = DriverManager.getConnection(connectionUrl,dbUser,dbPass);
			stmt = conn.createStatement();
			rset = stmt.executeQuery(defaultSQL);
			while (rset.next()) {
				rtnMap.put("result", rset.getString(1));
			}
			rtnMap.put("status","pass");
			rtnMap.put("SQLException","none");
		} catch (SQLException e) {
			rtnMap.put("status","fail");
			rtnMap.put("SQLException",e.getMessage());
			return rtnMap;
		} finally {
			if (rset!=null) {try {rset.close();} catch (SQLException e) {}}
			if (stmt!=null) {try {stmt.close();} catch (SQLException e) {}}
			if (conn!=null) {try {conn.close();} catch (SQLException e) {}}
		}

		return rtnMap;
	}

	@Override
	public  Map<String,String> updateServerList(JSONObject json, String userId) {
		Map<String,String> rtnMap = new TreeMap<String,String>();
		rtnMap = sterlingPrdDao.processDBServer(json, userId);
		return rtnMap;
	}

	@Override
	public List<Map<String, String>> getServerList(String userId) {
		List<Map<String, String>> rtnMap = sterlingPrdDao.getBccDBServer(userId);
		return rtnMap;
	}

}
