var GittipWidget = {};

GittipWidget.create_element = function(el_type, ident, opts) {
	var id = "autoloaded-" + ident;
	if (document.getElementById(id))
		return;

	var el = document.createElement(el_type);
	el.id = id;
	for (var key in opts) {
		el[key] = opts[key];
	}
	document.getElementsByTagName('head')[0].appendChild(el);
}

GittipWidget.setup = function() {
	var scripts = document.getElementsByTagName('script'),
	    css = null;

	for (var i = 0; i < scripts.length; i++) {
		css = scripts[i].getAttribute('data-gittip-css');
		if (css)
			break;
	}

	if (!css)
		css = '/widget.css';

	if (!('jQuery' in window)) {
		GittipWidget.create_element('script', 'jquery', {'src': 'https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js', 'type': 'text/javascript'});
		GittipWidget.create_element('link',   'widget', {'href': css, 'type': 'text/css', 'rel': 'stylesheet'});
		setTimeout(GittipWidget.setup, 100);
		return;
	}

	$(document).ready(function() {
		var span = $('span.gittip'),
		    username = span[0].getAttribute('data-username'),
		    btn = $('<button class="gittip" data-username="' + username + '">Gittip</button>');

		span.append(btn);

		$('.gittip').click(function(event) {
			window.open('https://www.gittip.com/' + username);
		});
	});
}

GittipWidget.setup();
