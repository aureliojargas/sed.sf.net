#! /bin/sed -f
#
# Sierpinski triangle in 11 commands + 1 label.
# Start with a line like this
# _______________________________X_____________________________

# Put an equal number of underscores on both sides.
s/^\(_*\).*/\1X\1/p

# Construct the last three lines of the triangle
:start
/^X/!s/_X_/X_X/gp
/^X/!s/_X_X_/X___X/gp
/^X/!s/_X___X_/X_X_X_X/gp

# Now remove all X's in a consecutive series, except the last.
# X_X_X_X --->
# Y_X_X_Y --->
# X_____X
#
# To ease the task, enlarge pattern space momentarily.
s/.*/__&__/
s/__X/__Y/g
s/X__/Y__/g
s/__\(.*\)__/\1/
y/YX/X_/

# And now create two new "seeds", one to the left and one to the right
s/_X\(__*\)X_/X_\1_X/gp
/^X/! bstart
