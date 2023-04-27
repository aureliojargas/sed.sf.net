#! /bin/sed -f
1{
s/.*/\
\
\
\
\
\
\
\
\
\
\
\
\
\
\
1>  | | \
   -+-+-\
2>  | | \
   -+-+-\
3>  | | \
\
   ^ ^ ^\
   A B C\
/
h
a\
Enter the name of the square in which\
you would like to place a counter, or\
press [RETURN] if you would like me to\
begin.
n
}
/^$/{
2g
2b mefirst
}
/[Aa]1/{
g
s/1>  |/1> X|/
t moved
b full
}
/[Aa]2/{
g
s/2>  |/2> X|/
t moved
b full
}
/[Aa]3/{
g
s/3>  |/3> X|/
t moved
b full
}
/[Bb]1/{
g
s/1> \(.\)| |/1> \1|X|/
t moved
b full
}
/[Bb]2/{
g
s/2> \(.\)| |/2> \1|X|/
t moved
b full
}
/[Bb]3/{
g
s/3> \(.\)| |/3> \1|X|/
t moved
b full
}
/[Cc]1/{
g
s/1> \(.|.\)| /1> \1|X/
t moved
b full
}
/[Cc]2/{
g
s/2> \(.|.\)| /2> \1|X/
t moved
b full
}
/[Cc]3/{
g
s/3> \(.|.\)| /3> \1|X/
t moved
b full
}
a\
I don't know which square you mean.\
Please enter your choice in the form 'C3'.
b
:full
a\
That particular square is already occupied.\
Please choose another!
b
:moved
/X|X|X/b win
/ X.* X.* X/b win
/|X|.*|X|.*|X|/b win
/|.|X.*|.|X.*|.|X/b win
/> X.*> .|X.*> .|.|X/b win
/> .|.|X.*> .|X.*> X/b win
/[OX]|[OX]|[OX].*[OX]|[OX]|[OX].*[OX]|[OX]|[OX]/b draw
h
:wait
n
/^$/!{
s/.*/Oh no you don't, it's my turn!!/
b wait
}
g
/O|O| /{
s/O|O| /O|O|O/
b loose
}
/ |O|O/{
s/ |O|O/O|O|O/
b loose
}
/O| |O/{
s/O| |O/O|O|O/
b loose
}
/> O.*> O.*>  /b playA
/> O.*>  .*> O/b playA
/>  .*> O.*> */b playA
/|O|.*|O|.*| |/b playB
/|O|.*| |.*|O|/b playB
/| |.*|O|.*|O|/b playB
/|.| .*|.|O.*|.|O/b playC
/|.|O.*|.| .*|.|O/b playC
/|.|O.*|.|O.*|.| /b playC
/>  |.*|O|.*|.|O/{
s/1>  /1> O/
b loose
}
/> O|.*| |.*|.|O/{
s/\(2> .|\) /\1O/
b loose
}
/> O|.*|O|.*|.| /{
s/\(3> .|.|\) /\1O/
b loose
}
/|.|O.*|O|.* |.|/{
s/3>  /3> O/
b loose
}
/|.|O.*| |.*O|.|/{
s/\(2> .|\) /\1O/
b loose
}
/|.| .*|O|.*O|.|/{
s/\(1> .|.|\) /\1O/
b loose
}
/X|X| /{
s/X|X| /X|X|O/
b finished
}
/ |X|X/{
s/ |X|X/O|X|X/
b finished
}
/X| |X/{
s/X| |X/X|O|X/
b finished
}
/> X.*> X.*>  /b playA
/> X.*>  .*> X/b playA
/>  .*> X.*> */b playA
/|X|.*|X|.*| |/b playB
/|X|.*| |.*|X|/b playB
/| |.*|X|.*|X|/b playB
/|.| .*|.|X.*|.|X/b playC
/|.|X.*|.| .*|.|X/b playC
/|.|X.*|.|X.*|.| /b playC
/>  |.*|X|.*|.|X/{
s/1>  /1> O/
b finished 
}
/> X|.*| |.*|.|X/{
s/\(2> .|\) /\1O/
b finished
}
/> X|.*|X|.*|.| /{
s/\(3> .|.|\) /\1O/
b finished
}
/|.|X.*|X|.* |.|/{
s/3>  /3> O/
b finished
}
/|.|X.*| |.*X|.|/{
s/\(2> .|\) /\1O/
b finished
}
/|.| .*|X|.*X|.|/{
s/\(1> .|.|\) /\1O/
b finished
}
:mefirst
/2> .| |/{
s/2> \(.\)| |/2> \1|O|/
2!a\
Don't mind if I do!
b finished
}
/[13]>  |/{
s/\([13]> \) |/\1O|/
b finished
}
/[13]> .|.| /{
s/\([13]> .|.|\) /\1O/
b finished
}
/| |/{
s/| |/|O|/
b finished
}
/2>  /{
s/2>  /2> O/
b finished
}
s/\(2> .|.|\) /\1O/
:finished
/[OX]|[OX]|[OX].*[OX]|[OX]|[OX].*[OX]|[OX]|[OX]/b draw
/O|O|O/b loose
/ O.* O.* O/b loose
/|O|.*|O|.*|O|/b loose
/|.|O.*|.|O.*|.|O/b loose
/> O.*> .|O.*> .|.|O/b loose
/> .|.|O.*> .|O.*> O/b loose
h
b
:win
s/$/\
\
You win!!/
q
:loose
s/$/\
\
I win!!/
q
:draw
s/$/\
\
It's a draw!!/
q
:playA
s/>  /> O/
b finished
:playB
s/| |/|O|/
b finished
:playC
s/\(|.|\) /\1O/
b finished
