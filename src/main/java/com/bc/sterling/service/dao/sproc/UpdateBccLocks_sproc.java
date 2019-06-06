package com.bc.sterling.service.dao.sproc;

import java.sql.Types;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;

import com.bc.sterling.base.dao.MSSQLBaseStoredProcedure;

public class UpdateBccLocks_sproc extends MSSQLBaseStoredProcedure {

	protected static final String SPROC_NAME = "dbo.UpdateBccLocks";

	public UpdateBccLocks_sproc(DataSource ds) {
		super(ds);
		setSql(SPROC_NAME);

		declareParameter(new SqlParameter("@refId", Types.VARCHAR));
        declareParameter(new SqlOutParameter("@status", Types.VARCHAR));
		declareParameter(new SqlParameter("@userId", Types.VARCHAR));

		this.compile();
	}

	public String execute(String refId, String userId) {

		Map<String, Object> params = this.getInputParamsMap();

		params.put("@refId", refId);
		params.put("@userId", userId);
        Map<String, Object> out = this.execute(params);
        String status = (String) out.get("@status");

        return status;
	}

}
