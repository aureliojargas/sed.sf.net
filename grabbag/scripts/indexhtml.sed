#! /sed -f
# Thu May 18 12:43:45 2000 by tilmann@bitterberg.de
# Changed Mon Feb 26 12:34:19 2000 by bonzini@gnu.org (removed
# limitations on the number of links)
#
# Description:
# Creates an index of links from a HTML file
# Does something similar like lynx -force_html -dump but
# leaves the document html (generate an index of links)
# 
# Example: Input
# <HTML><HEAD></HEAD><BODY>
# foo1 <a Href="http://link.org">Click here</a> foo2
# </BODY></HTML>
#
# Output:
# <HTML><HEAD></HEAD><BODY>
# foo1 <a href="http://link.org">[1] Click here</a> foo2
# <hr>[1] http://link.org<br>
# </BODY></HTML>
# 
# NOTE:
# 1) Will break at links like <A 
#                                HREF
# TODO:
# - let it handle weird HTML syntax

# Simplify the rest by assuming A tags are lowercase
s/<[ 	]*[Aa][ 	]*[Hh][Rr][Ee][Ff]/<a href/g

# there may be multiple links per line, so loop
:loop
/<a href *= *"[^#]/{;  # don't look at internal links
  x;     # Get the number and do black magic to increment it
  s/[^\n]*/&;9876543210 999990000099990000999000990090;/
  s/\([0-8]\{0,1\}\)\(9*\);[^1]*\(.\)\1[^;]*\2\(0*\)[^;]*;\(.*\)/\3\4\5/
  x;
  G;

  # the ||||| is used as a marker.
  # We now have: foo1 <a href="blah.html"> foo2\n397\nPREVIOUS ENTRIES
  # using newline as separator to the 's' command
  s
<a href *= *\("\([^"]\+\)"[^>]*>\)\([^\n]*\(\n\)\)\([^\n]*\)\(.*$\)
<||||||=\1[\5] \3\5\4\6\4[\5] \2<br>

  #         |----------1---------||-------3------| |---5---||--6--|
  #            |---2----|                 |--4-|    
  # Field Contains:
  # \1    the link text up to the closing >
  # \2    the link itself (http://foo.com)
  # \3    the rest of the input line
  # \4    a newline (\n)
  # \5    the number we would like to use
  # \6    everything up to the end of patternspace (i.e. the previous entries)
  #                       
  # Now the line looks like:
  # foo1 <||||||="blah.html">[1] foo2\n1\n[1] blah.html<br>

  h;                     # save the new entry and the updated counter
  s/[^\n]*\n//           # remove the HTML line from hold space
  x
  s/\n.*//               # remove what went in hold space from pattern space

  b loop;        	 # look if there is another link in that line
}

s/<||||||/<a href/g;   # "restore" the original line in pattern space

# Just before the </body> insert index
/<\/[Bb][Oo][Dd][Yy]>/{
  G			# insert saved stuff
  s/\(<\/[Bb][Oo][Dd][Yy]>[^\n]*\)\n[^\n]*\n*\(.*\)/<hr>\2\1/;
}
