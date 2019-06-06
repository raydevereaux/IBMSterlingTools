package com.bc.user.bean.sterling;

import java.io.Serializable;
import java.util.Date;

public class LockData implements Serializable {

	private static final long serialVersionUID = 1L;

	public String refId;
	public String itemName;
	public String userName;
	public String absTimestamp;
	public String timeout;
	public String systemName;
	public String clearOnStartup;
	public String reviewed;
	public Date createTimestamp;
	
	public String getRefId() {
		return refId;
	}
	public void setRefId(String refId) {
		this.refId = refId;
	}
	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getAbsTimestamp() {
		return absTimestamp;
	}
	public void setAbsTimestamp(String absTimestamp) {
		this.absTimestamp = absTimestamp;
	}
	public String getTimeout() {
		return timeout;
	}
	public void setTimeout(String timeout) {
		this.timeout = timeout;
	}
	public String getSystemName() {
		return systemName;
	}
	public void setSystemName(String systemName) {
		this.systemName = systemName;
	}
	public String getClearOnStartup() {
		return clearOnStartup;
	}
	public void setClearOnStartup(String clearOnStartup) {
		this.clearOnStartup = clearOnStartup;
	}
	public String getReviewed() {
		return reviewed;
	}
	public void setReviewed(String reviewed) {
		this.reviewed = reviewed;
	}
	public Date getCreateTimestamp() {
		return createTimestamp;
	}
	public void setCreateTimestamp(Date createTimestamp) {
		this.createTimestamp = createTimestamp;
	}
	
}
