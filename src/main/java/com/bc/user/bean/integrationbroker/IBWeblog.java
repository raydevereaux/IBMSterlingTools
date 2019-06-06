package com.bc.user.bean.integrationbroker;

import java.io.Serializable;

import org.json.JSONException;
import org.json.JSONObject;

public class IBWeblog implements  Serializable, Comparable<IBWeblog> {

	private static final long serialVersionUID = 1L;

	public String server;
	public String refId;
	public String srcName;
	public String serviceType;
	public String methodName;
	public String replyType;
	public String senderID;
	public String receiverID;
	public String docType;
	public String srcSeqNo;
	public String srcXref;
	public String targetSystem;
	public String targetApp;
	public String targetProc;
	public String serviceOperation;
	public String version;
	public String finalStatus;
	public String userName;
	public String createTimestamp;
	public String completeTimestamp;
	public String requestUrl;
	public String origRequest;
	public String finalResponse;
	public String execException;
	public Boolean reviewException = true;
	
	public String getServer() {
		return server;
	}
	public void setServer(String server) {
		this.server = server;
	}
	public String getRefId() {
		return refId;
	}
	public void setRefId(String refId) {
		this.refId = refId;
	}
	public String getSrcName() {
		return srcName;
	}
	public void setSrcName(String srcName) {
		this.srcName = srcName;
	}
	public String getServiceType() {
		return serviceType;
	}
	public void setServiceType(String serviceType) {
		this.serviceType = serviceType;
	}
	public String getMethodName() {
		return methodName;
	}
	public void setMethodName(String methodName) {
		this.methodName = methodName;
	}
	public String getReplyType() {
		return replyType;
	}
	public void setReplyType(String replyType) {
		this.replyType = replyType;
	}
	public String getSenderID() {
		return senderID;
	}
	public void setSenderID(String senderID) {
		this.senderID = senderID;
	}
	public String getReceiverID() {
		return receiverID;
	}
	public void setReceiverID(String receiverID) {
		this.receiverID = receiverID;
	}
	public String getDocType() {
		return docType;
	}
	public void setDocType(String docType) {
		this.docType = docType;
	}
	public String getSrcSeqNo() {
		return srcSeqNo;
	}
	public void setSrcSeqNo(String srcSeqNo) {
		this.srcSeqNo = srcSeqNo;
	}
	public String getSrcXref() {
		return srcXref;
	}
	public void setSrcXref(String srcXref) {
		this.srcXref = srcXref;
	}
	public String getTargetSystem() {
		return targetSystem;
	}
	public void setTargetSystem(String targetSystem) {
		this.targetSystem = targetSystem;
	}
	public String getTargetApp() {
		return targetApp;
	}
	public void setTargetApp(String targetApp) {
		this.targetApp = targetApp;
	}
	public String getTargetProc() {
		return targetProc;
	}
	public void setTargetProc(String targetProc) {
		this.targetProc = targetProc;
	}
	public String getServiceOperation() {
		return serviceOperation;
	}
	public void setServiceOperation(String serviceOperation) {
		this.serviceOperation = serviceOperation;
	}
	public String getVersion() {
		return version;
	}
	public void setVersion(String version) {
		this.version = version;
	}
	public String getFinalStatus() {
		return finalStatus;
	}
	public void setFinalStatus(String finalStatus) {
		this.finalStatus = finalStatus;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getCreateTimestamp() {
		return createTimestamp;
	}
	public void setCreateTimestamp(String createTimestamp) {
		this.createTimestamp = createTimestamp;
	}
	public String getCompleteTimestamp() {
		return completeTimestamp;
	}
	public void setCompleteTimestamp(String completeTimestamp) {
		this.completeTimestamp = completeTimestamp;
	}
	public String getRequestUrl() {
		return requestUrl;
	}
	public void setRequestUrl(String requestUrl) {
		this.requestUrl = requestUrl;
	}
	public String getOrigRequest() {
		return origRequest;
	}
	public void setOrigRequest(String origRequest) {
		this.origRequest = origRequest;
	}
	public String getFinalResponse() {
		return finalResponse;
	}
	public void setFinalResponse(String finalResponse) {
		this.finalResponse = finalResponse;
	}
	public String getExecException() {
		return execException;
	}
	public void setExecException(String execException) {
		this.execException = execException;
	}

	public Boolean getReviewException() {
		this.reviewException = checkReview();
		return this.reviewException;
	}
	
	public void setReviewException(Boolean reviewException) {
		this.reviewException = checkReview();
	}

	private Boolean checkReview() {
		
		if (repostedOrReviewed()) {
			this.reviewException = false;
		} else {
			if (this.execException==null
			  ||this.execException.trim().length()==0
			  ||".".equals(this.execException.substring(0,1))
			  ||"normal".equals(this.execException) ) {
				this.reviewException = false;
			} else if ("{".equals(this.execException.substring(0,1))) {
				try {
					JSONObject jsonException = new JSONObject(this.execException);
					String msgOut = jsonException.getString("msgOut");
					if ("patch".equals(msgOut.toLowerCase())) {
						JSONObject jsonRes = new JSONObject(this.finalResponse);
						Integer httpStatus = Integer.parseInt(jsonRes.getString("HttpStatusCode"));
						switch (httpStatus) {
							case 204:
								this.reviewException = false;
								break;
							default:
								this.reviewException = true;
								break;
						}
					} else {
						this.reviewException = true;
					}
				} catch (JSONException j) {
					this.reviewException = true;
				}
			} else {
				this.reviewException = true;
			}
		}
		return this.reviewException;
	}

	private Boolean repostedOrReviewed() {
		
		Boolean myRepostedOrReviewed = false;
		if (this.finalStatus==null
		  ||this.finalStatus.trim().length()==0) {
			myRepostedOrReviewed = false;
		} else {
		  String repost   = this.finalStatus.toLowerCase().replaceAll("repost", "");
		  String reviewed = this.finalStatus.toLowerCase().replaceAll("reviewed", "");
		  if (repost.length()<this.finalStatus.length()) {
			  myRepostedOrReviewed = true;
		  } else if (reviewed.length()<this.finalStatus.length()) {
			  myRepostedOrReviewed = true;
		  } else {
			  myRepostedOrReviewed = false;
		  }
		}
		return myRepostedOrReviewed;
	}
	
	@Override
	public int compareTo(IBWeblog o1) {
		int c1 = this.getCreateTimestamp().compareTo(o1.getCreateTimestamp());
		if (c1==0) {
			c1 = this.getRefId().compareTo(o1.getRefId());
			if (c1==0) {
				c1 = this.getServer().toLowerCase().compareTo(o1.getServer().toLowerCase());
			}
		}
		return c1;
	}
}
