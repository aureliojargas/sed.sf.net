################################################################################
#
#  Sedoku -- a sudoku (blech) solver in sed
#
#  The solver works in two stages. First, row, column and square consistency is
#  enforced. Then, if this does not solve the puzzle, a search is performed by
#  choosing a number where there is a range of possibilities and enforcing 
#  consistency
#
#  All the consistency work is performed in the pattern space, leaving the hold 
#  space free for the search.
#
#  Each square is stored as 11 chars:  X followed by a list of possible numbers
#  in the correct position, followed by a Y. For instance, X--34--789Y indicates
#  that in that square, the numbers 3,4,7,8,9 are consistent with all other 
#  numbers.
#  As a special case, when there is only one number present, X is replaced by x
#  The fixed width format of each square makes it easy to index a particluar row
#  column or 3x3 square.
#
#  Any squares which have only 1 allowed number (ie solved squares) are used to 
#  eliminate numbers from the available list in all other related squares (row
#  column, square). 
#
#  
#  See ###Elimination
#
#  When an elimination is being performed, 9 squares are `active' in the 
#  elimination, and these have the [xX] replaced by [aA]. Then, the program looks
#  for any solved numbers and removed this number from the list of all active 
#  but unsolved squared. After this, any solved squares are flagged by replacing
#  A with a. This is looped over until no more eliminations are made.
#
#  First, ranges of squares to be activated are marked between S,E pairs, and a
#  state letter is added to the beginning of the buffer to mark the current 
#  state. After elimination on the active squares, the markers are moved to 
#  activate the next set of squares.
#  
# See ###Search
#
# The hold space is used to maintain a <stack/queue> of puzzle solutions.
# Currently a queue is used (bredth first search) since I've never seen a
# puzzle which reaquies >1 search depth.
#
# The search is performed by replacing an incomplete cell with a complete  
# one and rerunning the solver. The number to be tried is marked with a Q
# The Q is moved along one available place. Cells in which all of the 
# numbers have been tried have X replaced with K. If Q goes beyond the
# last number in a cell, it is removed, the cell is changed to K and a 
# new Q is put in the next place.
#
# The top of the quee is moved in to the pattern space and changed in 
# to a form suitable for elimination. If is is consistent but unsolved,
# then it is put back in to the queue. Otherwise, the next thing in the
# queue is examined.

#Store as e.g. A12--5-7-9B
#Replace with lcase if number is exact

s/./X&Y/g
s/1/1--------/g
s/2/-2-------/g
s/3/--3------/g
s/4/---4-----/g
s/5/----5----/g
s/6/-----6---/g
s/7/------7--/g
s/8/-------8-/g
s/9/--------9/g
s/\./123456789/g

H

1,8d
#Empty the hold space for later
s/.*//
x
s/\n//g
#Mark known squares
s/X\(-*[0-9]-*\)Y/x\1Y/g

s/$/Z/
#a Z$ signifies no elminiation happened. z$ signifies that they did.


#Mark active squares with aA instead of xX
#First char is the machine state
#rR means row elimination is active. R for first row, r for the rest
#cC means col elimination is active.
#defghijkl for square elimination

:search

#Start with row elimination first
s/^/R/


#Mark active regions with (S)tart (E)nd pairs



:loop
#Rows
/^r/{
	s/S//
	s/E/S/
}
/^R/s/^R/rS/
/r/s/S.\{99\}/&E/


/r/{
	#Check to see if row elimination has finished
	/E/!{
		#Yes, so do Column elimination

		#Remove row markers
		s/[rS]//g
		#Place column markers
		s/\(.\{11\}\)\(.\{88\}\)/S\1E\2/g
		s/^/C/
	}
}

#Move all column markers across by 1 (11 chars)
/c/s/S\([^E]*\)E\(.\{11\}\)/\1S\2E/g
s/^C/c/

/c/{
	#Check to see if there is an S anywhere in the first row. If not, then columns are done
	/^c[^S]\{99\}/{
	#Remove markers
	s/[cSE]//g

	#Put in first square markers
	s/\(.\{33\}\)\(.\{66\}\)\(.\{33\}\)\(.\{66\}\)\(.\{33\}\)\(.\{66\}\)/S\1E\2S\3E\4S\5E\6/
	#Put in state machine state
	s/^/d/
	}
}

