package com.bc.user.bean.integrationbroker;

import java.io.Serializable;

public class IBWebCtrl implements Serializable {

	private static final long serialVersionUID = 1L;

	public String securityToken   = "bWlkZGxld2FyZTpCaGxhaDJycA==";
	public String userName;
	public String operation; //insert/update/delete
	public String serverDomain;
	public String BC_REFID;
	public String BC_SENDERID;
	public String BC_RECEIVERID;
	public String BC_DOCTYPE;
	public String BC_EXECTYPE;  // (peoplecodeClass/AppEngine/javaObject)
	public String BC_EXECSTATUS;  // (suspend/hold/stop or normal/ready/active)
	public String BC_EXECOBJNAME; // BC_INBOUND_ICIMS:BC_ACCPT_RQST  or com.bc.PeopleCode.utility.DynamicBinder
	public String BC_CTRL_SEQCHECK; // (check.deny/check.notify/nocheck.default/nocheck)
	public String BC_CTRL_SEQNUMBER;
	public String BC_NOTIFY_REFID;
	public String BC_REPLYTYPE;
	public String BC_RESTRICT_ACCESS;
	public String BC_CREATE_JTIME;
	public String BC_GROUPNAME;
	
	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getServerDomain() {
		return serverDomain;
	}

	public void setServerDomain(String serverDomain) {
		this.serverDomain = serverDomain;
	}

	public String getOperation() {
		return operation;
	}

	public String getBC_REFID() {
		return BC_REFID;
	}

	public void setBC_REFID(String bC_REFID) {
		BC_REFID = bC_REFID;
	}

	public String getBC_SENDERID() {
		return BC_SENDERID;
	}

	public void setBC_SENDERID(String bC_SENDERID) {
		BC_SENDERID = bC_SENDERID;
	}

	public String getBC_RECEIVERID() {
		return BC_RECEIVERID;
	}

	public void setBC_RECEIVERID(String bC_RECEIVERID) {
		BC_RECEIVERID = bC_RECEIVERID;
	}

	public String getBC_DOCTYPE() {
		return BC_DOCTYPE;
	}

	public void setBC_DOCTYPE(String bC_DOCTYPE) {
		BC_DOCTYPE = bC_DOCTYPE;
	}

	public String getBC_EXECTYPE() {
		return BC_EXECTYPE;
	}

	public void setBC_EXECTYPE(String bC_EXECTYPE) {
		BC_EXECTYPE = bC_EXECTYPE;
	}

	public String getBC_EXECSTATUS() {
		return BC_EXECSTATUS;
	}

	public void setBC_EXECSTATUS(String bC_EXECSTATUS) {
		BC_EXECSTATUS = bC_EXECSTATUS;
	}

	public String getBC_EXECOBJNAME() {
		return BC_EXECOBJNAME;
	}

	public void setBC_EXECOBJNAME(String bC_EXECOBJNAME) {
		BC_EXECOBJNAME = bC_EXECOBJNAME;
	}

	public String getBC_CTRL_SEQCHECK() {
		return BC_CTRL_SEQCHECK;
	}

	public void setBC_CTRL_SEQCHECK(String bC_CTRL_SEQCHECK) {
		BC_CTRL_SEQCHECK = bC_CTRL_SEQCHECK;
	}

	public String getBC_CTRL_SEQNUMBER() {
		return BC_CTRL_SEQNUMBER;
	}

	public void setBC_CTRL_SEQNUMBER(String bC_CTRL_SEQNUMBER) {
		BC_CTRL_SEQNUMBER = bC_CTRL_SEQNUMBER;
	}

	public String getBC_NOTIFY_REFID() {
		return BC_NOTIFY_REFID;
	}

	public void setBC_NOTIFY_REFID(String bC_NOTIFY_REFID) {
		BC_NOTIFY_REFID = bC_NOTIFY_REFID;
	}

	public String getBC_REPLYTYPE() {
		return BC_REPLYTYPE;
	}

	public void setBC_REPLYTYPE(String bC_REPLYTYPE) {
		BC_REPLYTYPE = bC_REPLYTYPE;
	}

	public String getBC_RESTRICT_ACCESS() {
		return BC_RESTRICT_ACCESS;
	}

	public void setBC_RESTRICT_ACCESS(String bC_RESTRICT_ACCESS) {
		BC_RESTRICT_ACCESS = bC_RESTRICT_ACCESS;
	}

	public String getBC_CREATE_JTIME() {
		return BC_CREATE_JTIME;
	}

	public String getBC_GROUPNAME() {
		return BC_GROUPNAME;
	}

	public void setBC_GROUPNAME(String bC_GROUPNAME) {
		BC_GROUPNAME = bC_GROUPNAME;
	}

	public void setBC_CREATE_JTIME(String bC_BC_CREATE_JTIME) {
		BC_CREATE_JTIME = bC_BC_CREATE_JTIME;
	}

	public void setOperation(String operation) {
		this.operation = operation;
	}
	
}
