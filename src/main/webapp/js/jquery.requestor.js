(function($) {
	
	var SESSION_TIMEOUT_MSG = "You session has timed out.  Please log back in.";
	var MULTIPLE_ERRORS_MSG = "The following errors have occurred:\n";
	var SINGLE_ERROR_MSG = "The following error has occurred:\n";
	$.request = function(url, options) {
		var settings = prepOptions(options);
		
		$.ajax({url: url, data: settings.parameters, dataType: settings.dataType, type:settings.method, async: settings.async, contentType:settings.contentType,
			error: function(xhr, text, err) {
			   
			if (xhr.status==0&&xhr.readyState==4) {return;}
				// an error occurred in the server request, figure out what to do
				var refresh = false;
				var errorMsg = '';
				if (xhr.status == 200) {
					// most likely a timeout issue, where the expected type back was JSON, but
					// the login page was returned
					if (isLogin(err)){
						errorMsg = SESSION_TIMEOUT_MSG;
						// force refresh of current page to make the user log back in
						refresh = true;	
					} else {
						errorMsg = "Unknown Server Error.";
					}
					
				} else {
					// some other server error
					errorMsg = "Server Error- " + "status :" + xhr.status + ": readyState:" + xhr.readyState+":";
				}
				processErrors([errorMsg], settings);
				
				// likely a session timeout issue.
				if (settings.onTimeoutRedirect && refresh) {
					// force refresh of current page to make the user log back in
					location.reload(true);
				}
			}, success: function(data, status) {
				// successfully made a request and received a valid response from the server
				
				
				// first check to see if the login page was returned
				if (settings.dataType != 'json' && isLogin(data)) {
					// consider this an error
					var errorMsg = SESSION_TIMEOUT_MSG;
					processErrors([SESSION_TIMEOUT_MSG], settings);
					if (settings.onTimeoutRedirect) {
						location.reload(true);
					}
				} else {
					if (typeof data == 'object') {
						// get the model
						var model = getItem(settings.modelName, data);
					
						// check the errors
						var errors = getItem(settings.errorName, data);
						if (errors && errors.length > 0) {
							var errorModel = getItem(settings.errorModelName, data);
							// there were server errors, treat this as a failure
							processErrors(errors, settings, errorModel);
						} else {
							// got here, everything successful
							if (settings.success) {
								settings.success(model);
							}
						}
					} else {
						// no checking to be done, just pass the data along
						if (settings.success) {
							settings.success(data);
						}
					}
				}
			} 
		});
	};
	$.fn.request = function(url, options) {
		var settings = prepOptions(options);
		var items = this;
		// force it to be html since this is a replace of a chunk of the page
		settings.dataType = 'html';
		
		if (settings.success != null) {
			// need to pull out the success to call from our own success
			settings.callerSuccess = settings.success;
		}
		settings.success = function(data) {
			// let's check first for a login, I think things might get halted before this
			// but I just want to make sure
			if (isLogin(data) && settings.onTimeoutRedirect) {
				// this was a login, and it hasn't redirected yet for some reason, try it again
				location.reload(true);
				// let's not do anything else
				return;
			}
			items.html(data);
			if (settings.callerSuccess) {
				settings.callerSuccess.call(items, data);
			}
		}
		// not going to set an extra error handler, if it fails the actual call already has handling
		// in place for that, I'll just allow any error handler the user passed in to be called
		
		// make the call
		$.request(url, settings, true);
		
		// this is asynchronous so just be a good jQuery citizen and return the current collection
		// realizing that the replacement hasn't taken place yet.
		return this;
	};
	var showErrors = function(errors) {
		var msg = MULTIPLE_ERRORS_MSG;
		if (errors.length == 1) {
			msg = SINGLE_ERROR_MSG;
		}
		for(var x=0; x < errors.length; x++) {
			msg += errors[x] + "\n";
		}
		alert(msg);
	};
	var processErrors = function(errors, settings, data) {
		if (settings.failure != null) {
			settings.failure(errors, data);
		}
		if (settings.showError) {
			showErrors(errors);
		}
	};
	// loops through the data and pulls out the first item with the name itemName,
	// otherwise it returns null;
	/*var getItem = function(itemName, data) {
		for each (var item in data) {
			if (item[itemName]) {
				return item[itemName];
			}
		}
		return null;
	};*/
	var getItem = function(itemName, data) {
		if (itemName == "jsonObject"){
			return data;
		}
		
		var foundValue = null;
		$.each (data, function(i, item){
			var booleanKeepGoing = true;
			if (i == itemName){
				foundValue = item;
				booleanKeepGoing = false;
			} else if (item != null && item[itemName]) {
				foundValue = item[itemName];
				booleanKeepGoing = false;
			}
			return booleanKeepGoing;
		}); 
		
		return foundValue;
	};
	var prepOptions = function(options) {
		return $.extend({
			method: 'get',
			aysnc: true,
			parameters: {},
			dataType: 'json',
			contentType: 'application/x-www-form-urlencoded',
			modelName: 'model',
			errorModelName: 'errorModel',
			errorName: 'allErrors',
			success: null,
			failure: null,
			showError: true,
			onTimeoutRedirect: true
		}, options||{});
	};
	var isLogin = function(data) {
		return data.indexOf('j_username') > -1;
	};
})(jQuery)