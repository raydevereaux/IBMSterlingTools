package com.bc.sterling.service.dao.sproc;

import java.sql.Types;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.jdbc.core.SqlParameter;

import com.bc.sterling.base.dao.MSSQLBaseStoredProcedure;

public class OracleUpdateWeblog_sproc extends MSSQLBaseStoredProcedure {

	protected static final String SPROC_NAME = "dbo.OracleUpdateWeblog";

	public OracleUpdateWeblog_sproc(DataSource ds) {
		super(ds);
		setSql(SPROC_NAME);

		declareParameter(new SqlParameter("@refId", Types.VARCHAR));
		declareParameter(new SqlParameter("@userId", Types.VARCHAR));

		this.compile();
	}

	public void execute(Integer refId, String status, String userId) {

		Map<String, Object> params = this.getInputParamsMap();

		params.put("@refId", refId);
		params.put("@userId", userId);
        Map<String, Object> out = this.execute(params);

	}

}
