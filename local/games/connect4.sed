#!/bin/sed -nf
# Author: Laurent Le Brun <llb [at] fr.fm>

# quit command
/^q/q

# welcome message
1{ i\
       Hei !\
\
Enter a column number [1-7].\
Type 'q' to exit.

# load game

  s/.*/\
Player X\
#-------#\
#       #\
#       #\
#       #\
#       #\
#       #\
#       #\
#       #\
#########/
b end
}

# wipe trash
s/[^1-7]//g

/^1/{
  s///;x
  /r \(.\)\(.\{12\}\) /{
     s/r \(.\)\(.\{12\}\) /r \1\2\1/
     b newt
  }
  b full
}

/^2/{
  s///;x
  /r \(.\)\(.\{13\}\) /{
     s/r \(.\)\(.\{13\}\) /r \1\2\1/
     b newt
  }
  b full
}

/^3/{
  s///;x
  /r \(.\)\(.\{14\}\) /{
     s/r \(.\)\(.\{14\}\) /r \1\2\1/
     b newt
  }
  b full
}

/^4/{
  s///;x
  /r \(.\)\(.\{15\}\) /{
     s/r \(.\)\(.\{15\}\) /r \1\2\1/
     b newt
  }
  b full
}

/^5/{
  s///;x
  /r \(.\)\(.\{16\}\) /{
     s/r \(.\)\(.\{16\}\) /r \1\2\1/
     b newt
  }
  b full
}

/^6/{
  s///;x
  /r \(.\)\(.\{17\}\) /{
     s/r \(.\)\(.\{17\}\) /r \1\2\1/
     b newt
  }
  b full
}

/^7/{
  s///;x
  /r \(.\)\(.\{18\}\) /{
     s/r \(.\)\(.\{18\}\) /r \1\2\1/
     b newt
  }
  b full
}

i\
  Bad input. Enter a column number [1-7].
  x
  b end

:full

i\
  Please choose another column.
  b end

:win
i\
  Victory !
q

:newt

# Falling
:fall
s/\([OX]\)\(.\{9\}\) / \2\1/
t fall

# next player
/r X/{
s/r X/r O/ ; bup
}
s/O/X/1
:up

# update game header
s/-\(.\{9\}[^ ]\)/!\1/g

# victory ?

/X\{4\}/b win
/\(X.\{9\}\)\{4\}/b win
/\(X.\{10\}\)\{4\}/b win
/\(X.\{8\}\)\{4\}/b win

/O\{4\}/b win
/\(O.\{9\}\)\{4\}/b win
/\(O.\{10\}\)\{4\}/b win
/\(O.\{8\}\)\{4\}/b win

# draw game ?
/!\{7\}/{
i\
  Draw game.
  q
}

i\

:end

# update screen

# add some sexy colors
s/#/[41;31m&[m/g
s/X/[33;1m&[m/g
s/O/[34;1m&[m/g
s/-/[32;32m&[m/g
s/!/[34;31m&[m/g

p

# remove the sexy colors
s/\[[0-9;]*m//g

x
