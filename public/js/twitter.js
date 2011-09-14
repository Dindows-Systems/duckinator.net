/* This uses the jQuery Tweets plugin, available at
 *  http://www.bahiastudio.net/labs/freebies/tweets/
 */

function twitter(username, identifier, show_avatar) {
  if(typeof(show_avatar) == "undefined")
    show_avatar = false;
  
  $(document).ready(function(){
    $(identifier).tweets({
      tweets: 4,
      username: username,
      avatar: show_avatar
    })
  })
}