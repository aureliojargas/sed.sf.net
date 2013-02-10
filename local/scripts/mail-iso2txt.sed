#!/bin/sed -f
# mail-iso2txt.sed  -  20000906 <aurelio@verde666.org>
#   convert the email encoded chars =xx to the right hexa char
#
# ps.: needs GNU sed >= 3.02.80 because the s//\xnn/ notation

s|=09|\x09|g
s|=20|\x20|g
s|=B7|\xb7|g
s|=BA|\xba|g
s|=C1|\xc1|g
s|=C2|\xc2|g
s|=C3|\xc3|g
s|=C4|\xc4|g
s|=C5|\xc5|g
s|=C6|\xc6|g
s|=C7|\xc7|g
s|=C8|\xc8|g
s|=C9|\xc9|g
s|=CA|\xca|g
s|=CB|\xcb|g
s|=CC|\xcc|g
s|=CD|\xcd|g
s|=CE|\xce|g
s|=CF|\xcf|g
s|=D7|\xd7|g
s|=E1|\xe1|g
s|=E2|\xe2|g
s|=E3|\xe3|g
s|=E4|\xe4|g
s|=E5|\xe5|g
s|=E6|\xe6|g
s|=E7|\xe7|g
s|=E8|\xe8|g
s|=E9|\xe9|g
s|=EA|\xea|g
s|=EB|\xeb|g
s|=EC|\xec|g
s|=ED|\xed|g
s|=EE|\xee|g
s|=EF|\xef|g
s|=F1|\xf1|g
s|=F2|\xf2|g
s|=F3|\xf3|g
s|=F4|\xf4|g
s|=F5|\xf5|g
s|=F6|\xf6|g
s|=F7|\xf7|g
s|=F8|\xf8|g
s|=F9|\xf9|g
s|=FA|\xfa|g
s|=FB|\xfb|g
s|=FC|\xfc|g
s|=$||g

