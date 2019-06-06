
	Date.prototype.fmtDate = function() {var myDate = this;
										 var fmtMnth = myDate.getMonth() +1;
										 var fmtDate = fmtMnth.toString().twoDigit()
												 	 +'/'+myDate.getDate().toString().twoDigit()
										  		 	 +'/'+myDate.getFullYear().toString();
										 return  fmtDate;};
	Date.prototype.fmtTime = function() {var myDate = this;
	 									 var fmtTime = myDate.getHours().toString().twoDigit()
												 	 +':'+myDate.getMinutes().toString().twoDigit()
										  		 	 +':'+myDate.getSeconds().toString().twoDigit()
        										 	 +'.'+myDate.getMilliseconds();
										 return  fmtTime;};
	Date.prototype.fmtTimestamp = function() {var myDate = this;
											  var fmtTimestamp = myDate.fmtDate()+'.'+myDate.fmtTime();
											  return  fmtTimestamp;};
	String.prototype.ignoreCase = function() {return this.toLowerCase();};
	String.prototype.toInteger = function() {return Number(this.toString());};
	String.prototype.contains = function(obj) {var rtn = false; if (this.toString().indexOf(obj)>-1||obj.indexOf(this.toString())>-1) rtn=true;return rtn;};
	String.prototype.twoDigit = function() {var d100 = Number(this.toString())+100;return d100.toString().substring(1,d100.length);};
	String.prototype.toPhone = function() {var phone = this.toString().replace(' ','').replace('/','').replace('-','').replace('(','').replace(')','');
										   var fmtPhone = this.toString();
										   if (phone.length>=10) {
											   fmtPhone = phone.toString().substring(0,3)
											   			+'/'+phone.toString().substring(3, 6)
											   			+'-'+phone.toString().substring(6, 10);
											   if (phone.length>10) {
												   if (phone.toString().substring(10, 11)!=' ') {fmtPhone += ' ';}
												   fmtPhone += phone.toString().substring(10,phone.length);
											   }
										   }
										   return fmtPhone;};
Date.prototype.getTimezone = function() {var myDate = this;
										 var tz = myDate.toString().split(' ');
										 var rtn = tz[6].substring(1,2);
										 for (var i=7;i<tz.length;i++) {
											 rtn = rtn+tz[i].substring(0,1);
										 }
										 return rtn;
										 };
 Date.prototype.getJulian = function() {
	 var jul = (this.getTime() / 86400000) - (this.getTimezoneOffset() / 1440) + 2440587.5;
	 return jul;
};