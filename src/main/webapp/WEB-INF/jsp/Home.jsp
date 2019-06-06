<%@ page pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<title>Home.jsp</title>
	<link rel="stylesheet" href="https://b2btools.bc.com/IBMSterlingTools/css/b2btools.css" type="text/css" />
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script type="text/javascript" src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script> <!-- dialog -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jstimezonedetect/1.0.4/jstz.min.js"></script> <!-- timezone -->
	<script type="text/javascript" src="https://b2btools.bc.com/IBMSterlingTools/js/BccCustomObjects.js"></script>
	<script type="text/javascript" src="https://b2btools.bc.com/IBMSterlingTools/js/b2btools.js"></script>
<style>
/*Override margins*/
.baseTable {
border-radius: 1em;
border: solid #487831;
padding: 10 10 10 10;
}
.menuTable {

} 
.altlight {
color:#000000;
background-color:#ffffff;
}
.altDark {
color:#000000;
background-color:#e8e8e8;
}
.head {
font-size:30px;
font-weight: bold;
color:#000000;
text-align:center;
text-decoration:none;
}
.title {
font-size:16px;
font-weight: bold;
color:#000000;
text-align:center;
text-decoration:none;
}
.flyout {
width: 2000px;
}
</style>
<script type="text/javascript">
           
$(document).ready(function() {
	$('.menuDiv0').hide();
    $('.menuDiv1').hide();
    $('.menuDiv2').hide();

    $(".linkUrl").click(function() {
        var url = $(this).html();
        window.location = url;
     });   	
       
	setTimeout(function(){$('.menuDiv0').show('slow');}, 250);
	setTimeout(function(){$('.menuDiv1').show('slow');}, 500);
	setTimeout(function(){$('.menuDiv2').show('slow');}, 750);
	setTimeout(function(){$('.flyout00').hide('slow');}, 1250);
	setTimeout(function(){$('.flyout01').hide('slow');}, 1500);
	setTimeout(function(){$('.flyout02').hide('slow');}, 1750);
	
});

</script>
</head>
<body>
<div class="menuDiv0" align="center">
<table>
	<tr>
		<td class="flyout flyout00">&nbsp;</td>
		<td>
			<table> 
				<tr class="head head0"><td><img src="https://b2btools.bc.com/IBMSterlingTools/images/BccTree.png" /></td></tr>
				<tr class="head head0"><td>Boise Cascade Company</td></tr>
				<tr class="title head1"><td>${pageContext.request.serverName}</td></tr>
				<tr class="title head2"><td>${dbUrl}</td></tr>
				<tr class="title head3"><td>&nbsp;</td></tr>
			</table>
		</td>
	</tr>
</table>
</div>
<div class="menuDiv1" align="center">
<table>
	<tr><td class="flyout flyout01">&nbsp;</td>
		<td>
			<table class="menuTable baseTable"> 
				<thead>
					<tr class="altLight"><th>&nbsp;</th><th>Function</th></tr>
				</thead>
				<tbody class="menuList">
					<tr class="altDark" ><td>1.</td><td><a href="javascript:;" class="linkUrl">sterlingHome.do</a></td></tr>
					<tr class="altLight"><td>-.</td><td><hr/></td></tr>
					<tr class="altDark" ><td>2.</td><td><a href="javascript:;" class="linkUrl">ibWeblogHome.do</a></td></tr>
					<tr class="altDark" ><td>3.</td><td><a href="javascript:;" class="linkUrl">ibRouteHome.do</a></td></tr>
					<tr class="altLight"><td>-.</td><td><hr/></td></tr>
					<tr class="altDark" ><td>4.</td><td><a href="javascript:;" class="linkUrl">databaseHome.do  </a></td></tr>
					<tr class="altDark" ><td>5.</td><td><a href="javascript:;" class="linkUrl">tpHome.do  </a></td></tr>
					<tr class="altLight"><td>6.</td><td><a href="javascript:;" class="linkUrl">trace.do   </a></td></tr>
					<tr class="altDark" ><td>7.</td><td><a href="javascript:;" class="linkUrl">history.do </a></td></tr>
					<tr class="altLight"><td>-.</td><td><hr/></td></tr>
					<tr class="altDark" ><td>8.</td><td><a href="http://bo48wh1sl362.bc.com:8080/" style="color:blue;">Stomp.do</a></td></tr>
					<tr class="altDark" ><td>0.</td><td><a href="http://bouxsbi03.bc.com:8080/dashboard/portal?action=JLoginUser" target="_blank" style="color:blue;">sbi03 (Prod)</a></td></tr>
					<tr class="altLight"><td>10.</td><td><a href="http://bouxsbi03.bc.com:8080/filegateway/home.do#route"          target="_blank" style="color:blue;">sfg03 (Prod)</a></td></tr>
				</tbody>
			</table>
		</td>
	</tr>
</table>
</div>
<div class="menuDiv2" align="center">
<table>
	<tr>
		<td class="flyout flyout02">&nbsp;</td>
		<td><td class="title foot0">&nbsp;</td>
	</tr>
	<tr>
		<td class="flyout flyout02">&nbsp;</td>
		<td><td class="title foot1">Build: ${buildTimestamp} </td>
	</tr>
</table>
<div>${menuMsg}</div>
</body>
