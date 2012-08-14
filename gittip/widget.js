var GittipWidget = {};

GittipWidget.initialized = false;

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

	if (!this.initialized) {
		GittipWidget.create_element('link',   'widget', {'href': css, 'type': 'text/css', 'rel': 'stylesheet'});
		GittipWidget.initialized = true;
	}

	if ((!document.getElementById('gittip-widget-button')) && document.getElementById('autoloaded-widget')) {
		var spans = document.getElementsByTagName('span'),
		    username, btn, span;

		for (var i in spans) {
			if (spans[i].getAttribute('class').split(' ').indexOf('gittip') >= 0) {
				span = spans[i];
				username = span.getAttribute('data-username');
				break;
			}
		}

    btn = document.createElement('button');
		btn.className = 'gittip';
		btn.id = 'gittip-widget-button';
		btn.setAttribute('data-username', username);
		btn.innerHTML = 'Gittip';

		span.appendChild(btn);

		btn.onclick = function(event) {
			window.open('https://www.gittip.com/' + username);
		};
	} else {
		setTimeout(GittipWidget.setup, 100);
		return;
	}
}

GittipWidget.setup();
