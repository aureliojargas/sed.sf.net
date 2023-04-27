#! /bin/sed -nf
# arkanoid.sed - 20020709 - http://sed.sf.net/sedgames
#   by aurélio marinho jargas <aurelio@verde666.org>
#
# arkanoid: a paddle that bounces a ball (pong!) to destroy blocks
#
# ACTORS:
#   o  ball               --  paddle
#   =  block              ~~  paddle (on hold mode)
#   *  block exploding    .   life (mini paddle)
#                                  [come on, use your imagination :)]
# COMMANDS:
#   z  left move      c  hold mode ON/OFF
#   x  right move     q  quit
#   
# ANTI-FLAME DISCLAIMER:
#   well, just as sokoban.sed, this one is cool because it's sed.
#   it's not funny to play or even exciting, because keep pressing
#   ENTER to the ball move sucks. but hey, it's cute! &;) 
#
# for the how-many-lines-it-has? fanatics:
#   prompt$ sed '/^ *#/d' arkanoid.sed | sed '$=;d'
#
# tip: use hold mode to escape circle ball movement
# TODO get classic arkanoid levels (somebody help me!)

b zero

:nocolor
  ### if you don't want colorful output, just uncomment next line
  #s/K(\([0-9;]*\))//g
  b showmap

:parsecomm
  ### arrow keys (1), numeric pad (2), i-case (3), wipe trash(4)
  //{ s/\[A/h/g ; s/\[B/h/g ; s/\[C/x/g ; s/\[D/z/g ; }
  y/4560/zhxq/
  y/QZXHCc/qzxhhh/
  s/[^qzxh#]//g
  b execcomm

:welcome
  i\
       Welcome to the SED Arkanoid\
  \
  Please select a level to begin [1-2]:
  d

:showhelp
  ### clear screen, show help
  i\
  [2J[H
  x; s|.*|\
  ...                  Sed Arkanoid\
  ...                  \
  ...                    z,4,<left>   left move\
  ...                    x,6,<right>  right move\
  ...                    c,5,<down>   hold on/off\
  ...                    q,0          quit game\
  ...                    <enter>      go!\
  \
                           http://sed.sf.net/sedgames|p
  s/.*//;x
  b end


:loadmap
  ### load map on HOLD space
  /^1$/{ s/.*/\
      _____________ \
     |             |\
     |             |\
     |=============|\
     |=============|\
     |=============|\
     |             |\
     |             |\
     |             |\
     |             |\
     |      o      |\
     |     ~~      |\
     |...__________|\
  / ; b endmap
  }
  /^2$/{ s/.*/\
      _____________ \
     |=            |\
     |===          |\
     |=====        |\
     |=======      |\
     |=========    |\
     |===========  |\
     |=============|\
     |             |\
     |             |\
     |      o      |\
     |     ~~      |\
     |...__________|\
  / ; b endmap
  }

  ### test levels
  #
  # free X test
  /^t1$/{ s/.*/\
  TEST 1 - f:X\
      _____________ \
     |       = = = |\
     |      o      |\
     |       = = = |\
     |             |\
     |.____________|\
   / ; b endmap
  }
  # free Y test
  /^t2$/{ s/.*/\
  TEST 2 - f:Y\
      _____________ \
     |             |\
     |  ==  =      |\
     |   =  ==     |\
     |     ==      |\
     |   =o=       |\
     |  ==         |\
     |             |\
     |____.________|\
   / ; b endmap
  }
  # tri-explosion test
  /^t3$/{ s/.*/\
 TEST 3 - 3\
      _____________ \
     |     ==      |\
     |     ==      |\
     |    ==  =    |\
     |     = ==    |\
     |  =o         |\
     |  ==         |\
     |             |\
     |.____________|\
   / ; b endmap
  }
  # round explosion test
  /^t4$/{ s/.*/\
 TEST 4 - >, <, b:>, b:<\
      _____________ \
     |     = =     |\
     |   == o ==   |\
     |   = = = =   |\
     |    == ==    |\
     |             |\
     |___________._|\
   / ; b endmap
  }
  /~~/!{s/.*/there is no '&' level!/p ;q;}

:endmap
  s/^/[H/ ; s/  $/ru / ; h
  b showhelp

#--------------------------------------------------------------------
#
### general hints about the code:
#
# - rlud are movements to perform on this turn
# - RLUD are movements already done
# - O is a ball already moved on this turn
# - @% are temporary ball states to indicate ball over a block
# - ! is a temporary explosion state after a free Y move
# - -- is plain paddle and ~~ is paddle on hold mode
# - ... are your 3 lives (mini-paddles)
# - # is the cheat mode identifier (jail!)
# - on hold, when releasing the ball, its X-direction will be same of
#   the paddle side where the ball is
# - on hold, forcing paddle on the wall can move ball to the other side
#   of the paddle
# - on hold mode, Y-direction is always down
# - explosions are showed, then reconverted to ball on the next move
# - ball on vertical and top borders do bounce
# - block explosion and paddle (of course) bounces
# - bounce: change X or Y direction
# - exploding a block may change Y-direction and/or X-direction, depending
#   if there's another block on the way (see explosion comments)
# - diagonal moves are done as X then Y moves (that's why % is needed)
# - K() pattern is replaced by color escape chars <esc>[m
# - < and > are round explosion direction. stored at the end (.$) of the map
# - ball direction (rlud) is stored at the end (.. $) of the map also
# - user commands are case insensitive


# missedball routine: 1. reset direction and explosion status
# 2. put ball over paddle , 3. take one life, 4. put paddle on hold mode
#
:missedball
  s/...$/ru /
  s/\*/ / ; s/ \(.\{20\}\)\([-~]\)/o\1\2/
  s/\._/__/
  s/--/~~/
  b end

:zero
1 b welcome

# first map loading
2 b loadmap

:ini
b parsecomm

:execcomm
### execute user commands

### first, have you missed a ball?
x ; /\*\(.\{20\}\)[_.]/{
  /#/!b missedball
  # cheat mode: never loses
  y/d*/uo/ ; b execcomm
} ; x

/q/q

# you cheater! (keep holding enter - hyperspeed)
/#/{ x ; /#/!s/\(.*\)|/\1\#/ ; }

# 1. move ball+paddle on hold, and goto end
# 2. move just paddle and continue
/z/{ x
  /o.\{20\}~/{ s/ o/o / ; s/ ~~/~~ / ; b end
  }
  s/ \(--\|~~\)/\1 /
}
/x/{ x
  /o.\{20\}~/{ s/o / o/ ; s/~~ / ~~/ ; b end
  }
  s/\(--\|~~\) / \1/
}
/h/{ x;
  ### turn OFF hold mode routine
  /~~/{
    # depending which side of paddle, change X-direction
    /o.\{20\}~~/y/Rr/LL/ ; /o.\{20\}~[^~]/y/Ll/RR/
    # change Y-direction
    /o.\{20\}~/y/Dd/UU/
  }
  # swap ON/OFF paddle shape
  y/-~/~-/
}
/./!x


# current explosion turns back to ball
/o/s/\*/ /g
s/\*/o/
# reset movements
y/RLUD/rlud/

# holded ball, no move
/o.\{20\}~/b end

### LET´S MOVE IT!

# reached top: do bounce changing Y-direction
/_\(.\{20\}\)o/y/u/d/

### detect borders, change X-direction
/|o/y/l/r/
/o|/y/r/l/

# plain right-left ball move
/r/s/o / O/
/l/s/ o/O /

# tricky move over a block - part I
/r/{ s/o=/ @/ ; s/% /=o/ ; }
/l/{ s/=o/@ / ; s/ %/o=/ ; }

# restore ball and mark X moves as done
y/O@rl/o%RL/

b explodeme


### detect block. if so, explode it!
#
#     0   1     RIGHT-UP example:
#   +---+---+
#   | = | * |   0. free X-way
#   |o  |  o|   1. explode and change Y-direction           (right-down)
#   +-------+
#   |== |** |   0. blocked X and Y way (tri-explosion)
#   |o= |o* |   1. explode all and change X and Y direction (left-down)
#   +-------+
#   |   |o  |
#   | = | * |   0. free Y-way
#   |o= | = |   1. explode and change X-direction           (left-up)
#   +---+---+
#   
### RIGHT-UP Smart clockwise full round explosion!
#
#   +---+---+---+---+---+
#   | = | * |   |   |   |  If two explosions on two turns,
#   |o =|  =|  *|   |o  |   we're on a round explosion.
#   | = | = | = | * |   |  After the roll, we end as left-up.
#   +---+---+---+---+---+
#

### explosion functions (wise is clockwise [>] or anti-clockwise [<])
# detectwise: if wise direction is empty, set it! - else dowise
#    setwise: set wise direction, based on current ball direction
#     dowise: set the next ball direction, based on wise direction
#
:detectwise
  / $/ b setwise
  b dowise

# */! : ball came from X/Y free
:setwise
  /\*/{
    /Ld $/s/ $/>/
    /Ru $/s/ $/>/
    /Rd $/s/ $/</
    /Lu $/s/ $/</
    y/ud/du/
  }	
  /!/{
    /Ld $/s/ $/</
    /Ru $/s/ $/</
    /Rd $/s/ $/>/
    /Lu $/s/ $/>/
    y/RL/LR/
  }	
  y/ud/UD/
  b end

:dowise
  /Rd<$/ y/d/U/
  /Lu<$/ y/u/D/
  /Ru<$/ y/R/L/
  /Ld<$/ y/L/R/
  /Ld>$/ y/d/U/
  /Ru>$/ y/u/D/
  /Rd>$/ y/R/L/
  /Lu>$/ y/L/R/
  b end


# UP & DOWN explosion code:
#   1. free X
#   2. blocked XY from left  (tri-explosion)
#   3. blocked XY from right (tri-explosion)
#   4. free Y
#
:explodeme
/d/{
  /o\(.\{20\}\)=/         s// \1*/
  /% \(.\{19\}\)==\(.*L\)/s//*o\1**\2/
  / %\(.\{19\}\)==\(.*R\)/s//o*\1**\2/
  /%\(.\{20\}\)=/         s//=\1!/
}
/u/{
  /=\(.\{20\}\)o/         s//*\1 /
  /==\(.\{19\}\)% \(.*L\)/s//**\1*o\2/
  /==\(.\{19\}\) %\(.*R\)/s//**\1o*\2/
  /=\(.\{20\}\)%/         s//!\1=/ 
}

# end tri-explosion: invert all directions (keep before "end free X" code)
/\*\*/{ y/udRL/DULR/ ; b end
}
# end free Y explosion
/! .*L\| !.*R/ b detectwise
# end free X explosion
/\*/ b detectwise


# detect paddle bounce, change Y-direction
/o\(.\{20\}\)-/y/d/u/

# plain up-down ball move (no explosion)
/u/s/ \(.\{20\}\)o/o\1 /
/d/s/o\(.\{20\}\) / \1o/

# tricky move over a block - part II
/u/s/ \(.\{20\}\)%/o\1=/
/d/s/%\(.\{20\}\) /=\1o/

# you missed the ball!
/o\(.\{20\}\)[_.]/y/o/*/


:end
# show move over a block explosion right
y/!/*/
# reset last explosion reminder for plain moves
/\*/!s/[<>]$/ /

### detect level finished or GAME OVER
/=/!{ s/\(\([^\n]*\n\)\{5\}[^|]*|\).........../\1K(33;1)  VICTORY!!K()/ ; }
/\./!{ s/\(\([^\n]*\n\)\{5\}[^|]*|\).........../\1K(31;1)  GAME OVERK()/ ; }

### save map
h

### hide direction (comment for debug)
s/...$//

### add colors
s/--/K(32;1)&K()/g
s/~~/K(32;1)&K()/g
s/o/K(33;1)&K()/g
s/ \?_\+ \?\||/K(42;32)&K()/g
s/\./K(42;32;1)&K()/g
s/#/K(42;37;1)&K()/g
s/\*/K(31;1)&K()/g
b nocolor

:showmap
s/K(\([0-9;]*\))/[\1m/g ; p

/VICT\|OVER/q
d
