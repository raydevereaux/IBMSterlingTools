
console.log('bind.js');

$(document).ready(function() {
	console.log('b2btools.js');

	var body  = document.getElementsByTagName('body')[0];
	try {
		var title = $(document).find("title").text();
		var txt = document.createTextNode(title);
		var a  = document.createElement("a");
		a.className = 'home';
		console.log('continue');
		a.href = 'home.do';
		a.appendChild(txt);
		body.appendChild(a);
	} catch (exception) {
		console.log(exception);
	}
});