#n
#This sed script prints out 99 green bottles with words or numbers
#Type numbers to get numbers otherwise, give it a blank line
# 
#Author: E. Rosten
#License: GPL (www.gnu.org)

/numbers/{
    s/.*/99a green bottles hanging on the wall/
    bl1
    }

s/.*/99 green bottles hanging on the wall/
:l1
h

s/\(.*\)/c\1/
benum
:eenumc


:begin
h
s/\(.*\)/b\1/
benum
:eenumb

s/.*/And if one green bottle should accidently fall/
p

g
s/.\(.\)/\1/
y/9876543210/8765432109/
x
s/\(.\).*/\1/
x
/9/{
    x
    y/9876543210/8765432109/
    x
    }
x
G
s/\
//
h
s/\(.*\)/aThere'll be \1/
benum
:eenuma
s/.*/\
/
p
x
/00/q
bbegin


bend

:enum
/[0-9][0-9]a/{
    s/\(.*[0-9][0-9]\)a\(.*\)/\1\2/
    bnoenum
    }

/[02-9][0-9]/{
    /0[0-9]/s/0/!/
    /2[0-9]/s/2/twenty /
    /3[0-9]/s/3/thirty /
    /4[0-9]/s/4/fourty /
    /5[0-9]/s/5/fifty /
    /6[0-9]/s/6/sixty /
    /7[0-9]/s/7/seventy /
    /8[0-9]/s/8/eighty /
    /9[0-9]/s/9/ninety /

    /[! ]0/s/0//
    /[! ]1/s/1/one/
    /[! ]2/s/2/two/
    /[! ]3/s/3/three/
    /[! ]4/s/4/four/
    /[! ]5/s/5/five/
    /[! ]6/s/6/six/
    /[! ]7/s/7/seven/
    /[! ]8/s/8/eight/
    /[! ]9/s/9/nine/
   
    /!one/s/bottles/bottle/g
    s/! /no /g
    s/!//g
    }

/1[0-9]/{
    s/10/ten/
    s/11/eleven/
    s/12/twelve/
    s/13/thirteen/
    s/14/fourteen/
    s/15/fifteen/
    s/16/sixteen/
    s/17/seventeen/
    s/18/eighteen/
    s/19/nineteen/
    }
:noenum
G
h
s/.\(.\).*/\1/g
y/otfsen/OTFSEN/
G

s/\(.\)\
\(.\).\(.*\
\)\(.*\)/\1\3\2\4/

s/  / /g
P
s/.*\
//


/^a/{
    s/^a//
    h
    beenuma
    }

/^b/{
    s/^b//
    h
    beenumb
    }

/^c/{
    s/^c//
    h
    beenumc
    }


:end


