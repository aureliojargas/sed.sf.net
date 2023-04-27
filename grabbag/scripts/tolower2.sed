#! /bin/sh

echo $* | sed '
  s/^ *//
  s/[^ ]$/& /

  :x
  /./ {
    # Save the sequence
    h

    # Convert the first item
    s/^\([^ ]*\).*$/\1/
    y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/

    # Make a command out of the old and new versions of the first item
    G
    s/^\(.*\)\n\([^ ]*\).*$/mv \2 \1/p

    # Remove the first item and loop
    g
    s/^\([^ ]*\) //
    bx
  }'