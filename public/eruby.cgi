#!/bin/sh
END=$[`expr match "$PATH_TRANSLATED" '.*/public/'`-8]
export SITE_FILE_NAME=$PATH_TRANSLATED
export PATH_TRANSLATED=${PATH_TRANSLATED:0:$END}/backend/backend.rb
exec /usr/bin/eruby -C UTF-8
