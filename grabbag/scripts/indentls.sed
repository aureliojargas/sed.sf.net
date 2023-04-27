#! /bin/sed -f

# Put the indentation in hold space
/:$/ {
  h
  s,\.:,,
  s,[^/:]*[/:],  ,g
  x
}

# Add the indentation in front of the line
G
s:\(.*\)\n\(.*\):\2\1:
