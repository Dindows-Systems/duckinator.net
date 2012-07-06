
/* start favicons.js */
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
		selector += ', #navhead a';

	anchors = document.querySelectorAll(selector);

	for (var i = 0; i < anchors.length; i++) {
		load_favicon(anchors[i]);
	}
}


/* end   favicons.js */

/* start legacyfix.js */
function _legacy_moz_fix_tag(tag) {
	tags = document.getElementsByTagName(tag);
	if(tags[0] && (tags[0].getAttribute('_moz-userdefined') != null)) {
		for(var i in tags) {
			if(tags[i].style)
				tags[i].style.display='none';
		}
	}	
}

function legacyfix() {
	moz_tags = ['header', 'article'];
	for(var i in moz_tags) {
		_legacy_moz_fix_tag(moz_tags[i]);
	}
}
/* end   legacyfix.js */

/* start mail.js */
function mailfix() {
	if(!('getElementsByClassName' in document))
		return false;
    
	var spans = document.getElementsByClassName('mail');
	
	for(var i =0; i < spans.length; i++) {
		var span = spans[i];
		var anchor = document.createElement('a');
		anchor.innerHTML = span.innerHTML;
		anchor.href = "mailto:" + span.innerHTML;
		span.removeChild(span.childNodes[0]);
		span.appendChild(anchor);
	}
}
/* end   mail.js */

/* start rot.js */
function _rot_js_entity_decode(data) {
	var matches = data.match(/&#\d+;?/g);

	if(matches == null)
		return data;
	
	for(var i = 0; i < matches.length; i++) {
		var replacement = String.fromCharCode((matches[i]).replace(/\D/g,""));

		data = data.replace(/&#\d+;?/,replacement);
	}
	return data;
}

// rot47() takes a string of any valid ASCII character
function rot47(text) {
	newtext = "";
	for (i = 0; i < text.length; i++) {
		code = text.charCodeAt(i);
		if (code >= 33 && code <= 126) {
			code = code + 47;
			if (code > 126)
				code = code-94;
		}
		newtext = newtext + String.fromCharCode(code)
	}

	return newtext;
}

// rot13() takes a string of letters only
function rot13(text) {
	newtext = "";
	for (i = 0; i < text.length; i++) {
		code = text.charCodeAt(i);
		if (code >= 65 && code <= 90) {
			/* Uppercase */
			code = code + 13;
			if (code > 90)
				code = code-26;
		} else if (code >= 97 && code <= 122) {
			/* Lowercase */
			code = code + 13;
			if (code > 122)
				code = code-26;
		}
		newtext = newtext + String.fromCharCode(code)
	}

	return newtext;
}

// rot5() takes numbers represented as strings
function rot5(text) {
	newtext = "";
	for (i = 0; i < text.length; i++) {
		code = text.charCodeAt(i);
		if (code >= 48 && code <= 57) {
			code = code + 5;
			if (code > 57)
				code = code-10;
		}
		newtext = newtext + String.fromCharCode(code)
	}

	return newtext;
}

function rot_fn(fn) {
	var spans = document.getElementsByClassName(fn);
	if(!(fn in window))
		return false;
	
	for(var i =0; i < spans.length; i++) {
		var span = spans[i];
		var old = _rot_js_entity_decode(span.getAttribute("data-rot"));
		var text = window[fn](old);
		span.innerHTML = text;
	}
}

function rot_all() {
	if(!('getElementsByClassName' in document))
		return false;

	var types = ['rot5', 'rot13', 'rot47'];
	for(var i = 0; i < types.length; i++) {
		rot_fn(types[i]);
	}
}
/* end   rot.js */

