#!/bin/sed -f 
#
# sedhttpd - A HyperText Transfer Protocol Daemon written in sed.
# Copyright (C) 2000 Matthew Parry <mettw@bowerbird.com.au>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#
1 {
s/^GET //
t GET
a\
HTTP/1.1 501 Not Implemented\
Server: sedhttpd/0.2\
Content-type: text/html\
Connection: close\
\
<HTML>\
<HEAD>\
<TITLE>501 Not Implemented</TITLE>\
</HEAD>\
<BODY bgcolor="white">\
<H1>501 Not Implemented</H1>\
<EM>Served by sedhttpd/0.2</EM>\
<P>\
<HR>\
</BODY>\
</HTML>\

}
d
: GET
/\/ / b HTML
/\.html / b HTML
/\.gif / b IMG
/\.jpg / b IMG
/\.jpeg / b IMG
/\.png / b IMG
: HTML
a\
HTTP/1.1 200 OK\
Server: sedhttpd/0.2\
Content-type: text/html\
Connection: close\

b SERVEDFILES
: IMG
/\.gif / {
a\
HTTP/1.1 200 OK\
Server: sedhttpd/0.2\
Content-type: image/gif\
Connection: close\

b SERVEDFILES
}
/\.jpg /,/\.jpeg / {
a\
HTTP/1.1 200 OK\
Server: sedhttpd/0.2\
Content-type: image/jpeg\
Connection: close\

b SERVEDFILES
} 
/\.png / {
a\
HTTP/1.1 200 OK\
Server: sedhttpd/0.2\
Content-type: image/png\
Connection: close\

b SERVEDFILES
} 
: SERVEDFILES
/^\/index\.html /{
r /home/mettw/public_html/index.html
d
}
/^\/ / {
r /home/mettw/public_html/index.html
d
}
/^\/photography\/ / {
r /home/mettw/public_html/photography/index.html
d
}
/^\/images\/graph5\.gif / {
r /home/mettw/public_html/images/graph5.gif
d
}
