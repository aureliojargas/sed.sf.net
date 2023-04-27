#! /bin/sed -nf
# Sierpinski in 7 commands + 2 labels, fast and unportable
# Paolo Bonzini 2003

# Pad to the right
s/\(_*\)X.*/\1X\1/p

# Add two empty lines at the border
:next
s/.*/_&_\
/

# Implement rule 90:
#  XXX     XX_     X_X      X__       _XX       _X_       __X        ___
#   _       X       _        X         X         _         X          _
#
# The first line takes care of XXX, X_X, _X_, ___, the second and third of __X
# and X__ XX_ and _XX cannot happen.
#
# The s command removes the first character and appends the outcome at the end
#
:loop
s/^\(X\(.X\)\|_\(._\)\)\(.*\)/\2\3\4_/
s/^\(_\(_X\)\|X\(__\)\)\(.*\)/\2\3\4X/
/^..\n/!bloop

# Ok, remove the last two remaining characters and the new line
s/^..\n//p

# Go on until the triangle expanded to the first character.
/^X/!bnext
