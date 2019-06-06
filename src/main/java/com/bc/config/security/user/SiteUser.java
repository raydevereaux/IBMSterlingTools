package com.bc.config.security.user;

import java.util.Collection;

import org.springframework.ldap.core.DirContextAdapter;
import org.springframework.ldap.core.DirContextOperations;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.ldap.userdetails.LdapUserDetailsImpl;
import org.springframework.security.ldap.userdetails.Person;

public class SiteUser extends Person {
	private static final long serialVersionUID = -5642048081923758470L;
	
	private String employeeId;
	private String mail;
	private String telephoneNumber;
	private String manager;
	
	public String getEmployeeId() {
		return employeeId;
	}
	
	public String getManager() {
		return manager;
	}

	public Boolean isAdmin() {
		Boolean admin = getManager().toLowerCase().indexOf("parkinson")==-1?false:true;
		if (admin) {
			//continue
		} else {
			admin = getManager().toLowerCase().indexOf("rodenbaugh")==-1?false:true;
		}
		return admin;
	}
	
	@Override
	public void populateContext(DirContextAdapter adapter) {
        super.populateContext(adapter);
		adapter.setAttributeValue("employeeId", employeeId);
		adapter.setAttributeValue("mail", mail);
		adapter.setAttributeValue("telephoneNumber", telephoneNumber);
		adapter.setAttributeValue("adManager", manager);
		
		Collection<GrantedAuthority> authList = super.getAuthorities();
		for (GrantedAuthority auth:authList) {
			System.out.println("authority "+auth.getAuthority());
		}
	}
	
	public static class Essence extends Person.Essence {
        public Essence(DirContextOperations ctx) {
			super(ctx);
			setEmployeeId(ctx.getStringAttribute("employeeId"));
			setMail(ctx.getStringAttribute("mail"));
			setPhone(ctx.getStringAttribute("telephoneNumber"));
			setManager(ctx.getStringAttribute("adManager"));
        }

		@Override
		protected LdapUserDetailsImpl createTarget() {
            return new SiteUser();
        }
		
		private void setEmployeeId(String employeeId) {
			((SiteUser)instance).employeeId = employeeId;
		}
		private void setMail(String mail) {
			((SiteUser)instance).mail = mail;
		}
		private void setPhone(String phone) {
			((SiteUser)instance).telephoneNumber = phone;
		}
		private void setManager(String mgr) {
			try {
				mgr = mgr.replace("\\,", "");
				String manager = mgr.substring(3, mgr.indexOf(","));
				//System.out.println(":"+manager+":");
				((SiteUser)instance).manager = manager;
			} catch (Exception e) {
				((SiteUser)instance).manager = "anonymous";
			}
		}
	}
}