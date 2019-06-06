package com.bc.user.bean.sterling;

import java.io.Serializable;
import java.util.Comparator;
import java.util.Date;

public class MailboxRouteInfo implements Comparator<MailboxRouteInfo>, Serializable {

	private static final long serialVersionUID = 1L;

	public Integer refId;
	public String fileTemplate;
	public Integer mailboxId;
	public String mailboxName;
	public String nameTemplate;
	public Integer groupId;
	public Date createTimestamp;
	public String busCode;
	public String logging;
	public String fileTrace;
	public String docType;
	//new
	public String mapName;
	public String bpName;
	public String eMailDest;
	public String subject;
	public String dfDirIO;  //dataFlowDirection
	public Integer groupSeq;
	public String dbUrl;
	
	public MailboxRouteInfo() {
		super();
	}
	
	public MailboxRouteInfo(Boolean testMode) {
		super();
		this.setDbUrl(testMode);
	}
	
	@Override
	public int compare(MailboxRouteInfo e1, MailboxRouteInfo e2) {
		int result = 0;
		if (e1.fileTemplate==null) {
			result = -1;
		} else if (e2.fileTemplate==null) {
			result = +1;
		} else {
			result = e1.fileTemplate.toLowerCase().compareTo( e2.fileTemplate.toLowerCase());
		}
		return result;
	}

	public Integer getRefId() {
		return refId;
	}


	public void setRefId(Integer refId) {
		this.refId = refId;
	}


	public String getFileTemplate() {
		return fileTemplate;
	}


	public void setFileTemplate(String fileTemplate) {
		this.fileTemplate = fileTemplate;
	}


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


	public String getNameTemplate() {
		return nameTemplate;
	}


	public void setNameTemplate(String nameTemplate) {
		this.nameTemplate = nameTemplate;
	}


	public Integer getGroupId() {
		return groupId;
	}


	public void setGroupId(Integer groupId) {
		this.groupId = groupId;
	}


	public Date getCreateTimestamp() {
		return createTimestamp;
	}


	public void setCreateTimestamp(Date createTimestamp) {
		this.createTimestamp = createTimestamp;
	}


	public String getBusCode() {
		return busCode;
	}


	public void setBusCode(String busCode) {
		this.busCode = busCode;
	}


	public String getLogging() {
		return logging;
	}


	public void setLogging(String logging) {
		this.logging = logging;
	}


	public String getFileTrace() {
		return fileTrace;
	}


	public void setFileTrace(String fileTrace) {
		this.fileTrace = fileTrace;
	}


	public String getDocType() {
		return docType;
	}


	public void setDocType(String docType) {
		this.docType = docType;
	}


	public String getMapName() {
		return mapName;
	}


	public void setMapName(String mapName) {
		this.mapName = mapName;
	}


	public String getBpName() {
		return bpName;
	}


	public void setBpName(String bpName) {
		this.bpName = bpName;
	}


	public String geteMailDest() {
		return eMailDest;
	}


	public void seteMailDest(String eMailDest) {
		this.eMailDest = eMailDest;
	}


	public String getSubject() {
		return subject;
	}


	public void setSubject(String subject) {
		this.subject = subject;
	}


	public String getDfDirIO() {
		return dfDirIO;
	}


	public void setDfDirIO(String dfDirIO) {
		this.dfDirIO = dfDirIO;
	}

	public Integer getGroupSeq() {
		return groupSeq;
	}

	public void setGroupSeq(Integer groupSeq) {
		this.groupSeq = groupSeq;
	}

	public String getDbUrl() {
		return dbUrl;
	}

	public void setDbUrl(String dbUrl) {
		this.dbUrl = dbUrl;
	}
	public void setDbUrl(Boolean testMode) {
		this.dbUrl = "sterlingHome.do?dbUrl=prod";
		if (testMode) {
			this.dbUrl = "sterlingHome.do?dbUrl=test";
		}
	}
	
	public Boolean getTestMode() {
		return getTestMode(this.dbUrl);
	}
	
	public static Boolean getTestMode(String dbUrl) {

		Boolean testMode = true;
		if ("prod".equalsIgnoreCase(dbUrl)||"sterlingHome.do?dbUrl=prod".equalsIgnoreCase(dbUrl)) {
			testMode = false;
		}
		return testMode;
	}
}
