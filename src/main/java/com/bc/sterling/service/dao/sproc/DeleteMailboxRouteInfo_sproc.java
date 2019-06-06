package com.bc.sterling.service.dao.sproc;

import java.sql.Types;
import java.text.SimpleDateFormat;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.jdbc.core.SqlParameter;

import com.bc.sterling.base.dao.MSSQLBaseStoredProcedure;
import com.bc.user.bean.sterling.MailboxRouteInfo;

public class DeleteMailboxRouteInfo_sproc extends MSSQLBaseStoredProcedure {
	private static final SimpleDateFormat df = new SimpleDateFormat("MM/dd/yyyy");
    protected static final String SPROC_NAME = "dbo.DeleteMailboxRouteInfo";

    public DeleteMailboxRouteInfo_sproc(DataSource ds) {
          super(ds);
          setSql(SPROC_NAME);
          
          declareParameter(new SqlParameter("@refId",Types.INTEGER));      
          declareParameter(new SqlParameter("@userId",Types.VARCHAR));

          this.compile();
    }

    public Integer execute(Integer refId, String userId) {Map<String, Object> params = this.getInputParamsMap();
          
          params.put("@refId",refId);
          params.put("@userId",userId);

          Map<String, Object> out = this.execute(params);

          return refId;
    }
}
