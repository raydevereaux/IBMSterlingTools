package com.bc.config.db;

import javax.sql.DataSource;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

@Configuration
public class DatasourcesOracle {
	@Bean (name={"HmigPeoplesoftDS"})
	public DataSource getHmigPeoplesoftDS() {
		DriverManagerDataSource ds = new DriverManagerDataSource();
	    ds.setDriverClassName("oracle.jdbc.OracleDriver");
		ds.setUrl("jdbc:oracle:thin:@bouxdora02.bc.com:1521/HMIG.bo.bc.com");
	    ds.setUsername("IB_OQ");
	    ds.setPassword("B01se17");
	    return ds;
	}

	@Bean (name={"HdevPeoplesoftDS"})
	public DataSource getHdevPeoplesoftDS() {
		DriverManagerDataSource ds = new DriverManagerDataSource();
	    ds.setDriverClassName("oracle.jdbc.OracleDriver");
		ds.setUrl("jdbc:oracle:thin:@bouxdora02.bc.com:1521/HDEV.bo.bc.com");
	    ds.setUsername("IB_OQ");
	    ds.setPassword("B01se17");
	    return ds;
	}
	
	@Bean (name={"HtstPeoplesoftDS"})
	public DataSource getHtstPeoplesoftDS() {
		DriverManagerDataSource ds = new DriverManagerDataSource();
	    ds.setDriverClassName("oracle.jdbc.OracleDriver");
		ds.setUrl("jdbc:oracle:thin:@bouxdora02.bc.com:1521/HTST.bo.bc.com");
	    ds.setUsername("IB_OQ");
	    ds.setPassword("B01se17");
	    return ds;
	}

	@Bean (name={"HprdPeoplesoftDS"})
	public DataSource getHprdPeoplesoftDS() {
		DriverManagerDataSource ds = new DriverManagerDataSource();
	    ds.setDriverClassName("oracle.jdbc.OracleDriver");
		ds.setUrl("jdbc:oracle:thin:@bouxpora02.bc.com:1521/HPRD.bo.bc.com");
	    ds.setUsername("IB_OQ");
	    ds.setPassword("B01se17");
	    return ds;
	}

	@Bean (name={"BmigPeoplesoftDS"})
	public DataSource getBmigPeoplesoftDS() {
		DriverManagerDataSource ds = new DriverManagerDataSource();
	    ds.setDriverClassName("oracle.jdbc.OracleDriver");
	    ds.setUrl("jdbc:oracle:thin:@bouxdora01.bc.com:1521/FMIG.bo.bc.com");  // sysadm/spaxs007
	    ds.setUsername("IB_OQ");
	    ds.setPassword("B01se17");
	    return ds;
	}
	
	@Bean (name={"BdevPeoplesoftDS"})
	public DataSource getBdevPeoplesoftDS() {
		DriverManagerDataSource ds = new DriverManagerDataSource();
	    ds.setDriverClassName("oracle.jdbc.OracleDriver");
	    ds.setUrl("jdbc:oracle:thin:@bouxdora01.bc.com:1521:BDEV");
	    ds.setUsername("IB_OQ");
	    ds.setPassword("B01se17");
	    return ds;
	}

	@Bean (name={"BtstPeoplesoftDS"})
	public DataSource getBtstPeoplesoftDS() {
		DriverManagerDataSource ds = new DriverManagerDataSource();
	    ds.setDriverClassName("oracle.jdbc.OracleDriver");
	    ds.setUrl("jdbc:oracle:thin:@bouxdora01.bc.com:1521/BTST.bo.bc.com");
	    ds.setUsername("IB_OQ");
	    ds.setPassword("B01se17");
	    return ds;
	}
	
	@Bean (name={"BprdPeoplesoftDS"})
	public DataSource getBprdPeoplesoftDS() {
		DriverManagerDataSource ds = new DriverManagerDataSource();
	    ds.setDriverClassName("oracle.jdbc.OracleDriver");
	    ds.setUrl("jdbc:oracle:thin:@bouxpora01.bc.com:1521/BPRD.bo.bc.com");
	    ds.setUsername("IB_OQ");
	    ds.setPassword("B01se17");
	    return ds;
	}
}
