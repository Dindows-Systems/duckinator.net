function Ghost(top, left) {
	this.top = top;
	this.left = left;
	this._ghostId = Ghost.ghosts.length;
	this.div = this.create();
	this.move(top, left);
	Ghost.ghosts.push(this);
	$(this.div).hover(function() {
		id = parseInt(this.getAttribute("data-ghost-id"));
		Ghost.ghosts[id].move();
	})
}

Ghost.ghosts = [];

Ghost.prototype.move = function (top, left) {
	// TODO: Make eyes move (.eyes.up, .eyes.down, .eyes.left, .eyes.right)
	if (typeof top == "undefined")
		top = this.top;

	if (typeof left == "undefined")
		left = this.left;


	var topOffset  = Math.floor(Math.random() * ($(window).height() / 2 - 60));
	var leftOffset = Math.floor(Math.random() * ($(window).width()  / 2 - 60));

	if (Math.floor(Math.random() * 2)) {
		top += topOffset;
	} else {
		top -= topOffset;
	}

	if (Math.floor(Math.random() * 2)) {
		left += leftOffset;
	} else {
		left -= leftOffset;
	}

	if (left < 0)
		left = 0;

	if (left >= $(window).width() - 50)
		left = $(window).width() - 50;

	if (top < 0)
		top = 0;

	if (top >= $(window).height() - 70)
		top = $(window).height() - 70;

	$(this.div).animate({
		top:  top  + "px",
		left: left + "px"
	}, 1500);

	this.top  = top;
	this.left = left;
}

Ghost.prototype._createDiv = function (className) {
	var div = document.createElement('div');
	
	if(typeof className != "undefined")
		div.className = className;

	return div;
}

Ghost.prototype._createEye = function() {
	var eye   = this._createDiv();
	    inner = this._createDiv('inner');

	eye.appendChild(inner);
	return eye;
}

Ghost.prototype.create = function() {
	var ghost  = this._createDiv('ghost'),
	    inner  = this._createDiv('inner'),
	    eyes   = this._createDiv('eyes');

	eyes.appendChild(this._createEye());
	eyes.appendChild(this._createEye());

	inner.appendChild(eyes);

	ghost.appendChild(inner);

	ghost.setAttribute("data-ghost-id", this._ghostId);

	return ghost;
}

Ghost.randomMove = function () {
	Ghost.ghosts[0].move()
	setTimeout(Ghost.randomMove, Math.floor(Math.random() * 10) + 5000);
}

$(document).ready(function(){
	var ghost = new Ghost($(window).height()/2,$(window).width()/2);
	document.getElementsByTagName('body')[0].appendChild(ghost.div);
	Ghost.randomMove(); // Faily quick hack.
});
