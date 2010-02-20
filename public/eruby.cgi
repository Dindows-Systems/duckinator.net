#!/bin/sh
#cd $(dirname ${PATH_TRANSLATED:-/})
exec /usr/bin/eruby -C UTF-8 "$@"
