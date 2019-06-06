package com.bc.sterling.base.dao;

import javax.sql.DataSource;

import org.springframework.jdbc.core.support.JdbcDaoSupport;

public abstract class SQLBaseDaoImpl extends JdbcDaoSupport {

	@SuppressWarnings("unused")
	public Boolean sqlDebug = true;

	public abstract void setSqlDebug(Boolean sqlDebug);
	public SQLBaseDaoImpl(DataSource ds) {
		setDataSource(ds);
	}
}