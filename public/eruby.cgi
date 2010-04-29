#!/bin/sh
END=$[`expr match "$PATH_TRANSLATED" '.*/public/'`-8]
export PAGE=$PATH_TRANSLATED
export PATH_TRANSLATED=${PATH_TRANSLATED:0:$END}/backend/dummy.rhtml
exec /usr/bin/eruby -C UTF-8
