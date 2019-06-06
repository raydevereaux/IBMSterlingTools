package com.bc.sterling.service.dao.sproc;

import java.sql.Types;
import java.text.SimpleDateFormat;
import java.util.Map;

import javax.sql.DataSource;

import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.jdbc.core.SqlParameter;

import com.bc.sterling.base.dao.MSSQLBaseStoredProcedure;

public class DeleteBccDBServer_sproc extends MSSQLBaseStoredProcedure {
	private static final SimpleDateFormat df = new SimpleDateFormat("MM/dd/yyyy");
    protected static final String SPROC_NAME = "dbo.DeleteBccDBServer";

    public DeleteBccDBServer_sproc(DataSource ds) {
          super(ds);
          setSql(SPROC_NAME);
          
          declareParameter(new SqlParameter("@refId",Types.INTEGER));
          declareParameter(new SqlParameter("@server",Types.VARCHAR));   
          declareParameter(new SqlParameter("@dbInstance",Types.VARCHAR));  
          declareParameter(new SqlParameter("@jdbcType",Types.VARCHAR));           
          declareParameter(new SqlParameter("@userId",Types.VARCHAR));

          this.compile();
    }

    public void execute(JSONObject json, String userId) throws JSONException {
    	Map<String, Object> params = this.getInputParamsMap();

		Integer refId      = json.getInt("refId");
		String server     = json.getString("server");
		String dbInstance = json.getString("dbInstance");
		String jdbcType   = json.getString("jdbcType");
        params.put("@refId",refId);
        params.put("@server",server);
        params.put("@dbInstance",dbInstance);
        params.put("@jdbcType",jdbcType);
        params.put("@userId",userId);
        this.execute(params);
    }
}
