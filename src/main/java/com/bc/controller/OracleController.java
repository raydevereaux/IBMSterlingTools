package com.bc.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bc.config.security.user.SiteUser;

@Controller("OracleController")
public class OracleController {

	private DateFormat dateFormater = new SimpleDateFormat("MM/dd/yyyy");

	@RequestMapping("/weblog.do")
	public String webloge(ModelMap map, HttpServletResponse response, HttpServletRequest request) {
		return this.IBWeblogHome(map, response, request);
	}
	
	@RequestMapping("/ibWeblogHome.do")
	public String IBWeblogHome(ModelMap map, HttpServletResponse response, HttpServletRequest request) {

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userId = request.getUserPrincipal().getName();
		SiteUser user = (SiteUser) auth.getPrincipal();
		Boolean restricted = user.isAdmin()?false:true;
		Date queryDate = new Date();
		map.put("queryDate", dateFormater.format(queryDate));
		request.setAttribute("request", request);
		request.setAttribute("restricted", restricted);
		return "IBWeblogHome";
	} 

	@RequestMapping("/ibRouteHome.do")
	public String IBRouteHome(ModelMap map, HttpServletResponse response, HttpServletRequest request) {

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userId = request.getUserPrincipal().getName();
		SiteUser user = (SiteUser) auth.getPrincipal();
		Boolean restricted = user.isAdmin()?false:true;
		Date queryDate = new Date();
		map.put("queryDate", dateFormater.format(queryDate));
		request.setAttribute("request", request);
		request.setAttribute("restricted", restricted);
		return "IBRouteHome";
	} 
}
