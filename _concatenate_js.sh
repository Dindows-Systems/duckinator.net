#!/bin/bash

DIR=$(dirname $(readlink -f $0)) # Directory script is in

cd $DIR/js

echo > all.js

for x in *.js; do
  [ "$x" == "all.js" ] && continue
  echo "/* start $x */" >> all.js
  cat $x >> all.js
  echo >> all.js
  echo "/* end   $x */" >> all.js
  echo >> all.js
done
