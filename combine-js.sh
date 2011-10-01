#!/bin/sh

DIR=$(dirname $(readlink -f $0)) # Directory script is in

cd $DIR/public/js

echo > all.min.js

for x in `ls *.js | grep -v 'all.js'`; do
    echo   >> all.js
    cat $x >> all.js
done
