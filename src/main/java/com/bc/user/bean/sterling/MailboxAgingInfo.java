package com.bc.user.bean.sterling;

import java.io.Serializable;
import java.util.Date;

public class MailboxAgingInfo implements Serializable {

	private static final long serialVersionUID = 1L;

    public Integer messageId;
	public String messageName;
	public String mailboxName;
	public Date messageTimestamp;
	public String messageFmtTimestamp;
    public Integer extCount;
	public String  userId;
    public Integer agedTotal;
    public Integer agedMins;
    public Integer agedHours;
    public Integer agedDays;
    public String ruleProc;

	public Integer getMessageId() {
		return messageId;
	}
	public void setMessageId(Integer messageId) {
		this.messageId = messageId;
	}
	public String getMessageName() {
		return messageName;
	}
	public void setMessageName(String messageName) {
		this.messageName = messageName;
	}
	public String getMailboxName() {
		return mailboxName;
	}
	public void setMailboxName(String mailboxName) {
		this.mailboxName = mailboxName;
	}
	public Date getMessageTimestamp() {
		return messageTimestamp;
	}
	public void setMessageTimestamp(Date messageTimestamp) {
		this.messageTimestamp = messageTimestamp;
	}
	public String getMessageFmtTimestamp() {
		return messageFmtTimestamp;
	}
	public void setMessageFmtTimestamp(String messageFmtTimestamp) {
		this.messageFmtTimestamp = messageFmtTimestamp;
	}
	public Integer getExtCount() {
		return extCount;
	}
	public void setExtCount(Integer extCount) {
		this.extCount = extCount;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public Integer getAgedTotal() {
		return agedTotal;
	}
	public void setAgedTotal(Integer agedTotal) {
		this.agedTotal = agedTotal;
	}
	public Integer getAgedMins() {
		return agedMins;
	}
	public void setAgedMins(Integer agedMins) {
		this.agedMins = agedMins;
	}
	public Integer getAgedHours() {
		return agedHours;
	}
	public void setAgedHours(Integer agedHours) {
		this.agedHours = agedHours;
	}
	public Integer getAgedDays() {
		return agedDays;
	}
	public void setAgedDays(Integer agedDays) {
		this.agedDays = agedDays;
	}
	public String getRuleProc() {
		return ruleProc;
	}
	public void setRuleProc(String ruleProc) {
		this.ruleProc = ruleProc;
	}
    
}
