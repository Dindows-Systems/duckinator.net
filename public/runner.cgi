#!/bin/sh
export GEM_PATH=/home/rockermono/.gem/ruby/1.8/
exec /usr/bin/env ruby -r../backend/backend.rb -e "run"
