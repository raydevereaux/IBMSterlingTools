<%@ page language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<title>DatabaseHome.jsp</title>
	<link rel="stylesheet" href="https://b2btools.bc.com/IBMSterlingTools/css/b2btools.css" type="text/css" />
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script type="text/javascript" src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script> <!-- dialog -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jstimezonedetect/1.0.4/jstz.min.js"></script> <!-- timezone -->
	<script type="text/javascript" src="https://b2btools.bc.com/IBMSterlingTools/js/BccCustomObjects.js"></script>
	<script type="text/javascript" src="https://b2btools.bc.com/IBMSterlingTools/js/b2btools.js"></script>
	<script type="text/javascript" src="js/jquery-2.70.0.blockUI.js"></script>
<style>
.baseTable td {
    padding-left: 15px;
    text-align: left;
}
/*Override margins*/
.baseTable {
border-radius: 1em;
border: solid #487831;
padding: 10 10 10 10;
}
.selServer {
color: #0000ff;
font-weight: bold;
} 
.selSchema {
color: #ff0000;
font-weight: bold;
} 
.selType {
color: #000000;
font-weight: bold;
} 
.itemPassed {
color: red;
background-color: ligntblue;
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
.editMsg {
color: #ff0000;
font-weight:bold;
text-align: center;
}
.exec {
border-style:solid;
border-width: 1px;
border-color: #000000;
border-radius:1em;
padding:20px,20px,20px,20px;
background-color:#e8e8e8;
color:#000000;
box-shadow: 10px 10px 5px #888888;
text-decoration:none;
padding-left: .5cm;
padding-right: .5cm;
font-style: italic;
text-align:center;
}
.secure {
}
.pass {
background-color:lightgreen;
}
.fail {
background-color:pink;
}
.selected {
background-color:yellow;
}
.seqRef {
display:none;
}
.copy {
color:blue;
}
.copy:hover {
color:red;
}
</style>
<script type="text/javascript">
           
$(document).ready(function() {
   	$('.copy').hide('slow');
	getServerList();
	
	$('.clear').click(function() {
		clear();
		$(".ckBox").prop('checked',false);
	});
	$('.copy').click(function() {
		$('.refId').html('');
		$('.rowId').html('');
	});
	$('.delete').click(function() {
       	var payload = new Object();
       	payload.refId      = $('.refId').html();
       	payload.server     = $('.server').val();
       	payload.dbInstance = $('.schema').val();
       	payload.jdbcType   = $('input[name=type]:checked').val();
       	payload.oper       = 'delete';
       	if (confirm(payload.server+' .Confirm delete ?')) {
       		$('.refId').html('');
    		$.blockUI();
       		updateServerList(payload);
       	} else {
       		alert('Delect Canceled');
       	}
	});
	$('.save').click(function() {
       	var payload = new Object();
       	payload.refId      = $('.refId').html();
       	payload.server     = $('.server').val();
       	payload.dbInstance = $('.schema').val();
       	payload.jdbcType   = $('input[name=type]:checked').val();
       	payload.oper       = 'insert';
       	if ($.isNumeric(payload.refId)&&payload.refId>'0') {
           	payload.oper   = 'update';
       	}
    	$.blockUI();
       	updateServerList(payload);
	});
	$('.selSchema').click(function() {
		$(this).parent().removeClass('pass');
		$(this).parent().removeClass('fail');
	});
	$('.selType').click(function() {
		$(this).parent().css("background-color","");
		$('.ckBox').attr('checked',false);
	});
	$('.clearChk').click(function() {
		initStripe();
		$(".ckBox").prop('checked',false);
	})
	$( '.serverList' ).on( 'click', '.test', function() {
		var chk = $(this).prop('checked');
		$(this).parent().parent().removeClass('selected');
		if (chk) {
			$(this).parent().parent().addClass('selected');
		}
	})
	$('.testAll').change(function() {
		var chk = $(this).prop('checked');
		$('.test').prop('checked',chk);
		$('.serverList tr').each(function() {
			$(this).removeClass('selected');
			if (chk) {
				$(this).addClass('selected');
			}
		});
	})
	$('.subList').click(function() {
       	$('.userMsg').html('');
		$(".seedData").each(function() {
			$(this).removeClass('pass');
			$(this).removeClass('fail');
			$(this).removeClass('selected');
			var chkDo = $(this).find('td').find('input').prop('checked');
			$(this).find('th').find('input').prop('checked',false);
			$(this).find('th').find('input').next().prop('checked',false);
			if (chkDo) {
				$(this).addClass('selected');
	       		var td = $(this).find('td');
	       		var payload = new Object();
	           	payload.oper    = 'test';
	       		payload.rowId   = td.next().html();
	       		payload.refId   = td.next().next().html();
	       		payload.type    = td.next().next().next().html().toLowerCase();
	       		payload.server  = td.next().next().next().next().html().toLowerCase();
	       		payload.schema  = td.next().next().next().next().next().html();
	       		payload.dbUser  = $('.dbUser').val();
	       		payload.dbPass  = $('.dbPass').val();
				if (editSql(payload)) {
			    	$.blockUI();
		       		//postUserMsg(JSON.stringify(payload));
					submitRequest(payload);
				}
			}
		});
		$('.testAll').prop('checked',false);
		$(".test").prop('checked',false);
	})
	$('.refreshList').click(function() {
    	$.blockUI();
		getServerList();
	})
	
	$('.type').click(function() {
		var type = $('input[name=type]:checked').val();
		$('input[name=type]').prop('checked',false);
		$(this).prop('checked', true);
		//doTypeCheckbox(type);
		setDbUser(type);
		var server  = $('.server').val();
		if (server.length>0) {
			$(".seedData").each(function() {
				$(this).removeClass('pass');
				$(this).removeClass('fail');
				var tdType = $(this).find('td').next().next().html();
				if (type==tdType) {
					$(this).addClass('selected');
					$(this).find('td').find('input').prop('checked', true);
				} else {
					$(this).removeClass('selected');
					$(this).find('td').find('input').prop('checked', false);
				}
				$(this).find('th').find('input').prop('checked',false);
				$(this).find('th').find('input').next().prop('checked',false);
			});
		}
	})
	$( '.serverList' ).on( 'click', '.ckBox', function() {
		$(this).parent().parent().removeClass('pass');
		$(this).parent().parent().removeClass('fail');
		$(this).parent().parent().removeClass('selected');
		var chkd = $(this).prop('checked');
		if (chkd) {
			if ($(this).hasClass('ok')) {
				$(this).next().prop('checked',false);
				$(this).parent().parent().addClass('pass');
			} else {
				$(this).prev().prop('checked',false);
				$(this).parent().parent().addClass('fail');
			}
		}
	})
	$( '.serverList' ).on( 'click', '.selServer', function() {
       	var type    = $(this).prev().html();
       	var server  = $(this).html();
       	var schema  = $(this).next().html();
       	clear();
		setDbUser(type);
		var rowId = $(this).parent().find('td').next().html();
		var refId = $(this).parent().find('td').next().next().html();
		$('.serverList tr').each(function() {
			$(this).removeClass('selected');
		});
		$(this).parent().addClass('selected');
       	$('.rowId').html(rowId);
       	$('.refId').html(refId);
       	$('.server').val(server);
       	$('.schema').val(schema);
       	$('.copy').show('slow');
       	doTypeCheckbox(type);
	}); 
	$('.dbTest').click(function() {
       	$('.userMsg').html('');
       	var rowId = $('.rowId').html();
       	var type  = $('input[name=type]:checked').val();
       	if (rowId.length==0&&type.length>0) {
           	$('.subList').click();
       	} else {
           	var payload = new Object();
       		payload.rowId   = $('.rowId').html();
       		payload.type    = $('input[name=type]:checked').val();
       		payload.server  = $('.server').val().toLowerCase();
       		payload.schema  = $('.schema').val();
       		payload.dbUser  = $('.dbUser').val();
       		payload.dbPass  = '*****';
       		postUserMsg(JSON.stringify(payload));
       		payload.dbPass  = $('.dbPass').val();
			if (editSql(payload)) {
		    	$.blockUI();
				submitRequest(payload);
			}
		}
	});
});

function clear() {

   	$('.userMsg').html('');
   	$('.rowId').html('');
   	$('.refId').html('');
	$('input[name=type][value="jdbc:oracle:thin"]').prop('checked', false);
   	$('input[name=type][value="jdbc:db2"]').prop('checked', false);
   	$('input[name=type][value="jdbc:sqlserver"]').prop('checked', false);
   	$('input[name=type][value="jdbc:mySql"]').prop('checked', false);
   	$('.server').val('');
   	$('.schema').val('');
   	$('.dbUser').val('');
   	$('.dbPass').val('');
   	$('.editMsg').html('');
   	$('.copy').hide('slow');
}

function doTypeCheckbox(type) {
   	if (type=='jdbc:oracle:thin') {
   		$('input[name=type][value="jdbc:oracle:thin"]').prop('checked', true);
   	} else if (type=='jdbc:db2') {
       	$('input[name=type][value="jdbc:db2"]').prop('checked', true);
   	} else if (type=='jdbc:sqlserver') {
   		$('input[name=type][value="jdbc:sqlserver"]').prop('checked', true);
   	} else if (type=='jdbc:mySql') {
   		$('input[name=type][value="jdbc:mySql"]').prop('checked', true);
   	} else {
   		$('input[name=type][value="jdbc:oracle:thin"]').prop('checked', false);
   		$('input[name=type][value="jdbc:db2"]').prop('checked', false);
   		$('input[name=type][value="jdbc:sqlserver"]').prop('checked', false);
   		$('input[name=type][value="jdbc:mySql"]').prop('checked', false);
   	}
}
function editSql(payload) {

	var valid = true;
	if (payload.server.length==0) {
		valid = false;
		$('.editMsg').html('Server must be entered')
	}
	if (payload.type.length==0) {
		valid = false;
		$('.editMsg').html('JDBC Type must be chosen')
	}
	if (payload.dbUser.length==0) {
		valid = false;
		$('.editMsg').html('Username must be entered')
	}
	return valid;
}

function setDbUser(type) {
	if (type=='jdbc:sqlserver') {
		$('.dbUser').val('SIadmin');
		$('.dbPass').val('SIadmin$07');
	} else if (type=='jdbc:oracle:thin') {
		$('.dbUser').val('IB_OQ');
		$('.dbPass').val('B01se17');
	} else if (type=='jdbc:db2') {
		$('.dbUser').val('webfocus');
		$('.dbPass').val('O2b4Tagain');
	} else if (type=='jdbc:mySql') {
		$('.dbUser').val('mySql');
		$('.dbPass').val('');
	}
}

function submitRequest(payload) {

	$.ajax({
       		type: "POST",
       		contentType: "application/json",
       		url: "databaseConnect.do",
       		xhrFields: {withCredentials: true},
       		cache: false,
       		timeout: 600000,
       		dataType: 'json',
       		data: JSON.stringify(payload),        
       		success: function(data) {
       				postUserMsg(JSON.stringify(data));
       				var rowId     = data.rowId;
       				var dbPass = data.sqlQuery.status=='pass'?true:false;
       				$(".seedData").each(function() {
       					var celVal = $(this).find('td').next().html();
       					if (rowId==celVal) {
           					$(this).removeClass('pass');
           					$(this).removeClass('fail');
           					$(this).removeClass('selected');
           					var inObj = $(this).find('input');
       						if (dbPass) {
           						$(this).addClass('pass');
       							$(this).find('th').find('input').prop('checked',true);
       							$(this).find('th').find('input').next().prop('checked',false);
       						} else {
           						$(this).addClass('fail');
       							$(this).find('th').find('input').prop('checked',false);
       							$(this).find('th').find('input').next().prop('checked',true);
       						}
       					}
       				});
       		    	$.unblockUI();
       			},
       		error: function (e) {
       				postUserMsg(JSON.stringify(data));
   		    		$.unblockUI();
   				}
  	});
}

function updateServerList(payload) {

	$.ajax({
       		type: "POST",
       		contentType: "application/json",
       		url: "updateServerList.do",
       		xhrFields: {withCredentials: true},
       		cache: false,
       		timeout: 600000,
       		dataType: 'json',
       		data: JSON.stringify(payload),        
       		success: function(data) {
       				postUserMsg(JSON.stringify(data));
       		    	getServerList();
       		    	$.unblockUI();
       			},
       		error: function (e) {
       				postUserMsg(JSON.stringify(data));
   		    		$.unblockUI();
   				}
  	});
}

function getServerList() {

   	var payload = new Object();
   	payload.request = 'getServerList()';
	$.ajax({
       		type: "POST",
       		contentType: "application/json",
       		url: "getServerList.do",
       		xhrFields: {withCredentials: true},
       		cache: false,
       		timeout: 600000,
       		dataType: 'json',
       		data: JSON.stringify(payload),        
       		success: function(data) {
       				var rowClass = ['altDark','altLight'];
       				$('.serverList').html('');
       				for (var i=0;i<data.length;i++) {
           				var body = '';
       					var clazz = rowClass[(i%2)];
       					body += '<tr class="seedData '+clazz+'">'
       					body += '<td><input type="checkbox" name="test" class="test"></td>';
       					body += '<td class="seqData"  >'+(i+1)+'.</td>'
       					body += '<td class="seqRef"   >'+data[i].refId+'</td>';
       					body += '<td class="seqType"  >'+data[i].jdbcType+'</td>';
       					body += '<td class="selServer">'+data[i].server+'</td>';
       					body += '<td class="selSchema">'+data[i].dbInstance+'</td>';
       					body += '<th>';
       					body += '<input type="checkbox" name="ckBox" class="ckBox ok">';
           				body += '<input type="checkbox" name="ckBox" class="ckBox">';
               			body += '</th>';
       					body += '</tr>';
       					$('.serverList').append(body);
       				}
       				
       		    	$.unblockUI();
       			},
       		error: function (e) {
       				postUserMsg(JSON.stringify(data));
   		    		$.unblockUI();
   				}
  	});
}

function initStripe() {

	$(".ckBox").prop('checked',false);
	$(".test").prop('checked',false);
	$(".testAll").prop('checked',false);
	var row =0;
	$(".seqData").each(function() {
		row++;
		$(this).html(row+'.');
	});
	var rowClass = ['altLight','altDark'];
	$('.serverList tr').each(function() {
		$(this).css("background-color","");
		$(this).removeClass(rowClass[0]);
		$(this).removeClass(rowClass[1]);
		var clazz = rowClass[((row++)%2)];
		$(this).addClass(clazz);
		$(this).removeClass('pass');
		$(this).removeClass('fail');
		$(this).removeClass('selected');
	});
}

function postUserMsg(msg) {
	var msgContainer = document.getElementById('msgContainer');
	var txt = document.createTextNode(msg);
	var li  = document.createElement('li')
	li.appendChild(txt);
	msgContainer.appendChild(li);
	return true;
}

</script>
</head>
<body>
<div>&nbsp;</div>
<div><b>Build: ${buildTimestamp}</b></div>
<div align="center">
<div>
	<table> 
		<tr class="head head0"><td><img src="https://b2btools.bc.com/IBMSterlingTools/images/BccTree.png" /></td></tr>
		<tr class="head head0"><td>Boise Cascade Company</td></tr>
		<tr class="title head1"><td>${pageContext.request.serverName}</td></tr>
		<tr class="title head2"><td>&nbsp;</td></tr>
	</table>
</div>
<div>
<table class="baseTable">
<tr>
 <td>
 <table>
	<thead>
		<tr><td colspan="5">&nbsp;</td></tr>
		<tr>
			<td colspan="2">&nbsp;</td>
			<th colspan="2">&nbsp;</th>
			<th colspan="2" align="center"><a href="javascript:;" class="clearChk">clear</a></th>
		</tr>
		<tr>
			<td><input type="checkbox" name="testAll" class="testAll"></td>
			<td>&nbsp;</td>
			<td class="seqRef">&nbsp;</td>
			<th>Type</th>
			<th>Server</th>
			<th>Instance</th>
			<th>pass/fail</th>
		</tr>
	</thead>
	<tbody class="serverList">
	</tbody>
	<tfoot>
		<tr><td colspan="3">&nbsp;</td></tr>
		<tr>
			<td colspan="3"><a href="javascript:;" class="subList exec">Test</a></td>
			<th colspan="1"><a href="javascript:;" class="refreshList">Refresh</a></th>
			<th colspan="2" align="center"><a href="javascript:;" class="clearChk">clear</a></th>
		</tr>
	</tfoot>
	</table>
 </td>
 <td>
<table>
	<tbody>
		<tr class="seqRef">
			<td>&nbsp;</td>
			<td class="refId"></td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td class="title">RowId</td>
			<td class="rowId"></td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td class="title">Server</td>
			<td><input type="text" name="server" class="server" size="40" /></td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td class="title">Instance:</td>
			<td><input type="text" name="schema" class="schema" size="40" /></td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td class="title">UserId:</td>
			<td><input type="text" name="dbUser" class="dbUser" size="40" /></td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td class="title">Password:</td>
			<td><input type="text" name="dbPass" class="dbPass" size="40" /></td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td>
			 	<table>
					<tr><td><input type="checkbox" name="type" class="type" value="jdbc:db2"         /></td><td>jdbc:db2</td></tr>
					<tr><td><input type="checkbox" name="type" class="type" value="jdbc:mySql"       /></td><td>jdbc:mySql</td></tr>
					<tr><td><input type="checkbox" name="type" class="type" value="jdbc:oracle:thin" /></td><td>jdbc:oracle:thin</td></tr>
			 		<tr><td><input type="checkbox" name="type" class="type" value="jdbc:sqlserver"   /></td><td>jdbc:sqlserver</td></tr>
			 	</table>
			</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td align="center"><a href="javascript:;" class="dbTest exec">Test</a></td>
			<td>&nbsp;</td>
		</tr>
		<tr><td colspan="3">&nbsp;</td></tr>
		<tr>
			<td colspan="3" width="100%">
			 	<table width="100%">
			 		<tr>
						<td align="left"  ><a href="javascript:;" class="clear" >Clear</a></td>
						<td align="center"><a href="javascript:;" class="delete">Delete</a></td>
						<td align="center" ><a href="javascript:;" class="save"  >Save</a></td>
						<td align="right"  ><a href="javascript:;" class="title copy">Copy</a></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td colspan="3" class="editMsg">&nbsp;</td></tr>
	</tbody>
</table>
</td>
</tr>
</table>
</div>
<div>&nbsp;</div>
<div align="center">
	<div align="left">
		<ol id="msgContainer" class="userMsg"></ol>
	</div>
</div>
</div>
</body>
