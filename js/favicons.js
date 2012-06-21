function load_favicon(anchor) {
	if (document.width >= 960) {
		anchor.setAttribute('style', 'background-image: url(' + anchor.origin + '/favicon.ico);');
		anchor.classList.add('icon');
	} else {
		anchor.setAttribute('style', 'background-image: none;');
		anchor.classList.remove('icon');
	}
}

function load_favicons() {
	anchors = document.querySelectorAll('#navhead a, .social a');

	for (var i = 0; i < anchors.length; i++) {
		load_favicon(anchors[i]);
	}
}

