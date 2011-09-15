function github(username, identifier) {
	var items = [];

	$.getJSON('https://api.github.com/users/' + username + '/repos?callback=?', function(data){
		$('<li data-pushed-at="' + data.pushed_at + '"><p><a href="' + data.html_url + '">' + data.name + '</a> (' + data.forks + ' forks, ' + data.watchers + ' watchers)</p>' +
			'<p>' + data.description + '</p></li>').appendTo(identifier);
	});

	$(identifier + ' li').sortElements(function(a, b){
		return $(a).text() > $(b).text() ? 1 : -1;
	});
}