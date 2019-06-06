package com.bc.sterling.base.dao;

import java.lang.reflect.Field;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.sql.DataSource;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.object.StoredProcedure;
import org.springframework.util.ReflectionUtils;
public class MSSQLBaseStoredProcedure extends StoredProcedure {

	protected static final String SPROC_NAME = null;
	protected static final Integer FIRST_RECORD = 0;
	protected static final Integer DEFAULT_TIMEOUT = 20;
	protected static final Boolean SKIP_UNDECLARED_RESULTS = true;

	public MSSQLBaseStoredProcedure(DataSource ds) {
		super(ds, SPROC_NAME);
		super.setQueryTimeout(DEFAULT_TIMEOUT);
		super.getJdbcTemplate().setSkipUndeclaredResults(true);
		super.setUpdatableResults(false);
	}

	public Map<String, Object> getInputParamsMap() {
		Map<String, Object> map = new HashMap<String, Object>();
		return map;
	}

	public <T> T getFirstRecord(List<T> results) {
		if (results == null)
			return null;
		T found = null;
		if (results.size() > 0) {
			found = results.get(FIRST_RECORD);
		}

		return found;
	}

	@Override
	public Map<String, Object> execute(Map<String, ?> inParams) throws DataAccessException {
		if (logger != null && logger.isTraceEnabled()) {
			logQuery(inParams);
		}
		return super.execute(inParams);
	}

	protected String logQuery(Map<String, ?> inParams) {
		String query = "";
		String sprocName;
		try {
			Field field = ReflectionUtils.findField(this.getClass(), "SPROC_NAME");
			if (field != null) {
				ReflectionUtils.makeAccessible(field);
				Object o = field.get(this);
				if (o != null) {
					sprocName = o.toString();
				} else {
					sprocName = this.getClass().getSimpleName();
				}
			} else {
				sprocName = this.getClass().getSimpleName();
			}
		} catch (IllegalAccessException e) {
			sprocName = this.getClass().getSimpleName();
		}
		query += "\nEXEC " + sprocName + "\n";
		boolean firstIteration = true;
		for (Entry<String, ?> entry : inParams.entrySet()) {
			String name = entry.getKey();
			Object valueobj = entry.getValue();
			String value = null;
			if (valueobj == null) {
				value = "NULL";
			} else {
				String valuetype = valueobj.getClass().getSimpleName();
				if ("Date".equals(valuetype)) {
					value = new java.sql.Date(((Date) valueobj).getTime()).toString();
				} else if ("Time".equals(valuetype)) {
					value = ((java.sql.Time) valueobj).toString();
				} else if ("Boolean".equals(valuetype)) {
					if ((Boolean) valueobj) {
						value = "1";
					} else {
						value = "0";
					}
				} else {
					value = valueobj.toString();
				}
				if ("String".equals(valuetype) || "Date".equals(valuetype) || "Time".equals(valuetype)) {
					value = "'" + value + "'";
				}
			}
			if (firstIteration) {
				firstIteration = false;
				query += "     ";
			} else {
				query += "    ,";
			}
			query += name + " = " + value + "\n";
		}
		return query;
	}

}
