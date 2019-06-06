package com.bc.sterling.service.dao.sproc;

import java.sql.Types;
import java.text.SimpleDateFormat;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;

import com.bc.sterling.base.dao.MSSQLBaseStoredProcedure;
import com.bc.user.bean.sterling.MailboxInfo;

public class InsertMailboxInfo_sproc extends MSSQLBaseStoredProcedure {
	private static final SimpleDateFormat df = new SimpleDateFormat("MM/dd/yyyy");
    protected static final String SPROC_NAME = "dbo.InsertMailboxInfo";

    public InsertMailboxInfo_sproc(DataSource ds) {
          super(ds);
          setSql(SPROC_NAME);
          
          declareParameter(new SqlOutParameter("@mailboxId",Types.INTEGER));
          declareParameter(new SqlParameter("@mailboxName",Types.VARCHAR));          
          declareParameter(new SqlParameter("@userId",Types.VARCHAR));

          this.compile();
    }

    public Integer execute(MailboxInfo mailbox, String userId) {Map<String, Object> params = this.getInputParamsMap();
          
          params.put("@mailboxId",0);
          params.put("@mailboxName",mailbox.mailboxName);
          params.put("@userId",userId);

          Map<String, Object> out = this.execute(params);
          Integer mailboxId = (Integer) out.get("@mailboxId");
          return mailboxId;
    }
}
