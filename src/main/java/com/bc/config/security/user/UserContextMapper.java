package com.bc.config.security.user;

import java.util.Collection;

import org.springframework.ldap.core.DirContextAdapter;
import org.springframework.ldap.core.DirContextOperations;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.ldap.userdetails.UserDetailsContextMapper;

public class UserContextMapper implements UserDetailsContextMapper {

	@Override
	public UserDetails mapUserFromContext(DirContextOperations ctx, String username, Collection<? extends GrantedAuthority> authorities) {
		SiteUser.Essence essence = new SiteUser.Essence(ctx);
		essence.setUsername(username);
		essence.setAuthorities(authorities);
		return essence.createUserDetails();
	}

	@Override
	public void mapUserToContext(UserDetails user, DirContextAdapter ctx) {
		if(user instanceof SiteUser) {
			((SiteUser)user).populateContext(ctx); 
		}
	}
	
}
