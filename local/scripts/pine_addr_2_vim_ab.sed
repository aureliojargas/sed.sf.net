# Format .addressbook to vim abbrevations
:redo;	# Define label redo
$s/\([^	]*\)	[^	]*	\([^	]*\).*/ab mm\1 \2\3/
N;
/\n   /!{
  s/\([^	]*\)	[^	]*	\([^	]*\)[^\n]*\(\n\)/ab mm\1 \2\3/
  P
  D
}
s/\n//g
s/   *//g
b redo;
