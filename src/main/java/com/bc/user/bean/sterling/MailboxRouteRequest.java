package com.bc.user.bean.sterling;

import java.io.Serializable;

public class MailboxRouteRequest implements Serializable {

	private static final long serialVersionUID = 1L;

	public String hostName;
	public String busProcId;
	public String busProcName;
	public String srcMailbox;
	public String fileName;
	;
	public String fileTemplate;
	public String targetFilename;
	public String mailboxName;
	public Integer groupId;

	public String busProcParm;

	public String nameTemplate;
	public String mapName;
	public String targetBPParm;
	public String eMailDest;
	
	public String getHostName() {
		return hostName;
	}
	public void setHostName(String hostName) {
		this.hostName = hostName;
	}
	public String getBusProcId() {
		return busProcId;
	}
	public void setBusProcId(String busProcId) {
		this.busProcId = busProcId;
	}
	public String getBusProcName() {
		return busProcName;
	}
	public void setBusProcName(String busProcName) {
		this.busProcName = busProcName;
	}
	public String getSrcMailbox() {
		return srcMailbox;
	}
	public void setSrcMailbox(String srcMailbox) {
		this.srcMailbox = srcMailbox;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getFileTemplate() {
		return fileTemplate;
	}
	public void setFileTemplate(String fileTemplate) {
		this.fileTemplate = fileTemplate;
	}
	public String getMailboxName() {
		return mailboxName;
	}
	public void setMailboxName(String mailboxName) {
		this.mailboxName = mailboxName;
	}
	public Integer getGroupId() {
		return groupId;
	}
	public void setGroupId(Integer groupId) {
		this.groupId = groupId;
	}
	public String getTargetFilename() {
		return targetFilename;
	}
	public void setTargetFilename(String targetFilename) {
		this.targetFilename = targetFilename;
	}
	public String getBusProcParm() {
		return busProcParm;
	}
	public void setBusProcParm(String busProcParm) {
		this.busProcParm = busProcParm;
	}
	public String getNameTemplate() {
		return nameTemplate;
	}
	public void setNameTemplate(String nameTemplate) {
		this.nameTemplate = nameTemplate;
	}

	public String getTargetBPParm() {
		return targetBPParm;
	}
	public void setTargetBPParm(String targetBPParm) {
		this.targetBPParm = targetBPParm;
	}
	public String geteMailDest() {
		return eMailDest;
	}
	public void seteMailDest(String eMailDest) {
		this.eMailDest = eMailDest;
	}
	public String getMapName() {
		return mapName;
	}
	public void setMapName(String mapName) {
		this.mapName = mapName;
	}


}
