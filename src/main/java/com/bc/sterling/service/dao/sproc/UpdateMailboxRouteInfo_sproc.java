package com.bc.sterling.service.dao.sproc;

import java.sql.Types;
import java.text.SimpleDateFormat;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.jdbc.core.SqlParameter;

import com.bc.sterling.base.dao.MSSQLBaseStoredProcedure;
import com.bc.user.bean.sterling.MailboxRouteInfo;

public class UpdateMailboxRouteInfo_sproc extends MSSQLBaseStoredProcedure {
	private static final SimpleDateFormat df = new SimpleDateFormat("MM/dd/yyyy");
	protected static final String SPROC_NAME = "dbo.UpdateMailboxRouteInfo";

	public UpdateMailboxRouteInfo_sproc(DataSource ds) {
		super(ds);
		setSql(SPROC_NAME);

		declareParameter(new SqlParameter("@refId", Types.INTEGER));
		declareParameter(new SqlParameter("@fileTemplate", Types.VARCHAR));
		declareParameter(new SqlParameter("@nameTemplate", Types.VARCHAR));
		declareParameter(new SqlParameter("@mailboxId", Types.INTEGER));
		declareParameter(new SqlParameter("@groupId", Types.INTEGER));
		declareParameter(new SqlParameter("@busCode", Types.VARCHAR));
		declareParameter(new SqlParameter("@logging", Types.VARCHAR));
		declareParameter(new SqlParameter("@fileTrace", Types.VARCHAR));
		declareParameter(new SqlParameter("@docType", Types.CHAR));
		declareParameter(new SqlParameter("@mapName", Types.VARCHAR));
		declareParameter(new SqlParameter("@bpName", Types.VARCHAR));
		declareParameter(new SqlParameter("@eMailDest", Types.VARCHAR));
		declareParameter(new SqlParameter("@subject", Types.VARCHAR));
		declareParameter(new SqlParameter("@dfDirIO", Types.VARCHAR));

		declareParameter(new SqlParameter("@userId", Types.VARCHAR));

		this.compile();
	}

	public void execute(MailboxRouteInfo log, String userId) {

		Map<String, Object> params = this.getInputParamsMap();

		params.put("@refId", log.refId);
		params.put("@fileTemplate", log.fileTemplate);
		if (log.nameTemplate==null||log.nameTemplate.trim().length()==0) {
			params.put("@nameTemplate", null);
		} else {
			params.put("@nameTemplate", log.nameTemplate);
		}
		params.put("@mailboxId", log.mailboxId);
		params.put("@groupId", log.groupId);
		params.put("@busCode", log.busCode);
		params.put("@logging", log.logging);
		params.put("@fileTrace", log.fileTrace);
		params.put("@docType", log.docType);
        params.put("@mapName",log.mapName);
        params.put("@bpName",log.bpName);
        params.put("@eMailDest",log.eMailDest);
        params.put("@subject",log.subject);
        params.put("@dfDirIO",log.dfDirIO);
		params.put("@userId", userId);
		this.execute(params);

	}
}
