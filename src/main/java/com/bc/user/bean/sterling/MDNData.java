package com.bc.user.bean.sterling;

import java.io.Serializable;
import java.util.Date;

public class MDNData implements Serializable {

	private static final long serialVersionUID = 1L;

	public String mailbox;
	public String partAs2Identifier;
	public String myAs2Identifier;
	public String mdnDisp;
	public String mdnStatus;
	public String contractIn;
	public String contractOut;
	public Date createTimestamp;
	
	public String getMailbox() {
		return mailbox;
	}
	public void setMailbox(String mailbox) {
		this.mailbox = mailbox;
	}
	public String getPartAs2Identifier() {
		return partAs2Identifier;
	}
	public void setPartAs2Identifier(String partAs2Identifier) {
		this.partAs2Identifier = partAs2Identifier;
	}
	public String getMyAs2Identifier() {
		return myAs2Identifier;
	}
	public void setMyAs2Identifier(String myAs2Identifier) {
		this.myAs2Identifier = myAs2Identifier;
	}
	public String getMdnDisp() {
		return mdnDisp;
	}
	public void setMdnDisp(String mdnDisp) {
		this.mdnDisp = mdnDisp;
	}
	public String getMdnStatus() {
		return mdnStatus;
	}
	public void setMdnStatus(String mdnStatus) {
		this.mdnStatus = mdnStatus;
	}
	public String getContractIn() {
		return contractIn;
	}
	public void setContractIn(String contractIn) {
		this.contractIn = contractIn;
	}
	public String getContractOut() {
		return contractOut;
	}
	public void setContractOut(String contractOut) {
		this.contractOut = contractOut;
	}
	public Date getCreateTimestamp() {
		return createTimestamp;
	}
	public void setCreateTimestamp(Date createTimestamp) {
		this.createTimestamp = createTimestamp;
	}
	
}
