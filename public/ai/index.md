## Background ##

I've been interested in <abbr title="Artificial Intelligence">AI</abbr> for a few years now, but only recently started trying to make a serious attempt in it.
Below is a rough design of my current idea.

Fair warning, this page hasn't been really updated in ages. The code is far different from this explanation.

## Design ##
[Cervello](http://github.com/RockerMONO/cervello)'s AI design uses a word-grouping system.

In the following, _w_ is the number of words in each group and _n_ is the number of words in a sentence before it is recorded in any manner.
_w_ defaults to 3, but may be changed.
_n_ defaults to _w_+1, but may be changed.

If a sentence contains more than _n_ words, it is split into groups of _w_ words.

*I will continue actual documentation later*
