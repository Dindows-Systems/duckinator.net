function load_favicon(anchor) {
  anchor.setAttribute('style', 'background-image: url(' + anchor.origin + '/favicon.ico);');
  anchor.className += ' icon';
}

function load_favicons() {
  anchors = document.querySelectorAll('#navhead a, .social a');

  for (var i = 0; i < anchors.length; i++) {
    console.log(anchors[i]);
    load_favicon(anchors[i]);
  }
}
