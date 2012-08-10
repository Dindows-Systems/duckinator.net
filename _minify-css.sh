#!/bin/sh

DIR=$(dirname $(readlink -f $0)) # Directory script is in

cd $DIR/css

echo -n > all.min.css

for x in {normalize,main}.css; do
  [ "$x" == "all.min.css" ] && continue
  # TODO: Figure out how to make csstidy be niec.
  #csstidy $x --template=default $x.tmp
  cat $x > $x.tmp

  sed -i  's|/\*.*\*/||g'             $x.tmp
  sed -i  's/\t\|^[\t ]*//g'          $x.tmp
  sed -i  's/ *\(:\|{\|}\) */\1/g'    $x.tmp
  #sed -i 's/,\n/,/g'                 $x.tmp

  # foo,\nbar -> foo,bar
  sed -i -n '1h;1!H;${;g;s/,\n/,/g;p;}' $x.tmp

  # foo\n} -> foo}
  sed -i -n '1h;1!H;${;g;s/\n}/}/g;p;}' $x.tmp

  # We run this 3 times because I want to avoid loops.
  # \n\n -> \n
  sed -i -n '1h;1!H;${;g;s/\n\n/\n/g;p;}' $x.tmp
  sed -i -n '1h;1!H;${;g;s/\n\n/\n/g;p;}' $x.tmp
  sed -i -n '1h;1!H;${;g;s/\n\n/\n/g;p;}' $x.tmp

  # Remove comments
  #sed -i -n '1h;1!H;${;g;s|/\*(^\*/)+\*/||g;p;}' $x.tmp
done

for x in {normalize,main}.css.tmp; do
  cat $x >> all.min.css
  echo >> all.min.css
done

rm *.tmp

