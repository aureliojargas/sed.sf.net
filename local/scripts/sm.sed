#! /bin/sed -f

# sed-sm -- template for a state machine with sed
#
# $Id$
# Carlos Duarte, 980525/980531

#
# How to use the state machine
# 
# There are five places to place code (marked through the script): 
# 1. before :main, to run only once, at start
# 2. after :main, to run on each line, after it has been load
# 3. code for states, to run on each state
# 4. after :pnext, to run on each line, after it has been processed per states
# 5. after :end, to run only once, at end of everything
# 
# 1 and 5, should be used to insert or append some text, or perhaps to
# read some file into script, etc..
# 
# 2,3,4 run on a pattern space, of format ^.*\n.*$
# First .* is the current line 
# Other .* is the state information
# 
# 2,4, may be used to do some refinements in addition to state's work,
# or, to do some common work to all states
# 
# State
# 
# A state can have one or more chars, and with fixed or variable dimension
# (of chars per state).
# Usually, a one char state is used (or at least, with fixed length),
# to easy things. If so, one can 
# . test current state 		/0$/b s0
# . change current state	s/.$/1/
# . push another state		s/$/1/
# . pop to previous state	s/.$//
# 
# At main, there are listed all possible states, jumping to their associate
# labels.
# Usually, each state should have a distinct label, perhaps named like
# "s<state>".
# 
# At each state code (code after its label), a pattern space like
# ^.*\n.*$ is received, where the first .* is line to process, and
# the last .* is the state information. Also, each state should exit
# by branching to one of these:
# . :pnext		print current line, and load next
# . :next			dont print, just collect next line
# 
# Hold buffer is kept untouch, so, it is freely available for specific use.
# 
# 20000720 aurelio's note: if speed is a problem, s/.*/[\n]*/ at the
#                          script. i've changed the filename to sm.sed


# 
# the implemented example, understands blocks of text, as non
# empty lines separated by blank ones, then delete them all (the blanks), 
# and quote 1st block with >, 2nd with :, 3r with |,
# at 4th turns to > again, on 5th :, etc... 
# 

# first state : 0
s/$/\
0/

#
# code to be ran only once, at start
# 

: main

# common init processing may come here, and operate on /^.*\n/

/0$/b s0
/1$/b s1
/2$/b s2

s/^.*\n//
s/.*/error: "&" is an invalid state/
q

##########
:s0
/^\n/{
s/.$/1/
b next
}
s/^/>/
b pnext

##########
:s1
/^\n/{
s/.$/2/
b next
}
s/^/:/
b pnext

##########
:s2
/^\n/{
s/.$/0/
b next
}
s/^/|/
b pnext

##########
:pnext
# common late processing may come here, and operate on /^.*\n/
P
:next
$b end
N
s/^\(.*\)\(\n.*\)\n\(.*\)$/\3\2/
b main

#
# code to be ran at end, only once. 
# d must be the last, if dont want to output last line (pattern space)
#

:end
d
