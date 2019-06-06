package com.bc.config.security;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.ldap.core.support.BaseLdapPathContextSource;
import org.springframework.security.ldap.DefaultSpringSecurityContextSource;

@Configuration
public class LdapConfig {

	@Bean
	@Primary
	public BaseLdapPathContextSource getLdapContextSource(
			  @Value("${ldap.username}") String ldapUsername
			, @Value("${ldap.password}") String ldapPassword
			, @Value("${ldap.url}") String ldapUrl
			, @Value("${ldap.base}") String ldapBase) {

		DefaultSpringSecurityContextSource contextSource = new DefaultSpringSecurityContextSource(ldapUrl);
		contextSource.setUserDn(ldapUsername);
		contextSource.setPassword(ldapPassword);
		contextSource.setBase(ldapBase);
		return contextSource;
	}

}