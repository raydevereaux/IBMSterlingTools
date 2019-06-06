package com.bc.util.json;

import java.io.Serializable;

public class IcimsJsonMsgs implements Serializable {

	private static final long serialVersionUID = 1L;

	public String[] type = { "{'person':0}", "{'job:1}","{'{location':2}" };
	public String[] oper = { "{'create':0}", "{'update:1}" };
	public String[] url = {"https://api.icims.com/customers/8533/people","https://api.icims.com/customers/8533/jobs","https://api.icims.com/customers/8533/companies"};
	public String[] person = {
			"{'externalid':'A00001','firstname':'George','middlename':'W','lastname':'Washington','folder':{'value':'Emp:Current Employee'},'email':'georgewashington@email.com','logingroup':null,'enddate':''}",
			"{'folder':{'value':'Emp:Former Employee'},'logingroup':null,'enddate':'2016-01-31'}" };
	public String[] job = {
			"{'externalid':'A1234', 'jobtitle':'Account Manager', 'jobnumber':'ACCTMGR', 'folder':{'value':'Active Job Template' }, 'eeocategory':{'value':'Service Workers' }, 'jobtype':{'value':'Exempt' }, 'positiontype':{'value':'Regular Full-Time' }, 'minimumsalary':{'currency':'USD','amount':'10','timeframe':'Hourly' }, 'maximumsalary':{'currency':'USD','amount':'20','timeframe':'Hourly' }}",
			"{'folder':{'value':'Inactive Job Template'}}" };
	public String[] location = {
			"{'externalid':'56451','name':'Company Headquarters','folder':{'value':'Active Location'},'addresses':[{'entry':'','addressstreet1':'123 Main Street','addressstreet2':'2nd Floor','addresscity':'Matawan','addressstate':{'value':'New Jersey'},'addresszip':'07747','addresscountry':{'value':'United States'}}]}",
			"{'folder':{'value':'Inactive Location'}}" };

	public String getPersonCreate() {
		return person[0].replace("'", "\"");
	}
	public String getJobCreate() {
		return job[0].replace("'", "\"");
	}
	public String getLocationCreate() {
		return location[0].replace("'", "\"");
	}
	public String getPersonUpdate() {
		return person[1].replace("'", "\"");
	}
	public String getJobUpdate() {
		return job[1].replace("'", "\"");
	}
	public String getLocationUpdate() {
		return location[1].replace("'", "\"");
	}
	
	public String getIcimsUrl(String type, String systemID) {
		String url = "https://api.icims.com/customers/8533/"+type;
		if  (systemID==null||systemID.trim().length()==0) {
			//continue
		} else {
			url = url + "/"+systemID;
		}
		return url;
	}	
	
	public String getPersonUrl(String systemID) {
		String url = this.url[0];
		if  (systemID==null||systemID.trim().length()==0) {
			//continue
		} else {
			url = url + "/"+systemID;
		}
		return url;
	}
	public String getJobUrl(String systemID) {
		String url =  this.url[1];
		if  (systemID==null||systemID.trim().length()==0) {
			//continue
		} else {
			url = url + "/"+systemID;
		}
		return url;
	}

	public String getLocationUrl(String systemID) {
		String url =  this.url[2];
		if  (systemID==null||systemID.trim().length()==0) {
			//continue
		} else {
			url = url + "/"+systemID;
		}
		return url;
	}

	public String CreatePersonJson() {

		StringBuilder sb = new StringBuilder();

		String emplExternalId = "A00004";
		String firstName      = "James";
		String middleName     = " ";
		String lastName       = "Madison";
		String emplStatus     = "Emp:Current Employee";
		String nameSuffix     = "Jr";
		String emailType      = "";
		String emailID        =  firstName+"."+lastName+"@email.com";
		String jobTitle       = "Account Manager";
		String supervisorId   = "A00001";
		String locId          = "549";
		String login          = emailID;
		
		sb.append("{");
		sb.append("'externalid': '"+emplExternalId+"',");
		sb.append("'firstname': '"+firstName+"',");
		sb.append("'middlename': '"+middleName+"',");
		sb.append("'lastname': '"+lastName+"',");
		sb.append("'folder': { 'value': '"+emplStatus+"' },");
		//sb.append("'field24315': { 'value': '"+nameSuffix+"' },");
		sb.append("'email': '"+emailID+"',");
		sb.append("'jobtitle': '"+jobTitle+"',");
		sb.append("'supervisor': { 'externalid': '"+supervisorId+"' },");
		sb.append("'location': { 'id': "+locId+" },");
		sb.append("'login': '"+login+"'");
		sb.append("}");
		return sb.toString().replace("'","\"");
	}
/*
Update:
https://api.icims.com/customers/8533/people/<systemID>
https://api.icims.com/customers/8533/jobs/<systemID>
https://api.icims.com/customers/8533/companies/<systemID>

Create:
String[] url = {}
https://api.icims.com/customers/8533/people
https://api.icims.com/customers/8533/jobs
https://api.icims.com/customers/8533/companies
 */
}