package com.bc.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bc.sterling.service.SterlingService;
import com.bc.user.bean.sterling.LockData;
import com.bc.user.bean.sterling.MDNData;
import com.bc.user.bean.sterling.MailboxAgingInfo;
import com.bc.user.bean.sterling.MailboxInfo;
import com.bc.user.bean.sterling.MailboxRouteInfo;
import com.bc.user.bean.sterling.MailboxRouteRequest;

@Controller("SterlingController")
public class SterlingController {

	@Autowired
	@Qualifier("sterlingService")
	private SterlingService sterlingService;
	
	@RequestMapping("/sterlingHome.do")
	public String sterlingHome(@RequestParam(value="dbUrl",required=false) String dbUrl, ModelMap map, HttpServletResponse response, HttpServletRequest request) {

		Boolean testMode = dbUrl==null?false:MailboxRouteInfo.getTestMode(dbUrl);
		String userId = request.getUserPrincipal().getName();
		try {
			request.getSession().setAttribute("haltList", sterlingService.getHaltedBusProc(testMode));
			List<MDNData> mdnList = sterlingService.getPendingMDN(testMode, userId);
			request.getSession().setAttribute("mdnList", mdnList);
			List<LockData> lockList = sterlingService.getBccLocksList(testMode, null);
			request.getSession().setAttribute("lockList", lockList);
		} catch (Exception e) {
			request.getSession().setAttribute("haltList", new ArrayList<Integer>());
			request.getSession().setAttribute("mailboxTotal", new ArrayList<Integer>());
			request.getSession().setAttribute("dbMsg", "DB Timeout (Re-Try Halted)");
			e.printStackTrace();
		}
		defaultMapLoad(testMode, map, request);
		MailboxRouteInfo form = new MailboxRouteInfo(testMode);
		map.addAttribute("MailboxRouteInfo", form);
		Cookie[] cookies = request.getCookies();
		for (Cookie cookie:cookies) {
			//System.out.println(cookie.getName()+" "+cookie.getValue());
			if ("AutoLogOn".equals(cookie.getName())) {
				// important! this needs to be done to enable AutoLogOn.
				cookie.setValue("yes");
				cookie.setMaxAge(60*60*24); // lasts a day
				response.addCookie(cookie);
			}
		}
		return "SterlingHome";
	} 

	@RequestMapping(value = "/saveMailboxRouteInfo.do")
	public String saveMailboxRouteInfo(@ModelAttribute("MailboxRouteInfo") MailboxRouteInfo form
			, BindingResult errors
			, ModelMap map
			, HttpServletRequest request) throws IOException {

		Boolean testMode = form.getTestMode();
		String userId = request.getUserPrincipal().getName();
		Integer refId = null;;
		try {
			if (form.refId==null) {
				refId = sterlingService.insertMailboxRouteInfo(testMode, form, userId);
				form.setRefId(refId);
				map.addAttribute("msg", "inserted("+form.mailboxName+")");
			} else {
				refId = form.getRefId();
				sterlingService.updateMailboxRouteInfo(testMode, form, userId);
				map.addAttribute("msg", "updated("+form.mailboxName+")");
			}
		} catch (Exception e) {
			e.printStackTrace();
			map.addAttribute("MailboxRouteInfo", form);
			map.addAttribute("msg", e.getMessage());
		}

		defaultMapLoad(testMode, map, request);
		map.addAttribute("refId", refId);
		return "SterlingHome";
	}
		
//--------------------------------------common--------------------------------------------------
	public void defaultMapLoad(Boolean testMode, ModelMap map, HttpServletRequest request) {

		String db = sterlingService.getDbUrl(testMode);
		request.getSession().setAttribute("dbServer", db);
		try {
			String userId  = request.getUserPrincipal().getName();
			List<MailboxInfo> mailboxInfoList = sterlingService.getMailboxInfoList(testMode, userId);
			List<MailboxRouteInfo> mbxByMailboxInfoList = sterlingService.getMailboxRouteInfoList(testMode, userId);
			List<MailboxRouteInfo> mbxByTemplateInfoList = sterlingService.getMailboxRouteInfoList(testMode, userId);
			Collections.sort(mbxByTemplateInfoList, new MailboxRouteInfo(testMode));
			Map<String, Integer> statusMap = sterlingService.getActiveMailboxes(testMode, userId);
			List<MailboxAgingInfo> messageList = sterlingService.getMailboxAgingList(testMode, userId);
			map.addAttribute("MailboxInfoList", mailboxInfoList);
			map.addAttribute("MbxByMailboxInfoList", mbxByMailboxInfoList);
			map.addAttribute("MbxByTemplateInfoList", mbxByTemplateInfoList);
			map.addAttribute("statusMap", statusMap);
			map.addAttribute("messageList", messageList);
		} catch (Exception e) {
			map.addAttribute("MailboxRouteRequest", new MailboxRouteRequest());
			map.addAttribute("MailboxInfoList", new ArrayList<MailboxAgingInfo>());
			map.addAttribute("MbxByMailboxInfoList", new ArrayList<MailboxRouteInfo>());
			map.addAttribute("MbxByTemplateInfoList", new ArrayList<MailboxRouteInfo>());
			map.addAttribute("statusMap", new TreeMap<String, Integer>());
			map.addAttribute("messageList", new ArrayList<MailboxAgingInfo>());
		}
		map.addAttribute("MailboxRouteInfo", new MailboxRouteInfo(testMode));
		map.addAttribute("refId", 0);
	}

}
