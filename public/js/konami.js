Konami = {
	keys: new Array(10),
	code: [38, 38, 40, 40, 37, 39, 37, 39, 66, 65],
	handler: null,

	checkKey: function(element, index, array) {
		return element == Konami.code[index];
	},

	onkeydown: function(e) {
		Konami.keys.shift();
		Konami.keys.push(e.keyCode);
		if (Konami.keys.every(Konami.checkKey)) {
			Konami.handler();
		}
	},

	init: function(fn) {
		this.handler = fn;
		$(document).keydown(this.onkeydown);
	}
}

