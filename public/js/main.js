function update_github() {
	$('#github').text('');
	github('duckinator', '#github');
}

function update_twitter() {
	$('#twitter').text('');
	twitter('duckinator', '#twitter');
}

$(document).ready(function(){
	legacyfix();
	rot_all();
	mailfix();

	if ($('#twitter')) {
		// This is so people w/out JS don't see a random "Twitter" on the right
		$('#twitter_header').text('Twitter');
		update_twitter(4); // Initial update
		setInterval(update_twitter, 120000);  // Every 2  minutes
	}

	if ($('#github')) {
		$('#github_message').text("My 10 most recently active personal projects:");
		update_github();  // Initial update
		setInterval(update_github,  1200000); // Every 20 minutes
	}
});

Konami.init(function(){
    b = $('body')[0];
    if (b.getAttribute('class') == 'konami')
        b.setAttribute('class','');
    else
        b.setAttribute('class','konami');
});
