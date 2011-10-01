

// Based on code at http://thechangelog.com/post/4258932732/fool-js-april-1st-javascript-snippet
// This script turns the page sideways if it's April 1st

function AprilFoolsCreateEscape() {
  var messages = [
    "Help!! Everything is tilted and I'm SCARED!!!!!!",
    "Ok, ok. Har Har. Can I see the page now?",
    "OH NO, MY EYES ARE LOPSIDED!",
    "WHAT IS THIS MADNESS?!",
    "MY BRAIN IS EXPLODING!",
    "My chair wont stick to the ceiling anymore, can we go back to the normal version?"
  ];

  div = document.createElement("div");
  div.style.position = "absolute";
  div.style.top = "0px";
  div.style.left = "0px";
  
  a = document.createElement("a");
  //a.innerHTML = "Help everything is tilted and I'm scared!!!!!!!";
  a.innerHTML = messages[Math.floor(Math.random() * messages.length)];
  a.setAttribute('href', '?april-fools');
  
  div.appendChild(a);
  document.getElementsByTagName('body')[0].appendChild(div);
}

function AprilFools() {
  if(!document.body) {
    setTimeout("AprilFools();", 100);
    return;
  }
  
  if (document.location.search.indexOf('april-fools') < 0) {
    AprilFoolsCreateEscape();
    el = document.getElementById("wrap");
    el.style.transform =
    el.style.webkitTransform =
    el.style.MozTransform =
    el.style.OTransform =
    el.style.msTransform =
      'rotate(' + [45, 90, 135, 180, 225, 270, 315][Math.floor(Math.random() * 7)] + 'deg)';
  }
}

var date = new Date();
if (date.getMonth() == 3 && date.getDate() == 1) { // If it's April 1
  AprilFools();
}

function github(username, identifier, limit) {
	var items = [];
	if(!limit)
		limit = 10;

	$.getJSON('https://api.github.com/users/' + username + '/repos?callback=?', function(data){
		$.each(data.data, function(id, repo){
			$('<li data-pushed-at="' + repo.pushed_at + '"><p><a href="' + repo.html_url + '">' + repo.name + '</a> (' + repo.forks + ' forks, ' + repo.watchers + ' watchers)</p>' +
				'<p>' + repo.description + '</p></li>').appendTo(identifier);
		});

		$(identifier + ' li').sortElements(function(a, b){
			return a.getAttribute('data-pushed-at') < b.getAttribute('data-pushed-at') ? 1 : -1;
		});

		$.each($(identifier + ' li'), function(index, li){
			if(index >= limit)
				li.style.display = 'none';
		});
	});
}
/**
 * jQuery.fn.sortElements
 * --------------
 * @author James Padolsey (http://james.padolsey.com)
 * @version 0.11
 * @updated 18-MAR-2010
 * --------------
 * @param Function comparator:
 *   Exactly the same behaviour as [1,2,3].sort(comparator)
 *   
 * @param Function getSortable
 *   A function that should return the element that is
 *   to be sorted. The comparator will run on the
 *   current collection, but you may want the actual
 *   resulting sort to occur on a parent or another
 *   associated element.
 *   
 *   E.g. $('td').sortElements(comparator, function(){
 *      return this.parentNode; 
 *   })
 *   
 *   The <td>'s parent (<tr>) will be sorted instead
 *   of the <td> itself.
 */
