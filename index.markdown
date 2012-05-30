---
title: 
layout: default
---

## A little about me ##
My name is Nick Markwell, also known as duck (or online as "duckinator"). I have been programming since 2005, and pick up new languages quickly.
I strongly support [open source software](http://en.wikipedia.org/wiki/Open_source) as well as both the [MIT/X11 license](http://en.wikipedia.org/wiki/MIT_License) and [ISC license](http://en.wikipedia.org/wiki/ISC_License).

You can visit [profile.io/duckinator](http://profile.io/duckinator) for more information.

## About the site ##

This site's being basically entirely rewritten...very slowly. I'll eventually finish.

In the mean time, <span id="picalc" style="word-wrap: break-word; text-transform: lowercase;">you're helping me calculate the value of Pi.</span>

A script loaded from <a href="http://pi.duckinator.net">pi.duckinator.net</a> calculates the value of Pi in small bursts (usually about 27 digits at a time), using visitors to various sites. It's merely an experiment with distributed calculations and the limitations of JavaScript. By including a single script (and, optionally, a single element with the ID "picalc") you can provide data for it, as well. See <a href="http://pi.duckinator.net">pi.duckinator.net</a> for more information.

## duckinator.net is open source ##

duckinator.net is completely open source, released under the MIT/X11 license.
Source is available at [http://github.com/duckinator/duckinator.net](http://github.com/duckinator/duckinator.net)

<script src="http://pi.duckinator.net/pi.js"><![CDATA[
PiCalc.calculate(function(data) {
  document.getElementById('picalc').innerHTML = '<a href=\'http://pi.duckinator.net/pi\'>you just calculated ' + data['last_length'] + ' digits of Pi!</a>';
});
]]></script>
