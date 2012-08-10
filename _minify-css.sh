#!/bin/sh

DIR=$(dirname $(readlink -f $0)) # Directory script is in

cd $DIR/css

echo -n > all.min.css

for x in {normalize,main}.css; do
  cat $x > $x.tmp

  # Remove single-line comments
  sed -i  's|/\*.*\*/||g'             $x.tmp

  # Remove all tabs and leading whitespace.
  sed -i  's/\t\|^[\t ]*//g'          $x.tmp

  # Remove whitespace around colons and brackets.
  sed -i  's/ *\(:\|{\|}\) */\1/g'    $x.tmp

  # Make comma-separated list be single-line (foo,\nbar -> foo,bar).
  sed -i -n '1h;1!H;${;g;s/,\n/,/g;p;}' $x.tmp

  # Remove newlines before closing brackets (foo\n} -> foo}).
  sed -i -n '1h;1!H;${;g;s/\s*\n}/}/g;p;}' $x.tmp

  # Remove newlines after opening brackets ({\nfoo -> {foo).
  sed -i -n '1h;1!H;${;g;s/{\s*\n/{/g;p;}' $x.tmp

  # Remove newlines after semicolons (foo;\nbar -> foo;bar).
  sed -i -n '1h;1!H;${;g;s/;\s*\n/;/g;p;}' $x.tmp

  # Remove repeated newlines.
  # TODO: Make this less hideous.
  cat $x.tmp | grep -v "^$" > $x.tmp2
  cat $x.tmp2 > $x.tmp
  rm $x.tmp2
done

for x in {normalize,main}.css.tmp; do
  cat $x >> all.min.css
  echo >> all.min.css
done

rm *.tmp

