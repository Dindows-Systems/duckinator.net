function load_favicon(anchor) {
	// Why doesn't firefox have anchor.origin? :(
	anchor.setAttribute('style', 'background-image: url(' + anchor.protocol + '//' + anchor.hostname + ':' + anchor.port + '/favicon.ico);');
	anchor.classList.add('icon');
}

function load_favicons() {
	selector = '.social a';

	// We don't want the :hover-related stuff on touchscreens
	// it's simply not usable there.
	if(!('ontouchstart' in window))
		selector += ', #header a';

	anchors = document.querySelectorAll(selector);

	for (var i = 0; i < anchors.length; i++) {
		load_favicon(anchors[i]);
	}
}

