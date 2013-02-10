#!/bin/sed -f
# Author: Laurent Le Brun <llb [at] fr.fm>

s/.*/############\
#A  #   #B #\
#     # #  #\
# # ### #  #\
# #   #    #\
#   #   #  #\
############/

## Fill matrix ##

s/A/0/g
: fill
y/0123456789a/123456789a0/
s/1 /10/g
s/ 1/01/g
s/1\(.\{12\}\) /1\10/g
s/ \(.\{12\}\)1/0\11/g

# path found ?
/0B/ball
/B0/ball
/B\(.\{12\}\)0/ball
/0\(.\{12\}\)B/ball
t fill

# no :(
i\
  No path was found.
d; q

## Get path ##

:all
# just follow the numbers !
# uncomment next line for debugging
# p
s/B/X/g
:est

/0X/{ s/0X/PX/; banana
}
/X0/{
     s/X0/XP/; banana
}
/X\(.\{12\}\)0/{
     s/X\(.\{12\}\)0/X\1P/; banana
}
/0\(.\{12\}\)X/{
     s/0\(.\{12\}\)X/P\1X/; banana
}

# The end.
# Clean the output.
s/[^ X*#\n]/ /g; q

# just some updates
:anana
s/X/*/
s/P/X/
y/0123456789a/a0123456789/
test
