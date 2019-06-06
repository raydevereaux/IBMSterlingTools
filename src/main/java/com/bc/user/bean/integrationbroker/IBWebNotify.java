package com.bc.user.bean.integrationbroker;

import java.io.Serializable;

public class IBWebNotify implements Serializable {

	private static final long serialVersionUID = 1L;
	
	public String serverDomain;
	public String BC_NOTIFY_REFID;
	public String BC_NOTIFY_ITEM;
	public String BC_GROUPNAME;
	public String BC_EMAIL_ADDR;
	public String BC_EXECSTATUS;
	public String BC_CREATE_JTIME;
	
	public String getServerDomain() {
		return serverDomain;
	}
	public void setServerDomain(String serverDomain) {
		this.serverDomain = serverDomain;
	}

	public String getBC_NOTIFY_REFID() {
		return BC_NOTIFY_REFID;
	}
	public void setBC_NOTIFY_REFID(String bC_NOTIFY_REFID) {
		BC_NOTIFY_REFID = bC_NOTIFY_REFID;
	}
	public String getBC_NOTIFY_ITEM() {
		return BC_NOTIFY_ITEM;
	}
	public void setBC_NOTIFY_ITEM(String bC_NOTIFY_ITEM) {
		BC_NOTIFY_ITEM = bC_NOTIFY_ITEM;
	}
	public String getBC_GROUPNAME() {
		return BC_GROUPNAME;
	}
	public void setBC_GROUPNAME(String bC_GROUPNAME) {
		BC_GROUPNAME = bC_GROUPNAME;
	}
	public String getBC_EMAIL_ADDR() {
		return BC_EMAIL_ADDR;
	}
	public void setBC_EMAIL_ADDR(String bC_EMAIL_ADDR) {
		BC_EMAIL_ADDR = bC_EMAIL_ADDR;
	}
	public String getBC_EXECSTATUS() {
		return BC_EXECSTATUS;
	}
	public void setBC_EXECSTATUS(String bC_EXECSTATUS) {
		BC_EXECSTATUS = bC_EXECSTATUS;
	}
	public String getBC_CREATE_JTIME() {
		return BC_CREATE_JTIME;
	}
	public void setBC_CREATE_JTIME(String bC_CREATE_JTIME) {
		BC_CREATE_JTIME = bC_CREATE_JTIME;
	}
	
}
