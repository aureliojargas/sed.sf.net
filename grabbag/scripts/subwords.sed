#! /bin/sh
#
# Find dictionary words in a string.
# Invoke with the string as an argument.
#
# Casper Boden-Cummins <mister_pink@bigfoot.com>

DICT=/usr/dict/words              # point to your local dictionary

echo $1 | cat - $DICT | sed -n '
1{
  h                               # 1st encountered word to hold space
  b
}
s/.*/&|&/                         # save copy of dictionary word
G                                 # append source word
:pair
s/\(|.*\)\(.\)\(.*\n.*\2\)/\1\3/  # find matching letters and remove one
t pair                            # repeat until no more letter pairs
s/|\n.*//p                        # if all letters matched, output saved copy
'
