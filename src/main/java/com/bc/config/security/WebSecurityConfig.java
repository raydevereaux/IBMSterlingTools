package com.bc.config.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.ldap.core.support.BaseLdapPathContextSource;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.bc.config.security.user.UserContextMapper;

@Configuration
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http
		.authorizeRequests()
        .antMatchers("/login*").anonymous()
        .anyRequest().authenticated()
        .and().formLogin().loginPage("/login").permitAll()
        .defaultSuccessUrl("/initial.do",true)
        //.defaultSuccessUrl("/*.do",true)
        .failureUrl("/login?error=true")
        .and().logout().logoutSuccessUrl("/login").permitAll();
		
		http.csrf().disable();
	}

// https://stackoverflow.com/questions/24916894/serving-static-web-resources-in-spring-boot-spring-security-application/24920752
	@Override
    public void configure(WebSecurity web) throws Exception {
        web.ignoring()
            .antMatchers("/js/*")
            .antMatchers("/css/*")
            .antMatchers("/images/*");
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        //return new LdapShaPasswordEncoder();
        return new BCryptPasswordEncoder();
    }

/*
// this will use local ldap lookup file LocalServer.ldif
	@Override
	public void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth
			.ldapAuthentication()
				.userDnPatterns("uid={0},ou=people")
				.groupSearchBase("ou=groups")
				.contextSource()
					.url("ldap://localhost:8389/dc=springframework,dc=org")
					.and()
				.passwordCompare()
					.passwordEncoder(new LdapShaPasswordEncoder())
					.passwordAttribute("userPassword");
	}

*/
	@Autowired
	public void configureGlobal(AuthenticationManagerBuilder auth, BaseLdapPathContextSource contextSource) throws Exception {
		auth.ldapAuthentication().contextSource(contextSource)
				.groupSearchBase("ou=AppData").groupSearchFilter("(cn={0})")
				.userSearchFilter("(uid={0})").userSearchBase("ou=Users")
				.userDetailsContextMapper(new UserContextMapper());
	}

}