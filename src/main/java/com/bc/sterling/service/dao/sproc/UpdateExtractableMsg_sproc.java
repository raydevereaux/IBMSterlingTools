package com.bc.sterling.service.dao.sproc;

import java.sql.Types;
import java.text.SimpleDateFormat;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.jdbc.core.SqlParameter;

import com.bc.sterling.base.dao.MSSQLBaseStoredProcedure;

public class UpdateExtractableMsg_sproc extends MSSQLBaseStoredProcedure {
	private static final SimpleDateFormat df = new SimpleDateFormat("MM/dd/yyyy");
	protected static final String SPROC_NAME = "dbo.UpdateExtractableMsg";

	public UpdateExtractableMsg_sproc(DataSource ds) {
		super(ds);
		setSql(SPROC_NAME);

		declareParameter(new SqlParameter("@msgId", Types.INTEGER));
		declareParameter(new SqlParameter("@msgCnt", Types.INTEGER));
		declareParameter(new SqlParameter("@userId", Types.VARCHAR));

		this.compile();
	}

	public void execute(Integer msgId, Integer msgCnt, String userId) {

		Map<String, Object> params = this.getInputParamsMap();

		params.put("@msgId", msgId);
		params.put("@msgCnt", msgCnt);
		params.put("@userId", userId);
		this.execute(params);

	}
}
