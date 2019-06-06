package com.bc.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bc.config.security.user.SiteUser;
import com.bc.project.util.BuildDate;
import com.bc.sterling.service.SterlingService;

@Controller("HomeController")
public class HomeController {

	@Autowired
	@Qualifier("OracleController")
	private OracleController oracleController;
	
	@Autowired
	@Qualifier("sterlingService")
	private SterlingService sterlingService;
	
	@RequestMapping(value = {"/" })
	public String defaultPage() {
		return "index";

	}
	
    @RequestMapping(value = "/login", method = RequestMethod.GET)
	public String loginGet(ModelMap map, HttpServletRequest request) {
		String error = request.getParameter("error");
        return "Login";
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
	public String loginPost(ModelMap map, HttpServletRequest request) {
		System.out.println("post*/.do");
        return "Login";
    }
    
	@RequestMapping("/initial.do")
	public String initial(ModelMap map, HttpServletRequest request) {
		String jUser = System.getProperty("user.name");
		String home = System.getProperty("java.home");
		String version = System.getProperty("java.version");
		System.out.println("java -user: "+jUser);
		System.out.println("java -home: "+home);
		System.out.println("java -version: "+version);
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userId = request.getUserPrincipal().getName();
		SiteUser user = (SiteUser) auth.getPrincipal();
		String target = "";
	    if (user.isAdmin()) {
			target = home(map, request);
	    } else { 
	    	target = oracleController.IBWeblogHome(map, null, request);
	    }
		return target;
	}
	
	@RequestMapping("/home.do")
	public String home(ModelMap map, HttpServletRequest request) {

		String userId = request.getUserPrincipal().getName();
		try {
			String dbUrl = sterlingService.getDbUrl(false); //default to prod
			request.getSession().setAttribute("dbUrl", dbUrl); 
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("dbUrl", "Not Connected");
			request.setAttribute("menuMsg", e.toString());
		}
		request.setAttribute("buildTimestamp", BuildDate.getBuildDate());
		request.setAttribute("request", request);
		return "Home";
	}
	
}
