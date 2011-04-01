// Based on code at http://thechangelog.com/post/4258932732/fool-js-april-1st-javascript-snippet
// This script turns the page sideways if it's April 1st
var date = new Date();
if ([date.getMonth(), d.getDate()] == [3, 1]) { // If it's April 1
  //  Uncomment the next line if you want the prank to happen only when the url hashtag is #april
  if (document.location.hash.indexOf('april') > -1) {
    document.body.style.transform =
    document.body.style.webkitTransform =
    document.body.style.MozTransform =
    document.body.style.OTransform =
    document.body.style.msTransform =
    'rotate(' + [45, 90, 135, 180, 225, 270, 315][Math.floor(Math.random() * 7)] + 'deg)';
  }
}
