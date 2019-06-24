package com.bc.project.util;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.Date;

public class BuildDate {

	public static SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy.HH.mm.ss.hhh");
	public static void main(String[] args) throws Exception {
		System.out.print("\033[H\033[2J");
		//comment for ken
		//System.out.println(BuildDate. getBuildDate());
	}

	public static String getBuildDate() {
		BuildDate buildDate = new BuildDate();
		String lastMod = sdf.format(new Date());
		try {
			String fullPath = buildDate.getPath();
			lastMod = buildDate.getLastMod(fullPath);
		} catch(Exception e) {
		}
		return lastMod; 
	}
	
	public String getPath() throws UnsupportedEncodingException {
		String path = this.getClass().getClassLoader().getResource("").getPath();
		String fullPath = URLDecoder.decode(path, "UTF-8");
		String filename = this.getClass().getName().replace(".", File.separator);
		String reponsePath = new File(fullPath).getPath() + File.separatorChar + filename+".class";
		return reponsePath;
	}
	
	public String getLastMod(String fullPath) throws Exception {
		String fileobj  = fullPath; //filepath +File.separator+filename;
		String lastMod =  sdf.format(new Date(new File(fileobj).lastModified()));
		return lastMod;
	}
}
