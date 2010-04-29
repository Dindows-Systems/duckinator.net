#!/bin/sh
END=$[`expr match "$PATH_TRANSLATED" '.*/public/'`-8]
export BACKEND=${PATH_TRANSLATED:0:$END}/backend/backend.rb
#exec /usr/bin/eruby -C UTF-8
exec /usr/bin/env ruby $BACKEND
