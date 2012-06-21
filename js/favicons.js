function load_favicon(anchor) {
	anchor.setAttribute('style', 'background-image: url(' + anchor.origin + '/favicon.ico);');
	anchor.classList.add('icon');
}

function load_favicons() {
	selector = '.social a';

	// We don't want the :hover-related stuff on touchscreens
	// it's simply not usable there.
	if(!window.touch)
		selector += ', #navhead a';

	anchors = document.querySelectorAll(selector);

	for (var i = 0; i < anchors.length; i++) {
		load_favicon(anchors[i]);
	}
}

