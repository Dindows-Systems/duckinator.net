## Background ##

I've been interested in <abbr title="Artificial Intelligence">AI</abbr> for a few years now, but only recently started trying to make a serious attempt in it.
Below is a rough design of my current idea.

## Design ##
[http://github.com/RockerMONO/cervello](Cervello)'s AI design uses a word-grouping system.

In the following, /w/ is the number of words in each group and /n/ is the number of words in a sentence before it is recorded in any manner.
/w/ defaults to 3, but may be changed.
/n/ defaults to /w/+1, but may be changed.

If a sentence contains more than /n/ words, it is split into groups of /w/ words.

*I will continue actual documentation later*

### Simple ruby implementation ###
<code>
class AI
  def initialize
  	@words = Hash.new(0)
  	
  end
end

ai = AI.new
ai.add("this is a test, blah test ohai thar a test blah")
</code>
