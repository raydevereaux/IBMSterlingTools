package com.bc.config.db;

import javax.sql.DataSource;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@Configuration
@Profile("!local")
@EnableTransactionManagement(proxyTargetClass=true)
public class DatasourcesMSSqlJndi {

	/*
     private final String jndiName = "java:jdbc/MsSterlingDS";
     
     @Bean(name = { "SterlingDataSource" })
     public DataSource sbiDataSource() throws IllegalArgumentException, NamingException {
          String version = System.getProperty("java.version");
          System.out.println(version+" setup non-local "+jndiName);
          JndiDataSourceLookup lookup = new JndiDataSourceLookup();
          lookup.setResourceRef(true);
          DriverManagerDataSource ds = (DriverManagerDataSource) lookup.getDataSource(jndiName);
          return ds;
     }
     */
	
	@Bean(name = { "SterlingDataSourcePrd" })
	public DataSource sterlingDataSourcePrd() {
		DriverManagerDataSource ds = new DriverManagerDataSource();
		ds.setUrl("jdbc:sqlserver://bospsql02-b2b.bc.com:56789;databaseName=b2bbcstat");
		ds.setUsername("SIadmin");
		ds.setPassword("SIadmin$07");
		return ds;
	}

	@Bean(name = { "SterlingDataSourceTst" })
	public DataSource sterlingDataSourceTst() {
		DriverManagerDataSource ds = new DriverManagerDataSource();
		ds.setUrl("jdbc:sqlserver://bosdsql14;databaseName=b2bbcstat");
		ds.setUsername("SIadmin");
		ds.setPassword("SIadmin$07");
		return ds;
	}
	
	@Bean(name = { "sslConfig" })
	public String sslConfig() {
	    System.out.println("javaHome: "+System.getProperty("java.home"));
	    return "done";
	}
}
