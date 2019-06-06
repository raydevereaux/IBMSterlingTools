package com.bc.user.bean.integrationbroker;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

public class IBWebRestUrl implements Serializable {

	private static final long serialVersionUID = 1L;

	private final String defaultDomain = "erpwshr-t.bc.com";

	public String securityToken   = "bWlkZGxld2FyZTpCaGxhaDJycA==";
	private final String webRoot   = "https://";
	private String serverDomain    = "erpwshr-t.bc.com";
	private final String webServer = "PSIGW";
	private final String connector = "RESTListeningConnector";
	public String ibInstance       = "PSFT_HR";

	public String serviceName   = "BCCSERVICE.v1";
	public String ibNode        = "BccPut";
	public String serviceType   = "rest";
	public String serviceMethod = "post";
	public String replyType     = "echo";;
	public String senderID      = "icims";
	public String receiverID    = "bcllc";
	public String docType       = "000";
	public String xref          = "xref";
	public String seqNo         = "000";
	public String targetSystem  = "sys";
	public String targetApp     = "app";
	public String targetProc    = "proc";
	public String payload       = "payload";
	private static Map<String,String> urlMap = new HashMap<String,String>();
	static {
		urlMap.put("hmig","bouxerp02.bc.com:8443");
		urlMap.put("hdev","erphdev.bc.com");
		urlMap.put("htst","bouxerp01.bc.com:8243");
		urlMap.put("hprd","erpwshr.bc.com");
		urlMap.put("bmig","bouxerp02.bc.com:9343");
		urlMap.put("bdev","erpbdev.bc.com");
		urlMap.put("btst","erpbtst.bc.com");
		urlMap.put("bprd","erpbprd.bc.com");
	}
	public String urlForPost() {
		StringBuilder sb = new StringBuilder();
		sb.append(webRoot);
		sb.append(serverDomain+"/");
		sb.append(webServer+"/");
		sb.append(connector+"/");
		sb.append(ibInstance+"/");
		sb.append(serviceName+"/");
		sb.append("BccPut/");
		sb.append(serviceType+"/");
		sb.append(serviceMethod+"/");
		sb.append(replyType+"/");
		sb.append(senderID+"/");
		sb.append(receiverID+"/");
		sb.append(docType+"/");
		sb.append(xref+"/");
		sb.append(seqNo+"/");
		sb.append(targetSystem+"/");
		sb.append(targetApp+"/");
		sb.append(targetProc+"/");
		return sb.toString();
	}
	
	public String urlForGet() {
		StringBuilder sb = new StringBuilder();
		sb.append(webRoot);
		sb.append(serverDomain+"/");
		sb.append(webServer+"/");
		sb.append(connector+"/");
		sb.append(ibInstance+"/");
		sb.append(serviceName+"/");
		sb.append("BccGet/");
		sb.append(serviceType+"/");
		sb.append(serviceMethod+"/");
		sb.append(replyType+"/");
		sb.append(senderID+"/");
		sb.append(receiverID+"/");
		sb.append(docType+"/");
		sb.append(xref+"/");
		sb.append(seqNo+"/");
		sb.append(targetSystem+"/");
		sb.append(targetApp+"/");
		sb.append(targetProc+"/");
		sb.append(payload);
		return sb.toString();
	}
	
	public String getServerDomain() {
		return serverDomain;
	}

	public void setServerDomain(String serverName) {
		try {
			this.serverDomain = urlMap.get(serverName.toLowerCase());
		} catch (Exception e) {
			this.serverDomain = defaultDomain;
		}
		if ("hdev".equals(serverName.toLowerCase())) {
			this.ibInstance = "PSFT_HRD";
		} else if ("htst".equals(serverName.toLowerCase())) {
			this.ibInstance = "PSFT_HRT";
		} else if ("bdev".equals(serverName.toLowerCase())) {
			this.ibInstance = "PSFT_EP";
		} else if ("bmig".equals(serverName.toLowerCase())) {
			this.ibInstance = "PSFT_EP";
		} else if ("btst".equals(serverName.toLowerCase())) {
			this.ibInstance = "PSFT_EP";
		} else if ("bprd".equals(serverName.toLowerCase())) {
			this.ibInstance = "PSFT_EP";
		} else {
			this.ibInstance = "PSFT_HR";
		} 
	}
}
