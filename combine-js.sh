#!/bin/sh

DIR=$(dirname $(readlink -f $0)) # Directory script is in

if [ ! -d "$DIR/static/js" ]; then
    echo "Please run $0 after rendering html"
    exit 1
fi

cd $DIR/static/js

echo > all.js

for x in `ls *.js | grep -v 'all.js'`; do
    echo   >> all.js
    cat $x >> all.js
done