#Move square markers
/^[e-m]/{
	#Start pos
	#0			0
	#33			33
	#66			66
	#297		255 + 42
	#330		255 + 75
	#363		255 + 108
	#594		255 + 255 + 84
	#627		255 + 255 + 117
	#660		255 + 255 + 150

	#Sed on OpenBSD requires that for \{X\}, 0 < X < 256

	s/[SE]//g
	s/^\(l.\{255\}.\{255\}.\{150\}\)\(.\{33\}\)\(.\{66\}\)\(.\{33\}\)\(.\{66\}\)\(.\{33\}\)/\1S\2E\3S\4E\5S\6E/
	s/^\(k.\{255\}.\{255\}.\{117\}\)\(.\{33\}\)\(.\{66\}\)\(.\{33\}\)\(.\{66\}\)\(.\{33\}\)/\1S\2E\3S\4E\5S\6E/
	s/^\(j.\{255\}.\{255\}.\{84\}\)\(.\{33\}\)\(.\{66\}\)\(.\{33\}\)\(.\{66\}\)\(.\{33\}\)\(.\{66\}\)/\1S\2E\3S\4E\5S\6E\7/
	s/^\(i.\{255\}.\{108\}\)\(.\{33\}\)\(.\{66\}\)\(.\{33\}\)\(.\{66\}\)\(.\{33\}\)\(.\{66\}\)/\1S\2E\3S\4E\5S\6E\7/
	s/^\(h.\{255\}.\{75\}\)\(.\{33\}\)\(.\{66\}\)\(.\{33\}\)\(.\{66\}\)\(.\{33\}\)\(.\{66\}\)/\1S\2E\3S\4E\5S\6E\7/
	s/^\(g.\{255\}.\{42\}\)\(.\{33\}\)\(.\{66\}\)\(.\{33\}\)\(.\{66\}\)\(.\{33\}\)\(.\{66\}\)/\1S\2E\3S\4E\5S\6E\7/
	s/^\(f.\{66\}\)\(.\{33\}\)\(.\{66\}\)\(.\{33\}\)\(.\{66\}\)\(.\{33\}\)\(.\{66\}\)/\1S\2E\3S\4E\5S\6E\7/
	s/^\(e.\{33\}\)\(.\{33\}\)\(.\{66\}\)\(.\{33\}\)\(.\{66\}\)\(.\{33\}\)\(.\{66\}\)/\1S\2E\3S\4E\5S\6E\7/
}


#Increment the state flag
y/defghijklm/efghijklmn/

/^n/{
	#Squares have finished
	s/[nSE]//g
	
	#If no substutions have taken place...
	/Z/bdone

	#else, go back to elimination on rows
	s/^/R/
	#Reset elminiation marker
	s/z/Z/
	bloop
}

################################################################################
#
###Elimination loop
# 
#Mark squares between SE pairs with aA insetad of xX
:markloop
tmarkloop
s/S\([^E]*\)X/S\1A/g
s/S\([^E]*\)x/S\1a/g
tmarkloop

#Perform elimination

belim

:change
#An elimination happened, so mark it with a z
s/Z/z/

:elim
telim
/a1/      		s/\(A\)1/\1-/g
/a-2/     		s/\(A.\)2/\1-/g
/a--3/    		s/\(A..\)3/\1-/g
/a---4/  		s/\(A...\)4/\1-/g
/a----5/  		s/\(A....\)5/\1-/g
/a-----6/   	s/\(A.....\)6/\1-/g
/a------7/    	s/\(A......\)7/\1-/g
/a-------8/     s/\(A.......\)8/\1-/g
/a--------9/    s/\(A........\)9/\1-/g

#Check for errors
/[aA]---------/bbork
/a1.*a1/bbork
/a-2.*a-2/bbork
/a--3.*a--3/bbork
/a---4.*a---4/bbork
/a----5.*a----5/bbork
/a-----6.*a-----6/bbork
/a------7.*a------7/bbork
/a-------8.*a-------8/bbork
/a--------9.*a--------9/bbork

#Mark newly solved squares as solved
s/A\(-*[0-9]-*\)Y/a\1Y/g 
tchange

#Unmark active squares
y/aA/xX/
bloop
################################################################################


#Inconsistent state
:bork
x
#Hold space empty -- first time through -- broken puzzle
/^$/{
s/.*/Broken1!/
q
}

#Else, just go and try the next thing
bnext


###Search
:done
#No unsolved squares---puzzle is finished!
/X/!bend



1000{s/.\{33\}/&   /g
s/.\{108\}/&\
/g
s/.\{255\}.\{71\}/&\
/g
s/[xXY]/ /g
q
}



#Hold space seperates puzzles with #
s/z/Z/
#Append the puzzle to the queue
s/^/#/
H
x
s/\n//g

#Move the end of the queue to the beginning
#bredth first search
s/\(.*\)\(#[^#]*\)$/\2\1/


#Next number to try is marked with a Q
#Only X cells need to be tried. Fully searched
#X cells are changed to K cells.
:next
#Move the marker (if present)
s/Q\([0-9]\)\(-*\)\([0-9Y][^#]*\)$/\1\2Q\3/

#Marker reached the end of the cell, flag cell and remove marker
s/X\(.........\)QY\([^#]*\)$/K\1Y\2/
#If necessary, place marker in next unchecked cell
/Q[^#]*$/!s/\(X-*\)\([0-9][-0-9]*Y[^#]*\)$/\1Q\2/




#Was this pattern exhausted?
/#[^X#]*$/{
	#Remove it and go again
	s/#[^#]*//
	
	/^$/{
		s/.*/Broken!/
		q
	}
	bnext
}

x

#Get the top of the stack and put it in a form for processing
g
s/.*#//g
y/K/X/
s/XQ........./x1--------/
s/X.Q......../x-2-------/
s/X..Q......./x--3------/
s/X...Q....../x---4-----/
s/X....Q...../x----5----/
s/X.....Q..../x-----6---/
s/X......Q.../x------7--/
s/X.......Q../x-------8-/
s/X........Q./x--------9/
#Now attempt to solve this version of the puzzle
bsearch


:end
s/X[-0-9]\{9\}Y/./g
s/x-*\([0-9]\)-*Y/\1/g
s/.\{9\}/&\
/g
s/Z//
q

#
# The End :-)
#
################################################################################
