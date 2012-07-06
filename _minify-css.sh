#!/bin/sh

DIR=$(dirname $(readlink -f $0)) # Directory script is in

cd $DIR/css

echo -n > all.min.css

for x in *.css; do
  [ "$x" == "all.min.css" ] && continue
  csstidy $x --template=highest $x.tmp
done

for x in *.tmp; do
  cat $x >> all.min.css
  echo >> all.min.css
done

rm *.tmp