jQuery.fn.sortElements = (function(){
    
    var sort = [].sort;
    
    return function(comparator, getSortable) {
        
        getSortable = getSortable || function(){return this;};
        
        var placements = this.map(function(){
            
            var sortElement = getSortable.call(this),
                parentNode = sortElement.parentNode,
                
                // Since the element itself will change position, we have
                // to have some way of storing it's original position in
                // the DOM. The easiest way is to have a 'flag' node:
                nextSibling = parentNode.insertBefore(
                    document.createTextNode(''),
                    sortElement.nextSibling
                );
            
            return function() {
                
                if (parentNode === this) {
                    throw new Error(
                        "You can't sort elements if any one is a descendant of another."
                    );
                }
                
                // Insert before flag:
                parentNode.insertBefore(this, nextSibling);
                // Remove flag:
                parentNode.removeChild(nextSibling);
                
            };
            
        });
       
        return sort.call(this, comparator).each(function(i){
            placements[i].call(getSortable.call(this));
        });
        
    };
    
})();
/*
*	jQuery Tweet v0.2
*	written by Diego Peralta
*
*	Copyright (c) 2010 Diego Peralta (http://www.bahiastudio.net/)
*	Dual licensed under the MIT (MIT-LICENSE.txt)
*	and GPL (GPL-LICENSE.txt) licenses.
*	Built using jQuery library 
*
*	Options:
*		- before (string): HTML code before the tweet.
*		- after (string): HTML code after the tweet.
*		- tweets (numeric): number of tweets to display.
*		- loader (bool): 
*		- avatar (bool):
*	
*	Example: 
*	
*		<script type="text/javascript" charset="utf-8">
*   		$(document).ready(function() {
*      			$('#tweets').tweets({
*          			tweets:4,
*          			username: "diego_ar",
*					avatar: true
*      			});
*  			});
*		</script>
*
*/
(function($){
	$.fn.tweets = function(options) {
		$.ajaxSetup({ cache: true });
		var defaults = {
			tweets: 5,
			before: "<li>",
			after: "</li>",
			loader: true,
			avatar: true
		};
		var options = $.extend(defaults, options);
		function relative_time(time_value) {
			var parsed_date = Date.parse(time_value);
			var relative_to = (arguments.length > 1) ? arguments[1] : new Date();
			var delta = parseInt((relative_to.getTime() - parsed_date) / 1000);
			var pluralize = function (singular, n) {
				return '' + n + ' ' + singular + (n == 1 ? '' : 's');
		};
			if(delta < 60) {
				return 'less than a minute ago';
			} else if(delta < (45*60)) {
				return 'about ' + pluralize("minute", parseInt(delta / 60)) + ' ago';
			} else if(delta < (24*60*60)) {
				return 'about ' + pluralize("hour", parseInt(delta / 3600)) + ' ago';
			} else {
				return 'about ' + pluralize("day", parseInt(delta / 86400)) + ' ago';
			}
		}
	    
		return this.each(function() {
			var obj = $(this);
			$.getJSON('http://search.twitter.com/search.json?callback=?&rpp='+options.tweets+'&q=from:'+options.username,
		        function(data) {
		            $.each(data.results, function(i, tweet) {
		                if(tweet.text !== undefined) {
		                    $(obj).append(options.before+'<img src="'+ tweet.profile_image_url +'" alt="">'+tweet.text+'<br/><small><a href="http://twitter.com/'+options.username+'/status/'+options.id_str+'">'+relative_time(tweet.created_at)+'</a></small>'+options.after);
		                }
		            });
		        }
		    );
		});
	};
})(jQuery);
/*
*	jQuery Tweet v0.3
*	written by Nick Markwell and Diego Peralta
*
*	Copyright (c) 2011 Nick Markwell (http://duckinator.net)
*	Copyright (c) 2010 Diego Peralta (http://www.bahiastudio.net/)
*	Dual licensed under the MIT (MIT-LICENSE.txt)
*	and GPL (GPL-LICENSE.txt) licenses.
*	Built using jQuery library 
*
*	Options:
*		- before (string): HTML code before the tweet.
*		- after (string): HTML code after the tweet.
*		- tweets (numeric): number of tweets to display.
*		- loader (bool): 
*		- avatar (bool):
*	
*	Example: 
*	
*		<script type="text/javascript" charset="utf-8">
*   		$(document).ready(function() {
*      			$('#tweets').tweets({
*          			tweets: 4,
*          			username: "diego_ar",
*					avatar: true
*      			});
*  			});
*		</script>
*
*/
(function($){
	$.fn.tweets = function(options) {
		$.ajaxSetup({ cache: true });
		var defaults = {
			tweets: 5,
			before: "<li>",
			after: "</li>",
			loader: true,
			avatar: true,
			linkify: true,
		};
		var options = $.extend(defaults, options);
		function relative_time(time_value) {
			var parsed_date = Date.parse(time_value);
			var relative_to = (arguments.length > 1) ? arguments[1] : new Date();
			var delta = parseInt((relative_to.getTime() - parsed_date) / 1000);
			var pluralize = function (singular, n) {
				return '' + n + ' ' + singular + (n == 1 ? '' : 's');
			};
			if(delta < 60) {
				return 'less than a minute ago';
			} else if(delta < (45*60)) {
				return 'about ' + pluralize("minute", parseInt(delta / 60)) + ' ago';
			} else if(delta < (24*60*60)) {
				return 'about ' + pluralize("hour", parseInt(delta / 3600)) + ' ago';
			} else {
				return 'about ' + pluralize("day", parseInt(delta / 86400)) + ' ago';
			}
		}

		function generate_avatar(tweet) {
			return '<span><a href="http://twitter.com/' + tweet.from_user + '"><img width="48" height="48" src="' + tweet.profile_image_url + '" alt=""></a></span>';
		}

		function generate_footer(tweet) {
			return '<small data-time="' + tweet.created_at + '" class="footer"><a href="http://twitter.com/' + options.username + '/status/' + tweet.id_str + '">' + relative_time(tweet.created_at) + '</a></small>';
		}

		function linkify(text) {
			/* linkify() is borrowed from @joaobarbosa's fork of jQuery-Tweets:
			 * https://github.com/joaobarbosa/jQuery-Tweets/blob/6422f8f368bcce017849f496b46062277080f2a4/js/jquery.tweets.0.1.js#L30
			 */
			var regexpUrl = /((ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?)/gi;
			var regexpUser = /[\@]+([A-Za-z0-9-_]+)/gi;
			var regexpHash = /(?:^| )[\#]+([A-Za-z0-9-_]+)/gi;
			text = text.replace(regexpUrl,'<a class="link" href="$1">$1</a>');
			text = text.replace(regexpUser,'<a class="mention" href="http://twitter.com/$1">@$1</a>');
			text = text.replace(regexpHash,' <a class="hashtag" href="https://search.twitter.com/search?tag=$1&lang=all">#$1</a>');
			return text;
		}

		return this.each(function() {
			var obj = $(this);
			$.getJSON('http://search.twitter.com/search.json?callback=?&rpp=' + options.tweets + '&q=from:' + options.username,
				function(data) {
					$.each(data.results, function(i, tweet) {
						if(tweet.text !== undefined) {
							var str = options.before;
							if (options.avatar)
								str += generate_avatar(tweet);

							str += '<span class="text">';
							if (options.linkify)
								str += linkify(tweet.text)
							else
								str += tweet.text

							str += '</span>';

							str += generate_footer(tweet) + options.after;
							$(obj).append(str);
						}
					});
				}
			);
		});
	};
})(jQuery);
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

	if ($('#github')) {
		$('#github_message').text("My 10 most recently active personal projects:");
		update_github();  // Initial update
		setInterval(update_github,  1200000); // Every 20 minutes
	}

	if ($('#twitter')) {
		// This is so people w/out JS don't see a random "Twitter" on the right
		$('#twitter_header').text('Twitter');
		update_twitter(4); // Initial update
		setInterval(update_twitter, 120000);  // Every 2  minutes
	}
});

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
/* This uses the jQuery Tweets plugin, available at
 *+  http://www.bahiastudio.net/labs/freebies/tweets/
 *+ updated by me, and located at
 *+  https://github.com/duckinator/jQuery-Tweets
 */

function twitter(username, identifier, num_tweets, show_avatar) {
  if(typeof(num_tweets) == "undefined")
    num_tweets = 4;

  if(typeof(show_avatar) == "undefined")
    show_avatar = true;
  
  $(identifier).tweets({
    tweets: num_tweets,
    username: username,
    avatar: show_avatar,
  });
}