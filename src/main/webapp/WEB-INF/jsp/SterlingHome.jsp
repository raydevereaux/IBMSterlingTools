<%@ page language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<jsp:useBean id="now" class="java.util.Date" scope="request" />
<html>
<head>
<title>SterlingHome.jsp</title>
<link rel="shortcut icon" href="images/BccTree.png" type="image/x-icon">
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="css/flora.datepick.css" type="text/css" />
<link rel="stylesheet" href="css/b2btools.css" type="text/css" />
<script type="text/javascript" src="webjars/jquery/jquery.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script> <!-- draggable -->
<script type="text/javascript" src="js/jquery-2.70.0.blockUI.js"></script>
<script type="text/javascript" src="js/BccCustomObjects.js"></script>
<script type="text/javascript" src="js/b2btools.js"></script>
<style>
/*Override margins*/ 
th {
border-bottom-style: solid;
border-width: 1px;
}
.content {
margin-left: 5px;
margin-right: 5px;
}
.sorter-false {
nowrap;
}
body {
margin-left:100px;
font-size:100%;
}
table {
padding-left:5px;
}
table.tblData {
padding:10px 10px 10px 10px;
border-style:solid;
border-radius: 1em;
}
table.mbxData {
padding:10px 10px 10px 10px;
border-style:solid;
border-radius: 1em;
}
table.tblMail {
padding:10px 10px 10px 10px;
border-style:solid;
background-color:#ffffff;
border-radius: 1em;
}

td {
padding-left:5px;
vertical-align: top;
}
.smallTxt {
font-weight:bold;
font-size:8px;
}
 .msgBody textarea {
width: 800px;
height: 500px;
overflow-x: scroll;
overflow-y: scroll;
display: block;
border: 1px solid black;
padding: 5px;
margin: 5px;
}
td.add {
padding-right:5px;
padding-left:5px;
width:10px;
}
.complete {
background-color:#ffffcc;
}
.altlight {
color:#000000;
background-color:#ffffff;
}
.altDark {
color:#000000;
background-color:#e8e8e8;
}
.altActive {
color:#000000;
background-color:orange;
}
.altRefId {
color:#ff0000;
}
.altRef {
color:#FFA500;
}
.outstanding {
font-weight:bold;
}
.view {
text-decoration:none;
font-weight:normal;
}
.ruleMessage {
color: #0000ff;
font-weight: bold;
text-alignment: center;
}

.fsaMailbox {
color: #3370a0;
font-weight: bold;
}

.defaultMailbox {
color: #751121;
font-weight: bold;
}

.bmrRule {
color:#009900;
text-decoration:none;
font-weight:bold;
border: solid black 1px;
border-radius: 5em;
}
.bmuRule {
color:#009900;
text-decoration:none;
font-weight:bold;
}
.sha2Rule {
color:#ff9900;
text-decoration:none;
font-weight:bold;
}
.as2Rule {
color:#0033CC;
text-decoration:none; 
font-weight:bold;
}
.ediRule {
color:#cc6600;
text-decoration:none;
font-weight:bold;
}
.sfgRule {
color:#990033;
text-decoration:none;
font-weight:bold;
}

.bccRule {
color:#701BF7;
text-decoration:none;
font-weight:bold;
}

.othRule {
color:#FF0000;
text-decoration:none;
font-weight:bold;
}

.dropMessage {
display:none;
font-weight:bold;
color:red;text-shadow: 0 0 4px white, 0 -5px 4px #FFFF33, 2px -14px 6px #FFDD33, -2px -16px 11px #FF8800, 2px -25px 18px #FF2200;
}
.footnote {
text-decoration:none;
font-weight:bold;
}

.mbxMessage {
color: #ff0000;
font-weight: bold;
text-alignment: center;
display: none;
}
.checkTemplate {
color:#000000;
font-size:16px;
font-weight:bold;
text-decoration:none;
border-radius: 1em;
}
.getRouteTest {
text-weight:bold;
color:black;
}
.getRouteTest:hover {
text-weight:normal;
color:blue;
}
.checkTemplate:hover {
color:#000000;
font-size:16px;
font-weight:normal;
border: solid #000000;
border-radius: 1em;
}
.unHide:hover {
color:#0000ff;
font-size:20px;
font-weight:normal;
text-decoration:underline wavy #ff0000;
}
.unHide {
color:#000000;
font-size:18px;
font-weight:bold;
text-decoration:none;
}

.head {
font-size:30px;
font-weight: bold;
color:#000000;
text-decoration:none;
}
a.head {
text-decoration:none;
}

.hProd {
font-size:20px;
font-weight: bold;
color:#000000;
}

.hTest {
font-size: 30px;
font-weight:900;
color:red;text-shadow: 0 0 4px white, 0 -5px 4px #FFFF33, 2px -10px 6px #FFDD33, -2px -16px 11px #FF8800, 2px -25px 18px #FF2200;
}

.hot {
font-size: 15px;
font-weight:900;
color:red;text-shadow: 0 0 2px white, 0 -3px 4px #FFFF33, 1px -5px 6px #FFDD33, -1px -8px 6px #FF8800, 1px -12px 9px #FF2200;
}

