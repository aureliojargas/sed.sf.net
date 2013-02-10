#!/bin/sed -nf
# Author: Laurent Le Brun <llb [at] fr.fm>

### commands ###
/^q/q
/^h/ { r game_readme.txt
bend }
/^v/bv

# welcome message
1{ i\
     Welcome.\
\
  During the game, type 'h' for help.\
  Level (1..5) ?
  d
  bend
}

2{
/^1/s/.*/\
LEVEL 1\
\
##########   \
#X1111111#   \
#12222221#   \
#11111111#   \
#11111111#   \
##########   \
\
(#)/

/^2/s/.*/\
LEVEL 2\
\
##########   \
#X1122111#   \
#122221#1#   \
#12211222#   \
#111111#1#   \
######111#   \
##########   \
\
(#)/

/^3/s/.*/\
LEVEL 3\
\
########     \
#X12122#     \
###2#12#     \
#113223#     \
#1#32#1#     \
#112111#     \
########     \
\
(#)/

/^4/s/.*/\
LEVEL 4\
\
###########  \
#X22222222#  \
#111#####1#  \
#1#1#####1#  \
#222222222#  \
###########  \
\
(#)/


/^5/s/.*/\
LEVEL 5\
\
############ \
#X222222221# \
##1###1##### \
#1211#22222# \
#1##1#11112# \
#11121####1# \
####1211111# \
############ \
\
(#)/


# ok, let's start
/LEVEL/{
  bprint
}


# error (bad level)
i\
  Unbound level.
q
} #end 3

### input ###
:input

# arrow keys support
s/\[A/e/g
s/\[B/d/g
s/\[C/f/g
s/\[D/s/g

# moves
/^e/{
s///;x
/#.\{13\}X/bcollision
s/\(.\)\(.\{13\}\)X\(.*\)(\(.\))/X\2\4\3(\1)/
bturn
}

/^s/{
s///;x
/#X/bcollision
s/\(.\)X\(.*\)(\(.\))/X\3\2(\1)/
bturn
}

/^d/{
s///;x
/X.\{13\}#/bcollision
s/X\(.\{13\}\)\(.\)\(.*\)(\(.\))/\4\1X\3(\2)/
bturn
}

/^f/{
s///;x
/X#/bcollision
s/X\(.\)\(.*\)(\(.\))/\3X\2(\1)/
bturn
}

i\
  Oups, bad input.
s/.*//
x
bprint

### Collision ###
:collision

i\
  Hey! You can't go there!
  bprint

### New turn ###
:turn

s/(1)/(#)/
s/(2)/(1)/
s/(3)/(2)/
s/(4)/(3)/
s/(5)/(4)/
s/(6)/(5)/

### print ###
:print

# sexy colors
s/X/[31;1m&[m/g
s/#/[46;36m&[m/g

p

# remove sexy colors
s/\[[0-9;]*m//g


### victory ###

/#.*[1-9]/! {
:v
i\
  Victory is yours!
  s///
  q
}

x

:end

s/.*//
