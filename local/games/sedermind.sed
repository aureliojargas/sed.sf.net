#! /bin/sed -rf

# Usage: sed -rf sedermind.sed ou ./sedermind.sed
# Please use Gnu Sed

                           # Sedermind #

2bigen
1!bcheck

i\
 Please enter a random word or sentence to generate a code.\
 (at least 4 letters)
bend

:igen
# lowercase input
s/.*/\L&/
s/[^a-z]//g

# We need to generate a code for mastermind ([1-8]{4})
# Since sed has no random function (and can't access to /dev/random),
# we ask the user to enter a random string (at least 4 letters)
# and we generate a code from this input.

:gen
y/abcdefghijklmnopqrstuvwxyz12345678/bcdefghijklmnopqrstuvwxyz123456781/
:l s/([^1-8])([1-8])/\2\1/; tl
s/^(.*)(.)$/\2\1/
s/^1(.)/\15/
/^[1-8]*$/!bgen
s/(....).*/\1/

s/$/\nGuess the code (4 digits between 1 and 8) [........]/
x

i\
\
  'o' is placed for each correct digit (value and position) \
  'x' is placed for each digit with bad position
bend

# Tester user guess.
:check

G
s/\n/:/
s/\n.*//

/^(.*):\1$/bvict

x
s/\./*/
/\./!blose
x

# Correct digits
:loop1
/([1-8]).{4}\1/{
 s/(.)(.{4})\1/ \2o/
}
tloop1

# Digits with bad position
:loop2
s/([1-8])(.*:.*)\1/\2x/
tloop2

# Clean things and display
s/.*://
s/[^ox]//g
:m s/xo/ox/; tm
s/$/    /
s/^(....).*/\1/
s/.*/ => '&'/
p
i\

bend

:vict
i\
 Victory is yours.
Q

:lose
i\
 Loser. \
 Answer was:
x
s/.*://
q

:end
g
s/.*\n//p

s/.*//
d
