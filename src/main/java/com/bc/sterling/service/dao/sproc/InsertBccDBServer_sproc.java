package com.bc.sterling.service.dao.sproc;

import java.sql.Types;
import java.text.SimpleDateFormat;
import java.util.Map;

import javax.sql.DataSource;

import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;

import com.bc.sterling.base.dao.MSSQLBaseStoredProcedure;
import com.bc.user.bean.sterling.MailboxInfo;

public class InsertBccDBServer_sproc extends MSSQLBaseStoredProcedure {
	private static final SimpleDateFormat df = new SimpleDateFormat("MM/dd/yyyy");
    protected static final String SPROC_NAME = "dbo.InsertBccDBServer";

    public InsertBccDBServer_sproc(DataSource ds) {
          super(ds);
          setSql(SPROC_NAME);
          
          declareParameter(new SqlOutParameter("@refId",Types.INTEGER));
          declareParameter(new SqlParameter("@server",Types.VARCHAR));   
          declareParameter(new SqlParameter("@dbInstance",Types.VARCHAR));  
          declareParameter(new SqlParameter("@jdbcType",Types.VARCHAR));           
          declareParameter(new SqlParameter("@userId",Types.VARCHAR));

          this.compile();
    }

    public Integer execute(JSONObject json, String userId) throws JSONException {
    	Map<String, Object> params = this.getInputParamsMap();

		String server     = json.getString("server");
		String dbInstance = json.getString("dbInstance");
		String jdbcType   = json.getString("jdbcType");
        params.put("@server",server);
        params.put("@dbInstance",dbInstance);
        params.put("@jdbcType",jdbcType);
        params.put("@userId",userId);

        Map<String, Object> out = this.execute(params);
        Integer refId = (Integer) out.get("@refId");
        return refId;
    }
}
