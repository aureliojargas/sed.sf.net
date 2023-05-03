#! /bin/sed -f

# This is an alternative approach to summing numbers,
# which works a digit at a time and hence has unlimited
# precision

G
s/\n/-/
s/$/-/

:loop
/[0-9a]-/ {
  s/9-/aaaaaaaaa-/g
  s/8-/aaaaaaaa-/g
  s/7-/aaaaaaa-/g
  s/6-/aaaaaa-/g
  s/5-/aaaaa-/g
  s/4-/aaaa-/g
  s/3-/aaa-/g
  s/2-/aa-/g
  s/1-/a-/g
  s/0-/-/g

  # Put the two groups of letters together
  s/\(a*\)-\([^a]*\)\(a*\)-/-\2-\1\3/

  # To handle carry, we change ten a's to a single a
  # before the minus, to be added on the next iteration
  s/\([0-9]\?-.*\)aaaaaaaaaa/a\1/
  /-a/ !s/\(.*\)-/\1-0/
  s/-aaaaaaaaa/-9/
  s/-aaaaaaaa/-8/
  s/-aaaaaaa/-7/
  s/-aaaaaa/-6/
  s/-aaaaa/-5/
  s/-aaaa/-4/
  s/-aaa/-3/
  s/-aa/-2/
  s/-a/-1/
  b loop
}

s/^--//
h
