// Based on code at http://thechangelog.com/post/4258932732/fool-js-april-1st-javascript-snippet
// This script turns the page sideways if it's April 1st

function AprilFoolsCreateEscape() {
  div = document.createElement("div");
  div.setAttribute('position', 'absolute');
  div.setAttribute('top', '0px');
  div.setAttribute('left', '0px');
  
  a = document.createElement("a");
  a.innerText = "Help everything is spinning and I'm scared!!!!!!!";
  a.setAttribute('href', '#help-everything-is-spinning-and-im-scared');
  
  div.appendChild(a);
  document.getElementsByTagName('body')[0].appendChild(div);
}

function AprilFools() {
  if(!document.body) {
    setTimeout("AprilFools();", 100);
    return;
  }
  
  var date = new Date();
  if (date.getMonth() == 3 && date.getDate() == 1) { // If it's April 1
    //  Uncomment the next line if you want the prank to happen only when the url hashtag is #april
    if (document.location.hash.indexOf('help-everything-is-spinning-and-i-am-scared') < 0) {
      AprilFoolsCreateEscape();
      document.body.style.transform =
      document.body.style.webkitTransform =
      document.body.style.MozTransform =
      document.body.style.OTransform =
      document.body.style.msTransform =
      'rotate(' + [45, 90, 135, 180, 225, 270, 315][Math.floor(Math.random() * 7)] + 'deg)';
    }
  }
}

AprilFools();
