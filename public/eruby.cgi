#!/bin/sh
END=$[`expr match "$PATH_TRANSLATED" '.*/public/'`-8]
export PAGE_LOCATION=$PATH_TRANSLATED
export PATH_TRANSLATED=${PATH_TRANSLATED:0:$END}/backend/dummy.rhtml
GEM_HOME=$GEM_HOME:$HOME/.gem/ruby/1.8/bin exec /usr/bin/eruby -C UTF-8
