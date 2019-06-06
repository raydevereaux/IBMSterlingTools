var cookieName = 'rqponml';
$( document ).on( 'keypress', function( event ) {
	var key = event.which;
 	if(key == 13) {
 		submitFunction();
        return false;  
	}
});
var Base64={_keyStr:"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=",encode:function(e){var t="";var n,r,i,s,o,u,a;var f=0;e=Base64._utf8_encode(e);while(f<e.length){n=e.charCodeAt(f++);r=e.charCodeAt(f++);i=e.charCodeAt(f++);s=n>>2;o=(n&3)<<4|r>>4;u=(r&15)<<2|i>>6;a=i&63;if(isNaN(r)){u=a=64}else if(isNaN(i)){a=64}t=t+this._keyStr.charAt(s)+this._keyStr.charAt(o)+this._keyStr.charAt(u)+this._keyStr.charAt(a)}return t},decode:function(e){var t="";var n,r,i;var s,o,u,a;var f=0;e=e.replace(/[^A-Za-z0-9\+\/\=]/g,"");while(f<e.length){s=this._keyStr.indexOf(e.charAt(f++));o=this._keyStr.indexOf(e.charAt(f++));u=this._keyStr.indexOf(e.charAt(f++));a=this._keyStr.indexOf(e.charAt(f++));n=s<<2|o>>4;r=(o&15)<<4|u>>2;i=(u&3)<<6|a;t=t+String.fromCharCode(n);if(u!=64){t=t+String.fromCharCode(r)}if(a!=64){t=t+String.fromCharCode(i)}}t=Base64._utf8_decode(t);return t},_utf8_encode:function(e){e=e.replace(/\r\n/g,"\n");var t="";for(var n=0;n<e.length;n++){var r=e.charCodeAt(n);if(r<128){t+=String.fromCharCode(r)}else if(r>127&&r<2048){t+=String.fromCharCode(r>>6|192);t+=String.fromCharCode(r&63|128)}else{t+=String.fromCharCode(r>>12|224);t+=String.fromCharCode(r>>6&63|128);t+=String.fromCharCode(r&63|128)}}return t},_utf8_decode:function(e){var t="";var n=0;var r=c1=c2=0;while(n<e.length){r=e.charCodeAt(n);if(r<128){t+=String.fromCharCode(r);n++}else if(r>191&&r<224){c2=e.charCodeAt(n+1);t+=String.fromCharCode((r&31)<<6|c2&63);n+=2}else{c2=e.charCodeAt(n+1);c3=e.charCodeAt(n+2);t+=String.fromCharCode((r&15)<<12|(c2&63)<<6|c3&63);n+=3}}return t}}

$(document).ready(function() {
	
	var srcUrl = $(".homeServer").html();
	var domain = '<table width="100%"><tr><td><img height="36" width="126" src="images/BccLogo.png" /></td><td align="center">'+srcUrl+'</td></tr></table>';
	$('.login-form').dialog({
		 autoOpen: false
		,modal: true
		,title: domain
		,open: function (event, ui) {
			$(".ui-widget-overlay").css({
            	opacity: 1.0,
            	filter: "Alpha(Opacity=100)",
            	backgroundColor: "#000000"
        	});
			$(".ui-dialog-titlebar-close").hide();
		}
		,show: {effect: 'blind', duration: 1000 }
		,hide: {effect: 'explode', duration: 1000}
		,position: {
			 my: "center"
			,at: "center"
		}
		,height: 250
		,width: 400
	});
	$('.login-form').dialog('open');
	
    $(".submitForm").click(function() {
		$(".msg").html('Submit Form');
    	submitFunction();
     });	

    var security = decrypt(getCookie(cookieName));
	var username = security.username;
	var password = security.password;
	var autoLogOn = getCookie("AutoLogOn")
	// important! this gets set immediately after the cookie is retrieved!
	setCookie("AutoLogOn", "no");
	$('.username').val(username);
	$('.password').val(password);
	if ($(".err").html()=='true') {
		$(".msg").html('Invalid Credentials');
	} else {
	    $(".msg").html('Enter username/password');
    }
	$(".err").hide();
	$('.username').focus();
	
});

function submitFunction() {

	var username = $('.username').val();
	var password = $('.password').val();
	setCookie(cookieName, encrypt('"AutoLogOn":'+username+':'+password));
	$("#loginform").submit();
}

function encrypt(clearTxt) {

	var encodedString = Base64.encode(clearTxt);
	return encodedString;
}
function setCookie(key, value) {
    var expires = new Date();
    expires.setTime(expires.getTime() + (1 * 24 * 60 * 60 * 1000));
    document.cookie = key + '=' + value + ';expires=' + expires.toUTCString()+ ';max-age='+(60*60*24);
}

function getCookie(key) {
    var keyValue = document.cookie.match('(^|;) ?' + key + '=([^;]*)(;|$)');
    return keyValue ? keyValue[2] : null;
}

function decrypt(encodedString) {
	if (encodedString==null||encodedString.length==0) {
		encodedString = 'bWlkZGxld2FyZTpCaGxhaDJycA==';
	}
	var decodedString = Base64.decode(encodedString);
	var res = decodedString.split(':');
	var log =  new Object();
	log.autoLogOn = res[0];
	log.username  = res[1];
	log.password  = res[2];
	return log;
}

