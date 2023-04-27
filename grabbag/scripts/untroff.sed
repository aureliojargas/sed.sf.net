#! /bin/sed -f

# Remove overstrikes produced by troff, replacing them with
# *...* and _..._ which are suitable, for example, for
# enclosing man page extracts in source code.

# Converting backspaces to degree signs makes it easier to
# look at the sed script with less.
y//°/
h

# --------------------------- first part, underlines

/°/!b justify
/_°./!b bold

# Add a _ at the beginning of underlined sequences
# \1 is a non-underlined character in the second regexp
s/^_°./_&/g
s/\([^°].\)\(_°.\)/\1_\2/g

# Remove the underlining sequence from all the characters
# but the last
:rem_
s/_°\(.\)\(_°.\)/\1\2/
t rem_

# Remove the underlining sequence from the last character
# too, and add a _ after it.
s/_°\(.\)/\1_/g

# --------------------------- second part, boldfaces

/°/!b finish

:bold

# Add a * at the beginning of boldfaced sequences
# \1 is a non-boldfaced character in the second regexp
s/^\(.\)°\1/*&/g
s/\([^°].\)\(.\)°\2/\1*\2°\2/g

# Remove the boldfacing sequence from all the characters
# but the last
:rembold
s/\(.\)°\1\(.\)°\2/\1\2°\2/
t rembold

# Remove the boldfacing sequence from the last character
# too, and add a * after it.
s/\(.\)°\1/\1*/g

# --------------------------- finishing touches...

# *as*(*1*) --> *as(1)*
s/\*\([a-zA-Z0-9]*\)\*(\*\([a-zA-Z0-9]*\)\*)/*\1(\2)*/g

:finish

# _abc_ _def_ ---> _abc def_
# *abc* *def* ---> *abc def*
#     ^^^
s/\([*_]\)\( \+\)\1/\2/g

# Re-align TP paragraphs whose first line would be mis-aligned.
/^       [*_]/ {
  s/\(       [*_].[*_]    \)  /\1/
  s/\(       [*_]..[*_]   \)  /\1/
  s/\(       [*_]...[*_]  \)  /\1/
  s/\(       [*_]....[*_] \)  /\1/
}

# ---------------------------- third part, justification

:justify

# In hold space, remove the sequences the easy way.  If the
# line was not 65 characters long, we're done.
x
s/.°\(.\)/\1/g
/^.\{65\}$/!{ x; b; }
x

# We had a 65 characters long line.  Re-justify it to
# 71 chars per line, to compensate for the *'s and _'s we
# introduced

# No spaces apart from the left margin? If so, nothing to do.
/^ *[^ ]* /!b

# If the line is too long, shorten it.  This is a rare
# case (>3 bold-faces or underlines), so don't go to great
# lengths to ensure uniform spacing (like we do below).
:reduce
/^.\{72\}/ {
  s/^\( *[^ ].* \) /\1/
  t reduce
}

:widen
/^.\{71\}/!{

  # Add a tilde (i.e. another space) before the last group of spaces
  # in the line.  The `^ *[^ ]' in the regexp makes sure that the
  # left margin is not touched.
  s/^\( *[^ ].*\)\( \+\)/\1°\2/
  t tilde

  # If not found, restart from the end of the line.
  y/°/ /
  b widen

  # Change the group of spaces to tildes.
  :tilde
  s/° /°°/
  t tilde
  b widen
}

# The line is long enough; we still have to convert tildes back to spaces
y/°/ /
