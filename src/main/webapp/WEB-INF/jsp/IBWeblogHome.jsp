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
.htrn .btrn {
color:darkgreen;
background-color:yellow;
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

// initial page setup
    $.blockUI({message: null});
	InitialPageLoad();
    getIBQuery();
   	getIBCounts();
	setTimeout(function() {$.unblockUI();}, 500);
//end

	$('.toolbar').draggable();
	var ot00 = parseInt($('.toolbar').css('top').replace('px','').toInteger());
	var ft00 = parseInt($('.toolbar').css('left').replace('px','').toInteger());

	$('.serverArea').change(function() {
		var serverArea = $("input[name=serverArea]:checked").val();
 		$('input[name=serverRadio]').each(function(){
      		$(this).prop('checked', false);
  		});
		switch (true) {
			case serverArea=='bfp':
				//$('.domainHR').hide();
				$('.domainFP .qNav').parent().show('slow');
				$('.domainFP').show('slow');
				break;
			case serverArea=='hhr':
				//$('.domainFP').hide();
				$('.domainHR .qNav').parent().show('slow');
				$('.domainHR').show('slow');
				break;
  			default:
				$('.domainFP').show('slow');
				$('.domainHR').show('slow');
				$('.serverDropDown').val(serverArea);
				$('.serverChoice').html(serverArea);
    			$.blockUI({message: null});
    			getIBQuery();
    			getIBCounts();
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
    	getIBQuery();
    	getIBCounts();
		setTimeout(function() {$.unblockUI();}, 500);
	});
	
    $('.serverDropDown').change(function() {
 		$('input[name=serverRadio]').each(function(){
      		$(this).prop('checked', false);
      		if ($('.serverDropDown').val()==$(this).val()) {
      			$(this).prop('checked', true);
      		}
  		});
		var serverDomain = $('.serverDropDown').val();
 		$('input[name=serverArea]').each(function(){
      		$(this).prop('checked', false);
      		if (serverDomain.substring(0,1)==$(this).val().substring(0,1)) {
      			$(this).prop('checked', true);
      		}
  		});
		$('.serverChoice').html(serverDomain);
    	$.blockUI({message: null});
    	getIBQuery();
		setTimeout(function() {$.unblockUI();}, 500);
    });
    	
	$(window).scroll(function () {
		var docTop = parseInt($(document).scrollTop());
		var docLeft = parseInt($(document).scrollLeft());
		var t0 = (docTop +ot00)+"px";
		var d0 = (docLeft+ft00)+"px";
		$('.toolbar').animate({left:d0,top:t0},{duration:0,queue:false});
	});
	
    $('.next').click(function() {
	  	pageSel++;
	    if (pageSel>=banner.length) {pageSel = 0;}
		$('.jsonText').html(popData[pageSel]);
		$('.jsonTextArea').val(popData[pageSel]);
		$( '.dialog' ).dialog({title: sSeqId+' ('+refId+') '+banner[pageSel]});
    });
  
    $('.prev').click(function() {
	  	pageSel--;
	    if (pageSel<0) {pageSel = banner.length -1;}
		$('.jsonText').html(popData[pageSel]);
		$('.jsonTextArea').val(popData[pageSel]);
		$( '.dialog' ).dialog({title: sSeqId+' ('+refId+') '+banner[pageSel]});
    });

    $( document ).on( 'click', '.ctrlMod', function() {
      // this is a controlTable bean
	  var tdObj          = $(this).parent().parent().find('td');
	  var refId          = tdObj.html();
	  var senderId       = tdObj.next().find('a').html();
	  var receiverId     = tdObj.next().next().html();
	  var docType        = tdObj.next().next().next().html();
	  var execType       = tdObj.next().next().next().next().html();
	  var execStatus     = tdObj.next().next().next().next().next().html();
	  var execObjName    = tdObj.next().next().next().next().next().next().html();
	  var ctrlSeqCheck   = tdObj.next().next().next().next().next().next().next().html();
	  var ctrlSeqNumber  = tdObj.next().next().next().next().next().next().next().next().html();
	  var notifyRefId    = tdObj.next().next().next().next().next().next().next().next().next().html();
      var notifyGroup    = tdObj.next().next().next().next().next().next().next().next().next().next().html();
	  var replyType      = tdObj.next().next().next().next().next().next().next().next().next().next().next().html();
	  var restrictAccess = tdObj.next().next().next().next().next().next().next().next().next().next().next().next().html();
	  clearEntry();
	  $('.ctrlRefId').html(refId);
      $('.senderId').val(senderId);
      $('.receiverId').val(receiverId);
      $('.docType').val(docType);
	  $('input[name=execType][value=' + execType + ']').prop('checked', true);
	  $('input[name=execStatus][value=' + execStatus + ']').prop('checked', true);
      $('.execObjName').val($.trim(execObjName));
      
      var size = $('.execObjName').attr('size');
      if (size<execObjName.length+18) {
      	$('.execObjName').attr('size',execObjName.length+18);
      }
      
	  $('input[name=ctrlSeqCheck][value=' + ctrlSeqCheck + ']').prop('checked', true);
      $('.ctrlSeqNumber').val(ctrlSeqNumber);
      $('.notifyRefId').val(notifyRefId);
	  $('input[name=replyType][value=' + replyType + ']').prop('checked', true);
	  $('input[name=restrictAccess][value=' + restrictAccess + ']').prop('checked', true);
	  	  
	  $('.ctrlMsg').html(' ');
      ///$('.createJTime').html(createJTime);
    });
    
	$('.ctrlNew').click(function() {
		clearEntry();
    	$('.senderId').focus();
    	
    });

	$('.ctrlCancel').click(function() {
		clearEntry();
		$('.routeDialog').dialog('close');
    	
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
		var refId          = $('.ctrlRefId').html();
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

	$('.routeDialog .iServerDomain').change(function() {
		//var serverDomain = $('.routeDialog .iServerDomain').val();
		var serverDomain = $('.iServerDomain').val();
		$('.notifyGroup .iServerDomain').html(serverDomain);
		if (serverDomain.length==0) {
		    serverDomain = 'hdev';
		}
		var senderId     = '';   // $('.iSenderId').val();
		var receiverId   = '';   //$('.iReceiverId').val();
		var docType      = '';   //$('.iDocType').val();
		clearEntry();
    	var msg = getIBWebCtrl(serverDomain, senderId, receiverId, docType);
    	if ($(this).hasClass('ctrlLookup')) {
			$('.routeDialog').dialog('open');
    	}
    });
    
	$('.ctrlRefresh, .ctrlLookup').click(function() {
		var serverDomain = $('.iServerDomain').val();
		if (serverDomain.length==0) {
		    serverDomain = 'hdev';
		}
		var senderId     = '';   // $('.iSenderId').val();
		var receiverId   = '';   //$('.iReceiverId').val();
		var docType      = '';   //$('.iDocType').val();
		clearEntry();
    	var msg = getIBWebCtrl(serverDomain, senderId, receiverId, docType);
    	if ($(this).hasClass('ctrlLookup')) {
			$('.routeDialog').dialog('open');
    	}
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
			$('.resultDialog').dialog('open');
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
                
	$('.updUrl').change(function() {
		var unused = updatePageUrl();
    });
    
    $('.viewClear').click(function() {
    	$('.dataRow').removeClass('selectRow');
		$('.viewClear').html('Select Row');
		$('.viewClear').prop('title', 'Click Row to Select');
		var closed = closeDiaglogs();
    });
  		
    $( document ).on( 'click', '.dataRow', function() {
    	$('.dataRow').removeClass('selectRow');
    	// start (for presentation htrn consistency)
 		$('.dataRow').each(function(){
 			if ($(this).hasClass('xtrn')) { //changes xtrn to htrn
    			$(this).removeClass('xtrn');
    			$(this).addClass('htrn');
 			}
  		});
  		if ($(this).hasClass('htrn')) { //removes htrn adds xtrn for remembering
    		$(this).removeClass('htrn');
    		$(this).addClass('xtrn');
    	}
    	// end (for presentation htrn consistency)
    	$(this).addClass('selectRow');
		var objKey = $(this);
		var sSeqId = $(this).find('td').html();
		getPopData(objKey, sSeqId);
		$('.dialog').dialog('close');
		$('.viewClear').html('Clear');
		$('.viewClear').prop('title', 'Click to Select Clear Selected');
    });  

    $( document ).on( 'click', '.errItem', function() {

		$('.msgBody').html('');
		var securityToken = $('.security .securityToken').val();
		if (securityToken.length==0) {
			$('.securityDialog').dialog('open');
			$('.securityToken').focus();
			return;
		}
    	$(this).parent().removeClass('error');
 		var numItems = $('.error').length;
 		if (numItems==0) {
 			$('.warning').hide();
 		}
		var obj  = $(this).parent().parent();
		var data = createBaseRowObj(obj);
		var jsTimestamp = 'Reviewed-'+new Date().fmtDate().substring(0,5);
		var payload = new Object();
		payload.securityToken = securityToken;
		payload.serverDomain = data.serverDomain;
		payload.xRef = data.refId;
		payload.stmt = "update ps_bc_ib_weblog set bc_final_status = '"+jsTimestamp+"' where bc_refid = "+data.refId;
    	$(this).html(jsTimestamp);
		var xFinal = updUpdtWebLog(payload);
    }); 
      
    $('.viewDialog').click(function() {
		$('.dialog').dialog('close');
      	$('.jsonTable').hide('slow');
      	$('.jsonTArea').show('slow');
		if ($(this).hasClass('p0')) {
			pageSel = 0;
		} else if ($(this).hasClass('p1')) {
			pageSel = 1;
		} else if ($(this).hasClass('p2')) {
			pageSel = 2;
		} else if ($(this).hasClass('p3')) {
			pageSel = 3;
		} else if ($(this).hasClass('p4')) {
			pageSel = 4;
		}
		$('.jsonText').html(popData[pageSel]);
		$('.jsonTextArea').val(popData[pageSel]);
		$('.dialog').dialog('open');
		$( '.dialog' ).dialog({title: sSeqId+' ('+refId+') '+banner[pageSel]});
    });
    
    $('.serverDomain').change(function() {
       	var urlObj = updatePageUrl();
      	$('.ibInstance').html(urlObj.ibInstance);
		$('.restTable .serviceMethod').val(urlObj.serviceMethod);
    });
    
    $('.serviceMethod').change(function() {
       	var urlObj = updatePageUrl();
      	$('.ibNode').html(urlObj.node);
      	$('.payloadTxt').html(urlObj.payloadTxt);
    });
    
    $('.payload').change(function() {
    
       	var serviceMethod = $('.serviceMethod option:selected').val();
       	if (serviceMethod=='get'||serviceMethod=='delete') {
			//continue
        } else {
    		if (payloadVal.substring(0,1)=="{") {
    			//continue
    		} else {
				var payloadObj =  new Object();
				payloadObj.payload = payloadVal;
				var payloadJson = JSON.stringify(payloadObj);
				$('.payload').val(payloadJson);
			}
		}

    });
    
    $('.restSub').click(function() {
	  	var urlRequest = createUrlBean();
		if (urlRequest.securityToken.length==0) {
			$('.securityDialog').dialog('open');
			$('.securityToken').focus();
		} else {
    		$.blockUI({message: null});
	  		var msg = execIbWebCntl(urlRequest);
			$('.resultDialog').dialog('open');
			setTimeout(function() {$.unblockUI();}, 500);
		}
    });
    
    $('.restCall').click(function() {
		$('.resultDialog').dialog('open');
    });
    
    $( document ).on( 'click', '.srcName', function() {
    		var rowObj = $(this).parent().parent();
			var rowBean = createBaseRowObj(rowObj);
	  		$('.iServerDomain').val(rowBean.serverDomain);
	  		$('.notifyGroupServerDomain').html(rowBean.serverDomain);
	  		$('.iSenderId').val(rowBean.senderID);
      		$('.iReceiverId').val(rowBean.receiverID);
      		$('.iDocType').val(rowBean.docType);
			clearEntry();
    		var htmlTxt = getIBWebCtrl(rowBean.serverDomain, rowBean.senderID, rowBean.receiverID, rowBean.docType);
    		var optText = getNotifyOptions(rowBean.serverDomain);
    		if (htmlTxt.length==0) {
    			$('.senderId').val(rowBean.senderID);
    			$('.receiverId').val(rowBean.receiverID);
    			$('.docType').val(rowBean.docType);
		 	}
      		$('.jsonTable').hide('slow');
      		$('.jsonTArea').show('slow');
		 	$('.routeDialog').dialog('open');
			$( '.routeDialog' ).dialog({title: '('+rowBean.serverDomain.toUpperCase()+')'+' -Routing Insert/Update.'});
    });

    $('.restMaster').click(function() {
        	$('.serviceMethod').val('get');
      		$('.payloadTxt').html('objId');
		 	$('.restDialog').dialog('open');
    });

    $('.clearCal').click(function() {
			$('.queryDate').val('select day');
			$('.queryResultMsg').html('Oracle Connection: Active');
			getIBQuery();
    });
    
    $('.serverRefresh').click(function() {
    	$.blockUI({message: null});
    	window.location = 'ibWeblogHome.do';
    });

    $('.ajaxRefresh').click(function() {
    	var today = new Date().fmtDate();
    	$.blockUI({message: null});
    	$('.queryDate').val(today);
    	getIBQuery();
    	$(window).scrollTop(0);
		setTimeout(function() {$.unblockUI();}, 500);
    });
    
    $('.jsonTextArea').change(function() {
	  	var jsonText = $('.jsonTextArea').val();
	  	$('.jsonText').html(jsonText);
    });
    
    $( document ).on( 'click', '.convert', function() {
	  	var jsonText = $('.jsonText').html();
	  	xmlConvertAjax(jsonText)
    	$('.xmlDialog').dialog('open');
    });

    $( document ).on( 'click', '.genericRest', function() {
    	var json = "";
    	var msg = icimsPostCall(json);
    	$('.resultDialog').dialog( 'open' );
		$('.resultDialog').dialog({title: 'Generic Rest'});
    });

    $( document ).on( 'click', '.jsGenericRest', function() {

		$.ajax({
   		  xhrFields: {withCredentials: true},
	      beforeSend: function (xhr) {xhr.setRequestHeader('Authorization', 'Basic ' + 'Ym9pc2VhcGl1c2VyOkYkQzc0bjhYbTtZIVVmQQ==');},
		  type: 'POST',
		  url: 'http://api.icims.com/customers/8533/people/30711',
		  data: {"folder":{"value":"Emp:Former Employee"},"logingroup":"x","enddate":"2016-01-31"},
		  success: function() {$('.resultText').val('Tran Success');},
		  error:   function() {$('.resultText').val('Post Error');},
		  dataType: "json"
		});

		var msg = $('.resultText').val();
	  	$('.jsonText').html(msg);
		$('.jsonTextArea').val(msg);
    	$('.resultDialog').dialog( 'open' );
		$('.resultDialog').dialog({title: 'Generic Rest'});
    });
       
    $( document ).on( 'click', '.customRest', function() {

		closeDiaglogs();
		$('.resultText').val('');
		$('.restMsg').html('');
		$('.dataRow').removeClass('selectRow');

		$('.restTable .serviceMethod').val('post');
		$('.restTable .serverDomain').val('hdev'); //default
		$('.restTable .ibInstance').html('PSFT_HRD');
		$('.restTable .senderID').val('bcllc');
		$('.restTable .receiverID').val('bcllc');
		$('.restTable .docType').val('docType');
		$('.restTable .xRef').val('xref');
		$('.restTable .seqNo').val(0);
		$('.restTable .targetSystem').val('sys');
		$('.restTable .targetApp').val('app');
		$('.restTable .targetProc').val('proc');
		$('.restTable .payload').val('custom'); //default
 
		$('.restTable .ibNode').html('BccPut');
		var unused = updatePageUrl();
		$('.restDialog' ).dialog( 'open' );
		$('.restDialog' ).dialog({title: 'New Rest-Send'});
    });
    
    $( document ).on( 'click', '.venderRestDialog .venderRestSub', function() {
    	$.blockUI({message: null});
    	var bean = createVenderRestJson();
    	var msg = callRest(bean)
		setTimeout(function() {$.unblockUI();}, 500);
    });
    
    $( document ).on( 'click', '.toProviderAsBcc', function() {
    	closeDiaglogs();
		//$('.consumerCall').hide('slow');
	  	$('.venderRestMsg').val('');
	  	
    	var rowObj = $(this).parent().parent();
		var rowBean = createBaseRowObj(rowObj);
	  	$('.venderRestDialog .venderRestUrl').val(rowBean.requestUrl);
		$('.venderRestDialog .payload').val(rowBean.origRequest);
		
		$('.venderRestDialog').dialog('open');
		$('.venderRestDialog' ).dialog({title: 'Consume Vender Rest Service'});
    });

	$('.venderRestDialog .venderRestSecurityToken').change(function() {
		var securityToken = $('.venderRestDialog .venderRestSecurityToken').val();
		var encodedObj  = encrypt(securityToken);
		$('.venderRestDialog .venderRestSecurityToken').val(encodedObj.encodedToken);
		$('.venderRestDialog .venderRestUsername').html(encodedObj.username);
		$('.venderRestDialog .venderRestSecurityToken').focus();
    });
    
    $( document ).on( 'click', '.toBccAsProvider', function() {

		closeDiaglogs();
		$('.resultText').val('');
		$('.restMsg').html('');
		var rowObj = $(this).parent().parent();
		var rowBean = createBaseRowObj(rowObj);

		if (rowBean.serviceMethod=='patch') {
			rowBean.serviceMethod = 'repost';
			rowBean.senderID = 'bcllc';
			rowBean.receiverID = 'bcllc';
			rowBean.docType = 'is';
			rowBean.targetSystem = '${pageContext.request.serverName}';
			rowBean.targetApp = 'iBroker';
			rowBean.targetProc = 'bccService';
		}
		
		$('.serverDomain').val(rowBean.serverDomain);
		$('.ibInstance').html(rowBean.ibInstance);
		$('.restTable .serviceMethod').val(rowBean.serviceMethod);
        
		$('.restTable .xref').val(rowBean.refId);
		$('.restTable .senderID').val(rowBean.senderID);
		$('.restTable .receiverID').val(rowBean.receiverID);
		$('.restTable .docType').val(rowBean.docType);
		$('.restTable .xRef').val(rowBean.refId);
		$('.restTable .seqNo').val(rowBean.srcSeqNo);
		$('.restTable .targetSystem').val(rowBean.targetSystem);
		$('.restTable .targetApp').val(rowBean.targetApp);
		$('.restTable .targetProc').val(rowBean.targetProc);
		$('.restTable .payload').val(rowBean.origRequest);
		$('.restTable .payloadTxt').html('Payload');
		$('.ibNode').html('BccPut');
		var unused = updatePageUrl();

		$( '.restDialog' ).dialog( 'open' );
		$( '.restDialog' ).dialog({title: 'Consume BCC Rest Service'});

    });

    $('.queryDate').change(function() {
    	$.blockUI({message: null});
    	getIBQuery();
    	getIBCounts();
		setTimeout(function() {$.unblockUI();}, 500);
    });
      
     $( document ).on( 'click', '.ibJsonAjax', function() {
     	var str = $(this).html();
     	var parms = str.split("/");
     	var targetProc = parms[0];
     	var objId = parms[1];
		var msg = iBrokerAjax(targetProc, objId);
		if (msg.length >100) {
			$('.resultDialog').dialog('open');
		}
		$('.consumerCall').show('slow');
    });
    
    $('.icimsPost').click(function() {

		closeDiaglogs();
		$('.resultText').val('');
		$('.restMsg').html('');
		var rowObj = $(this).parent().parent();
		var rowBean = createBaseRowObj(rowObj);

		$('.serverDomain').val(rowBean.serverDomain);
		$('.ibInstance').html(rowBean.ibInstance);
		$('.restTable .serviceMethod').val(rowBean.serviceMethod);
        
		$('.restTable .xref').val(rowBean.refId);
		$('.restTable .senderID').val(rowBean.senderID);
		$('.restTable .receiverID').val(rowBean.receiverID);
		$('.restTable .docType').val(rowBean.docType);
		$('.restTable .xRef').val(rowBean.refId);
		$('.restTable .seqNo').val(rowBean.srcSeqNo);
		$('.restTable .targetSystem').val(rowBean.targetSystem);
		$('.restTable .targetApp').val(rowBean.targetApp);
		$('.restTable .targetProc').val(rowBean.targetProc);
		$('.restTable .payload').val(rowBean.origRequest);
		$('.restTable .payloadTxt').html('Payload');
		$('.ibNode').html('BccPut');
		var unused = updatePageUrl();
		$( '.restDialog' ).dialog( 'open' );
		$( '.restDialog' ).dialog({title: 'Consume BCC Rest Service'});
    });
        
    $('.href').click(function() {
    	  $('.echo').submit();
    	  return true;
    });          
    $( '.dialog' ).dialog({
      autoOpen: false,
      show: {effect: 'blind', duration: 1000 },
      hide: {effect: 'explode', duration: 1000},
      dialogClass: 'bccDialog',
      height: 550,
      width: 650
    });          
    $( '.xmlDialog' ).dialog({
      autoOpen: false,
      show: {effect: 'blind', duration: 1000 },
      hide: {effect: 'explode', duration: 1000},
      dialogClass: 'bccDialog',
      height: 500,
      width: 575
    });        
    $( '.routeDialog' ).dialog({
      autoOpen: false,
      show: {effect: 'blind', duration: 1000 },
      hide: {effect: 'explode', duration: 1000},
      dialogClass: 'bccDialog',
      height: 500,
      width: 1375
    });
    $( '.restDialog' ).dialog({
      autoOpen: false,
      show: {effect: 'blind', duration: 1000 },
      hide: {effect: 'explode', duration: 1000},
      dialogClass: 'bccDialog',
      height: 600,
      width: 750
    });            
    $( '.resultDialog' ).dialog({
      autoOpen: false,
      show: {effect: 'blind', duration: 1000 },
      hide: {effect: 'explode', duration: 1000},
      dialogClass: 'bccDialog',
      height: 550,
      width: 650
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
      height: 300,
      width: 600
    }); 
    $( '.consumerDialog' ).dialog({
      autoOpen: false,
      show: {effect: 'blind', duration: 1000 },
      hide: {effect: 'explode', duration: 1000},
      dialogClass: 'bccDialog',
      height: 400,
      width: 400
    }); 
    $( '.venderRestDialog' ).dialog({
      autoOpen: false,
      show: {effect: 'blind', duration: 1000 },
      hide: {effect: 'explode', duration: 1000},
      dialogClass: 'bccDialog',
      height: 750,
      width: 1000
    }); 
    
	$('.clearCal').hide('slow');
	$( ".queryDate" ).datepicker({maxDate: "+0d"});
   	$(".queryDate").val('${queryDate}'); //jstl magic
	$( ".queryDate" ).show('slow');
 	$('.clearCal').show('slow');

$('.disabledKey').hover(
  function() {
	$('.hmig').hide();
	$('.hdev').hide();
	$('.htst').hide();
	$('.hprd').hide();
	$('.key').show();
	switch (true) {
		case $(this).hasClass('hmig'):
			$('.hmig').addClass('hover');
			$('.bmig').addClass('hover');
			$('.hmig').show('slow');
			break;
		case $(this).hasClass('htst'):
			$('.htst').addClass('hover');
			$('.btst').addClass('hover');
			$('.htst').show('slow');
			break;
		case $(this).hasClass('hdev'):
			$('.hdev').addClass('hover');
			$('.bdev').addClass('hover');
			$('.hdev').show('slow');
			break;
		case $(this).hasClass('hprd'):
			$('.hprd').addClass('hover');
			$('.bprd').addClass('hover');
			$('.hprd').show('slow');
			break;
	}
  }, function() {
	$('.hmig').show();
	$('.hdev').show();
	$('.htst').show();
	$('.hprd').show();
	switch (true) {
		case $(this).hasClass('hmig'):
			$('.hmig').removeClass('hover');
			$('.bmig').removeClass('hover');
			break;
		case $(this).hasClass('htst'):
			$('.htst').removeClass('hover');
			$('.btst').removeClass('hover');
			break;
		case $(this).hasClass('hdev'):
			$('.hdev').removeClass('hover');
			$('.bdev').removeClass('hover');
			break;
		case $(this).hasClass('hprd'):
			$('.hprd').removeClass('hover');
			$('.bprd').removeClass('hover');
			break;
	}
  }
);

});

function InitialPageLoad() {

	if (/Mobi/.test(navigator.userAgent)) {
		mobileDevice = true;
	}
 	var numItems = $('.error').length;
 	if (numItems==0) {
 		$('.warning').hide();
 	} else {
 		$('.warning').html('Page Has "HPrd" Errors (Investigate)');
 	}
		//$('.serverDomain option[value="hprd"]').attr('disabled','disabled');
	// initial security
	if (restricted =='true') {
		$('.serverDomain option[value="hprd"]').remove();
		hideRestricted();
	}
	var done = hideToolbarNav();
	return true;
}

function hideToolbarNav() {

	var allHidden = true;
	$('.qNav').each(function(){
		if ($(this).html().indexOf('(0.0)')==-1) {
			allHidden = false;
			$(this).parent().show('slow');
		} else {
			$(this).parent().hide('slow');
		}
	});
	
	if (allHidden) {
		$('.qNav').parent().show('slow');
	}
	
	return true;
}

function clearEntry() {

	$('.ctrlRefId').html(0);
	$('.senderId').val('');
	$('.receiverId').val('');
	$('.docType').val('');
    $('.execType').attr('checked',false);
    $('.execStatus').attr('checked',false);
	$('.execObjName').val('');
    $('.execStatus').attr('checked',false);
    $('.ctrlSeqCheck').attr('checked',false);
	$('.ctrlSeqNumber').val('');
	$('.notifyRefId').val('0');
   	$('.replyType').attr('checked',false);
   	$('.restrictAccess').attr('checked',false);
	$('.ctrlMsg').html('');
	$('.log-container').html('');
    $('.warn').css("color","#000000");
    $('.warn').css("font-weight","normal");
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

function createCtrlBean(oper) {

		var securityToken = $('.security .securityToken').val();
		var serverDomain   = $('.iServerDomain').val();
		var refId          = $('.ctrlRefId').html();
		var senderId       = $('.senderId').val();
		var receiverId     = $('.receiverId').val();
		var docType        = $('.docType').val();
		var execType       = $("input[name='execType']:checked").val();
		var execStatus     = $("input[name='execStatus']:checked").val();
		var execObjName    = $('.execObjName').val();
		var ctrlSeqCheck   = $("input[name='ctrlSeqCheck']:checked").val();
		var ctrlSeqNumber  = $('.ctrlSeqNumber').val();
		var notifyRefId    = $('.notifyRefId').val();
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
		$('.dialog').dialog('close');
		$('.xmlDialog').dialog('close');
		$('.routeDialog').dialog('close');
		$('.restDialog').dialog('close');
		$('.resultDialog').dialog('close');
		$('.securityDialog').dialog('close');
		$('.notifyGroupDialog').dialog('close');
		$('.consumerDialog').dialog('close');
		$('.venderRestDialog').dialog('close');
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

function createUrlBean() {

		var securityToken = $('.security .securityToken').val();
		var serverDomain  = $('.restTable .serverDomain').val();
		var ibInstance    = $('.restTable .ibInstance').html();
		var ibNode        = $('.restTable .ibNode').html();
		var serviceType   = $('.restTable .serviceType').html();
		var serviceMethod = $('.restTable .serviceMethod').val();
		var replyType     = $('.restTable .replyType').val();
		var senderID      = $('.restTable .senderID').val();
		var receiverID    = $('.restTable .receiverID').val();
		var docType       = $('.restTable .docType').val();
		var xref          = $('.restTable .xRef').val();
		var seqNo         = $('.restTable .seqNo').val();
		var targetSystem  = $('.restTable .targetSystem').val();
		var targetApp     = $('.restTable .targetApp').val();
		var targetProc    = $('.restTable .targetProc').val();
		var payload       = $('.restTable .payload').val();
		if (serviceMethod=='get'||serviceMethod=='delete') {
			//continue
		} else {
    		if (payload.substring(0,1)=='{') {
    			//continue
    		} else {
				var payloadObj =  new Object();
				payloadObj.payload = payload;
				payload = JSON.stringify(payloadObj);
			}
   		}
		var reqUrl =  new Object();
		reqUrl.securityToken   = securityToken;
		reqUrl.serverDomain   = serverDomain;
		reqUrl.ibInstance     = ibInstance;
		reqUrl.ibNode         = ibNode;
		reqUrl.serviceType    = serviceType;
		reqUrl.serviceMethod  = serviceMethod;
		reqUrl.replyType      = replyType;
		reqUrl.senderID       = senderID;
		reqUrl.receiverID     = receiverID;
		reqUrl.docType        = docType;
		reqUrl.xref           = xref;
		reqUrl.seqNo          = seqNo;
		reqUrl.targetSystem   = targetSystem;
		reqUrl.targetApp      = targetApp;
		reqUrl.targetProc     = targetProc;
		reqUrl.payload        = payload;
		
		return reqUrl;
}

function updatePageUrl() {

		var serverDomain  = $('.restTable .serverDomain').val();
		if (serverDomain==null) {serverDomain = 'hdev';}
		var ibServlet     = 'PSIGW';
		var ibconnector   = 'RESTListeningConnector';
		var ibInstance    = 'PSFT_HR';
		if (serverDomain=='hdev') {
			ibInstance = 'PSFT_HRD';
		} else if (serverDomain=='htst') {
			ibInstance = 'PSFT_HRT';
		} else if (serverDomain=='bdev'||serverDomain=='btst'||serverDomain=='bprd') {
			ibInstance = 'PSFT_EP';
		}
		var serviceName   = 'BCCSERVICE.v1';
		var serviceType   = 'rest';
       	var serviceMethod = $('.serviceMethod option:selected').val();
		var ibNode        = 'BccPut';
      	var payloadTxt = 'Payload';
        if (serviceMethod=='get'||serviceMethod=='delete') {
        	ibNode = 'BccGet';
      		payloadTxt ='ObjId';
      	}    		
		var replyType     = $('.restTable .replyType').val();
		var senderID      = $('.restTable .senderID').val();
		var receiverID    = $('.restTable .receiverID').val();
		var docType       = $('.restTable .docType').val();
		var xref          = $('.restTable .xRef').val();
		var seqNo         = $('.restTable .seqNo').val();
		var targetSystem  = $('.restTable .targetSystem').val();
		var targetApp     = $('.restTable .targetApp').val();
		var targetProc    = $('.restTable .targetProc').val();
		var payload       = $('.restTable .payload').val();

		var bean =  new Object();
		bean.serverDomain  = serverDomain;
		bean.ibInstance    = ibInstance;
		bean.serviceName   = serviceName;
		bean.serviceType   = serviceType;
		bean.serviceMethod = serviceMethod;
		bean.replyType     = replyType;
		bean.ibNode        = ibNode;
		bean.payloadTxt    = payloadTxt;
		bean.senderID      = senderID;
		bean.receiverID    = receiverID;
		bean.docType       = docType;
		bean.xref          = xref;
		bean.seqNo         = seqNo;
		bean.targetSystem  = targetSystem;
		bean.targetApp     = targetApp;
		bean.targetProc    = targetProc;
		var jsonString = JSON.stringify(bean);
		
//var urlTxt = $( '.restTable .serverDomain option:selected' ).text();
var urlDomain = 'erpwshr-t.bc.com';
switch (serverDomain.toLowerCase()) {
	case 'hmig':
		urlDomain = 'erpwshr-t.bc.com';
		break;
	case 'bdev':
		urlDomain = 'erpbdev.bc.com';
		break;
	case 'btst':
		urlDomain = 'erpbtst.bc.com';
		break;
	case 'bprd':
		urlDomain = 'erpbprd.bc.com';
		break;
	case 'hdev':
		urlDomain = 'erphdev.bc.com';
		break;
	case 'htst':
		urlDomain = 'bouxerp01.bc.com:8243';
		break;
	case 'hprd':
		urlDomain = 'erpwshr.bc.com';
		break;
	default:
		urlDomain = 'erpwshr-t.bc.com';
		break;
}
		var urlString = 'https://'
					   +urlDomain+'/'
					   +ibServlet+'/'
					   +ibconnector+'/'
					   +bean.ibInstance+'/'
					   +bean.serviceName+'/'
					   +bean.ibNode+'/'
					   +bean.serviceType+'/'
					   +bean.serviceMethod+'/'
					   +bean.replyType+'/'
					   +bean.senderID+'/'
					   +bean.receiverID+'/'
					   +bean.docType+'/'
					   +bean.xref+'/'
					   +bean.seqNo+'/'
					   +bean.targetSystem+'/'
					   +bean.targetApp+'/'
					   +bean.targetProc
					;
		if (bean.serviceMethod == 'get') {
			var payload = $('.restTable .payload').val();
			urlString = urlString+'/'+payload;
		}

		if ($('.restTable .serverDomain').val()==null) {
			$('.serviceUrl').val('');
		} else {
			$('.serviceUrl').val(urlString);
		}
		//$('.serviceUrl').html(jsonString);
		//$('.serviceUrl').val(JSON.stringify(bean));
		return bean;
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

function createBaseRowObj(rowObj) {

var tdObj       = rowObj.find('td');
var pageId           = tdObj.html();

var refId            = tdObj.next().html();
var requestUrl       = tdObj.next().next().html();
var origRequest      = tdObj.next().next().next().html();
var finalResponse    = tdObj.next().next().next().next().html();
var execException    = tdObj.next().next().next().next().next().html();
var senderID         = tdObj.next().next().next().next().next().next().html();
var receiverID       = tdObj.next().next().next().next().next().next().next().html();
var docType          = tdObj.next().next().next().next().next().next().next().next().html();

var serviceMethod    = tdObj.next().next().next().next().next().next().next().next().next().next().next().html();
var replyType        = tdObj.next().next().next().next().next().next().next().next().next().next().next().next().html();
var srcSeqNo         = tdObj.next().next().next().next().next().next().next().next().next().next().next().next().next().html();
var srcXref          = tdObj.next().next().next().next().next().next().next().next().next().next().next().next().next().next().html();
var targetSystem     = tdObj.next().next().next().next().next().next().next().next().next().next().next().next().next().next().next().html();
var targetApp        = tdObj.next().next().next().next().next().next().next().next().next().next().next().next().next().next().next().next().html();
var targetProc       = tdObj.next().next().next().next().next().next().next().next().next().next().next().next().next().next().next().next().next().html();
var serviceOperation = tdObj.next().next().next().next().next().next().next().next().next().next().next().next().next().next().next().next().next().next().html();
var serverDomain     = tdObj.next().next().next().next().next().next().next().next().next().next().next().next().next().next().next().next().next().next().next().html();
var finalStatus      = tdObj.next().next().next().next().next().next().next().next().next().next().next().next().next().next().next().next().next().next().next().next().html();
var createJTime      = tdObj.next().next().next().next().next().next().next().next().next().next().next().next().next().next().next().next().next().next().next().next().next().html();
var completeJTime    = tdObj.next().next().next().next().next().next().next().next().next().next().next().next().next().next().next().next().next().next().next().next().next().next().html();

serviceMethod    = serviceMethod.substring(serviceMethod.indexOf('/')+1,serviceMethod.length).toLowerCase();
if (serviceMethod=='post') {
	serviceMethod = 'repost';
}

var rowBean =  new Object();
rowBean.pageId           = pageId;
rowBean.refId            = refId;
rowBean.requestUrl       = requestUrl;
rowBean.origRequest      = origRequest;
rowBean.finalResponse    = finalResponse;
rowBean.execException    = execException;
rowBean.senderID         = senderID;
rowBean.receiverID       = receiverID;
rowBean.docType          = docType;
rowBean.serviceMethod    = serviceMethod;
rowBean.replyType        = replyType;
rowBean.srcSeqNo         = srcSeqNo;
rowBean.srcXref          = srcXref;
rowBean.targetSystem     = targetSystem;
rowBean.targetApp        = targetApp;
rowBean.targetProc       = targetProc;
rowBean.serviceOperation = serviceOperation;
rowBean.finalStatus      = finalStatus;
rowBean.createJTime      = createJTime;
rowBean.completeJTime    = completeJTime;
rowBean.serverDomain     = serverDomain;

if (serverDomain=='hdev') {
	rowBean.ibInstance = 'PSFT_HRD';
} else if (serverDomain=='htst') {
	rowBean.ibInstance = 'PSFT_HRT';
} else if (serverDomain=='bdev'||serverDomain=='btst'||serverDomain=='bprd') {
	rowBean.ibInstance = 'PSFT_EP';
} else {
	rowBean.ibInstance = 'PSFT_HR';
}
		
return rowBean;
}

function getIBQuery() {

	closeDiaglogs();
	var queryDate = $('.queryDate').val();
	var serverDomain = $('.serverChoice').html()
   	var payload = new Object();
   	payload.queryDate    = queryDate;
   	payload.serverDomain = serverDomain;
	$.ajax({
       		type: "POST",
       		contentType: "application/json",
       		url: "queryDate.do",
       		xhrFields: {withCredentials: true},
       		cache: false,
       		timeout: 600000,
       		dataType: 'json',
       		data: JSON.stringify(payload),           
			success : function(data) {
   		 					var msg = '';
   		 					//var barStyle = ['altlight','altDark'];
   		 					$('.rowCnt').html('('+data.length+')');
   		 					for (var i=0;i<data.length;i++) {
   		 						var seq = i+1;
   		 						msg += '<tr class="'+barStyle[(seq%2)]+' dataRow '+data[i].server+'"">';
   		 						msg += '<td align="right">'+seq+'.</td>';
   		 						msg += '<td style="display:none;">'+data[i].refId+'</td>';
   		 						msg += '<td style="display:none;">'+data[i].requestUrl+'</td>';
   		 						msg += '<td style="display:none;">'+data[i].origRequest+'</td>';
   		 						msg += '<td style="display:none;">'+data[i].finalResponse+'</td>';
   		 						msg += '<td style="display:none;">'+data[i].execException+'</td>';
   		 						msg += '<td style="display:none;">'+data[i].senderID+'</td>';
   		 						msg += '<td style="display:none;">'+data[i].receiverID+'</td>';
   		 						msg += '<td style="display:none;">'+data[i].docType+'</td>';
								if ('bcllc' == data[i].receiverID.toLowerCase()) {
									msg += '<td><a href="javascript:;" class="refId toBccAsProvider" title="Re-Post">'+data[i].refId+'</a></td>';
								} else if ('icims' == data[i].receiverID.toLowerCase()||'patch' == data[i].methodName) {
									msg += '<td><a href="javascript:;" class="refId toBccAsProvider">'+data[i].refId+'</a></td>';
								} else {
									msg += '<td><a href="javascript:;" class="refId toProviderAsBcc">'+data[i].refId+'</a></td>';
								}
								msg += '<td nowrap><a href="javascript:;" class="srcName">'+data[i].srcName+'</a></td>';
   		 						msg += '<td>'+data[i].serviceType+'/'+data[i].methodName+'</td>';
   		 						msg += '<td>'+data[i].replyType+'</td>';
   		 						msg += '<td>'+data[i].srcSeqNo+'</td>';
   		 						msg += '<td>'+data[i].srcXref+'</td>';
   		 						msg += '<td>'+data[i].targetSystem+'</td>';
   		 						msg += '<td>'+data[i].targetApp+'</td>';
   		 						msg += '<td>'+data[i].targetProc+'</td>';
   		 						msg += '<td><a href="javascript:;" class="none">'+data[i].serviceOperation+'.'+data[i].version+'</a></td>';
   		 						msg += '<td title="'+data[i].userName+'">'+data[i].server+'</td>';
   		 						if (data[i].reviewException) {
   		 							msg += '<td class="error"><a href="javascript:;" class="errItem">'+data[i].finalStatus+'</a></td>';
   		 						} else {
   		 							msg += '<td>'+data[i].finalStatus+'</td>';
   		 						} 
   		 						msg += '<td nowrap>'+data[i].createTimestamp+'</td>';
   		 						msg += '<td nowrap>'+data[i].completeTimestamp+'</td>';
   		 						msg += '</tr>';
   		 					}
   		 					$('.tBody, .queryResultMsg').hide('slow');
   		 					if (msg.length==0) {
    				 			$('.queryResultMsg').html('Oracle Connection: Active-NoResults');
    				 		} else {
    				 			$('.queryResultMsg').html('Oracle Connection: Active');
    				 		}
  							$('.tBody').html(msg);
   		 					$('.tBody, .queryResultMsg').show('slow');
   		 				},
			  error : function(data) {
   		 					$('.msgBody').html(data);
    				 		$('.queryResultMsg').html(data);
 							$('.msgBody').css("color","#ffffff");
   							$('.msgBody').css("background-color","#ff0000");
   			 			}
   			 }
   	);
    // security magic
	if (restricted=='true') {
		hideRestricted();
	}
 	if ($('.error').length==0) {
 		$('.warning').hide('slow');
 	} else {
 		if (serverDomain.toLowerCase()=='hprd') {
 			$('.warning').html('Page Has "HPRD" Errors (Investigate)');
 			$('.warning').show('slow');
 		}
 	}
	return true;
}

function getIBCounts() {

	var queryDate = $('.queryDate').val();
   	var payload = new Object();
   	payload.queryDate = queryDate;
	$.ajax({
       		type: "POST",
       		contentType: "application/json",
       		url: "queryCounts.do",
       		xhrFields: {withCredentials: true},
       		cache: false,
       		timeout: 600000,
       		dataType: 'json',
       		data: JSON.stringify(payload),           
			success : function(data) { 
							//console.log(JSON.stringify(data));
							for (var key in data) {
								var cnt = data[key];
								switch (key.toLowerCase()) {
									case 'hprd':
										$('.keyHprd').html('Hprd ('+cnt+')');
										break;
									case 'htst':
										$('.keyHtst').html('Htst ('+cnt+')');
										break;
									case 'hdev':
										$('.keyHdev').html('Hdev ('+cnt+')');
										break;
									case 'hmig':
										$('.keyHmig').html('Hmig ('+cnt+')');
										break;
									case 'bprd':
										$('.keyBprd').html('Bprd ('+cnt+')');
										break;
									case 'btst':
										$('.keyBtst').html('Btst ('+cnt+')');
										break;
									case 'bdev':
										$('.keyBdev').html('Bdev ('+cnt+')');
										break;
									case 'bmig':
										$('.keyBmig').html('Bmig ('+cnt+')');
										break;
									default:
										break;
								}
							}
							var done = hideToolbarNav();
						},
			  error : function(data) {
							$('.msgBody').html(data);
							$('.queryResultMsg').html(data);
							$('.msgBody').css("color","#ffffff");
							$('.msgBody').css("background-color","#ff0000");
						}
					}
	);
	return true;
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

function createVenderRestJson() {

	var username      = $('.venderRestDialog .venderRestUsername').html();
  	var method        = $('.venderRestDialog .venderRestMethod').val();
    var url           = $('.venderRestDialog .venderRestUrl').val();
    var securityToken = $('.venderRestDialog .venderRestSecurityToken').val();
    var payload       = $('.venderRestDialog .venderRestPayload').val();
    
	var bean        =  new Object();
	bean.username      = username;
	bean.method        = method;
	bean.url           = url;
	bean.securityToken = securityToken;
	bean.payload       = payload;
	return bean;
}

function getPopData(obj, pSeqId) {
	sSeqId       = pSeqId;
  	statusObjRow = obj;
	var rowVal  = createPopDataObj(obj);
  	refId       = rowVal.refId; // global
    senderId    = rowVal.senderId;
    popData[0]  = rowVal.url;
    popData[1]  = rowVal.request;
    popData[2]  = rowVal.response;
    popData[3]  = rowVal.exception;
	switch (senderId.toUpperCase()) {
  		case 'ICIMS':
    		var linkPage = formatIcimsJson(rowVal.request);
			$('.icimsLinks').html(linkPage);
    		break;
		default:
			$('.icimsLinks').html('');
    		break;
	}
	return true;
}

function icimsPersonAjax(person) {
	var restUrl = "https://api.icims.com/customers/8533/people/"+person; //  /19086
	$('.msgBody').html(restUrl);
	// jQuery.support.cors = true;
	$.ajax({
  	url: restUrl,
  	cache: false,
    type: 'POST',
    crossDomain: true,
    dataType: 'jsonp',
  	success: function(obj) {
				$('.msgBody').html(obj);
  	},
  	error: function (request, status, error) {
  				var msg = $('.msgBody').html()+'\n';
				$('.msgBody').html(msg+status.toUpperCase() + ", myError: " + error);
	}
	});
	return true;

}

function iBrokerAjax(targetProc, objId) {
	
	var htmlTxt = '';
	$('.resultText .icimsMsg').html('no server side call');
	return htmlTxt;

}

function formatIcimsJson(obj) {

 var htmlTxt = '';
 $('.dialogTable').removeClass('baseTable');
 if (obj.substring(0,1)=='{') {
	$('.dialogTable').addClass('baseTable');
	var jsonObj = JSON.parse(obj);
	var links   = jsonObj.links;
	if (links) {
		var workflowUrl = '';
		var jobUrl = '';
		var personUrl = '';
		var userUrl = '';
		for (var i=0;i<links.length;i++) {
			switch (links[i].rel) {
  				case 'applicantWorkflow':
  					workflowID  = jsonObj.systemId;
  					workflowUrl = links[i].url+'?fields=field24378,field24437,field24440,field';
    				break;
  				case 'job':
  					jobID  = jsonObj.jobId;
  					jobUrl = links[i].url+'?fields=joblocation,jobnumber,field24189';
    				break;
  				case 'person':
  					personID  = jsonObj.personId;
  					personUrl = links[i].url+'?fields=firstname,middlename,lastname,field24315,addresses,phones,email,startdate,field24381,field24386,logingroup';
    				break;
  				case 'user':
  					userID  = jsonObj.userId;
  					userUrl = links[i].url;
    				break;
			}
		}
		htmlTxt += '&nbsp;<table class="detail">'; // leading space will hide toXml/toJson button
		htmlTxt += '<tr class="altDark"><th>https://api.icims.com/customers/8533/.....</th></tr>';
		htmlTxt += '<tr><td><a href="'+workflowUrl+'" target="icims">WorkFlow</a></td></tr>';
		htmlTxt += '<tr><td><a href="'+jobUrl     +'" target="icims">Job</a></td></tr>';
		htmlTxt += '<tr><td><a href="'+personUrl  +'" target="icims">Person</a></td></tr>';
		htmlTxt += '<tr><td><a href="'+userUrl    +'" target="icims">User</a></td></tr>';

		htmlTxt += '</table>';
	}
 } else {
	htmlTxt += '<div>Non-Json Message</div>';
 } 
	return htmlTxt;
}

function xmlConvertAjax(payload) {

	$.ajax({
		type: "POST",
		url: "xmlConvert.do",
		contentType: "application/text",
		xhrFields: {withCredentials: true},
		cache: false,
		timeout: 600000,
		dataType: 'text',
		data: payload,        
		success: function(data) {
				console.log('data',JSON.stringify(data));
				var obj = JSON.parse(data);
				$('.xmlText').val(obj.payload); //refer xmlConvert() method in class OracleAjaxController()
			},
		error: function(data) {
				$('.xmlText').val(data);
			}
	});
 	$('.xmlDialog').dialog('open');
	return true;

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
		success: function(data) {$('.ctrlMsg').html(JSON.stringify(data));},
		error: function(data) {$('.ctrlMsg').html('<td colspan="20">'+data+'</td>');}
	});
    return msg;
}

function execNotifyUpdate(webNotify) {

	var msg = '';
	var payload = JSON.stringify(webNotify);
	$.ajax({
		type: "POST",
		contentType: "application/json",
		url: "updWebNotify.do",
		xhrFields: {withCredentials: true},
		cache: false,
		timeout: 600000,
		dataType: 'json',
		data: JSON.stringify(payload),        
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

function execIbWebCntl(urlRequest) {

	var msg = '';
	var payload = urlRequest;
	$.ajax({
		type: "POST",
		url: "execIbWebCntl.do",
		contentType: "application/json",
		xhrFields: {withCredentials: true},
		cache: false,
		timeout: 600000,
		dataType: 'json',
		data: JSON.stringify(payload),        
		success: function(data) {
				var msg = JSON.stringify(data);
				$('.restMsg .jsonText .jsonTextArea .resultText').html(msg);
			},
		error: function(data) {
				var msg = '<td colspan="20">'+data+'</td>';
				$('.restMsg .jsonText .jsonTextArea .resultText').html(msg);
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
					msg += '<td>'+data[i].BC_REFID+'</td>';
					msg += '<td><a href="javascript:;" class="ctrlMod" style="color:blue" title="Modify">'+data[i].BC_SENDERID+'</a></td>';
					msg += '<td>'+data[i].BC_RECEIVERID+'</td>';
					msg += '<td>'+data[i].BC_DOCTYPE+'</td>';
					msg += '<td>'+data[i].BC_EXECTYPE+'</td>';
					msg += '<td>'+data[i].BC_EXECSTATUS+'</td>';
					msg += '<td>'+data[i].BC_EXECOBJNAME+'</td>';
					msg += '<td style="display:none;">'+data[i].BC_CTRL_SEQCHECK+'</td>';
					msg += '<td style="display:none;">'+data[i].BC_CTRL_SEQNUMBER+'</td>';
					msg += '<td style="display:none;">'+data[i].BC_NOTIFY_REFID+'</td>';
					msg += '<td>'+data[i].BC_GROUPNAME+'</td>';
					msg += '<td>'+data[i].BC_REPLYTYPE+'</td>';
					msg += '<td style="display:none;">'+data[i].BC_RESTRICT_ACCESS+'</td>';
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

function callRest(json) {

	var msg = '';
	var payload = json;
	$.ajax({
		type: "POST",
		url: "callRest.do",
		contentType: "application/json",
		xhrFields: {withCredentials: true},
		cache: false,
		timeout: 600000,
		dataType: 'json',
		data: JSON.stringify(payload),        
		success: function(data) {
				var msg = JSON.stringify(data);
				$('.resultText .venderRestDialog .venderRestMsg').val(msg);
			},
		error: function(data) {
				var msg = '<td colspan="20">'+data+'</td>';
				$('.resultText .venderRestDialog .venderRestMsg').val(msg);
			}
	});
    return msg;
}

function updUpdtWebLog(json) {

	var msg = '';
	var payload = json;
	$.ajax({
		type: "POST",
		url: "updUpdtWebLog.do",
		contentType: "application/json",
		xhrFields: {withCredentials: true},
		cache: false,
		timeout: 600000,
		dataType: 'json',
		data: JSON.stringify(payload),        
		success: function(data) {
				var msg = JSON.stringify(data);
			},
		error: function(data) {
				var msg = '<td colspan="20">'+data+'</td>';
			}
	});
    return msg;
}

function getNotifyOptions(serverDomain) {

	var msg = '';
	var payload = new Object();
	payload.serverDomain = serverDomain;
	$.ajax({
		type: "POST",
		url: "getNotifyOptions.do",
		contentType: "application/json",
		xhrFields: {withCredentials: true},
		cache: false,
		timeout: 600000,
		dataType: 'json',
		data: JSON.stringify(payload),        
		success: function(data) {
				var msg = '<select name="notifyRefId" class="notifyRefId">';
				msg += '<option value="0">none </option>';
				for (var i=0;i<data.length;i++) {
					msg += '<option value="'+data[i].BC_NOTIFY_REFID+'">'+data[i].BC_GROUPNAME+'</option>';
				}
				msg += '</select>';
	    		$('.notifyDropdown').html(msg);
			},
		error: function(data) {
					msg = '<div>'+data+'</div>';
					$('.notifyDropdown').html(msg);
				}
	});
    return msg;
}

function icimsTestPost() {
	var staticData = '{"firstname":"Oscar","folder":{"value":"Emp:Current Employee"},"externalid":999999,"middlename":null,"supervisor":{"externalid":61815},"lastname":"Ross"}';
	var thisMsg = jsonPost(staticData);
	//testJson();
	return thisMsg;
}

function testJson() {
    $.ajax({
		url: "http://rest-service.guides.spring.io/greeting"
    }).then(function(data) {
		rtnMsg = JSON.stringify(data);
		$('.resultText').val(rtnMsg);
    });
}
function jsonPost(data) {
	var url = 'http://bo48wh1sl362.bc.com:8080/Callback/1'; //'https://api.icims.com/customers/8533/people/30711';
	$.ajax({
		type: "GET",
		dataType: "json",
		url: "http://rest-service.guides.spring.io/greeting",
		success: function(data) {
			rtnMsg = '{"success": '+JSON.stringify(data)+' }';
			$('.resultText').val(rtnMsg);
		},
		error: function(xhr){
			rtnMsg = '{"error": '+JSON.stringify(xhr)+' }';
			$('.resultText').val(rtnMsg);
		}
	});
	
	return true;
}

function tempPost(data) {
	var url = 'https://api.icims.com/customers/8533/people/30711';
	$.ajax({
		type: "POST",
		url: url,
		data: JSON.stringify(data),
		contentType: "application/json; charset=utf-8",
		crossDomain: true,
		dataType: "json",
		success: function (data, status, jqXHR) {
			alert(success);
		},
		error: function(xhr, textStatus, error){
			alert(xhr.statusText);
			alert(textStatus);
			alert(error);
		}
	});
}
</script>
<div class="head" align="center"><img src="images/BccTree.png" class="ajaxRefresh" title="Click to Refresh Page" /></div>
<div class="head" align="center">Boise Cascade</div>
<div class="view">${pageContext.request.serverName}</div>
<div class="view page">Oracle IBWeblog</div>
<div class="warning"></div>
<div>&nbsp;</div>
<c:set var="row" value="0" />
	<div class="partnerListDiv">
<table>
	<tr>
		<td valign="top" width="150px">
			<div class="toolbar">
				<table>
					<thead>
						<tr><td><a href="javascript:;" class="head" style="font-size:18px;">ToolBar <span class="rowCnt">(${IBWeblogList.size()})</span></a></td></tr>
					<thead>
					<tbody>
						<tr><td><a href="javascript:;" class="serverRefresh small exec" title="serverRefresh">Server Refresh</a></td></tr>
						<tr style="display:none;"><td><a href="javascript:;" class="ajaxRefresh small exec"   title="ajaxRefresh"  >Ajax Refresh</a></td></tr>
						<tr><td><a href="javascript:;" class="restMaster small exec"    title="resendRest"   >PS/IB Request</a></td></tr>
						<tr><td><a href="javascript:;" class="username   small exec"    title="username"     >No Security</a></td></tr>
						<tr><td><a href="javascript:;" class="viewDialog small exec p0" title="OrigUrl  "    >OrigUrl  </a></td></tr>
						<tr><td><a href="javascript:;" class="viewDialog small exec p1" title="Request  "    >Request  </a></td></tr>
						<tr><td><a href="javascript:;" class="viewDialog small exec p2" title="Response "    >Response </a></td></tr>
						<tr><td><a href="javascript:;" class="viewDialog small exec p3" title="Exception"    >Exception</a></td></tr>
						<tr><td>&nbsp;</td></tr>
						<tr style="display:none;"><td><a href="javascript:;" class="viewDialog small exec p4" title="icims Links">Icims</a></td></tr>
						<tr style="display:none;"><td><a href="javascript:;" class="icimsPost small exec"   title="Send Rest">IcimsPost</a></td></tr>
						<tr><td><a href="javascript:;" class="viewClear" title="click row to select">Select Row</a></td></tr>
					</tbody>
					<tfoot>
						<tr>
							<td>
<table class="domainDB">
	<tr><td><input type="radio" class="serverArea" name="serverArea" value="bfp" />FP:</td></tr>
	<tr><td class="domainFP">
	<table>
		<tr><td></td><td><input type="radio" class="serverRadio" name="serverRadio" value="bdev" /></td><td class="qNav keyBdev bdev">Bdev ()</td></tr>
		<tr><td></td><td><input type="radio" class="serverRadio" name="serverRadio" value="bmig" /></td><td class="qNav keyBmig bmig">Bmig ()</td></tr>
		<tr><td></td><td><input type="radio" class="serverRadio" name="serverRadio" value="btst" /></td><td class="qNav keyBtst btst">Btst ()</td></tr>
		<tr><td></td><td><input type="radio" class="serverRadio" name="serverRadio" value="bprd" /></td><td class="qNav keyBprd bprd">Bprd ()</td></tr>
	</table>
	</td></tr>
	<tr><td><input type="radio" class="serverArea" name="serverArea" value="hhr" checked />HR:</td></tr>
	<tr><td class="domainHR">
	<table>
		<tr><td></td><td><input type="radio" class="serverRadio" name="serverRadio" value="hdev" /></td><td class="qNav keyHdev hdev">Hdev ()</td></tr>
		<tr><td></td><td><input type="radio" class="serverRadio" name="serverRadio" value="hmig" /></td><td class="qNav keyHmig hmig">Hmig ()</td></tr>
		<tr><td></td><td><input type="radio" class="serverRadio" name="serverRadio" value="htst" /></td><td class="qNav keyHtst htst">Htst ()</td></tr>
		<tr><td></td><td><input type="radio" class="serverRadio" name="serverRadio" value="hprd" checked /></td><td class="qNav keyHprd hprd">Hprd ()</td></tr>
	</table>
	</td></tr>
</table>
							</td>
						</tr>
					<tfoot>
				</table>
			</div>
		</td>
		<td width="1500px" align="center">
		<table class="partnerListTable baseTable">
			<thead>
				<tr>
					<td colspan="10">Security <a href="javascript:;" class="username">ClickHere</a></td>
				</tr>
			    <tr class="title">
			    	<td colspan="15" width="100%">
			    		<table>
							<tr class="title">
								<td width="20%" align="left"><img width="126" height="36" src="images/BccLogo.png" class="ajaxRefresh" /></td>
								<td width="60%" align="center"><span class="queryResultMsg"></span></td>
								<td width="20%" align="right" nowrap>
									<table>
										<tr>
											<td class="serverChoice">hprd</td>
											<td nowrap>
												<select name="serverDropDown" class="serverDropDown">
													<option value="all" >00. All </option>
													<option value="hdev">1h. HDEV Development </option>
													<option value="htst">2h. HTST Testing     </option>
													<option value="hmig">3h. HMIG Migration   </option>
													<option value="hprd" selected>5h. HPRD Production  </option>
													<option value="bdev">1b. BDEV Development </option>
													<option value="btst">2b. BTST Testing     </option>
													<option value="bmig">3b. BMIG Migration   </option>
													<option value="bprd">4b. BPRD Production  </option>
												</select>
											</td>
											<td align="right"><div><input type="text" id="queryDate" class="queryDate" size="10"></div><a href="javascript:;" class="clearCal">clear</a></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr class="altLight">
					<th class="rowCnt">(${IBWeblogList.size()})</th>
					<th>RefId</th>
					<td style="display:none;" width="20">.refId}</td>
					<td style="display:none;" width="20">.requestUrl</td>
					<td style="display:none;" width="20">.origRequest</td>
					<td style="display:none;" width="20">.finalResponse</td>
					<td style="display:none;" width="20">.execException</td>
					<td style="display:none;" width="20">.senderID</td>
					<td style="display:none;" width="20">.receiverID</td>
					<td style="display:none;" width="20">.docType</td>
					<th>SrcName</th>
					<th>Method</th>
					<th>Reply</th>
					<th>SeqNo</th>
					<th>Xref</th>
					<th>System</th>
					<th>App</th>
					<th>Proc</th>
					<th>ServiceOperation</th>
					<th>src</th>
					<th>Status</th>
					<th>Create</th>
					<th>Complete</th>
				</tr>
			</thead>
			<tbody class="tBody">
			</tbody>
			<tfoot>
				<tr>
					<td colspan="19">
						<table>
							<tr>
								<td width="200" colspan="3">&nbsp;</td>
								<td align="center"><a href="javascript:;" class="viewDialog small exec p0" title="OrigUrl  ">OrigUrl  </a></td>
								<td align="center"><a href="javascript:;" class="viewDialog small exec p1" title="Request  ">Request  </a></td>
								<td align="center"><a href="javascript:;" class="viewDialog small exec p2" title="Response ">Response </a></td>
								<td align="center"><a href="javascript:;" class="viewDialog small exec p3" title="Exception">Exception</a></td>
								<td width="50">&nbsp;</td>
								<td align="center"><a href="javascript:;" class="customRest exec"      >PS/IB Request</a></td>
								<td align="right"><a href="javascript:;" class="exec small ctrlLookup" >Updt Ctrl    </a></td>
								<td style="display:none;" align="right">
									<div><a href="javascript:;" class="genericRest small exec"   title="Send Rest">Post</a></div>
									<div><a href="javascript:;" class="jsGenericRest small exec" title="Send Rest">javascript</a></div>
								</td>
							</tr>
							<tr><td colspan="12"><div class="msgBody"></div></td></tr>
						</table>
					</td>
				</tr>
			</tfoot>
		</table>
		</td>
	</tr>
</table>
		<div class="dialog" title="Json">
			<table class="dialogTable baseTable">
				<thead>
					<tr>
						<td class="prev">prev()</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td class="next">next()</td>
					</tr>
				</thead>
				<tbody>
					<tr class="jsonTable"><td class="jsonText" colspan="4" width="100%"></td></tr>
					<tr class="jsonTArea"><td colspan="4"><textarea rows="15" cols="75" class="jsonTextArea"> </textarea></td></tr>
				</tbody>
				<tfoot>
					<tr><td colspan="4"><a href="javascript:;" class="convert exec small" title="Convert">Convert</a></td></tr>
				</tfoot>
			</table>
		</div>
		<div class="xmlDialog" title="XML">
			<textarea rows="20" cols="70" class="xmlText"> </textarea> 
		</div>
	</div>
		<div class="routeDialog" title="Routing Insert/Update">
			<table class="dialogTable baseTable"> 
				<thead>
					<tr>
						<td>&nbsp;     </td>
						<td style=" padding-top: 0px;">Domain  </td>
					<td>
						<select name="iServerDomain" class="iServerDomain">
							<option value="hdev">hdev</option>
							<option value="htst">htst</option>
							<option value="hmig">hmig</option>
							<option value="hprd">hprd</option>
							<option value="bdev">bdev</option>
							<option value="btst">btst</option>
							<option value="bprd">bprd</option>
						</select>
					</td>
						<td colspan="6" align="right"><a href="javascript:;" class="exec small oracleRefresh">Oracle Refresh</a></td>
					</tr>
					<tr>
						<td>&nbsp;     </td>
						<td style=" padding-top: 0px;">Security</td>
						<td style=" padding-top: 0px;"><a href="javascript:;" class="username">ClickHere</a></td>
						<td colspan="6" align="right"><a href="javascript:;" class="exec small ctrlRefresh"  >Route Refresh </a></td>
					</tr>
					<tr>
						<td>&nbsp;     </td>
						<td>SenderId   </td>
						<td>ReceiverId </td>
						<td>DocType    </td>
						<td>ExecType   </td>
						<td>Active     </td>
						<td>ExecObjName</td>
						<td style="display:none;">SeqChk     </td>
						<td style="display:none;">&nbsp;</td>
						<td><a href="javascript:;" class="notifyGroupView">AlertGrp</a></td>
						<td>HostData   </td>
						<td style="display:none;">Dynamic    </td>
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
						<td class="ctrlRefId"></td>
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
								<tr><td><input type="text" name="execObjName" class="execObjName"   size="60" /></td></tr>
								<tr>
									<td nowrap align="right">&nbsp;<b>SeqCheck:</b>&nbsp;
										<input type="radio" name="ctrlSeqCheck" class="ctrlSeqCheck"  value="yes" >yes&nbsp;
										<input type="radio" name="ctrlSeqCheck" class="ctrlSeqCheck"  value="no"  >no
									</td>
								</tr>
							</table>
						</td>
						<td valign="top">
							<table class="dataEntry">
								<tr>
									<td style=" padding-top: 0px;" class="notifyDropdown">
									</td>
								</tr>
								<tr><td nowrap><b>SeqNo:</b><input type="text" name="ctrlSeqNumber" class="ctrlSeqNumber" size="1" /></td></tr>
							</table>
						</td>
						<td>
							<table class="dataEntry">
								<tr><td><input type="radio" name="replyType" class="replyType"    value="json"></td><td>json</td></tr>
								<tr><td><input type="radio" name="replyType" class="replyType"    value="xml" ></td><td>xml </td></tr>
								<tr><td><input type="radio" name="replyType" class="replyType"    value="txt" ></td><td>txt </td></tr>
							</table>
						</td>
						<td style="display:none;">
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
										<td align="center"><a href="javascript:;" class="exec small ctrlCancel"      >Cancel     </a></td>
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
<div class="restDialog" title="Custom Rest Request">
<table class="baseTable" width="100%">
	<tr>
		<td align="center">
<table class="restTable dataEntry">
	<tr>
		<td>Security</td>
		<td><a href="javascript:;" class="username">ClickHere</a></td>
	</tr>
	<tr>
		<td>Domain</td>
		<td>
			<select name="serverDomain" class="serverDomain updUrl" style="font-weight:bold;font-size:16px">
				<option value="hdev">1h. HDEV Development </option>
				<option value="htst">2h. HTST Testing     </option>
				<option value="hmig">3h. HMIG Migration   </option>
				<option value="hprd">4h. HPRD Production  </option>
				<option value="bdev">1b. BDEV Development </option>
				<option value="btst">2b. BTST Testing     </option>
				<option value="bmig">3b. BMIG Migration   </option>
				<option value="bprd">4b. BPRD Production  </option>
			</select>
		</td>
	</tr>
	<tr><td>&nbsp;</td>
		<td>
			<table>
				<tr style="background-color:gray;color:white;">
					<td>method      </td>
					<td>replyType   </td>
					<td>senderID    </td>
					<td>receiverID  </td>
					<td>docType     </td>
				</tr>
				<tr>
					<td>
						<select name="serviceMethod" class="serviceMethod updUrl">
							<option value="get"   >Get </option>
							<option value="post"  >Post</option>
							<option value="put"   >Put </option>
							<option value="delete">Delete</option>
							<option value="repost">rePost</option>
						</select>
					</td>
					<td>
						<select name="replyType" class="replyType updUrl">
							<option value="json">Json</option>
							<option value="xml" >Html</option>
							<option value="xml" >Xml</option>
							<option value="txt">Txt</option>
						</select>			
					</td>
					<td><input type="text" name="senderID"      class="senderID   updUrl" size="10" value="bcllc" /></td>
					<td><input type="text" name="receiverID"    class="receiverID updUrl" size="10" value="bcllc" /></td>
					<td><input type="text" name="docType"       class="docType    updUrl" size="5"  value="doc" /></td>
				</tr>
				<tr style="background-color:gray;color:white;">
					<td>xRef   </td>
					<td>Seq    </td>
					<td>System </td>
					<td>App    </td>
					<td>Proc   </td>
				</tr>
				<tr>
					<td><input type="text" name="xRef"          class="xRef         updUrl" size="10" value="xref" /></td>
					<td><input type="text" name="seqNo"         class="seqNo        updUrl" size="3"  value="000"  /></td>
					<td><input type="text" name="targetSystem"  class="targetSystem updUrl" size="4"  value="mig"  /></td>
					<td><input type="text" name="targetApp"     class="targetApp    updUrl" size="10" value="app"  /></td>
					<td><input type="text" name="targetProc"    class="targetProc   updUrl" size="10" value="proc" /></td>
				</tr>
				<tr style="display:none;">
					<td class="ibInstance">psft_hr</td>
					<td class="ibNode">BccPut</td>
					<td class="serviceType">rest</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr><td style="font-weight:bold;">TargetUrl</td></tr>
	<tr>
		<td colspan="2"><textarea rows="3" cols="65"  name="serviceUrl" class="serviceUrl"></textarea></td>
	</tr>
	<tr><td style="font-weight:bold;" class="payloadTxt">Payload</td></tr>
	<tr><td colspan="2"><textarea rows="5" cols="65" name="payload" class="payload"></textarea>&nbsp;<a href="javascript:;" class="restCall">open</a></td></tr>
	</table>
		</td>
	</tr>
	<tfoot>
		<tr><td align="center"><a href="javascript:;" class="restSub exec small">Submit</a></td></tr>
	</tfoot>
</table>
	<div class="restMsg">&nbsp;</div>
</div>		
<div class="resultDialog" title="Send Results">
	<table class="dialogTable baseTable">
		<tbody>
			<tr class="jsonTArea">
				<td>
					<textarea rows="15" cols="75" class="resultText"> </textarea>
				</td>
			</tr>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="4">
					<a href="javascript:;" class="convert exec small" title="Convert">Convert</a>
				</td>
			</tr>
		</tfoot>
	</table>
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
				<td>Status</td>
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
				<td>&nbsp</td>
				<td align="left"  ><a href="javascript:;" class="notifyGroupMod del exec small" title="Encode">delete</a></td>
				<td align="center"><a href="javascript:;" class="notifyGroupMod ins exec small" title="Encode">insert</a></td>
				<td align="right" ><a href="javascript:;" class="notifyGroupMod upd exec small" title="Encode">update</a></td>
			</tr>
		</tfoot>
	</table>
	<div><textarea rows="5" cols="65" class="notGroupMsg"></textarea></div>
</div>

<div class="consumerDialog" title="Icims Links">
	<div class="icimsLinks"></div>
	<div class="consumerMsg" align="center">&nbsp;</div>
	<div><a href="javascript:;" class="consumerCall restCall exec">View Results</a></div>
</div>

<div class="venderRestDialog" title="Icims Links">
<div>
	<table class="venderRestTable baseTable">
		<tr>
			<td>Method</td>
			<td>
				<select name="venderRestMethod" class="venderRestMethod">
					<option value="get"    >Get</option>
					<option value="post"   >Post</option>
					<option value="put"    >Put</option>
					<option value="delete" >Delete</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>Dest Url</td>
			<td><textarea rows="1" cols="100" name="venderRestUrl" class="venderRestUrl" value="" ></textarea></td>
		</tr>
		<tr>
			<td>UserName</td>
			<td class="venderRestUsername"></td>
		</tr>
		<tr>
			<td>Authentication</td>
			<td><input type="text" name="venderRestSecurityToken" class="venderRestSecurityToken" size="100" value="" /></td>
		</tr>
		<tr>
			<td>Payload</td>
			<td><textarea rows="4" cols="110" name="venderRestPayload" class="venderRestPayload"></textarea></td>
		</tr>
		<tr><td colspan="2"><a href="javascript:;" class="venderRestSub exec">Transmit</a></td></tr>
	</table>
</div>
<div>&nbsp;</div>
<div><hr /></div>
<div><textarea rows="10" cols="130" name="venderRestMsg" class="venderRestMsg" title="SelectAll (ctrl-A)">Rest Results</textarea></div>
<div>
	<ul>
		<li>Copy/Paste what you want to keep.  Transaction is not logged.</li>
	</ul>
</div>
<div>&nbsp;</div>
<div><a href="javascript:;" class="venderRestResults restCall exec">Results Window</a></div>
</div>
</form:form>
</html>