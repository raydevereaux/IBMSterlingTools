<%@ page language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Login.jsp</title>
<link rel="stylesheet" type="text/css" href="css/login-form..css">
<link rel="stylesheet" type="text/css" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<script type="text/javascript" src="js/jquery.cookies.2.2.0.min.js"></script>
<script type="text/javascript" src="js/login-form.js"></script>
<style>
.msg {
text-align:center;
font-weight:bold;
}
.homeServer {
style:display:none;
}
table {
width:100%;
}
</style>
</head>
<body>
<div class="homeServer">${pageContext.request.serverName}</div>
<div>
<div class="login-form">
	<form id="loginform" name='f' action='login' method='POST'>
		<table>
			<tr><td align="center"><input type="text" class="username" name="username" placeholder="username" /></td></tr>
			<tr><td align="center"><input type="password" class="password" name="password" placeholder="password" /></td></tr>
			<tr><td align="center">&nbsp;</td></tr>
			<tr><td align="center"><input class="submitForm butStyle" type="button" value="log in" /></td></tr>
			<tr><td align="center">&nbsp;</td></tr>
			<tr><td class="msg"></td></tr>
			<tr><td class="err"><%= request.getParameter("error") %></td></tr>
		</table>
	</form>
</div>
</div>
</body>
</html>