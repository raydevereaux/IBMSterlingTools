package com.bc.project.util;

public class StackTraceUtil {

	  public static String getStackTrace(Throwable aThrowable) {
	    StringBuilder result = new StringBuilder();
	    result.append(aThrowable.toString());
	    String NEW_LINE = System.getProperty("line.separator");
	    result.append(NEW_LINE);
	    for (StackTraceElement element : aThrowable.getStackTrace() ){
	      result.append( element );
	      result.append( NEW_LINE );
	    } 
	    return result.toString();
	  }
}