package com.bc.user.bean.sterling;

import java.io.Serializable;
import java.util.Date;

public class MailboxInfo implements Serializable {

	private static final long serialVersionUID = 1L;

	public Integer mailboxId;
	public String mailboxName;
	public Date createTimestamp;
	public String inOut;
	public Integer getMailboxId() {
		return mailboxId;
	}
	public void setMailboxId(Integer mailboxId) {
		this.mailboxId = mailboxId;
	}
	public String getMailboxName() {
		return mailboxName;
	}
	public void setMailboxName(String mailboxName) {
		this.mailboxName = mailboxName;
	}
	public Date getCreateTimestamp() {
		return createTimestamp;
	}
	public void setCreateTimestamp(Date createTimestamp) {
		this.createTimestamp = createTimestamp;
	}
	public String getInOut() {
		return inOut;
	}
	public void setInOut(String inOut) {
		this.inOut = inOut;
	}

}
