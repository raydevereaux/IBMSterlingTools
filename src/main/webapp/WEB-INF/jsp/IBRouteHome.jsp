<%@ page language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<jsp:useBean id="now" class="java.util.Date" scope="request" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<html>
<head>
<link rel="shortcut icon" type="image/x-icon" href="images/BccTree.png">
<title>IBRouteHome.jsp</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="css/flora.datepick.css" type="text/css" />
<link rel="stylesheet" href="css/b2btools.css" type="text/css" />
<script type="text/javascript" src="webjars/jquery/jquery.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script> <!-- draggable -->
<script type="text/javascript" src="js/jquery-2.70.0.blockUI.js"></script> <!--  curtain -->
<script type="text/javascript" src="js/jquery.datepick.js"></script> <!-- dates -->
<script type="text/javascript" src="js/BccCustomObjects.js"></script> <!--  scrolling -->
<script type="text/javascript" src="js/b2btools.js"></script>
<script type="text/javascript" src="https://bcsm-t.bc.com/helpwidget/iTopWidget/ItopWidget.js"></script>

</head>

<style>
/*Override margins*/
th {
border-bottom-style: solid;
border-width: 1px;
text-decoration:none;
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
text-decoration:none;
text-align:center;
}
a.head {
text-decoration:none;
}
.view {
font-size:16px;
font-weight:bold;
text-align:center;
}
.baseTable {
border-radius: 1em;
border: solid #487831;
}
.partnerListTable {
padding: 10 10 10 10;
}
.partnerListTable .serverChoice {
font-weight:bold;
}
td {
vertical-align:top;
padding: 5 5 5 5;
}
.QueryResultMsg {
text-align:center;
color:black;
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
.small {
font-size:10px;
font-weight:bold;
}
.small:hover {
font-size:20px;
font-weight:bold;
}
tfoot td {
padding-top:10px;
padding-bottom:10px;
}
.bccDialog {
border-radius: .5em;
border: solid #487831;
}
.ui-dialog-titlebar {
border-radius: 1em;
color:white;
background-color:#2E8B57;
}
.prev {
text-align:left;
color:brown;
}
.next {
text-align:right;
color:brown;
}
.title {
text-align:center;
font-size:16pt;
font-weight:bold;
border-radius: .5em;
color:white;
background-color:#ffffff;
}
.msgBody {
border-radius: .5em;
text-align:center;
}
table .dataEntry td {
padding: 1px 1px 1px 1px;
}
.jsonText {
font-size:14px;
}
.detail th {
padding: 10px 10px 10px 10px;
text-align:left;
}
.clearCal {
font-size:12px;
color:black;
}
.detail td a {
color:blue;
font-weight:bold;
font-size:16px;
text-decoration:none;
}
.clearCal {
color:blue;
}
.ctrlMod {
color:blue;
text-decoration:none;
}
.refId {
color:blue;
text-decoration:none;
text-align:center;
}
.selectRow {
background-color: #20f0c7;
color: #000000;
}
.toolbar {
position: absolute;
left: 20px;
top: 50px;
opacity:1.5;
}
.absTable {
position: absolute;
left: 10px;
top: 20px;
opacity:1.5;
}
.viewClear {
text-decoration:none;
}
.error {
background-color:#ff0000;
color:#ffffff;
text-align:center;
}
.errItem {
background-color:#ff0000;
color:#ffffff;
}
.none {
text-decoration: none;
color:black;
}
.hprd .bprd {
color:black;
font-style: normal;
}
.htst .btst {
color:darkgreen;
font-style: italic;
}
.hdev .bdev {
color:darkorange;
font-style: italic;
}
.hmig .bmig {
color:darkred;
font-style: oblique;
}
.hover {
font-weight:bold;
font-size:15px;
}
.warning {
color:#ffffff;
background-color:#ff0000;
font-weight:bold;
text-align:center;
}
.support {
font-weight:bold;
color:#000000;
text-decoration:none;
}
.support:hover {
font-size:24px;
color:#ff9900;
}
.footer td {
padding-top:0px;
padding-bottom:0px;
}
.domainDB {
background-color:white;
}
.domainDB td {
padding: 1 1 1 1;
}
.serverChoice {
color:black;
}
.ctrlCopy {
color:#ffffff;
background-color:#ff0000;
font-weight:bold;
text-align:center;
}
</style>
<form:form method="get" modelAttribute="TPPartner" action="ibWeblogHome.do" id="TPPartner" >

<script type="text/javascript">

// did this to implement security.  ajax creates this situation. 
// var 'restricted' is added js uses .parent() to overlay the <a> tag contents (gets rid of rad js errors) 
	var restricted = '${restricted}';
//Global variables
    var mobileDevice = false;
	var barStyle = ['altlight','altDark'];   
 	var sSeqId  = '-1';
 	var pageSel = 0;
  	var refId;
  	var senderId;
  	var statusObjRow;
 	var banner  = ['OrigUrl', 'Request', 'Response', 'Exception'];
 	var popData = ['Requested-Url', 'Orig-Request', 'Final-Response', 'Exec-Exception'];
 	
$(document).ready(function() {

	try {
		var itopTile = $('.itopContainer');
		var thisUser = 'ry'; //'e136510';
		itopCallback(itopTile, Load);
		itopCallback(thisUser, Activate);
	} catch(error) {
		console.error(error);
	}	
// initial page setup
    $.blockUI({message: null});
	InitialPageLoad();
	setTimeout(function() {$.unblockUI();}, 500);
	$('.iServerDomain').val('bdev');
	getIBWebCtrl('bdev','', '', '');

//end

	$('.serverArea').change(function() {
		var serverArea = $("input[name=serverArea]:checked").val();
 		$('input[name=serverRadio]').each(function(){
      		$(this).prop('checked', false);
  		});
		switch (true) {
			case serverArea=='bfp':
				$('.domainHR').hide();
				$('.domainFP .qNav').parent().show('slow');
				$('.domainFP').show('slow');
				break;
			case serverArea=='hhr':
				$('.domainFP').hide();
				$('.domainHR .qNav').parent().show('slow');
				$('.domainHR').show('slow');
				break;
  			default:
				$('.domainFP').show('slow');
				$('.domainHR').show('slow');
				$('.serverDropDown').val(serverArea);
				$('.serverChoice').html(serverArea);
    			$.blockUI({message: null});
				setTimeout(function() {$.unblockUI();}, 500);
				break;
		}
	});

	$('.serverRadio').click(function() {
		var serverDomain = $("input[name=serverRadio]:checked").val();
 		$('input[name=serverArea]').each(function(){
      		$(this).prop('checked', false);
      		if (serverDomain.substring(0,1)==$(this).val().substring(0,1)) {
      			$(this).prop('checked', true);
      		}
  		});
		$('.serverChoice').html(serverDomain);
		$('.serverDropDown').val(serverDomain);
    	$.blockUI({message: null});
		setTimeout(function() {$.unblockUI();}, 500);
	});

	$('.routeDialog .iServerDomain').change(function() {
		//var serverDomain = $('.routeDialog .iServerDomain').val();
		var serverDomain = $('.iServerDomain').val();
		$('.notifyGroup .iServerDomain').html(serverDomain);
		var senderId     = '';   // $('.iSenderId').val();
		var receiverId   = '';   //$('.iReceiverId').val();
		var docType      = '';   //$('.iDocType').val();
		clearEntry();
    	var msg = getIBWebCtrl(serverDomain, senderId, receiverId, docType);
    });

	$(".pathCheck").click(function() {
		// .replace('\', '/');
		var regex = /\x5c/g
		var sPath = $('.filepath').val();
		var fPath = sPath.replace(regex, '/');
		if (fPath.substring(1,2)==':') {
			fPath = '/bcapps'+fPath.substring(2,fPath.length);
		}
		if (fPath.substring(fPath.length -1,fPath.length)!='/') {
			fPath = fPath+'/';
		}
        var fName = $('.filename').val();
		$('.filepath').val(fPath);
    	$('.execObjName').val(fPath+fName);
	});

	$('.filename, .filepath').change(function() {
        var fPath = $('.filepath').val();
        var fName = $('.filename').val();
        var nChar = fName.substring(0,1);
        var pChar = fPath.substring(fPath.length -1,fPath.length)
        if (nChar =='/'||nChar =='.') { fName = fName.substring(1,fName.length); }
        if (pChar !='/') { fPath = fPath+'/'; }
        $('.execObjName').val(fPath+fName);
        $('.filepath').val(fPath);
        $('.filename').val(fName);
	});
	
	$('.nameClear').click(function() {
        $('.filename').val('');
	});
	
	$('.ctrlMsg').click(function() {
    	$('.ctrlMsg').html('');
	});
	
	$(".ctrlServer").change(function() {
		var refId = $('.ctrlRefId').html();
		if (refId==''||refId=='0') {
			//continue
		} else {
			$('.ctrlCopy').show('slow');
		}
		$('.ctrlRefId').html('0');
	});
	
	$(".renameNode").click(function() {
        var node = $(this).html();
        var path = $('.filepath').val();
        var name = $('.filename').val();
        if (node.substring(0,1)=='.') {node = node.substring(1,node.length);}
        if (name.length>0) {name +='.';}
        $('.filename').val(name+node);
		var execType       = $("input[name='execType']:checked").val();
		if (execType=='FilePath') {
        	$('.execObjName').val(path+name+node);
		}
        if ($('.execObjName').val().length>200) {alert('Template Truncation will occur on save!');}
	});
	
    $( document ).on( 'click', '.ctrlMod', function() {
      var ctrlServer     = $('.iServerDomain').val();
	  var tdObj          = $(this).parent().parent().find('td');
	  var refId          = tdObj.next().html();
	  var senderId       = tdObj.next().next().find('a').html();
	  var receiverId     = tdObj.next().next().next().html();
	  var docType        = tdObj.next().next().next().next().html();
	  var execType       = tdObj.next().next().next().next().next().html();
	  var execStatus     = tdObj.next().next().next().next().next().next().html();
	  var execObjName    = tdObj.next().next().next().next().next().next().next().html();
	  var ctrlSeqCheck   = 'no'; //tdObj.next().next().next().next().next().next().next().next().html();
	  var ctrlSeqNumber  = tdObj.next().next().next().next().next().next().next().next().next().html();
	  var notifyRefId    = tdObj.next().next().next().next().next().next().next().next().next().next().html();
      var notifyGroup    = tdObj.next().next().next().next().next().next().next().next().next().next().next().html();
	  var replyType      = tdObj.next().next().next().next().next().next().next().next().next().next().next().next().html();
	  var restrictAccess = tdObj.next().next().next().next().next().next().next().next().next().next().next().next().next().html();
	  clearEntry();
	  $('.ctrlServer').val(ctrlServer);
	  $('.ctrlRefId').html(refId);
      $('.senderId').val(senderId);
      $('.receiverId').val(receiverId);
      $('.docType').val(docType);
	  $('input[name=execType][value=' + execType + ']').prop('checked', true);
	  $('input[name=execStatus][value=' + execStatus + ']').prop('checked', true);
	  execObjName = $.trim(execObjName);
      $('.execObjName').val(execObjName);

  	$('.filepath').val('');
  	$('.filename').val('');
	if (execType=='FilePath') {
		var pos = execObjName.lastIndexOf('/') +1;
		if (pos >0) {
      		$('.filepath').val(execObjName.substring(0,pos));
      		$('.filename').val(execObjName.substring(pos,execObjName.length));
		}
	}

     $('input[name=ctrlSeqCheck][value=' + ctrlSeqCheck + ']').prop('checked', true);
      $('.ctrlSeqNumber').val(ctrlSeqNumber);
	  $('input[name=alertGrp][value=' + notifyRefId + ']').prop('checked', true);
      $('.notifyRefId').val(notifyRefId);
	  $('input[name=replyType][value=' + replyType + ']').prop('checked', true);
	  $('input[name=restrictAccess][value=' + restrictAccess + ']').prop('checked', true);
	  	  
	  $('.ctrlMsg').html(' ');
    });
  
	$('.ctrlNew').click(function() {
		clearEntry();
    	$('.senderId').focus();
    	
    });

	$('.ctrlCancel').click(function() {
		clearEntry();
    });

	$('.ctrlDelete').click(function() {
	
		$('.ctrlMsg').html('');
		var refId = $('.ctrlRefId').html();
		if (refId=='1') {
			alert('Protector: You May Not Delete this Control Entry');
		} else if (confirm('Delete This Control Entry?')) {
			var bean = createCtrlBean('delete');
			if (bean.BC_REFID>0) {
				if (bean.securityToken.length==0) {
					$('.securityDialog').dialog('open');
					$('.securityToken').focus();
				} else {
					var rtn = updWebCtrl(bean);
				}
			} else {
				var validData = appendError('Invalid RefId');
			}
		} else {
			$('.ctrlMsg').html('Delete Aborted');
		}
    	
    });
     
	$('.ctrlSave').click(function() {
		var refId = $('.ctrlRefId').html();
		var oper = 'update';
		if (refId==''||refId=='0') {oper = 'insert';}
		var bean = createCtrlBean(oper);
		if (bean.validData) {
			if (bean.securityToken.length==0) {
				$('.securityDialog').dialog('open');
				$('.securityToken').focus();
			} else {
    			$.blockUI({message: null});
				var rtn = updWebCtrl(bean);
				setTimeout(function() {$.unblockUI();}, 500);
			}
		}
    });
 
	$('.ctrlRefresh').click(function() {
		refresh();
    });  

	$('.username').click(function() {
		$('.securityDialog').dialog('open');
		$('.securityToken').focus();
    });

	$( document ).on( 'click', '.notifyGroup .groupName', function() {
		var trObj = $(this).parent().parent().find('td');
		var refId     = trObj.html();
		var itemId    = trObj.next().html();
		var groupName = trObj.next().next().next().find('a').html();
		var email     = trObj.next().next().next().next().html();
		var status    = trObj.next().next().next().next().next().html();

		$('.notGroupRefId').val(refId);
		$('.notGroupItem').val(itemId);
		$('.notGroupName').val(groupName);
		$('.notGroupEmail').val(email);
		$('.notGroupStatus').val(status);
    });
    
	$('.notifyGroupMod').click(function() {
		var del = $(this).hasClass('del');
		var upd = $(this).hasClass('upd');
		var ins = $(this).hasClass('ins');
		var operation = ""
		if (del) {
			operation = "delete";
		} else if (upd) {
			operation = "update";
		} else if (ins) {
			operation = "insert";
		}
		var notifyBean = createNotifyBean(operation);
		if (notifyBean.securityToken.length==0) {
			$('.securityDialog').dialog('open');
			$('.securityToken').focus();
		} else {
			var msg = execNotifyUpdate(notifyBean);
			/// $('.resultDialog').dialog('open');
		}
    });
    
	$('.notifyGroupView').click(function() {
		var serverDomain = $('.routeDialog .iServerDomain').val();
		var msg = execIbWebNotify(serverDomain);
		$('.notifyGroupServerDomain').html(serverDomain);
		$('.notifyGroup .notGroupRefId').val('');
		$('.notifyGroup .notGroupItem').val('');
		$('.notifyGroup .notGroupName').val('');
		$('.notifyGroup .notGroupEmail').val('');
		$('.notifyGroup .notGroupStatus').val('');
		$('.notifyGroup .notGroupMsg').html('');
		$('.notifyGroupDialog').dialog('open');
	});
 
	$('.encode').click(function() {
		$('.securityDialog').dialog('close');
    });
      
	$('.security .securityToken').change(function() {
		var securityToken = $('.security .securityToken').val();
		var encodedObj  = encrypt(securityToken);
		$('.security .securityToken').val(encodedObj.encodedToken);
		$('.username').html(encodedObj.username);
		$('.security .securityToken').focus();
    });

    $( '.securityDialog' ).dialog({
      autoOpen: false,
      show: {effect: 'blind', duration: 1000 },
      hide: {effect: 'explode', duration: 1000},
      dialogClass: 'bccDialog',
      height: 200,
      width: 400
    });

    $( '.notifyGroupDialog' ).dialog({
      autoOpen: false,
      show: {effect: 'blind', duration: 1000 },
      hide: {effect: 'explode', duration: 1000},
      dialogClass: 'bccDialog',
      height: 500,
      width: 600
    }); 
    
});

function InitialPageLoad() {

	if (/Mobi/.test(navigator.userAgent)) {
		mobileDevice = true;
	}
	// initial security
	if (restricted=='true') {
		$('.serverDomain option[value="hprd"]').remove();
		hideRestricted();
	}
    $('.ctrlCopy').hide('slow');
	return true;
}

function clearEntry() {

	$('.ctrlServer').val('');
	$('.ctrlRefId').html(0);
	$('.senderId').val('');
	$('.receiverId').val('');
	$('.docType').val('');
    $('.execType').attr('checked',false);
    $('.execStatus').attr('checked',false);
	$('.execObjName').val('');
    $('.execStatus').attr('checked',false);
    //$('.ctrlSeqCheck').attr('checked',false);
	$('.ctrlSeqNumber').val('');
	$('.notifyRefId').val('0');
   	$('.replyType').attr('checked',false);
   	$('.restrictAccess').attr('checked',false);
	//$('.ctrlMsg').html('');
	$('.log-container').html('');
    $('.warn').css("color","#000000");
    $('.warn').css("font-weight","normal");
	$('.filepath').val('');
	$('.filename').val('');
	$('.notifyGroupDialog').dialog('close');
    $('.ctrlCopy').hide('slow');
    return true;
}

function encrypt(token) {

	var rtn =  new Object(); 
	var Base64={_keyStr:"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=",encode:function(e){var t="";var n,r,i,s,o,u,a;var f=0;e=Base64._utf8_encode(e);while(f<e.length){n=e.charCodeAt(f++);r=e.charCodeAt(f++);i=e.charCodeAt(f++);s=n>>2;o=(n&3)<<4|r>>4;u=(r&15)<<2|i>>6;a=i&63;if(isNaN(r)){u=a=64}else if(isNaN(i)){a=64}t=t+this._keyStr.charAt(s)+this._keyStr.charAt(o)+this._keyStr.charAt(u)+this._keyStr.charAt(a)}return t},decode:function(e){var t="";var n,r,i;var s,o,u,a;var f=0;e=e.replace(/[^A-Za-z0-9\+\/\=]/g,"");while(f<e.length){s=this._keyStr.indexOf(e.charAt(f++));o=this._keyStr.indexOf(e.charAt(f++));u=this._keyStr.indexOf(e.charAt(f++));a=this._keyStr.indexOf(e.charAt(f++));n=s<<2|o>>4;r=(o&15)<<4|u>>2;i=(u&3)<<6|a;t=t+String.fromCharCode(n);if(u!=64){t=t+String.fromCharCode(r)}if(a!=64){t=t+String.fromCharCode(i)}}t=Base64._utf8_decode(t);return t},_utf8_encode:function(e){e=e.replace(/\r\n/g,"\n");var t="";for(var n=0;n<e.length;n++){var r=e.charCodeAt(n);if(r<128){t+=String.fromCharCode(r)}else if(r>127&&r<2048){t+=String.fromCharCode(r>>6|192);t+=String.fromCharCode(r&63|128)}else{t+=String.fromCharCode(r>>12|224);t+=String.fromCharCode(r>>6&63|128);t+=String.fromCharCode(r&63|128)}}return t},_utf8_decode:function(e){var t="";var n=0;var r=c1=c2=0;while(n<e.length){r=e.charCodeAt(n);if(r<128){t+=String.fromCharCode(r);n++}else if(r>191&&r<224){c2=e.charCodeAt(n+1);t+=String.fromCharCode((r&31)<<6|c2&63);n+=2}else{c2=e.charCodeAt(n+1);c3=e.charCodeAt(n+2);t+=String.fromCharCode((r&15)<<12|(c2&63)<<6|c3&63);n+=3}}return t;}}
	var colon = token.indexOf(':');
	if (colon>0) {
		rtn.encodedToken = Base64.encode(token);
		rtn.username = token.substr(0,colon);
	} else {
		alert('token must have a colon embeded');
		rtn.encodedToken = '';
		rtn.username     = '';
	}
	return rtn;
}

function refresh() {
	var serverDomain = $('.iServerDomain').val();
	var senderId     = '';   // $('.iSenderId').val();
	var receiverId   = '';   //$('.iReceiverId').val();
	var docType      = '';   //$('.iDocType').val();
	clearEntry();
	var msg = getIBWebCtrl(serverDomain, senderId, receiverId, docType);
} 

function createCtrlBean(oper) {

		var securityToken = $('.security .securityToken').val();
		var serverDomain   = $('.ctrlServer').val();
		var refId          = $('.ctrlRefId').html();
		var senderId       = $('.senderId').val();
		var receiverId     = $('.receiverId').val();
		var docType        = $('.docType').val();
		var execType       = $("input[name='execType']:checked").val();
		var execStatus     = $("input[name='execStatus']:checked").val();
		var execObjName    = $('.execObjName').val();
		var ctrlSeqCheck   = 'no'; //$("input[name='ctrlSeqCheck']:checked").val();
		var ctrlSeqNumber  = '0'; //$('.ctrlSeqNumber').val();
		var notifyRefId    = $("input[name='alertGrp']:checked").val();
		var replyType      = $("input[name='replyType']:checked").val();
		var restrictAccess = $("input[name='restrictAccess']:checked").val();
		var validData = true;
		if (notifyRefId==null) {notifyRefId = 0;}
		if (ctrlSeqNumber==null) {ctrlSeqNumber = 0;}
		
		$('.log-container').html('');
		if (senderId.length==0) {
			validData = appendError('SenderID is empty');
		}
		if (receiverId.length==0) {
			validData = appendError('ReceiverID is empty');
		}
		if (docType.length==0) {
			validData = appendError('DocType is empty');
		}
		
		var bean =  new Object(); 
		bean.securityToken      = securityToken;
		bean.operation          = oper;
		bean.serverDomain       = serverDomain;
		bean.BC_REFID           = refId;
		bean.BC_SENDERID        = senderId;
		bean.BC_RECEIVERID      = receiverId;
		bean.BC_DOCTYPE         = docType;
		bean.BC_EXECTYPE        = execType;
		bean.BC_EXECOBJNAME     = execObjName;
		bean.BC_EXECSTATUS      = execStatus;
		bean.BC_CTRL_SEQCHECK   = ctrlSeqCheck;
		bean.BC_CTRL_SEQNUMBER  = ctrlSeqNumber;
		bean.BC_NOTIFY_REFID    = notifyRefId;
		bean.BC_REPLYTYPE       = replyType;
		bean.BC_RESTRICT_ACCESS = restrictAccess;
		bean.validData        = validData;
		
		return bean;
}

function closeDiaglogs() {
	try {
		$('.securityDialog').dialog('close');
		$('.notifyGroupDialog').dialog('close');
		$('.msgBody').html('');
	} catch (exception) {
		console.log(exception);
	}
	return true;
}    

function appendError(msg) {
	var log_container = document.getElementById('log-container');
	var txt = document.createTextNode(msg);
	var li  = document.createElement("li");
	li.appendChild(txt);
	log_container.appendChild(li);
    $('.warn').css("color","#ff0000");
    $('.warn').css("font-weight","bold");
	return false;
}

function createNotifyBean(operation) {

	var securityToken = $('.security .securityToken').val();
	var notifyBean =  new Object();
	notifyBean.securityToken    = securityToken;
	notifyBean.operation        = operation;
	notifyBean.serverDomain     = $('.notifyGroupServerDomain').html();
	notifyBean.BC_NOTIFY_REFID  = $('.notGroupRefId').val();
	notifyBean.BC_NOTIFY_ITEM   = $('.notGroupItem').val();
	notifyBean.BC_GROUPNAME     = $('.notGroupName').val();
	notifyBean.BC_EMAIL_ADDR    = $('.notGroupEmail').val();
	notifyBean.BC_EXECSTATUS    = $('.notGroupStatus').val();
	return notifyBean;
}


function hideRestricted() {

	// attr added by b2btools.js
	$('.home').attr('href','ibWeblogHome.do');
	
   	$('.srcName').each(function() {
		var tagHtml = $(this).html();
		$(this).parent().html(tagHtml);
	});
   	$('.errItem').each(function() {
		var tagHtml = $(this).html();
		$(this).parent().html(tagHtml);
	});
	return true;
}

function createPopDataObj(obj) {

  	var refId      = obj.find('td').next().html();
    var url        = obj.find('td').next().next().html(); // url
    var request    = obj.find('td').next().next().next().html(); // request
    var response   = obj.find('td').next().next().next().next().html(); // response
    var exception  = obj.find('td').next().next().next().next().next().html(); // exception
    var senderId   = obj.find('td').next().next().next().next().next().next().html();
    
	var rowBean =  new Object();
	rowBean.refId     = refId;
	rowBean.url       = url;
	rowBean.request   = request;
	rowBean.response  = response;
	rowBean.exception = exception;
	rowBean.senderId  = senderId;
	return rowBean;
}

function updWebCtrl(webCtrl) {

	var msg = '';
	var payload = webCtrl;
	$.ajax({
		type: "POST",
		url: "updWebCtrl.do",
		contentType: "application/json",
		xhrFields: {withCredentials: true},
		cache: false,
		timeout: 600000,
		dataType: 'json',
		data: JSON.stringify(payload),        
		success: function(data) {$('.ctrlMsg').html(JSON.stringify(data)); refresh();},
		error: function(data) {$('.ctrlMsg').html('<td colspan="20">'+data+'</td>');}
	});
    return msg;
}

function execNotifyUpdate(webNotify) {

	var msg = '';
	//var payload = JSON.stringify(webNotify);
	$.ajax({
		type: "POST",
		contentType: "application/json",
		url: "updWebNotify.do",
		xhrFields: {withCredentials: true},
		cache: false,
		timeout: 600000,
		dataType: 'json',
		data: JSON.stringify(webNotify),        
		success: function(data) {
					$('.notGroupMsg').val(JSON.stringify(data));
	  				$('.resultText').val(JSON.stringify(data));
	  			},
		error: function (e) {
					var msg = '<td colspan="20">'+data+'</td>';
					$('.notGroupMsg').val(msg);
  					$('.resultText').val(msg);
				}
	});
    return msg;
}

function execIbWebNotify(serverDomain) {

	var msg = '';

	var payload = new Object();
	payload.serverDomain = serverDomain;
	$.ajax({
		type: "POST",
		url: "execIbWebNotify.do",
		contentType: "application/json",
		xhrFields: {withCredentials: true},
		cache: false,
		timeout: 600000,
		dataType: 'json',
		data: JSON.stringify(payload),        
		success: function(data) {
				var msg = '';
				for (var i=0;i<data.length;i++) {
					var seq = i+1;
					msg += '<tr class="'+barStyle[(seq%2)]+'">';
					msg += '<td style="display:none;">'+data[i].BC_NOTIFY_REFID+'</td>';
					msg += '<td style="display:none;">'+data[i].BC_NOTIFY_ITEM+'</td>';
					msg += '<td>'+seq+'.</td>';
					msg += '<td><a href="javascript:;" class="groupName" style="color:blue" title="Modify">'+data[i].BC_GROUPNAME+'</a></td>';
					msg += '<td>'+data[i].BC_EMAIL_ADDR+'</td>';
					msg += '<td>'+data[i].BC_EXECSTATUS+'</td>';
					msg += '</tr>';
				}
				$('.notifyGroup .notGroupList').html(msg);
			},
		error: function(data) {
				var msg = '<td colspan="20">'+data+'</td>';
				$('.notifyGroup .notGroupList').html(msg);
			}
	});
    return msg;
}

function getIBWebCtrl(serverDomain, senderId, receiverId, docType) {

	var msg = '';

	var payload = new Object();
	payload.serverDomain = serverDomain;
	payload.senderId = senderId;
	payload.receiverId = receiverId;
	payload.docType = docType;
    console.log(JSON.stringify(payload));
	$.ajax({
		type: "POST",
		url: "getWebCtrl.do",
		contentType: "application/json",
		xhrFields: {withCredentials: true},
		cache: false,
		timeout: 600000,
		dataType: 'json',
		data: JSON.stringify(payload),        
		success: function(data) {
	        	console.log(JSON.stringify(data));
	        	var msg = '';
				for (var i=0;i<data.length;i++) {
					var seq = i+1;
					msg += '<tr class="'+barStyle[(seq%2)]+'">';
					msg += '<td align="right">'+seq+'.</td>';
					msg += '<td style="display:none;">'+data[i].BC_REFID+'</td>';
					if (data[i].BC_REFID=='1') {
						msg += '<td style="color:red">'+data[i].BC_SENDERID+'</td>';
					} else {
						msg += '<td><a href="javascript:;" class="ctrlMod" title="Modify">'+data[i].BC_SENDERID+'</a></td>';
					}
					msg += '<td>'+data[i].BC_RECEIVERID+'</td>';
					msg += '<td>'+data[i].BC_DOCTYPE+'</td>';
					msg += '<td>'+data[i].BC_EXECTYPE+'</td>';
					msg += '<td>'+data[i].BC_EXECSTATUS+'</td>';
					msg += '<td>'+data[i].BC_EXECOBJNAME+'</td>';
					msg += '<td style="display:none;">'+data[i].BC_CTRL_SEQCHECK+'</td>';
					msg += '<td style="display:none;">'+data[i].BC_CTRL_SEQNUMBER+'</td>';
					msg += '<td style="display:none;">'+data[i].BC_NOTIFY_REFID+'</td>';
					msg += '<td align="center"">'+data[i].BC_GROUPNAME+'</td>';
					msg += '<td>'+data[i].BC_REPLYTYPE+'</td>';
					msg += '<td style="display:none">'+data[i].BC_RESTRICT_ACCESS+'</td>';
					msg += '</tr>';
				}
				$('.routeText').html(msg)
			},
		error: function(data) {
	        	console.log(JSON.stringify(data));
				var msg = '<td colspan="20">'+data+'</td>';
				$('.routeText').html(msg)
				}
	});
	return msg;

}

function icimsPostCall(json) {

	var msg = '';
	$.ajax({
		type: "POST",
		url: "icimsPost.do",
		contentType: "application/json",
		xhrFields: {withCredentials: true},
		cache: false,
		timeout: 600000,
		dataType: 'json',
		data: JSON.stringify(payload),        
		success: function(data) {
				var msg = JSON.stringify(data);
				$('.jsonText').html(msg);
				$('.jsonTextArea').val(msg);
				$('.resultText').val(msg);
			},
		error: function(data) {
				var msg = '<td colspan="20">'+data+'</td>';
				$('.jsonText').html(msg);
				$('.jsonTextArea').val(msg);
				$('.resultText').val(msg);
			}
	});
    return msg;
}

</script>
<div class="head" align="center"><img src="images/BccTree.png" class="ajaxRefresh" title="Click to Refresh Page" /></div>
<div class="head" align="center">Boise Cascade</div>
<div class="view">${pageContext.request.serverName}</div>
<div class="view page">Oracle IBRoute</div>
<div>&nbsp;</div>
<div align="center">
		<div class="routeDialog" title="Routing Insert/Update">
			<table class="dialogTable"> 
				<thead>
					<tr>
						<td class="itopContainer"></td>
						<td>&nbsp;     </td>
						<td>&nbsp;     </td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>Domain  </td>
						<td>
							<select name="iServerDomain" class="iServerDomain">
								<option value="hdev">hdev</option>
								<option value="htst">htst</option>
								<option value="hmig">hmig</option>
								<option value="hprd">hprd</option>
								<option value="bdev">bdev</option>
								<option value="btst">btst</option>
								<option value="bmig">bmig</option>
								<option value="bprd">bprd</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>&nbsp;     </td>
						<td style=" padding-top: 0px;">Security</td>
						<td style=" padding-top: 0px;"><a href="javascript:;" class="username">ClickHere</a></td>
					</tr>
					<tr>
						<th>&nbsp;     </th>
						<th>SenderId   </th>
						<th>ReceiverId </th>
						<th>DocType    </th>
						<th>ExecType   </th>
						<th>Active     </th>
						<th>ExecObjName</th>
						<th style="display:none;">SeqChk     </th>
						<th style="display:none;">SeqNo      </th>
						<th>Alert      </th>
						<th>type       </th>
						<th style="display:none">&nbsp;     </th>
				</thead>
				<tbody class="routeText">
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td>
							<table class="dataEntry">
								<tr>
									<td>
								<select name="ctrlServer" class="ctrlServer">
									<option value=""></option>
									<option value="hdev">hdev</option>
									<option value="htst">htst</option>
									<option value="hmig">hmig</option>
									<option value="hprd">hprd</option>
									<option value="bdev">bdev</option>
									<option value="btst">btst</option>
									<option value="bmig">bmig</option>
									<option value="bprd">bprd</option>
								</select>
									</td>
								</tr>
								<tr><td class="ctrlCopy">Copy</td></tr>
							</table>
						</td>
						<td style="display:none" class="ctrlRefId"></td>
						<td><input type="text" name="senderId"   class="senderId"     size="10" /></td>
						<td><input type="text" name="receiverId" class="receiverId"   size="10" /></td>
						<td><input type="text" name="docType"    class="docType"      size="3" /></td>
						<td>
							<table class="dataEntry">
								<tr><td><input type="radio" name="execType" class="execType" value="AppEngine"></td><td title="Sync ">AppEngine</td></tr>
								<tr><td><input type="radio" name="execType" class="execType" value="Scheduler"></td><td title="Async">Scheduler</td></tr>
								<tr><td><input type="radio" name="execType" class="execType" value="Job"      ></td><td title="Async">PSJob</td></tr>
								<tr><td><input type="radio" name="execType" class="execType" value="JavaClass"></td><td>JavaClass</td></tr>
								<tr><td><input type="radio" name="execType" class="execType" value="PackClass"></td><td>PackClass</td></tr>
								<tr><td><input type="radio" name="execType" class="execType" value="FilePath" ></td><td>FilePath</td></tr>
							</table>
						</td>
						<td>
							<table class="dataEntry">
								<tr><td><input type="radio" name="execStatus" class="execStatus"  value="yes" ></td><td>yes</td></tr>
								<tr><td><input type="radio" name="execStatus" class="execStatus"  value="no"  ></td><td>no </td></tr>
							</table>
						</td>
						<td>
							<table class="dataEntry">
								<tr><td colspan="10"><input type="text" name="execObjName" class="execObjName"   size="150" /></td></td></tr>
	<tr class="onlyFilepath">
		<td colspan="10">
			<span style="font-family:Courier New;">Filepath:</span>
			<input type="text" name="filepath" class="filepath"   size="125" />
			<a href="javascript:;" class="pathCheck" title="make linux path">linux</a>
		</td>
	</tr>
	<tr class="onlyFilepath">
		<td colspan="10">
			<span style="font-family:Courier New;">Filename:</span>
			<input type="text" name="filename" class="filename"   size="125" />
			<a href="javascript:;" class="nameClear">clear</a>
		</td>
	</tr>
	<tr class="onlyFilepath">
		<td>
			<ol start="1">
				<li><a href="javascript:;" class="renameNode" title="filename w/o .ext">&#36;{filename}</a></li>
				<li><a href="javascript:;" class="renameNode" title="filename .ext only">&#36;{ext}</a></li>
				<li><a href="javascript:;" class="renameNode" title="Seq no">&#36;{seqNo}</a></li>
				<li><a href="javascript:;" class="renameNode" title="this.hostname">&#36;{hostname}</a></li>
				<li><a href="javascript:;" class="renameNode" title="BPProcId">&#36;{absTimestamp}</a></li>
			</ol>
		</td>
		<td>
			<ol start="6">
				<li><a href="javascript:;" class="renameNode" title="yyyyMMddHHmmssnnn">&#36;{timestamp}</a></li>
				<li><a href="javascript:;" class="renameNode" title="yyyyMMddHHmmss">&#36;{dateTime}</a></li>
				<li><a href="javascript:;" class="renameNode" title="yyyyMMdd">&#36;{date}</a></li>
				<li><a href="javascript:;" class="renameNode" title="HHmmss">&#36;{time}</a></li>
				<li><a href="javascript:;" class="renameNode" title="MMddyyyy">&#36;{mdyDate}</a></li>
			</ol>
		</td>
		<td>
			<ol start="11">
				<li><a href="javascript:;" class="renameNode">&#36;{isaSenderId}</a></li>
				<li><a href="javascript:;" class="renameNode">&#36;{isaReceiverId}</a></li>
				<li><a href="javascript:;" class="renameNode">&#36;{isaDocType}</a></li>
				<li><a href="javascript:;" class="renameNode">&#36;{urlNode02}</a></li>
			</ol>
		</td>
		<td>
			<ol start="15">
				<li><a href="javascript:;" class="renameNode">&#36;{userId}</a></li>
				<li><a href="javascript:;" class="renameNode">&#36;{xref}</a></li>
				<li><a href="javascript:;" class="renameNode">&#36;{seq}</a></li>
				<li><a href="javascript:;" class="renameNode">&#36;{app}</a></li>
				<li><a href="javascript:;" class="renameNode">&#36;{proc}</a></li>
			</ol>
		</td>
		<td>
			<ol start="20">
				<li><a href="javascript:;" class="renameNode" title="filename">&#36;{node01}</a></li>
				<li><a href="javascript:;" class="renameNode" title="filename">&#36;{node02}</a></li>
				<li><a href="javascript:;" class="renameNode" title="filename">&#36;{node03}</a></li>
				<li><a href="javascript:;" class="renameNode" title="filename">&#36;{node04}</a></li>
			</ol>
		</td>
		<td>
			<ol start="24">
				<li><a href="javascript:;" class="renameNode" title="Static Value">.csv</a></li>
				<li><a href="javascript:;" class="renameNode" title="Static Value">.edi</a></li>
				<li><a href="javascript:;" class="renameNode" title="Static Value">.htm</a></li>
				<li><a href="javascript:;" class="renameNode" title="Static Value">.txt</a></li>
				<li><a href="javascript:;" class="renameNode" title="Static Value">.xml</a></li>
			</ol>
		</td>
	</tr>
							</table>
						</td>
						<td nowrap style="display:none;">
							<table class="dataEntry">
								<tr><td><input type="radio" name="ctrlSeqCheck" class="ctrlSeqCheck"  value="yes" >yes</td></tr>
								<tr><td><input type="radio" name="ctrlSeqCheck" class="ctrlSeqCheck"  value="no" checked="checked" >no</td></tr>
							</table>
						</td>
						<td valign="top" style="display:none;">
							<table class="dataEntry">
								<tr>
									<td style=" padding-top: 0px;" class="notifyDropdown">
									</td>
								</tr>
								<tr><td><input type="text" name="ctrlSeqNumber" class="ctrlSeqNumber" size="1" value="0" /></td></tr>
							</table>
						</td>
						<td style="display:none;">&nbsp;</td>
						<td>
							<table class="dataEntry">
								<tr><td><input type="radio" name="alertGrp" class="alertGrp" value="0"></td><td>none</td></tr>
								<tr><td><input type="radio" name="alertGrp" class="alertGrp" value="1"></td><td>AppGroup</td></tr>
								<tr><td><input type="radio" name="alertGrp" class="alertGrp" value="2"></td><td>Middleware</td></tr>
							</table>
						</td>
						<td>
							<table class="dataEntry">
								<tr><td><input type="radio" name="replyType" class="replyType"    value="json"></td><td>json</td></tr>
								<tr><td><input type="radio" name="replyType" class="replyType"    value="xml" ></td><td>xml </td></tr>
								<tr><td><input type="radio" name="replyType" class="replyType"    value="txt" ></td><td>txt </td></tr>
							</table>
						</td>
						<td style="display:none">
							<table class="dataEntry">
								<tr><td><input type="radio" name="restrictAccess" class="restrictAccess" value="open"     ></td><td>Open</td></tr>
								<tr><td><input type="radio" name="restrictAccess" class="restrictAccess" value="restrict" ></td><td>Restrict</td></tr>
							</table>
						</td>
						<td>&nbsp;</td><td class="createJTime"></td>
					</tr>
					<tr>
						<td colspan="12" width="100%">
							<table width="100%">
								<tbody class="dataEntry">
									<tr>
										<td align="left">  <a href="javascript:;" class="exec small ctrlDelete warn" >Delete     </a></td>
										<td align="center"><a href="javascript:;" class="exec small ctrlNew"         >New        </a></td>
										<td align="center"><a href="javascript:;" class="exec small ctrlSave warn"   >Save/Update</a></td>
										<td align="center"><a href="javascript:;" class="exec small notifyGroupView" >AlertGrp</a></td>
										<td align="center"><a href="javascript:;" class="exec small ctrlRefresh"     >Route Refresh </a></td>
									</tr>
								</tbody>
							</table>
						</td>
				</tfoot>
			</table>
			<table width="100%">
				<tr style="display:none;">
					<td><input type="text" name="iSenderId"     class="iSenderId"     size="10" /></td>
					<td><input type="text" name="iReceiverId"   class="iReceiverId"   size="10" /></td>
					<td><input type="text" name="iDocType"      class="iDocType"      size="3"  /></td>
				</tr>
			</table>
			<div align="center" class="ctrlMsg">&nbsp;</div>
			<div><ol id="log-container" class="log-container"></ol></div>
			<div>&nbsp;</div>
		</div>
	
<div class="securityDialog" title="Authentication">
	<table class="security dialogTable baseTable">
		<thead>
			<tr><td><a href="javascript:;" class="username" style="font-weight:bold;">UserName</a></td><td align="right">Username:password</td></tr>
		</thead>
		<tbody>
			<tr><td colspan="2"><input type="text" name="securityToken" class="securityToken" size="40" value="" /></td></tr>
		</tbody>
		<tfoot>
			<tr><td><a href="javascript:;" class="encode exec small" title="Encode">Encode</a></td><td align="right">Separate by colon</td></tr>
		</tfoot>
	</table>
</div>		
<div class="notifyGroupDialog" title="Notification Groups">
			<table>
				<tr>
					<td style=" padding-top: 0px;">Domain  </td>
					<td style=" padding-top: 0px;"><a href="javascript:;" class="notifyGroupServerDomain">hmig</a></td>
				</tr>
				<tr><td style=" padding-top: 0px;">Security</td><td style=" padding-top: 0px;"><a href="javascript:;" class="username">ClickHere</a></td></tr>
			</table>
	<table class="notifyGroup dialogTable baseTable">
		<thead>
			<tr>
				<td>&nbsp;</td>
				<td>GroupName</td>
				<td>email</td>
				<td>Active</td>
			</tr>
		</thead>
		<tbody class="notGroupList"></tbody>
		<tfoot>
			<tr>
				<td>&nbsp;</td>
				<td><input type="text" name="notGroupName"  class="notGroupName"  size="10" value="" /></td>
				<td><input type="text" name="notGroupEmail" class="notGroupEmail" size="30" value="" /></td>
				<td>
					<select name="notGroupStatus" class="notGroupStatus">
						<option value=""   >   </option>
						<option value="yes">yes</option>
						<option value="no" >no </option>
					</select>
				</td>
			</tr>
			<tr style="display:none;">
				<td>&nbsp;</td>
				<td><input type="text" name="notGroupRefId" class="notGroupRefId" size="1" value="" /></td>
				<td><input type="text" name="notGroupItem"  class="notGroupItem"  size="1" value="" /></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td align="left"  ><a href="javascript:;" class="notifyGroupMod del exec small" title="Encode">delete</a></td>
				<td align="center"><a href="javascript:;" class="notifyGroupMod ins exec small" title="Encode">insert</a></td>
				<td align="right" ><a href="javascript:;" class="notifyGroupMod upd exec small" title="Encode">update</a></td>
			</tr>
		</tfoot>
	</table>
	<div><textarea rows="1" cols="60" class="notGroupMsg"></textarea></div>
</div>

<div>&nbsp;</div>
</div>
</form:form>
</html>