.hLocal {
font-size: 20px;
font-weight:900;
color:#808808;text-shadow: 0 0 4px white, 0 -5px 4px #FFFF33, 2px -10px 6px #FFDD33, -2px -16px 11px #FF8800, 2px -25px 18px #FF2200;
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
.baseTable {
border-radius: 1em;
border: solid #487831;
}
.MailTable {
    position: absolute;
    top: 30px;
    opacity:1.5;
} 
.MsgTable {
    position: absolute;
    top: 600px;
    opacity:1.5;
} 
.overlay {
  display: block;
  background-color: black;
  color: white;
}
.LockTable {
top: 100
width:150;
}
.MdnTable {
top: 100
width:100;
}
table.dtlMail {
padding:10px 10px 10px 10px;
border-style:solid;
border-radius: 1em;
}
.divMail {
    height: 300px;
    overflow: auto;
    resize: both;
}
.NavTable {
    position: absolute;
    left: 10px;
    top: 20px;
    opacity:1.5;
}  
.ArrowTable {
}  
.EntryTable {
    position: absolute;
    left: 50px;
    top: 175px;
    opacity:1.5;
	padding:5px 5px 5px 5px;
	border-radius: 1em;
	border-style:solid;
} 
.TestTable {
    position: absolute;
    left: 50px;
    top: 300px;
    opacity:1.5;
	padding:5px 5px 5px 5px;
	border-radius: 1em;
	border-style:solid;
}
.msgLoaded {text-align:center;}
.msgTitle {
font-weight:bold;
font-size:18px;
text-align:center;
}
.stats td {
text-align:right;
}
.stats thd {
text-align:right;
text-decoration:underline;
}
.renameNode {
text-decoration:none;
}
.fireWebService {
text-decoration:none;
}
td.server {
text-align:center;
font-weight:bold;
text-decoration:none;
}
.refreshType {
font-weight: bold;
}
.searchMatch {
background-color:lightgreen;
text-decoration:blink;
border-radius: 20em;
}
.checkMatch1 {
background-color:orange;
text-decoration:blink;
border-radius: 20em;
border:solid;
}
.checkMatch2 {
background-color:yellow;
text-decoration:blink;
border-radius: 20em;
border:solid;
}
.noAnimate {
background-color:#FFA500;
text-decoration:blink;
border-radius: 20em;
}
.searchNoMatch {
background-color:yellow;
text-decoration:blink;
border-radius: 20em;
}
.haltCount {
display:none;
}
.halted {
color:#ff0000;
border-radius: 20em;
text-align:center;
}
.halt {
color: #114511;
text-decoration:none;
font-size: 16px;
font-weight:500;
border-radius: 10em;
padding: 5 5 5 5;
}
.halt:hover {
background-color: #487831;
color:#ffffff;
border: solid #487831;
}
.mbxCntHide {
display:none;
}
.restoreRow {
color:red;
font-weight:bold;
}
.entryServer {
font-weight:bold;
}
.defHide {
display:none;
}
.testDestFilename {
color:blue;
}
</style>
<script type="application/javascript">

document.onkeyup=function(e){
	var e = e || window.event; // for IE to cover IEs window object
	//dataLog('key:'+e.which);
	if (e.which==36||(e.ctrlKey&&e.which==20)) { //  Home OR (ctrl+CapsLock or Home)
		promptDialogOpen('http://bouxsbi03:8080/dashboard/portal');
	}
	return true;
}

$( document ).on( "mousemove", function( event ) {

  var xPos = event.pageX;
  var yPos = event.pageY;
  $('.mouseX').html(xPos);
  $('.mouseY').html(yPos);
  if (xPos<0) {$('.mouseX').css('color','red');} else {$('.mouseX').css('color','black');}
  if (yPos<0) {$('.mouseY').css('color','red');} else {$('.mouseY').css('color','black');}
});
$(document).ready(function() {

    var mobileDevice = false;
	if (/Mobi/.test(navigator.userAgent)) {
		mobileDevice = true;
		$('.byTemplateName').hide('slow');
		$('.tblMailbox').hide('slow');
		$('.MailTable').animate({"top": "250px", "left": "400px" }, "slow" );
	}

if (window.innerHeight<800&&window.innerWidth<999) {
	$('.byTemplateName').hide();	
	$('.tblMailbox').hide();
}
    var pxStep = 400;
	$('.SoapTable').draggable();
	$('.ArrowTable').draggable();
	$('.MailTable').draggable({
        stop: function(){
            var offset = $(this).offset();
            ot01 = parseInt(offset.top);
            ft01 = parseInt(offset.left);
            $('.x1').html(ot01);
            $('.y1').html(ft01);
        }
    });
    
	$('.EntryTable').draggable({
        stop: function(){
            var offset = $(this).offset();
            ot02 =  parseInt(offset.top);
            ft02 =  parseInt(offset.left);
            $('.x2').html(ot02);
            $('.y2').html(ft02);
        }
    });
    
	$('.MsgTable').draggable({
        stop: function(){
            var offset = $(this).offset();
            ot03 =  parseInt(offset.top);
            ft03 =  parseInt(offset.left);
            $('.x3').html(ot03);
            $('.y3').html(ft03);
        }
    });
    
	$('.TestTable').draggable({
        stop: function(){
            var offset = $(this).offset();
            ot04 =  parseInt(offset.top);
            ft04 =  parseInt(offset.left);
            $('.x4').html(ot04);
            $('.y4').html(ft04);
        }
    });
    
	$('.MdnTable').draggable({
        stop: function(){
            var offset = $(this).offset();
            ot05 =  parseInt(offset.top);
            ft05 =  parseInt(offset.left);
            $('.x5').html(ot05);
            $('.y5').html(ft05);
        }
    });
	$('.LockTable').draggable({
        stop: function(){
            var offset = $(this).offset();
            ot06 =  parseInt(offset.top);
            ft06 =  parseInt(offset.left);
            $('.x6').html(ot06);
            $('.y6').html(ft06);
        }
    });
    var browserType = ''; //navigator.userAgent;
    $('.browserType').html(browserType);
	$('.sorter-false').css('display', 'none');
	var pad = 5;
	
	var winMaxHeight = window.innerHeight;
	var winMaxWidth = window.innerWidth;
	var t0 = 25; //align top
	var f0 = winMaxWidth-(winMaxWidth /3); //align right
	$('.MailTable').css('position','absolute');
	$('.MailTable').css('top', t0);
	$('.MailTable').css('left', f0);

	var ot00 = parseInt($('.NavTable').css('top').replace('px','').toInteger());
	var ft00 = parseInt($('.NavTable').css('left').replace('px','').toInteger());
	var ot01 = parseInt($('.MailTable').css('top').replace('px','').toInteger());
	var ft01 = parseInt($('.MailTable').css('left').replace('px','').toInteger());
	var ot02 = parseInt($('.EntryTable').css('top').replace('px','').toInteger());
	var ft02 = parseInt($('.EntryTable').css('left').replace('px','').toInteger());
	var ot03 = parseInt($('.MsgTable').css('top').replace('px','').toInteger());
	var ft03 = parseInt($('.MsgTable').css('left').replace('px','').toInteger());
	var ot04 = parseInt($('.TestTable').css('top').replace('px','').toInteger());
	var ft04 = parseInt($('.TestTable').css('left').replace('px','').toInteger());
	var ot05 = parseInt($('.MdnTable').css('top').replace('px','').toInteger());
	var ft05 = parseInt($('.MdnTable').css('left').replace('px','').toInteger());
	var ot06 = parseInt($('.LockTable').css('top').replace('px','').toInteger());
	var ft06 = parseInt($('.LockTable').css('left').replace('px','').toInteger());

    $('.x0').html(winMaxHeight);$('.y0').html(winMaxWidth);
    $('.x1').html(ot01);$('.y1').html(ft01);
    $('.x2').html(ot02);$('.y2').html(ft02);
    $('.x3').html(ot03);$('.y3').html(ft03);
    $('.x4').html(ot04);$('.y4').html(ft04);
    $('.x5').html(ot05);$('.y5').html(ft05);
    $('.x6').html(ot06);$('.y6').html(ft06);

	$('.debug').hide('slow');
	$('.cntrlText').hide('slow');
	$('.SearchTable').hide('slow');
    $('.SearchTable').addClass('showSlow');
	$('.ArrowTable').hide();
	$('.LockTable').hide();
	$('.MdnTable').hide();
	
	$(window).resize(function() {
		winMaxHeight = window.innerHeight;
		winMaxWidth = window.innerWidth;
   		$('.x0').html(winMaxHeight);$('.y0').html(winMaxWidth);
	});
	
    var posMax = $('.NavTable').offset();
    var posMaxTop = parseInt(posMax.top);
    var posMaxLeft = parseInt(posMax.left);
    var posMaxBot  = posMaxTop + winMaxHeight;
    var posMaxRight = posMaxLeft + winMaxWidth; 
   	$('.xTop').html(posMaxTop);$('.yTop').html(parseInt(posMaxLeft));
   	$('.xBot').html(posMaxBot);$('.yBot').html(posMaxRight);
	
	var xPos = 0;
	var yPos = 0;
	$(window).scroll(function () {
            
        var docTop = parseInt($(document).scrollTop());
        var docLeft = parseInt($(document).scrollLeft());
        // this is so things dont scroll off the bottom
        if(ot00>posMaxBot) {ot00 = posMaxBot - 100;}
        if(ot01>posMaxBot) {ot01 = posMaxBot - 100;}
        //if(ot02>posMaxBot) {ot02 = posMaxBot - 100;}
        if(ot03>posMaxBot) {ot03 = posMaxBot - 100;}
        if(ot04>posMaxBot) {ot04 = posMaxBot - 100;}
        //if(ot05>posMaxBot) {ot05 = posMaxBot - 100;}
        //if(ot06>posMaxBot) {ot06 = posMaxBot - 100;}
        
		var t0 = (docTop +ot00)+"px";
		var t1 = (docTop +ot01)+"px";
		var t2 = (docTop +ot02)+"px";
		var t3 = (docTop +ot03)+"px";
		var t4 = (docTop +ot04)+"px";
		//var t5 = (docTop +ot05)+"px";
		//var t6 = (docTop +ot06)+"px";
		
		var d0 = (docLeft+ft00)+"px";
		var d1 = (docLeft+ft01)+"px";
		var d2 = (docLeft+ft02)+"px";
		var d3 = (docLeft+ft03)+"px";
		var d4 = (docLeft+ft04)+"px";
		//var d5 = (docLeft+ft05)+"px";
		//var d6 = (docLeft+ft06)+"px";
        $('.x1').html(t1);$('.y1').html(d1);
        //$('.x2').html(t2);$('.y2').html(d2);
        $('.x3').html(t3);$('.y3').html(d3);
        $('.x4').html(t4);$('.y4').html(d4);
        //$('.x5').html(t5);$('.y5').html(d5);
        //$('.x6').html(t6);$('.y6').html(d6);

		$('.NavTable').animate({left:d0,top:t0},{duration:0,queue:false});
        posMax = $('.NavTable').offset();
        posMaxTop = parseInt(posMax.top);
        posMaxLeft = parseInt(posMax.left);
        posMaxBot  = posMaxTop + winMaxHeight;
        posMaxRight = posMaxLeft + winMaxWidth;
		$('.MailTable' ).animate({left:d1,top:t1},{duration:0,queue:false});
		//$('.EntryTable').animate({left:d2,top:t2},{duration:0,queue:false});
		$('.MsgTable'  ).animate({left:d3,top:t3},{duration:0,queue:false});
		$('.TestTable' ).animate({left:d4,top:t4},{duration:0,queue:false});
		//$('.MdnTable'  ).animate({left:d5,top:t5},{duration:0,queue:false});
		//$('.LockTable'  ).animate({left:d6,top:t6},{duration:0,queue:false});
   		$('.xTop').html(posMaxTop);$('.yTop').html(parseInt(posMaxLeft));
   		$('.xBot').html(posMaxBot);$('.yBot').html(posMaxRight);
		
	});

	$('.defExec').attr('checked',true);
	$('.execRow').hide('slow');
	
	$('.EntryTable').hide();
	$('.delete').hide();
	$('.mbxActivate').hide();
	$('.MsgTable').hide();
	//$('.masterMsgId').hide();
	$(".SoapTable").hide();

    var drag = document.createElement("IMG");
    drag.src = "https://b2btools.bc.com/IBMSterlingTools/images/drag.png";
    drag.title = 'Draggable';
    var noDrag = document.createElement("IMG");
    noDrag.src = "https://b2btools.bc.com/IBMSterlingTools/images/noDrag.png";
    noDrag.title = 'No Drag';
    var logo = document.createElement("IMG");
    logo.src = "https://b2btools.bc.com/IBMSterlingTools/images/BccLogo.png";logo.width=126;logo.height=36;
    var tree = document.createElement("IMG");
    tree.src = "https://b2btools.bc.com/IBMSterlingTools/images/BccTree.png";tree.width=39;tree.height=36;
	$(".logo").html(logo);
    
    $('.logo').click(function() {
		$('.SearchTable').hide();
    	if ($('.MsgTable').hasClass('hide') ) {
			$('.MsgTable').removeClass('hide');
			$('.ButtonTable').show();
			$(".logo").html(logo);
			$(".cntrlDisplay").show('slow');
			$(".ArrowTable").hide('slow');
			$('.byTemplateName').show('slow');	
			$('.tblMailbox').show('slow');
			if ($('.searchVal').val().length>0) {
				$('.ButtonTable').hide();
				$('.SearchTable').show('slow');
			}
    	} else {
			$('.MsgTable').addClass('hide');
			$(".logo").html(tree);
			$(".cntrlDisplay").hide('slow');
			$(".ArrowTable").show('slow');
		}
     });
    
    $('.pageHome, .logo').click(function() {
    	$('html, body').animate({scrollTop: 0,scrollLeft: 0}, 2000);
    	var topAbs1 = 300 - ot01;
    	var leftAbs1 = 400 - ft01;
		var topStep1  = '+='+topAbs1+'px';
		var leftStep1 = '+='+leftAbs1+'px';
    	$('.MailTable').animate({"top": topStep1, "left": leftStep1 }, "slow" );
        ot01 += topAbs1;
        ft01 += leftAbs1;
        $('.x1').html(ot01);
        $('.y1').html(ft01);
        
    	$(".renameTbl").hide('slow');
    	$(".loggingTbl" ).hide('slow');
    	var topAbs2 = 200 - ot02;
    	var leftAbs2 = 200 - ft02;
		var topStep2  = '+='+topAbs2+'px';
		var leftStep2 = '+='+leftAbs2+'px';
    	$('.EntryTable').animate({"top": topStep2, "left": leftStep2 }, "slow" );
        ot02 += topAbs2;
        ft02 += leftAbs2;
        $('.x2').html(ot02);
        $('.y2').html(ft02);
     });

    $('.left, .right, .top, .bot').click(function() {
    	var mvTop    = 0;
    	var mvLeft   = 0;
    	if ($(this).hasClass('top')) {mvTop = pxStep * -1;}
    	if ($(this).hasClass('bot')) {mvTop = pxStep * +1;}
    	if ($(this).hasClass('left')) {mvLeft = pxStep * -1;}
    	if ($(this).hasClass('right')) {mvLeft = pxStep * +1;}
		var topStep  = '+='+mvTop+'px';
		var leftStep = '+='+mvLeft+'px';
    	$('.MailTable').animate({"top": topStep, "left": leftStep }, "slow" );
        ot01 += mvTop;
        ft01 += mvLeft;
        $('.x1').html(ot01);
        $('.y1').html(ft01);
     });

    $(".fullTable").click(function() {
    	if ($(this).hasClass('hideOff') ) {
			$('.sorter-false').css('display', 'none');
			$(this).removeClass('hideOff');
		} else {
			$('.sorter-false').css('display', '');
			$(this).addClass('hideOff');
		}
     });

    $(".showSearch").click(function() {
    	if ($('.ButtonTable').hasClass('showSlow') ) {
    		$('.ButtonTable').addClass('showSlow');
    		$('.ButtonTable').removeClass('hideSlow');
			$('.ButtonTable').show('slow');
    	} else {
    		$('.ButtonTable').addClass('hideSlow');
    		$('.ButtonTable').removeClass('showSlow');
			$('.ButtonTable').hide();
    	}
    	if ($('.SearchTable').hasClass('showSlow') ) {
    		$('.SearchTable').addClass('showSlow');
    		$('.SearchTable').removeClass('hideSlow');
			$('.SearchTable').show('slow');
			$('.searchVal').focus();
    	} else {
    		$('.SearchTable').addClass('hideSlow');
    		$('.SearchTable').removeClass('showSlow');
			$('.SearchTable').hide();
    	}
     });

    $(".clearSearch").click(function() {
		if ($('.searchVal').val().length==0) {
			$('.SearchTable').hide();
			$('.ButtonTable').show('slow');
		} else {
			$('.searchVal').val('');
			$('.searchVal').focus();
			clearBackground();
		}
     });     
         	                
    $(".dragMsgTable").click(function() {
    	if ($('.MsgTable').hasClass('dragOff') ) {
			$('.MsgTable').draggable('enable');
			$('.MsgTable').removeClass('dragOff');
			$(".dragMsgTable").html(drag);
    	} else {
			$('.MsgTable').draggable('disable');
			$('.MsgTable').addClass('dragOff');
			$(".dragMsgTable").html(noDrag);
		}
     });

    $(".dragEntryTable").click(function() {;
    	if ($('.EntryTable').hasClass('dragOff') ) {
			$('.EntryTable').draggable('enable');
			$('.EntryTable').removeClass('dragOff');
			$(".dragEntryTable").html(drag);
    	} else {
			$('.EntryTable').draggable('disable');
			$('.EntryTable').addClass('dragOff');
			$(".dragEntryTable").html(noDrag);
		}
     });

    $(".dragMailTable").click(function() {
    	if ($('.MailTable').hasClass('dragOff') ) {
			$('.MailTable').draggable('enable');
			$('.MailTable').removeClass('dragOff');
			$(".dragMailTable").html(drag);
    	} else {
			$('.MailTable').draggable('disable');
			$('.MailTable').addClass('dragOff');
			$(".dragMailTable").html(noDrag);
    	}
     });

    $(".dragTestTable").click(function() {
    	if ($('.TestTable').hasClass('dragOff') ) {
			$('.TestTable').draggable('enable');
			$('.TestTable').removeClass('dragOff');
			$(".dragTestTable").html(drag);
    	} else {
			$('.TestTable').draggable('disable');
			$('.TestTable').addClass('dragOff');
			$(".dragTestTable").html(noDrag);
		}
     });

    $(".dragMdnTable").click(function() {
    	if ($('.MdnTable').hasClass('dragOff') ) {
			$('.MdnTable').draggable('enable');
			$('.MdnTable').removeClass('dragOff');
			$(".dragMdnTable").html(drag);
    	} else {
			$('.MdnTable').draggable('disable');
			$('.MdnTable').addClass('dragOff');
			$(".dragMdnTable").html(noDrag);
    	}
     });

    $(".dragLockTable").click(function() {
    	if ($('.LockTable').hasClass('dragOff') ) {
			$('.LockTable').draggable('enable');
			$('.LockTable').removeClass('dragOff');
			$(".dragLockTable").html(drag);
    	} else {
			$('.LockTable').draggable('disable');
			$('.LockTable').addClass('dragOff');
			$(".dragLockTable").html(noDrag);
    	}
     })
     
    $(".dragSoapTable").click(function() {
    	if ($('.SoapTable').hasClass('dragOff') ) {
			$('.SoapTable').draggable('enable');
			$('.SoapTable').removeClass('dragOff');
			$(".dragSoapTable").html(drag);
    	} else {
			$('.SoapTable').draggable('disable');
			$('.SoapTable').addClass('dragOff');
			$(".dragSoapTable").html(noDrag);
    	}
     });

	var testTable = $.trim($(".testTableBody").html());
	if (testTable.length==0) {
		$('.TestTable').hide();
	}
	$(".soap").click(function() {
		centerSoapTable(posMaxTop, posMaxLeft);
		$(".SoapTable").toggle('slow');
	});
	
	$(".fireWebService").click(function() {
		var fileTemplate = $('.fileTemplate').val();
		$('.msgName').val(fileTemplate);
		$('.EntryTable').hide();
		centerSoapTable(posMaxTop, posMaxLeft);
		$(".SoapTable").show('slow');
	});

	$(".soapClose").click(function() {
		$(".SoapTable").hide('slow');
	});
	
	$(".soapMode").click(function() {

	});
			
	$(".soapAjax").click(function() {
		$(this).hide('slow');
       	var payload = new Object();
       	payload.msgName= $('.msgName').val();
       	payload.msgBody= $('.msgBody').val();
       	payload.mode   = $('.soapMode option:selected' ).val();
        $.blockUI();
    	$.ajax({
           		type: "POST",
           		contentType: "application/json",
           		url: "webserviceSoap.do",
           		xhrFields: {withCredentials: true},
           		cache: false,
           		timeout: 600000,
           		dataType: 'json',
           		data: JSON.stringify(payload),        
           		success: function(data) {$('.msgBody').val(JSON.stringify(data));},
           		error: function (e) {$('.msgBody').val(JSON.stringify(data));}
      	});
    	$.unblockUI();
		$(this).show('slow');
	});
			
	$(".lockReview").click(function() {
       	var payload = new Object();
       	payload.dbUrl = $('.dbUrl').val();
       	payload.refId = $(this).val();
		if (payload.refId=='all') {
			var chkd = $(this).prop('checked');
			$(".lockReview").prop('checked',chkd);
		}
        $.blockUI();
		var ajaxVal = ajaxClearLocks(payload);
	});
			
	$(".clearLocks").click(function() {
		showLockTable();
       	var payload = new Object();
       	payload.refId = 'all';
        $.blockUI();
		var ajaxVal = ajaxClearLocks(payload);
		$(".lockReview").prop('checked',true);
        $('.statusAll').html(ajaxVal);
    	$.unblockUI();
	});
					
    $(".mail").click(function() {
		$('.mail').attr('checked',false);
		$(this).attr('checked',true);
		var mailId = $(this).val();
		var mailName = $(this).parent().parent().find('td').next().next().next().html();
		$(".mailboxId").val(mailId);
		$(".mbMailboxId").html(mailId);
		$(".mailboxName").val(mailName);
		$(".mbMailboxName").html(mailName);
		dataEntryTop();
		$('.fileTemplate').focus();
		if (mailName=='/DeadLetter') {
			$('.dropMessage').show('slow');
		} else {
			$('.dropMessage').hide('slow');
		}
     });
     
    $(".template").click(function() {
    	clearBackground();
    	var tmpName = $(this).html();
    	if (tmpName.length>0&&tmpName.substring(0,1)!='$') {
			var search = tmpName.substring(0,tmpName.indexOf('$')-1).toLowerCase();
    		$(".searchVal").val(search);
			var match = searchAll(search);
			scrollSearch(match);
		}
     });

    $(".exec").click(function() {
		var choice = $(this).val();
		if (choice=='none') {
			$('.exec').attr('checked',false);
			$(this).attr('checked',true);
		} else {
			$('.addMbx').attr('checked',true);
			if (choice=='eMail') { 
				$('.eMailRow').show('slow');
				var mbxName = $('.defaultEmailName').html();
				var mbxId   = $('.defaultEmailId').html();
		   		$('.mbMailboxId').html(mbxId);
				$('.mbMailboxName').html(mbxName);
		   		$(".mailboxId").val(mbxId);
				$('.mailboxName').val(mbxName);
			}
			if (choice=='reMap') {
				$('.mapRow').show('slow');
			}
			if (choice=='busProc') {
				$('.bpRow').show('slow');
			}
			if (1==0) {
				$('.addMbx').attr('checked',false);
				$('.defExec').attr('checked',true);
		}
	}
     });

    $(".togData").click(function() {
    	$('.tblData').toggle("slow");
     });
              
    $(".hideEmpty").click(function() {
    	$('.tblMail').toggle("slow");   
		topPos = $('.MailTable').css('top');
     });

    $(".hideMdn").click(function() {
    	$('.MdnTable').hide('slow');
     });

    $(".hideLock").click(function() {
    	$('.LockTable').hide('slow');
     });
     
    $(".hideMsgs").click(function() {
    	$('.MsgTable').hide('slow');
     });
     
    $('html, body').dblclick(function() {
    	clearBackground();
     });

    $('.bccRule, .sfgRule, .bmrRule, .bmuRule, .sha2Rule, .ediRule, .as2Rule, .othRule, .nonRule').click(function() {
    	$('.MsgTable').hide('slow');
    	clearBackground();
	    var search = $(this).html();
	    var itemMatch = false;
	    $('.TestTable .srcMailbox').val(search);
   		$('.entryMailboxName').each(function() {
   			if ($(this).html()==search) {
   				itemMatch = true;
   				$(this).addClass('searchMatch');
   			}
		});
   		$('.defaultMailbox').each(function() {
   			if ($(this).html()==search) {
   				itemMatch = true;
   				$(this).addClass('searchMatch');
   			}
		});
   		$('.mbxDisplay').removeClass('searchMatch');
   		$('.mbxDisplay').removeClass('searchNoMatch');
   		if (itemMatch) {
   			$(this).addClass('searchMatch');
   		} else {
   			$(this).addClass('searchNoMatch');
   		}
     });    
     
    $(".find").click(function() {
    	$('.MsgTable').hide('slow');
    	clearBackground();
	    var search = $(".msgTitle").html();
   		$('.mbxDisplay').each(function() {
   			if ($(this).html()==search) {
   				$(this).addClass('searchMatch');
   			}
		});
		//$('.searchMatch').attr('id','target');
		var topPos  = $('.searchMatch').offset().top  - (window.innerHeight /2);
		var leftPos = $('.searchMatch').offset().left - (window.innerWidth  /2);
		//$('html, body').animate({
		//		scrollTop: topPos,
		//		scrollLeft: leftPos
		//}, 2000);
     });

    $(".cntrlTest").click(function() {
		$(".TestTable" ).toggle("slow");
     });
      
    $(".mbxRoutingTest").click(function() {
    	var srcMailbox = $(".srcMailbox").val();
    	var filename   = $(".filename").val();
        $.blockUI({message:'<div class="wait">Processing</div><img src="images/ajax-loader.gif" class="wait" />'});
    	doRouteTest(srcMailbox, filename);
     });

    $( document ).on( 'click', '.getRouteTest', function() {
    	var srcMailbox = $('.msgTitle').html();
    	if (srcMailbox.startsWith('/AS2/')&&srcMailbox.endsWith('/Outbound')) { srcMailbox = '/';}
    	var filename = $(this).html();
    	$(".srcMailbox").val(srcMailbox);
    	$(".filename").val(filename);
        $.blockUI({message:'<div class="wait">Processing</div><img src="images/ajax-loader.gif" class="wait" />'});
    	doRouteTest(srcMailbox, filename);
		$(".TestTable" ).show("slow");
    });
    
    $(".debugTog").click(function() {
		$(".debug" ).toggle("slow");
     });
      
    $(".cntrlEntry").click(function() {
		var dbUrl = $('.dbUrl option:selected').text();
		$('.entryServer').html(dbUrl);
    	if ($(this).hasClass('nav')) {
			$(".EntryTable" ).show("slow");
		} else {
			$(".EntryTable" ).toggle("slow");
		}
     });
    
     $( document ).on( 'click', '.masterMsgId', function() { 
    	$(this).prop('checked', false);
  		$('.msgId').prop('checked', true);
  		$.blockUI({message:'<div class="wait">Updating</div>'});
   		$('.msgId').each(function() {
 			var myParent = $(this).parent().parent();
   			var msgId    = $(this).val();
    		updateExtractable(myParent, msgId);
		});
  	   	$.unblockUI();
     });
    
     $( document ).on( 'click', '.msgId', function() {
    	var delCheck = $(this).is(':checked');
    	if (delCheck) {
      		$.blockUI({message:'<div class="wait">Updating</div>'});
    		var myParent = $(this).parent().parent();
    		var msgId    = $(this).val();
    		updateExtractable(myParent, msgId);
      	   	$.unblockUI();
    	}
     });

     $( document ).on( 'click', '.restoreMsg', function() { 
 		var myParent = $(this).parent().parent();
   		var msgId    = $(this).parent().parent().find('td').next().next().next().next().html();
    	restoreExtractable(myParent, msgId);
     });
                              
     $( document ).on( 'click', '.showMessages, .tblCount', function() {
		$('.MsgTable').hide();
	    var mailboxParent = $(this).parent().find('td').next().html();
	    if ($(this).hasClass('tblCount')) {
	    	mailboxParent = $(this).parent().find('td').next().next().next().html();
	    }
	    var data = '';
	    var row = 0;
	    $('.msgTitle').html(mailboxParent);
	    var rowClass = ['altDark','altLight'];
   		$(".msg").each(function() {
			var mailbox = $(this).find('td').html();
			var msgId   = $(this).find('td').next().html();
			var msgName = $(this).find('td').next().next().html();
			var msgDate = $(this).find('td').next().next().next().html();
   			if ($('.msgTitle').html()==mailbox) {
   				row++;
   				data += '<tr class="'+ rowClass[(row%2)] +'">';
   				data += '<td title="'+msgId+'"><input type="checkbox" name="msgId" class="msgId" value="'+msgId+'"/></td>';
   				data += '<td nowrap>'+row+'. </td>';
   				data += '<td nowrap class="getRouteTest">'+msgName+'</td>'; //careful with apost
   				data += '<td>'+msgDate+'</td>';
				data += '<td>&nbsp;</td>';   						
   				data += '</tr>';
   			}
		});
		$('.dtlData').html(data);
		$('.MsgTable').css('position','absolute');
		$('.MsgTable').css('left', 250);
		$('.MsgTable').css('top', 175);
		$('.MsgTable').show('slow');
     });
     
     $( document ).on( 'click', '.showMailbox', function() {
    	clearBackground();
	    var search = $(this).html();
   		$(".mbxDisplay").each(function() {
   			if ($(this).html()==search) {
   				$(this).addClass('searchMatch');
   			}
		});
		//$('.searchMatch').attr('id','target');
		var topPos  = $('.searchMatch').offset().top  - (window.innerHeight /2);
		var leftPos = $('.searchMatch').offset().left - (window.innerWidth  /2);
		$('html, body').animate({
				scrollTop: topPos,
				scrollLeft: leftPos
		}, 2000);
     });
   
    $(".mbxDisplay").dblclick(function() {
		var mailName = $(this).html();
		if ($(".fileTemplate").val()=='*') {
			$(".mbxMessage").html('May Not Change This Template');
		} else {
			$('.mbxActivate').show();
			var actMailboxId = $(this).parent().find('input').val();
			$('.actMailboxId').val(actMailboxId);
			$('.fileTemplate').val(mailName);
			$('.displayFileTemplate').html(mailName);
			$('.fileTemplate').hide();
			$('.displayfileTemplate').show();
			$('.checkTemplate').hide();
			$('.fileTemplate').focus();
			$('.mbxMessage').html('Default for this Mailbox Only');
		}
     });
      
    $(".search").click(function() {
    	clearBackground();  
	    var search = $(".searchVal").val().toLowerCase();
	    if (search.length==0) {
    			$(".searchMsg").html('No Criteria');
	    } else {
	    	var match = searchAll(search);
			scrollSearch(match);
		}
     });
          
    $(".checkTemplate").click(function() {
    	clearBackground();
	    var search = $(".fileTemplate").val().toLowerCase();
	    if (search.length==0) {
    			$(".EntryTable .msg").html('No Check Criteria');
	    } else {
	    	var foundResult = false;
   			$('.update').each(function() {
   				var obj = $(this).html();
   				if (obj.contains(search)) {
    				foundResult = true;
					$(this).addClass('checkMatch1');
   				}
			});
			if (foundResult) {
    			$(".EntryTable .msg").html('Check Results are <span class="checkMatch1">highlighted</span>');
    		} else {
    			$(".EntryTable .msg").html('Check Complete');
    		}
		}
     });
           
    $(".save").click(function() {
    
    	var msgArray = [];
    	msgArray.push("Template Required (min 3 char)");
    	msgArray.push("MailboxName Required");
    	msgArray.push("FileTemplate matches MailboxName, Invalid");
    	if ($(".fileTemplate").val().length>=3||$(".fileTemplate").val()=='*') {msgArray[0] = "";}  	
    	if ($(".mailboxId").val()>''){msgArray[1] = "";}
    	if ($(".fileTemplate").val()!=$(".mbMailboxName").html()) {msgArray[2] = "";}
    	
    	if (msgArray.join("").length) {
    		$(".msg").html("<ol><li>"+msgArray.join("</li><li>")+"</li></ol>");
    	} else {
    	  	$("#MailboxRouteInfo").submit();
    	}
     });
    
	$(".update").click(function() {
		$('.TestTable').hide();
		$(".SoapTable").hide();
		$(".EntryTable" ).hide("slow");	

		var dbUrl = $('.dbUrl option:selected').text();
		$('.entryServer').html(dbUrl);
		
		$(".copy").show();
		$('.mail').attr('checked',false);
		$('tr .altRefId').addClass('altRef');
		$('tr').removeClass('altRefId');
		$(this).parent().addClass('altRefId');
		var refId        = $(this).parent().find('td').next().html();
		var fileTemplate = $(this).parent().find('td').next().next().html();
		var mailboxId    = $(this).parent().find('td').next().next().next().html();
		var mailboxName  = $(this).parent().find('td').next().next().next().next().html();
		var nameTemplate = $(this).parent().find('td').next().next().next().next().next().html();
		var busCode      = $(this).parent().find('td').next().next().next().next().next().next().html();
		var docType      = $(this).parent().find('td').next().next().next().next().next().next().next().html();
		var logging      = $(this).parent().find('td').next().next().next().next().next().next().next().next().html();
		var fileTrace    = $(this).parent().find('td').next().next().next().next().next().next().next().next().next().html();
		var mapName      = $(this).parent().find('td').next().next().next().next().next().next().next().next().next().next().html();
		var bpName       = $(this).parent().find('td').next().next().next().next().next().next().next().next().next().next().next().html();
		var eMailDest    = $(this).parent().find('td').next().next().next().next().next().next().next().next().next().next().next().next().html();
		var subject      = $(this).parent().find('td').next().next().next().next().next().next().next().next().next().next().next().next().next().html();
		var dfDirIO      = $(this).parent().find('td').next().next().next().next().next().next().next().next().next().next().next().next().next().next().html();

		if (fileTemplate.substring(0,1)=='/') {
			$('.TestTable .srcMailbox').val(fileTemplate);
		}

		$('.refId').val(refId);
		$('.fileTemplate').val(fileTemplate);
		$('.nameTemplate').val(nameTemplate);
		$('.mailboxId').val(mailboxId);
		$('.mbMailboxId').html(mailboxId);
		$('.mailboxName').val(mailboxName);
		$(".mbMailboxName").html(mailboxName);
		$(".displayfileTemplate").html(fileTemplate);
		$(".docType").val(docType);
		$(".mapName").val(mapName);
		$(".bpName").val(bpName);
		$(".eMailDest").val(eMailDest);
		$(".subject").val(subject);
   		$(".busCode").each(function() {
   			if ($(this).val()==busCode) {
   				$(this).attr('checked',true);
   			} else {
   				$(this).attr('checked',false);
   			}
		});
   		$(".logging").each(function() {
   			if ($(this).val()==logging) {
   				$(this).attr('checked',true);
   			} else {
   				$(this).attr('checked',false);
   			}
		});
   		$(".fileTrace").each(function() {
   			if ($(this).val()==fileTrace) {
   				$(this).attr('checked',true);
   			} else {
   				$(this).attr('checked',false);
   			}
		});
   		$(".dfDirIO").each(function() {
   			if ($(this).val()==dfDirIO) {
   				$(this).attr('checked',true);
   			} else {
   				$(this).attr('checked',false);
   			}
		});
		
   		$('.exec').attr('checked',false);
		$('.execRow').hide();
   		if (eMailDest.length>0||subject.length>0) {
   			$('.execEmail').attr('checked',true);
   			$('.addMbx').attr('checked',true);
			$('.eMailRow').show('slow');
   		}
		if (mapName.length>0) {
   			$('.execRemap').attr('checked',true);
   			$('.addMbx').attr('checked',true);
			$('.mapRow').show('slow');
   		}
		if (bpName.length>0) {
   			$('.execBpName').attr('checked',true);
   			$('.addMbx').attr('checked',true);
			$('.bpRow').show('slow');
   		} 
   		if (1==0) {
   			$('.defExec').attr('checked',true);
   		}
		
   		$(".mail").each(function() {
   			if ($(this).val()==mailboxId) {
   				$(this).attr('checked',true);
   				//$(this).parent().parent().css("background-color","#e0e0e0");
   			} else {
   				$(this).attr('checked',false);
   			}
		});
		$('.save').val('Change');
		$('.delete').show();
		$('.mbxActivate').hide();
		if (fileTemplate=="*"||fileTemplate.substring(0,1)=="/") {
			$('.fileTemplate').hide();
			$('.displayfileTemplate').show();
		} else {
			$('.fileTemplate').show();
			$('.displayfileTemplate').hide();
		}
		if (fileTemplate.substring(0,1)=="/") {
			if (fileTemplate.substring(0,7)=="/bcapps") {
				$(".mbxMessage").html('FSA for BOSAPPINF');
			} else {
				$(".mbxMessage").html('Default for this Mailbox Only');
			}
			$('.mbxMessage').show();
			$('.delete').show();
		} else {
			$('.mbxMessage').hide();
		}
		if (mailboxName=='/DeadLetter') {
			$('.dropMessage').show('slow');
		} else {
			$('.dropMessage').hide('slow');
		}
		if (fileTemplate=="*") {
			$('.delete').hide();
		}
		if (fileTemplate.substring(0,1)=='/') {
			$('.checkTemplate').hide();
		} else {
			$('.checkTemplate').show('slow');
		}
		
		//var etTop  = ($('.EntryTable').css('top').replace('px','').toInteger());
		//var etLeft = ($('.EntryTable').css('left').replace('px','').toInteger())+50;
        var etTop = parseInt($(document).scrollTop());
        var etLeft = parseInt($(document).scrollLeft());
        if (etTop<0) {etTop = 100}
        
		//var t1 = "100px"; //($(document).scrollTop() +etTop)+"px";
		//var d1 = "150px"; //($(document).scrollLeft()+200)+"px";
		//$('.EntryTable').animate({left:d1,top:t1},{duration:0,queue:false});
		$('html, body').animate({ scrollTop: '0px'}, 2000);
		$('.EntryTable').animate({ scrollTop: '100px' }, 1000);
		$('.EntryTable').animate({ scrollLeft: '600px' }, 1000);
		$(".EntryTable" ).show("slow");	
		$(".renameTbl" ).show('slow');
		$(".loggingTbl" ).show('slow');
		$('.fileTemplate').focus();
	});

    $(".renameToggle").click(function() {
    	$(".renameTbl").toggle('slow');
     });

    $(".loggingToggle").click(function() {
    	$(".loggingTbl" ).toggle('slow');
     });
    
//ToDo   
    $(".delete").click(function() {
    	$(".EntryTable .msg").html('');
    	if (confirm('Delete This Entry?')) {
    		var refId = $(".refId").val();
    		var dbUrl = $(".dbUrl").val();
    		var json = new Object();
    		json.refId = refId;
    		json.dbUrl = dbUrl;
        	deleteTemplate(json);
    	} else {
    	  $(".EntryTable .msg").html('Cancel Delete');
    	}
     });
     
    $(".mbxActivate").click(function() {
    
    	var mailboxId = $(".actMailboxId").val();
    	var mailboxName = $(".fileTemplate").val();
        var url = 'activateMailboxRule.do?mailboxId='+mailboxId+'&mailboxName='+mailboxName;
        $.blockUI({message:'<div class="wait">Processing</div><img src="images/ajax-loader.gif" class="wait" />'});
        window.location = url;
    	
     });
 
    $('.showMdnTable').click(function() {
		$('.MdnTable').show('slow');
		//window.scroll(100,300);
		var winHeight = window.innerHeight;
		var winWidth = window.innerWidth;
		var mdnHeight = $('.MdnTable').css('height').replace('px','').toInteger();
		var t6 = $(document).scrollTop() + ((winHeight-mdnHeight)/2);
		var f6 = $(document).scrollLeft() + (winWidth/2);
		$('.MdnTable').css('position','absolute');
		$('.MdnTable').css('top', t6);
		$('.MdnTable').css('left', f6);
     });
 
     $('.showLockTable').click(function() {
     	showLockTable();
     });

     
     $(".dbUrl").change(function() {
        var url = $('.dbUrl').val();
        $.blockUI({message:'<div class="wait">Processing</div><img src="images/ajax-loader.gif" class="wait" />'});
        window.location = url;
	});

	$(".refreshMbx").click(function() {
        var listMode=$(this).html();
        $.blockUI({message:'<div class="wait">Updating</div>'});
       	$('.refreshType').html(listMode+' '+'Mail'); // <div>('+new Date().fmtTime()+')</div>');
       	var payload = new Object();
       	payload.dbUrl = $('.dbUrl').val();
       	payload.listMode = listMode;
        console.log(JSON.stringify(payload));
       	$.ajax({
       		type: "POST",
       		contentType: "application/json",
       		url: "refreshMbx.do",
       		xhrFields: {withCredentials: true},
       		cache: false,
       		timeout: 600000,
       		dataType: 'json',
       		data: JSON.stringify(payload),
       		success: function(data) {
		 			console.log('success.js');
		 			console.log(data);
		 			var tblData = '';
		 			var i=0; 
		 			var rowClass = ['altLight','altDark'];
		 			$.each(data, function(key, value) {
		 				i++; 
		 				var tClass= rowClass[(i%2)];
		 				var mbClass='showMailbox';
		 				tblData += '<tr class="'+tClass+'">'
		 					+'<td class="showMessages" align="center">('+value+')</td>'
		 					+'<td class="'+mbClass+'" nowrap>'+key+'</td>'
		 					+'<td>&nbsp;</td>'
		 					+'</tr>';
		 			});
		 			$('.mbxBody').html(tblData);
		 			console.log('success.js');
				},
       		error: function (e) {
		 			$('.mbxBody').html('<tr><td colspan="3">'+e.responseText+'<tr><td>');
		 			console.log("ERROR : ", e);
       				}
       	});
    	$.unblockUI();
	});
		     
	$(".refresh, .halt, .reload").click(function() {
		var url = $('.dbUrl').val();
        $.blockUI({message:'<div class="wait">Processing</div><img src="images/ajax-loader.gif" class="wait" />'});
        window.location = url;
	});
	
	     
	$(".renameNode").click(function() {
        var node = $(this).html();
        var name = $('.nameTemplate').val();
        if (node.substring(0,1)=='.') {node = node.substring(1,node.length);}
        if (name.length>0) {name +='.';}
        $('.nameTemplate').val(name+node);
        var nameLen = $('.nameTemplate').val().length;
        $('.nameLength').html(' ('+nameLen+' chars) 100 char max');
        if (nameLen>100) {alert('Template Truncation will occur on save!');}

	});
	
	$( ".unHide" ).click(function() {
		$( ".tblDiv" ).toggle( "slow", function() {
			$( ".unHide" ).html('Template List Toggle');
		});
	});
	 
	$(".clearTest").click(function() {
    
		$('.testTableBody').html('');
    	$(".msg").html('');
		$('.filename').focus();

	});

	 $( document ).on( 'click', '.testDestFilename', function() { 
    	var srcMailbox = $(this).prev().html();
    	var filename   = $(this).html();
    	//$(".srcMailbox").val(srcMailbox);
    	//$(".filename").val(filename);
        $.blockUI({message:'<div class="wait">Processing</div><img src="images/ajax-loader.gif" class="wait" />'});
    	doRouteTest(srcMailbox, filename);
	});
	
	$(".clearNameTemplate").click(function() {
    
		$('.nameTemplate').val('');
		$('.nameLength').html('');
		$('.nameTemplate').focus();

	});

	$(".copy").click(function() {
		$('.save').val('Insert');
		$('.delete').hide();
		$('.refId').val('');
		$(".displayfileTemplate").html('');
		$(".mbxMessage").html('Copy');
		$('.mbxMessage').show('slow');
		$(".copy").hide();
		$('.fileTemplate').show('slow');
		$('.checkTemplate').show('slow');
		$('.fileTemplate').focus();
	});
			
	$(".clear").click(function() {
    
		$('.save').val('Insert');
		$('.delete').hide();
		$('.refId').val('');
		$('.fileTemplate').val('');
		$('.nameTemplate').val('');
		$('.mbMailboxId').html('');
		$('.mailboxId').val('');
		$('.mailboxName').val('');
		$(".displayfileTemplate").html('');
		$('.mbMailboxName').html('');
    	$('.msg').html('');
		$('.mbxMessage').hide();
		$('.mbxActivate').hide();
		$(".displayfileTemplate").hide();
		
		$(".docType").val('');
		$(".mapName").val('');
		$(".bpName").val('');
		$(".eMailDest").val('');
		$(".subject").val('');
   		$(".busCode").attr('checked',false);
   		$(".logging").attr('checked',false);
   		$(".fileTrace").attr('checked',false);
   		$(".dfDirIO").attr('checked',false);
		
		$('.fileTemplate').show();
		$('.checkTemplate').show('slow');
		$('.fileTemplate').focus();

	});
    $('.prompt').click(function() {
    	promptDialogOpen($(this).html());
     });
    
    $( '.promptDialog' ).dialog({
      autoOpen: false,
      show: {effect: 'blind', duration: 1000 },
      hide: {effect: 'explode', duration: 1000},
      dialogClass: 'bccDialog',
      height: 200,
      width: 425
    });

	$(".fileTemplate").click(function() {
     	$(".fileTemplate").focus();
	});
	$(".nameTemplate").click(function() {
     	$(".nameTemplate").focus();
	});
	$(".docType").click(function() {
		$(".docType").focus();
	});
	$(".mapName").click(function() {
		$(".mapName").focus();
	});
	$(".eMailDest").click(function() {
		$(".eMailDest").focus();
	});
	$(".subject").click(function() {
		$(".subject").focus();
	});
	$(".bpName").click(function() {
		$(".bpName").focus();
	});
	$(".srcMailbox").click(function() {
		$(".srcMailbox").focus();
	});
	$(".filename").click(function() {
		$(".filename").focus();
	});

});

function promptDialogOpen(copy) {
	$('.promptText').val(copy);
	$('.promptDialog').dialog('open');
	return true;
}

function deleteTemplate(payload) {

	$.blockUI({message:'<div class="wait">Processing</div><img src="images/ajax-loader.gif" class="wait" />'});
	$.ajax({
		type: "POST",
		contentType: "application/json",
		url: "deleteTemplate.do",
		xhrFields: {withCredentials: true},
		cache: false,
		timeout: 600000,
		dataType: 'json',
		data: JSON.stringify(payload),
		success: function(data) {
					console.log("Delete Success : ", JSON.stringify(data));
					$('.msg').html("success: "+JSON.stringify(data));
					$('.save').val('Insert');
					$('.delete').hide();
					$('.refId').val('');
					$(".copy").hide();
					$('.fileTemplate').focus();
					$.unblockUI();
				 },
		error: function (e) {
				console.log("Error : ", e);
				$('.msg').html("error: "+JSON.stringify(data));
				$.unblockUI();
				}
	});

	return true;	
}

function ajaxClearLocks(payload) {
	var ajaxVal = 'inc';
	$.ajax({
		type: "POST",
		contentType: "application/json",
		url: "lockReview.do",
		xhrFields: {withCredentials: true},
		cache: false,
		timeout: 600000,
		dataType: 'json',
		data: JSON.stringify(payload),
		success: function(data) {
				console.log("Success : ", JSON.stringify(data));
				if (data.refId == 'all') {
					//continue
				} else {
					var tarObj = $('.status'+data.refId);
					var val = tarObj.html();
		        	tarObj.html(data.status);
				}
				$('.msg').html(JSON.stringify(data));
				$.unblockUI();
			},
		error: function (e) {console.log("Error : ", e);}
	});
	ajaxVal = 'resolved';
	return ajaxVal;
}

function showLockTable() {
	$('.LockTable').show('slow');
	var winHeight = window.innerHeight;
	var winWidth = window.innerWidth;
	var lockHeight = $('.LockTable').css('height').replace('px','').toInteger();
	var t6 = $(document).scrollTop() + ((winHeight-lockHeight)/3);
	var f6 = $(document).scrollLeft() + (winWidth/3);
	$('.LockTable').css('position','absolute');
	$('.LockTable').css('top', t6);
	$('.LockTable').css('left', f6);
}

function refresh() {
	var url = $('.dbUrl').val();
	$.blockUI({message:'<div class="wait">Processing</div><img src="images/ajax-loader.gif" class="wait" />'});
	window.location = url;
}

function reColorRows(classList) {
	$('.sortTable tbody tr').removeClass(classList[0]);
	$('.sortTable tbody tr').removeClass(classList[1]);
	var row = 0;
	$('.sortTable tbody tr').each(function() {
		row++;
		$(this).addClass(classList[(row%2)]);
	});
}
function centerSoapTable(maxTop, maxLeft) {
	var tblHeight = $('.SoapTable').css('height').replace('px','').toInteger();
	var tblTop  = maxTop+(tblHeight/2)-20;
	var tblLeft = (maxLeft/2);
	
	$('.SoapTable').css('position','absolute');
	$('.SoapTable').css('top', tblTop);
	$('.SoapTable').css('left', tblLeft);
}

function doRouteTest(srcMailbox, filename) {
	if (srcMailbox==null||srcMailbox.length==0) {srcMailbox = '/';}
	var payload = new Object();
   	payload.dbUrl = $('.dbUrl').val();
	payload.srcMailbox = srcMailbox;
	payload.filename   = filename;
	$.ajax({
		type: "POST",
		url: "mbxRoutingTest.do",
		contentType: "application/json",
		xhrFields: {withCredentials: true},
		cache: false,
		timeout: 600000,
		dataType: 'json',
		data: JSON.stringify(payload),        
		success: function(data) {
				console.log('data.len',data.length);
				console.log('data.json',JSON.stringify(data));
				var msg = '';
				for (var i=0;i<data.length;i++) {
					var mbxName = data[i].mailboxName;
				    $('.testMbxHead').html('DestMailbox');
					msg +='<tr>';
					msg +='<td>'+(i+1)+'.</td>';
					msg +='<td class="testFileTemplate">'+data[i].fileTemplate+'</td>';
					msg +='<td class="testDestMailbox">' +mbxName+'</td>';
					msg +='<td class="testDestFilename">'+data[i].targetFilename+'</td>';
					msg += '<td>';
					if (data[i].busProcName.length>0
					  ||data[i].eMailDest.length>0
					  ||data[i].busProcParm.length>0) {
						msg += '<ol>';
						if (data[i].busProcName>0) {msg +='<li>'+data[i].busProcName+'</li>';}
						if (data[i].eMailDest.length>0) {msg +='<li>'+data[i].eMailDest+'</li>';}
						if (data[i].busProcParm.length>0) {msg +='<li>'+data[i].busProcParm+'</li>';}
						msg += '</ol>';
					}
					msg += '</td>';
					msg +='</tr>';
				}
				$('.testTableBody').html(msg);
		    	$.unblockUI();
			},
		error: function(data) {
				var msg = '<tr><td colspan="4">'+data+'</td></tr>';
				$('.testTableBody').val(msg);
			}
	});
}

function updateExtractable(myParent, msgId) {
	var seq   = myParent.find('td').next().html();
	var txt   = myParent.find('td').next().next().html();
	var jTime = myParent.find('td').next().next().next().html();
	var row = '<td><a class="restoreMsg" href="javascript:;"><img src="https://b2btools.bc.com/IBMSterlingTools/images/reload.png" title="restore" /></a></td>'
	         +'<td>'+seq+'</td>'
	         +'<td>'+txt+'</td>'
	         +'<td>'+jTime+'</td>'
	         +'<td style="display:none;">'+msgId+'</td>'
	myParent.addClass('restoreRow');
	myParent.html(row);
   	var payload = new Object();
   	payload.dbUrl = $('.dbUrl').val();
   	payload.msgId  = msgId;
   	payload.msgCnt = 0;
   	$.ajax({
       		type: "POST",
       		contentType: "application/json",
       		url: "updateExtractableMsg.do",
       		xhrFields: {withCredentials: true},
       		cache: false,
       		timeout: 600000,
       		dataType: 'json',
       		data: JSON.stringify(payload),        
       		success: function(data) {$('.msgPartner').html('Protocol Delete success');},
       		error: function (e) {$('.msgPartner').html('Protocol Delete Failure');}
   	});
}

function restoreExtractable(myParent, msgId) {
	$.blockUI({message:'<div class="wait">Updating</div>'});
	var seq   = myParent.find('td').next().html();
	var txt   = myParent.find('td').next().next().html();
	var jTime = myParent.find('td').next().next().next().html();
	var row = '<td><input type="checkbox" name="msgId" class="msgId" value="'+msgId+'"/></td>'
	         +'<td>'+seq+'</td>'
	         +'<td>'+txt+'</td>'
	         +'<td>'+jTime+'</td>'
	         +'<td style="display:none;">'+msgId+'</td>'
	myParent.removeClass('restoreRow');
	myParent.html(row);
   	var payload = new Object();
   	payload.dbUrl = $('.dbUrl').val();
   	payload.msgId  = msgId;
   	payload.msgCnt = 1;
   	$.ajax({
       		type: "POST",
       		contentType: "application/json",
       		url: "updateExtractableMsg.do",
       		xhrFields: {withCredentials: true},
       		cache: false,
       		timeout: 600000,
       		dataType: 'json',
       		data: JSON.stringify(payload),        
       		success: function(data) {$('.msgPartner').html('Protocol Delete success');},
       		error: function (e) {$('.msgPartner').html('Protocol Delete Failure');}
   	});
   	$.unblockUI();
}

function scrollSearch(noMatch) {

    $('.searchMsg').html('');
	if (noMatch) {
    		$(".searchMsg").html('No Matches Found');
			if ($(".searchVal").val().length>0) {
				$('html, body').animate({
					scrollTop: 0,
					scrollLeft: 0
				}, 2000);
			}
	} else {
		var topPos = $('.searchMatch, .checkMatch1, .checkMatch2').offset().top -($(window).height() /2);
		$('html, body').animate({
			scrollTop: topPos
		}, 2000);
	}
}

function dataEntryTop() {

	var topPos = $('#tblEntry').offset().top -($(window).height() /2) -20;
	$('html, body').animate({
		scrollTop: topPos
	}, 2000);
}

function clearBackground() {
   	$(".searchMsg").html('');
   	$('.entryMailboxName').removeClass('searchMatch');
   	$('.entryTemplate').removeClass('checkMatch1');
   	$('.template').removeClass('checkMatch2');
   	$('.showMailbox').removeClass('noAnimate');
    $('.tblData').show("slow");
}

function displayExecChoice(choice) {

	//$('.execRow').hide();
	if (choice=='none') {
		$('.addMbx').attr('checked',false);
	} else {
		$('.addMbx').attr('checked',true);
		if (choice=='eMail') { 
			$('.eMailRow').show('slow');
		}
		if (choice=='reMap') {
			$('.mapRow').show('slow');
		}
		if (choice=='busProc') {
			$('.bpRow').show('slow');
		}
		if (1==0) {
			$('.addMbx').attr('checked',false);
			$('.defExec').attr('checked',true);
		}
	}
}

function searchAll(searchVal) {
	var match1 = searchTemplate(searchVal);
	var match2 = searchRename(searchVal);
	if (match1==0&&match2==0) {
		$(".searchMsg").html('No Matches');
	} else {
		$(".searchMsg").html('('+(match1+match2)+') <span class="checkMatch1">Matches</span>');
	}
	return match;
}

function searchTemplate(search) {
	var match = 0;
   	$('.entryTemplate').removeClass('checkMatch1');
	$('.entryTemplate').each(function() {
		var target = $(this).html().toLowerCase();
		if ( (target.substring(0,1)=='/'&&target.substring(0,1)=='/')
		   ||(target.substring(0,1)!='/'&&target.substring(0,1)!='/')) {
			var indx = target.indexOf(search);
			if (indx>-1) {
				match++;
				$(this).addClass('checkMatch1');
			}
		}
	});
	return match;
}

function searchRename(search) {
	var match = 0;
   	$('.template').removeClass('checkMatch2');
	$('.template').each(function() {
		var target = $(this).html().toLowerCase();
		var indx = target.indexOf(search);
		if (indx>-1) {
			match++;
			$(this).addClass('checkMatch2');
		}
	});
	return match;
}

</script>
</head>
<body class="body">
<form:form method="Post" modelAttribute="MailboxRouteInfo" action="saveMailboxRouteInfo.do" id="MailboxRouteInfo" >
<div align="center" class="refresh"><img src="images/BccLogo.png" /></div>
<div class="hProd" align="center">${pageContext.request.serverName}</div>
<div class="hProd" align="center">${dbServer}</div>
<div align="left">
	<form:select class="dbUrl" path="dbUrl">
		<form:option value="sterlingHome.do?dbUrl=prod">Production (bospsql02a/b2b)</form:option>
		<form:option value="sterlingHome.do?dbUrl=test">Development (bosdsql14)</form:option>
	</form:select>
</div>
<div>&nbsp;</div>

<c:set var="columns" value="1" />
<c:set var="listSize" value="${MbxByMailboxInfoList.size()}" />
<fmt:parseNumber var="colRows" integerOnly="true" value="${(listSize /columns)}" />
<c:if test="${colRows lt 20}">
	<c:set var="colRows" value="20" />
</c:if>
<c:set var="row" value="0" />
<c:set var="breakRow" value="0" />
	<table class="tblData byTemplateName">
		<tr>
			<td>
				<table class="sortTable">
					<thead>
						<tr>
							<th class="sortCol">Seq</th>
							<th class="sorter-false">ref</th>
							<th class="sortCol">FileTemplate</th>
							<th class="sorter-false">mbxId</th>
							<th class="sortCol">Mailbox</th>
							<th class="sortCol">Rename Template</th>
							<th class="sorter-false">busCode</th>
							<th class="sorter-false">docType</th>
							<th class="sorter-false">log</th>
							<th class="sorter-false">trace</th>
							<th class="sorter-false">mapName</th>
							<th class="sorter-false">BPName</th>
							<th class="sorter-false">eMailDest</th>
							<th class="sorter-false">MailSubject</th>
							<th class="sorter-false">IO</th>
							<th class="sorter-false">Seq</th>
						</tr>
					</thead>
					<tbody>
<c:forEach var="act" items="${MbxByTemplateInfoList}" varStatus="status">
							<c:set var="row" value="${row + 1}" />
							<c:set var="defTitle" value="" />
							<c:set var="defClass" value="" />
							<c:set var="selClass" value="" />
							<c:set var="selStyle" value="" />
							<c:set var="errStyle" value="" />
							<c:choose>
								<c:when test="${fn:startsWith(act.fileTemplate, '/bcapps')}">
									<c:set var="defClass" value="fsaMailbox" />
									<c:set var="defTitle" value="FSA Adapter Definition" />
								</c:when>
								<c:when test="${fn:startsWith(act.fileTemplate, '/')}">
									<c:set var="defClass" value="defaultMailbox" />
									<c:set var="defTitle" value="Mailbox Default Definition" />
								</c:when>
								<c:otherwise>
									<c:set var="defTitle" value="Filenames begin with Definition" />
								</c:otherwise>
							</c:choose>
							<c:if test="${breakRow%2==0}">
								<c:set var="rowClass" value="altDark" />
							</c:if>
							<c:if test="${breakRow%2==1}">
								<c:set var="rowClass" value="altLight" />
							</c:if>
							<c:if test="${refId==act.refId}">
								<c:set var="selClass" value="altRefId" />
							</c:if>
							<c:if test="${fn:startsWith(act.fileTemplate, '/')&&refId!=act.refId}">
								<c:set var="selStyle" value="style='font-style:italic;font-weight:bold;'" />
							</c:if>
							<c:if test="${fn:length(act.fileTemplate)>=3&&fn:startsWith(act.fileTemplate, 'off')&&refId!=act.refId}">
								<c:set var="selStyle" value="style='color:#FF8000;font-weight:bold;'" />
							</c:if>
							<c:if test="${empty act.mailboxName}">
								<c:set var="errStyle" value="style='background-color:#FF0000;color:#ffffff;'" />
							</c:if>
							
							<tr class="${selClass} ${rowClass}" ${errStyle}>
								<td>${row}.</td>
								<td class="sorter-false">${act.refId}</td>
								<td class="update entryTemplate ${defClass}" ${selStyle} title="${defTitle}" nowrap>${act.fileTemplate}</td>
								<td class="sorter-false">${act.mailboxId}</td>
								<td class="entryMailboxName showMailbox" nowrap>${act.mailboxName}</td>
								<td class="template">${act.nameTemplate}</td>
								<td class="sorter-false">${act.busCode}</td>
								<td class="sorter-false">${act.docType}</td>
								<td class="sorter-false">${act.logging}</td>
								<td class="sorter-false">${act.fileTrace}</td>
								<td class="sorter-false">${act.mapName}</td>
								<td class="sorter-false">${act.bpName}</td>
								<td class="sorter-false">${act.eMailDest}</td>
								<td class="sorter-false">${act.subject}</td>
								<td class="sorter-false">${act.dfDirIO}</td>
								<td class="sorter-false update">${row}.</td>
							</tr>
	<c:set var="breakRow" value="${breakRow + 1}" />
</c:forEach>
					</tbody>
				</table>
	</table>
<div class="EntryTable altDark">
<div id="tblEntry">
	<table>
		<tr>
			<td><a href="javascript:;" class="dragEntryTable"><img src="https://b2btools.bc.com/IBMSterlingTools/images/drag.png" title="Draggable" /></a></td>
			<td width="70%" align="center"><h3><span  class="renameToggle">Template</span>&nbsp;<span  class="loggingToggle">Entry</span></h3></td>
			<td width="30%">
				<table width="100%">
					<tr>
						<td align="left"><a href="javascript:;" class="copy"><img src="https://b2btools.bc.com/IBMSterlingTools/images/copy.png" title="copy" /></a></td>
						<td>&nbsp;</td>
						<td align="right"><a href="javascript:;" class="cntrlEntry"><img src="https://b2btools.bc.com/IBMSterlingTools/images/close.png" title="close" /></a></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</div>
<table class="tblEntry">
<tr><td valign="top"><span class="entryServer"></span>
<table class="baseTable altLight" align="center" width="50%">
<tr><td colspan="3">&nbsp;</td></tr>
<tr class="outstanding">
    <td title="Not Case Sensitive"><span class="altDark">FileTemplate</span></td>
	<td class='mbxMessage' align="center">&nbsp;</td>
    <td align="right"><a href="javascript:;" class="checkTemplate altDark">Dup Check</a></td>
</tr>
<tr>
	<td style="display:none"><form:input path="refId" class="refId" size="4" /></td>
	<td nowrap colspan="3"><span class="displayfileTemplate" style="display:none;"></span><form:input path="fileTemplate" class="fileTemplate" size="75" /></td>
</tr>
<tr>
    <td nowrap><span class="altDark outstanding">Dest Mailbox</span>........</td>
	<td style="display:none"><span class="mbMailboxId"></span><form:hidden path="mailboxId" class="mailboxId" size="4" /></td>
	<td nowrap colspan="2"><span class="mbMailboxName">${MailboxRouteInfo.mailboxName}</span><form:hidden path="mailboxName" class="mailboxName" /></td>
</tr>
<tr>
	<td colspan="1" class="dropMessage">&nbsp;</td>
	<td colspan="2" class="dropMessage">Message will be dropped after processing</td>
</tr>
</table>
<div class=" renameTbl">
<div>&nbsp;</div>
<table class="baseTable altLight">
	<tr>
		<td colspan="1"><td><b>Re-Name Template</b></td>
		<td colspan="4" align="center"><span class="nameLength">&nbsp;</span></td>
		<td colspan="2"><a href="javascript:;" class="clearNameTemplate">clear ReName</a></td>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="9"><form:input path="nameTemplate" class="nameTemplate" size="150" /></td>
	</tr>
	<tr>
		<td>
			<ol start="1">
				<li><a href="javascript:;" class="renameNode" title="filename w/o .ext">&#36;{FileName}</a></li>
				<li><a href="javascript:;" class="renameNode" title="filename .ext only">&#36;{Ext}</a></li>
				<li><a href="javascript:;" class="renameNode" title="this.hostname">&#36;{HostName}</a></li>
				<li><a href="javascript:;" class="renameNode" title="BPProcId">&#36;{ProcId}</a></li>
				<li><a href="javascript:;" class="renameNode" title="Seq no">&#36;{seqNo}</a></li>
			</ol>
		</td>
		<td>
			<ol start="6">
				<li><a href="javascript:;" class="renameNode" title="yyyyMMddHHmmssnnn">&#36;{Timestamp}</a></li>
				<li><a href="javascript:;" class="renameNode" title="yyyyMMddHHmmss">&#36;{DateTime}</a></li>
				<li><a href="javascript:;" class="renameNode" title="yyyyMMdd">&#36;{Date}</a></li>
				<li><a href="javascript:;" class="renameNode" title="HHmmss">&#36;{Time}</a></li>
				<li><a href="javascript:;" class="renameNode" title="MMddyyyy">&#36;{mdyDate}</a></li>
			</ol>
		</td>
		<td>
			<ol start="11">
				<li><a href="javascript:;" class="renameNode">&#36;{isaSenderId}</a></li>
				<li><a href="javascript:;" class="renameNode">&#36;{isaReceiverId}</a></li>
				<li><a href="javascript:;" class="renameNode">&#36;{isaDocType}</a></li>
				<li><a href="javascript:;" class="renameNode">&#36;{isaCntl}</a></li>
				<li><a href="javascript:;" class="renameNode">&#36;{isaMode}</a></li>
			</ol>
		</td>
		<td>
			<ol start="16">
				<li><a href="javascript:;" class="renameNode" title="filename">&#36;{node01}</a></li>
				<li><a href="javascript:;" class="renameNode" title="filename">&#36;{node02}</a></li>
				<li><a href="javascript:;" class="renameNode" title="filename">&#36;{node03}</a></li>
				<li><a href="javascript:;" class="renameNode" title="filename">&#36;{node04}</a></li>
				<li><a href="javascript:;" class="renameNode" title="filename">&#36;{node05}</a></li>
			</ol>
		</td>
		<td>
			<ol start="21">
				<li><a href="javascript:;" class="renameNode" title="filename">&#36;{node06}</a></li>
				<li><a href="javascript:;" class="renameNode" title="filename">&#36;{node07}</a></li>
				<li><a href="javascript:;" class="renameNode" title="filename">&#36;{node08}</a></li>
				<li><a href="javascript:;" class="renameNode" title="filename">&#36;{node09}</a></li>
				<li><a href="javascript:;" class="renameNode" title="filename">&#36;{node10}</a></li>
			</ol>
		</td>
		<td>
			<ol start="26">
				<li><a href="javascript:;" class="renameNode" title="Source Mailbox">&#36;{srcRoot}</a></li>
				<li><a href="javascript:;" class="renameNode" title="Source Mailbox">&#36;{srcMbx02}</a></li>
				<li><a href="javascript:;" class="renameNode" title="Source Mailbox">&#36;{srcMbx03}</a></li>
				<li><a href="javascript:;" class="renameNode">&#36;{mtfRef01}</a></li>
				<li><a href="javascript:;" class="renameNode">&#36;{mtfRef02}</a></li>
				<li><a href="javascript:;" class="renameNode">&#36;{mtfRef03}</a></li>
			</ol>
		</td>
		<td>
			<ol start="31">
				<li><a href="javascript:;" class="renameNode" title="Target Mailbox">&#36;{tarRoot}</a></li>
				<li><a href="javascript:;" class="renameNode" title="Target Mailbox">&#36;{tarMbx02}</a></li>
				<li><a href="javascript:;" class="renameNode" title="Target Mailbox">&#36;{tarMbx03}</a></li>
			</ol>
		</td>
		<td>
			<ol start="34">
				<li><a href="javascript:;" class="renameNode" title="Static Value">.csv</a></li>
				<li><a href="javascript:;" class="renameNode" title="Static Value">.edi</a></li>
				<li><a href="javascript:;" class="renameNode" title="Static Value">.htm</a></li>
				<li><a href="javascript:;" class="renameNode" title="Static Value">.txt</a></li>
				<li><a href="javascript:;" class="renameNode" title="Static Value">.xml</a></li>
			</ol>
		</td>
	</tr>
</table>
</div>
<div class="loggingTbl">
<div>&nbsp;</div>
<table class="baseTable altLight" align="center">
<tr><td colspan="3">&nbsp;</td></tr>
<tr class="outstanding"><td colspan="3" class="altDark">Logging</td></tr>
<tr>
	<td><td>&nbsp;</td>
	<td>
		<table align="left"  class="outstanding">
<c:forEach var="bus" items="${businessList}">
			<tr><td>${bus.code}</td><td><form:radiobutton path="busCode" class="busCode" value="${bus.code}"/></td></tr>
</c:forEach>
		</table>
		<table align="left" style="font-weight:bold;">
			<tr><td>DocType</td><td><form:input path="docType" class="docType" size="3" maxlength="3" /></td></tr>
			<tr title="*for X12 Only"><td align="right">Use4Route</td><td><form:checkbox path="logging" class="logging" value="n"/></td></tr>
			<tr title="*FileTracing "><td align="right">Trace</td><td><form:checkbox path="fileTrace" class="fileTrace" value="y"/></td></tr>
			<tr><td align="right">FlowIn</td><td><form:radiobutton path="dfDirIO" class="dfDirIO" value="I" /></td></tr>
			<tr><td align="right">FlowOut</td><td><form:radiobutton path="dfDirIO" class="dfDirIO" value="O" /></td></tr>
		</table>
	</td>
	<td><td>&nbsp;</td>
	<td>
		<table style="font-weight:bold;">
			<tr class="outstanding altDark"><td>Processing</td><td align="right"><a href="javascript:;" class="fireWebService"><img width="30" height="23" src="https://b2btools.bc.com/IBMSterlingTools/images/soapBar.png" /></a>&nbsp;</td></tr>
			<tr><td width="300px">Exec  </td></tr>
			<tr><td><input type="checkbox" class="exec defExec" name="exec0" value="none">AddMailbox Only</td></tr>
			<tr><td><input type="checkbox" class="exec execEmail" name="exec1" value="eMail">Create Email</td></tr>
			<tr><td><input type="checkbox" class="exec execRemap" name="exec2" value="reMap">ReMap File</td></tr>
			<tr><td><input type="checkbox" class="exec execBpName" name="exec3" value="busProc">Run BusProc</td></tr>
			<tr><td><input type="checkbox" class="exec addMbx" name="addMbx" value="Add">AddMailbox (atEnd)</td></tr>
			<tr class="execRow eMailRow"><td>eMailDest: <form:input path="eMailDest" class="eMailDest" size="30" /></td></tr>
			<tr class="execRow eMailRow"><td>Subject: <form:input path="subject" class="subject" size="30" /></td></tr>
			<tr class="execRow mapRow"><td>MapName: <form:input path="mapName" class="mapName" size="20" /></td></tr>
			<tr class="execRow bpRow"><td>BpName:</td></tr>
			<tr class="execRow bpRow"><td><form:textarea path='bpName' class='bpName' rows='1' cols='30' /></td></tr>
		</table>
	</td>
	</td>
</tr>
<tr><td colspan="9"><span class="ruleMessage">${ruleMessage}</span></td></tr>
</table>
</div>
<div>&nbsp;</div>
<div class="msg">${msg}</div>
<tr>
	<td style="display:none"><input type="text" name="actMailbox" class="actMailboxId" size="4" value="0" /></td>
	<td align="center" colspan="2">
		<input type="button" class="delete butStyle" value="Delete" />
		<input type="button" class="save butStyle" value="Insert" />
		<input type="button" class="mbxActivate butStyle" value="ActivateMailboxRule" />
	</td>
</tr>
<tr>
    <td colspan="4">
    <table>
    <tr>
		<td align="left"  ><a href="javascript:;" class="copy">copy</a></td>
		<td align="center"><a href="javascript:;" class="renameToggle">toggle</a></td>
		<td align="center"><a href="javascript:;" class="loggingToggle">toggle</a></td>
		<td align="right" ><a href="javascript:;" class="clear">clear</a></td>
	</tr>
	</table>
	</td>
</tr>
</table>
</div>
<div class="msg">&nbsp;${msg}&nbsp;</div>
<div id="bot">&nbsp;</div>
<div>&nbsp;</div>
<table class="tblMailbox">
<tr>
	<td>&nbsp;</td>
	<td>
<c:set var="columns" value="3" />
<c:set var="breakRow" value="0" />
<c:set var="listSize" value="${MailboxInfoList.size()}" />
<fmt:parseNumber var="colRows" integerOnly="true" value="${(listSize /columns)+1}" />
<table class="mbxData">
	<tr><td colspan="${columns}"> (${MailboxInfoList.size()}) Mailboxes</td></tr>
	<tr style="background-color:#e0e0e0;"><th colspan="${columns}">Mailboxes (${listSize} rows)</th></tr>
<tr>
<tr><td>
	<table>
<c:forEach var="mailbox" items="${MailboxInfoList}" varStatus="status">
<c:set var="breakRow" value="${breakRow + 1}" />
<c:if test="${breakRow%2==0}"><c:set var="rowClass" value="altDark" /></c:if>
<c:if test="${breakRow%2==1}"><c:set var="rowClass" value="altLight" /></c:if>
<c:set var="use" value="" />
<c:set var="note" value="" />
<c:set var="cnt" value="" />
<c:set var="mbxTitle" value="${mailbox.inOut}" />
<c:choose>
	<c:when test="${fn:startsWith(mailbox.inOut, 'BC_Mailbox_') }">
		<c:set var="use" value="bmrRule" />
		<c:set var="note" value="*" />
	</c:when>
	<c:when test="${fn:startsWith(mailbox.inOut, 'BC_MailboxUtility_sha2') }">
		<c:set var="use" value="sha2Rule" />
		<c:set var="note" value="*" />
	</c:when>
	<c:when test="${fn:startsWith(mailbox.inOut, 'BC_MailboxUtility') }">
		<c:set var="use" value="bmuRule" />
		<c:set var="note" value="*" />
	</c:when>
	<c:when test="${fn:startsWith(mailbox.inOut, 'BC_') }">
		<c:set var="use" value="bccRule" />
		<c:set var="note" value="*" />
	</c:when>
	<c:when test="${fn:startsWith(mailbox.inOut, 'EDIInboundCollection') }">
		<c:set var="use" value="ediRule" />
		<c:set var="note" value="*" />
	</c:when>
	<c:when test="${fn:startsWith(mailbox.inOut, 'FileGatewayRoutingRule') }">
		<c:set var="use" value="sfgRule" />
		<c:set var="note" value="*" />
	</c:when>
	<c:when test="${fn:startsWith(mailbox.inOut, 'AS2Contract') }">
		<c:set var="use" value="as2Rule" />
		<c:set var="note" value="*" />
	</c:when>
	<c:when test="${mailbox.inOut ne null}">
		<c:set var="use" value="othRule" />
		<c:set var="note" value="*" />
	</c:when>
	<c:otherwise>
		<c:set var="mbxTitle" value="No SBI Rule" />
		<c:set var="use" value="nonRule" />
		<c:set var="note" value="" />
	</c:otherwise>
</c:choose>
<c:if test="${statusMap.containsKey(mailbox.mailboxName)}">
		<c:set var="cnt" value="(${statusMap[mailbox.mailboxName]})" />
</c:if>
<c:if test = "${mailbox.mailboxName == '/Emailbox'}">   
		<c:set var="mbxTitle">Default eMail (${mailbox.mailboxId})</c:set>
		<c:set var="note">${note} 
			<span class="defHide defaultEmailId">${mailbox.mailboxId}</span>
			<span class="defHide defaultEmailName">${mailbox.mailboxName}</span>
		</c:set>
</c:if> 
		<tr class="${rowClass}">
			<td class="tblCount">${cnt}</td>
			<td>${note}</td>
			<td><input type="checkbox" class="mail" name="mail" value="${mailbox.mailboxId}" /></td>
			<td class="mbxDisplay ${use}" title="${mbxTitle}" nowrap>${mailbox.mailboxName}</td>
		</tr>
  <c:if test="${breakRow ge colRows}">
<c:set var="breakRow" value="0" />
  	</table>
</td>
<td>
    <table>
  </c:if>
</c:forEach>
	</table>
</td>
</tr>
<tr class="othRule"><td>
<tr><td>* <span class="footnote">Rule defined for this mailbox</span></td></tr>
<tr>
<td>
<ol>
<li><span class="bccRule">BC* Rule</span></li>
<li><span class="as2Rule">AS2 Contract</span></li>
<li><span class="bmuRule">BC_MailboxUtility Rule</span></li>
<li><span class="ediRule">EDIInboundBootstrap Rule</span></li>
<li><span class="sha2Rule">BC_MailboxUtility_sha2 Rule</span></li>
<li><span class="sfgRule">FileGatewayMailboxRoute Rule</span></li>
<li><span class="othRule">Other Rule</span></li>
</ol>
</td>
</tr>
<tr><td>* <span class="footnote">hover to view rule name</span></td></tr>
<tr><td>  <span class="footnote searchMatch">Search Match</span></td></tr>
<tr><td>  <span class="footnote searchNoMatch">No Search Match</span></td></tr>
<tr><td>&nbsp;</td></tr>
<tr>
	<td>
		<ul style="text-decoration:none;">
			<li><a href="javascript:;" class="prompt">http://bouxsbi03:8080/dashboard/portal</a></li>
			<li><a href="javascript:;" class="prompt">http://bouxsbi03.bc.com:8080/filegateway</a></li>
		</ul>
	</td>
</table>
<div>&nbsp;</div>
<div class="msg">${msg}</div>
<div style="text-align:center;font-weight:bold;">${dbUrl}</div>
<div style="text-align:center;font-weight:bold;">${pageContext.request.serverName}</div>
</td>
</tr>
</table>
<div>&nbsp;</div>
<div class="MailTable">
	<table class="tblMail">
	  <thead>
		<tr class="altlight">
			<td align="left"  >
				<a href="javascript:" class="dragMailTable"><img src="https://b2btools.bc.com/IBMSterlingTools/images/drag.png"  title="Draggable" /></a>
			</td>
			<td class="server">MailboxList</td>
			<td align="right" >
				<a href="javascript:" class="reload"><img src="https://b2btools.bc.com/IBMSterlingTools/images/reload.png" title="reload" /></a>
				<a href="javascript:" class="hideEmpty"><img src="https://b2btools.bc.com/IBMSterlingTools/images/close.png" title="close" /></a>
			</td>
		</tr>
		<tr>
			<td align="left"  ></td>
			<td align="center"></td>
			<td align="right"></td>
		</tr>
		<tr class="altLight">
			<th>Msgs</th>
			<th class="refreshType">Active Mail</th>
			<th><a href="javascript:" class="refreshMbx">All</a></th>
		</tr>
	  </thead>
<c:set var="breakRow" value="0" />
	<tbody class="mbxBody">
<c:forEach var="entry" items="${statusMap}">
  <c:set var="breakRow" value="${breakRow + 1}" />
  <c:set var="msgClass" value="showMailbox" />
  <c:if test="${breakRow%2==1}"><c:set var="rowClass" value="altDark" /></c:if>
  <c:if test="${breakRow%2==0}"><c:set var="rowClass" value="altLight" /></c:if>
  <c:if test="${fn:indexOf(entry.key, '/archive')>0}"><c:set var="msgClass" value="noShowMailbox" /></c:if>
		<tr class="${rowClass}">
			<td class="showMessages" align="center">(${entry.value})</td>
			<td class="${msgClass}" nowrap>${entry.key}</td>
			<td>&nbsp;</td>
		</tr>
</c:forEach>
	  </tbody>
<c:set var="lockCount" value="${fn:length(lockList)}" />
<c:set var="haltCount" value="${fn:length(haltList)}" />
<c:set var="mdnCount" value="${fn:length(mdnList)}" />
	  <tfoot>
		<tr><td><hr/></td><td class="msgLoaded"><hr/></td><td><hr/></td></tr>
		<tr class="altLight">
			<td><a href="javascript:" class="refreshMbx">Pending</a></td>
			<td align="center">
				<div><a href="javascript:" class="refreshMbx">Refresh</a></div>
			<c:if test="${lockCount gt 0}">
				<div class="showLockTable hot">Locked (${lockCount})</div></c:if>
			<c:if test="${haltCount gt 0}">
				<div>Halted (${haltCount})</div></c:if>
			<c:if test="${mdnCount gt 0}">
				<div class="showMdnTable">Mdn (${mdnCount})</div></c:if>
			</td>
			<td align="right"><a href="javascript:" class="refreshMbx">Archive</a>
		</tr>
	  </tfoot>
	</table>
</div>
<div class="MsgTable">
  <div class='divMail'>
	<table class="dtlMail altLight" style="width:700px">
		<thead>
			<tr class="altLight">
				<td colspan="1"><a href="javascript:;" class="dragMsgTable"><img src="https://b2btools.bc.com/IBMSterlingTools/images/drag.png" title="Draggable" /></a></td>
				<td colspan="3" class="msgTitle altLight" align="center">MailMessages</td>
				<td colspan="1" align="right"><a href="javascript:;" class="hideMsgs"><img src="https://b2btools.bc.com/IBMSterlingTools/images/close.png" title="close" /></a></td>
			</tr>
			<tr class="altDark">
				<th><input type="checkbox" name="masterMsgId" class="masterMsgId" value="master" /></th>
				<th>&nbsp;</th>
				<th>Message</th>
				<th>Timestamp</th>
				<td></td>
			</tr>
		</thead>
		<tbody class="dtlData"></tbody>
		<tfoor><tr class="altLight"><td colspan="5" align="center"><a href="javascript:;" class="find" title="find">find mailbox</a></td></tr></tfoot>
	</table>
	<div class='url'></div>
  </div>
</div>
<table class="msgData" style="display:none;">
<c:forEach var="msg" items="${messageList}">
	<tr class="msg">
		<td>${msg.mailboxName}</td>
		<td>${msg.messageId}</td>
		<td>${msg.messageName}</td>
		<td>${msg.messageFmtTimestamp}</td>
	</tr>
</c:forEach>
</table>

<div class="TestTable altDark">
<div>
<table>
<tr>
	<td align="left"><a href="javascript:;" class="dragTestTable"><img height="24" width="24" src="https://b2btools.bc.com/IBMSterlingTools/images/drag.png" title="Draggable" /></a></td>
	<td class="server">Template Test</td>
	<td align="right"><a href="javascript:;" class="cntrlTest"><img src="https://b2btools.bc.com/IBMSterlingTools/images/close.png" title="close" /></a></td>
</tr>
<tr>
	<td align="right">Source Mailbox</td>
	<td><input type="text" name="srcMailbox" class="srcMailbox" size="75" value="${MailboxRouteRequest.srcMailbox}" /></td>
	<td>&nbsp;</td>
</tr>
<tr>
	<td align="right">FileName</td>
	<td align="left">
		<input type="text" name="fileName" class="filename" size="75" value="${MailboxRouteRequest.fileName}" />&nbsp;
		<input type="button" class="mbxRoutingTest butStyle" value="Test" />
	</td>
	<td>&nbsp;</td>
</tr>
<tr>
	<td colspan="3">
		<table width="100%" style="padding-left:5px;">
		  <thead>
			<tr>
				<td>&nbsp;</td>
				<th align="left">FileTemplate</th>
				<th align="left" class="testMbxHead">DestMailbox</th>
				<th align="left">Target Filename</th>
				<th align="left">&nbsp;</th>
			</tr>
		  </thead>
		  <tbody class="testTableBody"></tbody>
		  <tfoot><tr><td>&nbsp;</td></tr></tfoot>
		</table>
	</td>
</tr>
</table>
</div>
</div>
<div>&nbsp;</div>
<div class="LockTable">
	<table class="tblMail">
	  <thead>
		<tr class="altlight">
			<td align="left"><a href="javascript:;" class="dragLockTable"><img src="https://b2btools.bc.com/IBMSterlingTools/images/drag.png" title="Draggable" /></a></td>
			<td colspan="8" align="center"><b>DB Lock's</b></td>
			<td align="right"><a href="javascript:" class="hideLock"><img src="https://b2btools.bc.com/IBMSterlingTools/images/close.png" title="close" /></a></td>
		</tr>
		<tr class="altLight">
			<th><input type="checkbox" class="lockReview" name="lockReviewAll" value="all"></th>
			<th>&nbsp;</th>
			<th>Status</th>
			<th>Item Name</th>
			<th>Created</th>
			<th>User</th>
			<th>ABSTime</th>
			<th>Timeout</th>
			<th>System</th>
			<th>&nbsp;</th>
		</tr>
	  </thead>
<c:set var="breakRow" value="0" />
	<tbody>
<c:forEach var="lock" items="${lockList}">
  <c:set var="breakRow" value="${breakRow + 1}" />
  <c:if test="${breakRow%2==1}"><c:set var="rowClass" value="altLight" /></c:if>
  <c:if test="${breakRow%2==0}"><c:set var="rowClass" value="altDark" /></c:if>
  <c:if test="${lock.reviewed=='active'}"><c:set var="rowClass" value="altActive" /></c:if>
		<tr class="${rowClass}">
			<td><input type="checkbox" class="lockReview" name="lockReview" value="${lock.refId}"></td>
			<td align="center">${breakRow}.</td>
			<td nowrap class="statusAll status${lock.refId}">${lock.reviewed}</td>
			<td nowrap>${lock.itemName}</td>
			<td nowrap>${lock.createTimestamp}</td>
			<td nowrap>${lock.userName}</td>
			<td nowrap>${lock.absTimestamp}</td>
			<td nowrap>${lock.timeout}</td>
			<td nowrap>${lock.systemName}</td>
			<td nowrap>${lock.clearOnStartup}</td>
		</tr>
</c:forEach>
	  </tbody>
	  <tfoot>
		<tr><td colspan="10" class="lockMsg"></td></tr>
	  </tfoot>
	</table>
</div>

<div>&nbsp;</div>
<div class="MdnTable">
	<table class="tblMail">
	  <thead>
		<tr class="altlight">
			<td align="left">
				<a href="javascript:;" class="dragMdnTable"><img src="https://b2btools.bc.com/IBMSterlingTools/images/drag.png" title="Draggable" /></a>
			</td>
			<td colspan="2" align="center"><b>Pending MDN's</b></td>
			<td align="right"><a href="javascript:" class="hideMdn"><img src="https://b2btools.bc.com/IBMSterlingTools/images/close.png" title="close" /></a></td>
		</tr>
		<tr class="altLight">
			<th>&nbsp;</th>
			<th>Mailbox</th>
			<th>Created</th>
			<th>Status</th>
		</tr>
	  </thead>
<c:set var="breakRow" value="0" />
	<tbody>
<c:forEach var="entry" items="${mdnList}">
  <c:set var="breakRow" value="${breakRow + 1}" />
  <c:if test="${breakRow%2==1}"><c:set var="rowClass" value="altDark" /></c:if>
  <c:if test="${breakRow%2==0}"><c:set var="rowClass" value="altLight" /></c:if>
		<tr class="${rowClass}">
			<td align="center">${breakRow}.</td>
			<td class="showMailbox">${entry.mailbox}</td>
			<td class="showMailbox">${entry.createTimestamp}</td>
			<td class="showMailbox">${entry.mdnStatus}/${entry.mdnDisp}</td>
		</tr>
</c:forEach>
	  </tbody>
	  <tfoot>
		<tr><td><hr/></td><td><hr/></td><td><hr/></td><td><hr/></td></tr>
		<tr><td colspan="4" class="mdnMsg"></td></tr>
	  </tfoot>
	</table>
</div>

<div class="NavTable">
	<table>
		<tr>
			<td colspan="8" class="logo">&nbsp;</td>
			<td>
	<table class="altLight cntrlDisplay ButtonTable">
		<tr>
			<td style="display:none"><a href="javascript:;" class="nav clearLocks" title="Clear Locks"><img width="30" height="30" src="https://b2btools.bc.com/IBMSterlingTools/images/lock.jpg" /></a></td>
			<td><a href="javascript:;" class="nav cntrlEntry" title="Enter New Route"><img src="https://b2btools.bc.com/IBMSterlingTools/images/new.png" /></a></td>
			<td><a href="javascript:;" class="nav cntrlTest"  title="Test Routing"><img src="https://b2btools.bc.com/IBMSterlingTools/images/test.png" /></a></td>
			<td><a href="javascript:;" class="nav fullTable"  title="unhide params" ><img src="https://b2btools.bc.com/IBMSterlingTools/images/share.png" /></a></td>
			<td><a href="javascript:;" class="nav hideEmpty"  title="Show Active Mail"><img src="https://b2btools.bc.com/IBMSterlingTools/images/unHide.png" /></a></td>
			<td><a href="javascript:;" class="nav showSearch" title="Show Search"><img width="23" height="23" src="https://b2btools.bc.com/IBMSterlingTools/images/search.png" /></a></td>
		</tr>
		<tr>
			<td class="cntrlText"><a href="javascript:;" class="nav debugTog"   title="debug"><img src="https://b2btools.bc.com/IBMSterlingTools/images/smDebug.png" /></a></td>
			<td class="cntrlText" colspan="3" align="center">&nbsp;</td>
			<td class="cntrlText"><a href="javascript:;" class="nav soap" title="Soap"><img width="30" height="23" src="https://b2btools.bc.com/IBMSterlingTools/images/soapBar.jpg" /></a></td>
		</tr>
	</table>
			</td>
			<td>
	<table class="altLight SearchTable">
		<tr>
			<td><input type="text" class="searchVal" name="searchVal" value="" placeholder="Search"></td>
			<td align="center"><a href="javascript:;" class="search"><img width="23" height="23" src="https://b2btools.bc.com/IBMSterlingTools/images/search.png" title="Search Go" /></a></td>
		</tr>
		<tr>
			<td>
				<table width="100%">
					<tr>
						<td class="searchMsg"   align="left">&nbsp;</td>
						<td class="clearSearch" align="right"><a href="javascript:;">clear</a></td>
					</tr>
				</table>
			</td>
			<td>&nbsp;</td>
		</tr>
	</table>
			</td>
		</tr>
	</table>
<div class="ArrowTable">
	<div>&nbsp;</div>
	<table class="altLight">
		<tr><td class="left top">&nbsp;</td><td class="top"><img width="23" height="30" src="https://b2btools.bc.com/IBMSterlingTools/images/top.png" /></td><td class="right top">&nbsp;</td></tr>
		<tr>
			<td class="left" ><img width="30" height="23" src="https://b2btools.bc.com/IBMSterlingTools/images/iconLeft.png" /></td>
			<td class="pageHome" align="center" valign="middle">&nbsp;</td>
			<td class="right"><img width="30" height="23" src="https://b2btools.bc.com/IBMSterlingTools/images/iconRight.png" /></td>
		</tr>
		<tr><td class="left bot">&nbsp;</td><td class="bot"><img width="23" height="30" src="https://b2btools.bc.com/IBMSterlingTools/images/bot.png" /></td><td class="right bot">&nbsp;</td></tr>
	</table>
</div>
	<div class="altLight debug">
		<div>&nbsp;</div>
		<table class="stats">
			<tr><td colspan="3" class="browserType">x</td></tr>
			<tr><td>&nbsp;</td><td>Top (x)</td><td>Left (y)</td></tr>
			<tr><td>TopLeft</td><td class="xTop">x</td><td class="yTop">y</td></tr>
			<tr><td>BotRight</td><td class="xBot">x</td><td class="yBot">y</td></tr>
			<tr><td>Viewable</td><td class="x0">x</td><td class="y0">y</td></tr>
			<tr><td>MousePos</td><td class="mouseX">0</td><td class="mouseY">0</td></tr>
			<tr><td>.MailTable</td><td class="x1">x</td><td class="y1">y</td></tr>
			<tr><td>.EntryTable</td><td class="x2">x</td><td class="y2">y</td></tr>
			<tr><td>.MsgTable</td><td class="x3">x</td><td class="y3">y</td></tr>
			<tr><td>.TestTable</td><td class="x4">x</td><td class="y4">y</td></tr>
			<tr><td>.MdnTable</td><td class="x5">x</td><td class="y5">y</td></tr>
			<tr><td>.LockTable</td><td class="x6">x</td><td class="y6">y</td></tr>
		</table>
	</div>
</div>
<div class="SoapTable baseTable">
	<table class="altLight">
		<thead>
			<tr>
				<td align="left"><a href="javascript:;" class="dragSoapTable"><img src="https://b2btools.bc.com/IBMSterlingTools/images/drag.png" title="Draggable" /></a></td>
				<td style="font-size:25;font-weight:bold;" align="center">Soap Webservice</td>
				<td align="right"><a href="javascript:;" class="soapClose"><img src="https://b2btools.bc.com/IBMSterlingTools/images/close.png" title="close" /></a>&nbsp;</td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>&nbsp;</td>
				<td>
					<table width="100%">
						<tr>
							<td><input type="text" class="msgName" name="msgName" placeholder="msgName" size="100" /></td>
							<td align="right">
								<select class="soapMode">
									<option value="    ">select</option>
									<option value="test">test  </option>
									<option value="prod">prod  </option>
								</select>
							</td>
					</tr>
					</table>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><textarea class="msgBody" placeholder="Ajax Response"></textarea></td>
				<td>&nbsp;</td>
			</tr>
		</tbody>
		<tfoot>
			<tr>
				<td>&nbsp;</td>
				<td align="center"><a href="javascript:;" class="soapAjax" title="fire"><img height="53" width="130" src="https://b2btools.bc.com/IBMSterlingTools/images/submitButton.jpg" /></a></td>
				<td align="right">
				</td>
			</tr>
		</tfoot>
	</table>
</div>		
<div class="promptDialog" title="Copy To Clipboard ">
	<table class="promptTable dialogTable baseTable">
		<tr><td><textarea rows="6" cols="45" name="promptText" class="promptText"></textarea></td></tr>
	</table>
</div>
</form:form>
</body>
</html>