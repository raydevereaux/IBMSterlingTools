package com.bc.sterling.service.dao.sproc;

import java.sql.Types;
import java.text.SimpleDateFormat;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;

import com.bc.sterling.base.dao.MSSQLBaseStoredProcedure;
import com.bc.user.bean.sterling.MailboxRouteInfo;

public class InsertMailboxRouteInfo_sproc extends MSSQLBaseStoredProcedure {
	private static final SimpleDateFormat df = new SimpleDateFormat("MM/dd/yyyy");
    protected static final String SPROC_NAME = "dbo.InsertMailboxRouteInfo";

    public InsertMailboxRouteInfo_sproc(DataSource ds) {
          super(ds);
          setSql(SPROC_NAME);

		declareParameter(new SqlOutParameter("@refId", Types.INTEGER));
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

    public Integer execute(MailboxRouteInfo route, String userId) {Map<String, Object> params = this.getInputParamsMap();
          
          params.put("@refId",0);
          params.put("@fileTemplate",route.fileTemplate);
          if (route.nameTemplate==null||route.nameTemplate.trim().length()==0) {
			params.put("@nameTemplate", null);
          } else {
			params.put("@nameTemplate", route.nameTemplate);
          }
          params.put("@mailboxId",route.mailboxId);
          params.put("@groupId",route.groupId);
          params.put("@busCode",route.busCode);
          params.put("@logging",route.logging);
          params.put("@fileTrace",route.fileTrace);
          params.put("@docType",route.docType);
          params.put("@mapName",route.mapName);
          params.put("@bpName",route.bpName);
          params.put("@eMailDest",route.eMailDest);
          params.put("@subject",route.subject);
          params.put("@dfDirIO",route.dfDirIO);
          params.put("@userId",userId);

          Map<String, Object> out = this.execute(params);
          Integer refId = (Integer) out.get("@refId");
          return refId;
    }
}
