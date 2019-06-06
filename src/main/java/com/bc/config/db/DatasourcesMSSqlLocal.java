package com.bc.config.db;

import javax.sql.DataSource;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@Configuration
@Profile("local")
@EnableTransactionManagement(proxyTargetClass=true)
public class DatasourcesMSSqlLocal {

	//ds.setDriverClassName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	//ds.setUrl("jdbc:sqlserver://bospsql03cl-b2b.bc.com:56789;databaseName=b2bbcstat");
	
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

	@Bean(name = { "serverConfig" })
	public String serverConfig() {
	    //System.setProperty("java.home", "C:\\Java\\jdk1.8.0_201");
	    //String certificatesTrustStorePath = "C:\\Java\\jdk1.8.0_201\\jre\\lib\\security\\cacerts";
	    System.out.println("serverConfigserverConfig.javaHome: "+System.getProperty("java.home"));
	    //System.setProperty("javax.net.ssl.trustStore", certificatesTrustStorePath);
	    //System.setProperty("javax.net.ssl.trustStorePassword", "changeit");
	    return "done";
	}
}
