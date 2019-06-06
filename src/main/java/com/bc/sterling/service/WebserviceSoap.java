package com.bc.sterling.service;

import java.io.IOException;

public interface WebserviceSoap {

	public Integer getResponseCode();
	public String sendRequest(Boolean prod, String filename) throws IOException;
}
