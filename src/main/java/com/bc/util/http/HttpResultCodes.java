package com.bc.util.http;

import java.util.Map;
import java.util.TreeMap;

public class HttpResultCodes {

	public static Map<String, String> httpStatus = new TreeMap<String, String>();

	static {

		httpStatus.put("-500", "default/undefined");
		httpStatus.put("103", "Checkpoint");
		httpStatus.put("103", "Early Hints");
		httpStatus.put("200", "OK Normal");
		httpStatus.put("201", "OK Created");
		httpStatus.put("202", "OK Accepted");
		httpStatus.put("203", "OK Non-Authoritative Information");
		httpStatus.put("204", "OK No Content");
		httpStatus.put("205", "OK Reset Content");
		httpStatus.put("206", "OK Partial Content (RFC 7233)");
		httpStatus.put("207", "OK Multi-Status (RFC 4918)");
		httpStatus.put("208", "OK Already Reported (RFC 5842)");
		httpStatus.put("226", "OK IM Used (RFC 3229)");
		httpStatus.put("300", "Multiple Choices");
		httpStatus.put("301", "Moved Permanently");
		httpStatus.put("302", "Found");
		httpStatus.put("303", "See Other");
		httpStatus.put("304", "Not Modified (RFC 7232)");
		httpStatus.put("305", "Use Proxy");
		httpStatus.put("306", "Switch Proxy");
		httpStatus.put("307", "Temporary Redirect");
		httpStatus.put("308", "Permanent Redirect (RFC 7538)");
		httpStatus.put("400", "Bad Request");
		httpStatus.put("401", "Unauthorized (RFC 7235)");
		httpStatus.put("402", "Payment Required");
		httpStatus.put("403", "Forbidden");
		httpStatus.put("404", "Not Found");
		httpStatus.put("405", "Method Not Allowed");
		httpStatus.put("406", "Not Acceptable");
		httpStatus.put("407", "Proxy Authentication Required (RFC 7235)");
		httpStatus.put("408", "Request Timeout");
		httpStatus.put("409", "Conflict");
		httpStatus.put("410", "Gone");
		httpStatus.put("411", "Length Required");
		httpStatus.put("412", "Precondition Failed (RFC 7232)");
		httpStatus.put("413", "Payload Too Large (RFC 7231) ");
		httpStatus.put("414", "URI Too Long (RFC 7231)");
		httpStatus.put("415", "Unsupported Media Type");
		httpStatus.put("416", "Range Not Satisfiable (RFC 7233)");
		httpStatus.put("417", "Expectation Failed");
		httpStatus.put("418", "I'm a teapot (RFC 2324)");
		httpStatus.put("420", "Method Failure (Spring Framework)");
		httpStatus.put("420", "Enhance Your Calm (Twitter)");
		httpStatus.put("421", "Misdirected Request (RFC 7540)");
		httpStatus.put("422", "Unprocessable Entity (RFC 4918)");
		httpStatus.put("423", "Locked (RFC 4918)");
		httpStatus.put("424", "Failed Dependency (RFC 4918)");
		httpStatus.put("426", "Upgrade Required");
		httpStatus.put("428", "Precondition Required (RFC 6585)");
		httpStatus.put("429", "Too Many Requests (RFC 6585)");
		httpStatus.put("431", "Request Header Fields Too Large (RFC 6585)");
		httpStatus.put("440", "Login Time-out");
		httpStatus.put("444", "No Response");
		httpStatus.put("449", "Retry With");
		httpStatus.put("450", "Blocked by Windows Parental Controls (Microsoft)");
		httpStatus.put("451", "Unavailable For Legal Reasons (RFC 7725)");
		httpStatus.put("451", "Redirect");
		httpStatus.put("495", "SSL Certificate Error");
		httpStatus.put("496", "SSL Certificate Required");
		httpStatus.put("497", "HTTP Request Sent to HTTPS Port");
		httpStatus.put("498", "Invalid Token (Esri)");
		httpStatus.put("499", "Token Required (Esri)");
		httpStatus.put("499", "Client Closed Request");
		httpStatus.put("500", "Internal Server Error");
		httpStatus.put("501", "Not Implemented");
		httpStatus.put("502", "Bad Gateway");
		httpStatus.put("503", "Service Unavailable");
		httpStatus.put("504", "Gateway Timeout");
		httpStatus.put("505", "HTTP Version Not Supported");
		httpStatus.put("506", "Variant Also Negotiates (RFC 2295)");
		httpStatus.put("507", "Insufficient Storage (RFC 4918)");
		httpStatus.put("508", "Loop Detected (RFC 5842)");
		httpStatus.put("509", "Bandwidth Limit Exceeded (Apache Web Server/cPanel)");
		httpStatus.put("510", "Not Extended (RFC 2774)");
		httpStatus.put("511", "Network Authentication Required (RFC 6585)");
		httpStatus.put("520", "Unknown Error");
		httpStatus.put("521", "Web Server Is Down");
		httpStatus.put("522", "Connection Timed Out");
		httpStatus.put("523", "Origin Is Unreachable");
		httpStatus.put("524", "A Timeout Occurred");
		httpStatus.put("525", "SSL Handshake Failed");
		httpStatus.put("526", "Invalid SSL Certificate");
		httpStatus.put("527", "Railgun Error ");
		httpStatus.put("530", "Site is frozen");
		httpStatus.put("598", "Network read timeout error");

	}
}
