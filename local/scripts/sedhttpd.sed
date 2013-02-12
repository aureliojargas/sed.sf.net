#!/bin/sed -f 
#
# sedhttpd - A HyperText Transfer Protocol Daemon written in sed.
# Copyright (C) 2000 Matthew Parry 
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
s/^GET /MIME /
t GET
a\
HTTP/1.1 501 Not Implemented\
Server: sedhttpd/0.3\
Content-type: text/html\
Connection: close\
Content-length: 166\
\
<HTML>\
<HEAD>\
<TITLE>501 Not Implemented</TITLE>\
</HEAD>\
<BODY bgcolor="white">\
<H1>501 Not Implemented</H1>\
<EM>Served by sedhttpd/0.3</EM>\
<P>\
<HR>\
</BODY>\
</HTML>\

}
d
: ERROR
a\
HTTP/1.1 404 Not Found\
Server: sedhttpd/0.3\
Content-type: text/html\
Connection: close\
Content-length: 148\
\
<HTML><HEAD><TITLE>404 Not Found</TITLE></HEAD>\
<BODY bgcolor="white"><H1>404 Not Found</H1>\
<EM>Served by sedhttpd/0.3</EM>\
<P><HR>\
</BODY></HTML>
d
: MIME
/\.txt / b TXT
/\/ / b HTML
/\.html / b HTML
/\.gif / b IMG
/\.jpg / b IMG
/\.jpeg / b IMG
/\.png / b IMG
b ERROR
: TXT
a\
HTTP/1.1 200 OK\
Server: sedhttpd/0.3\
Content-type: text/plain\
Connection: close\

b GET
: HTML
a\
HTTP/1.1 200 OK\
Server: sedhttpd/0.3\
Content-type: text/html\
Connection: close\

b GET
: IMG
/\.gif / {
a\
HTTP/1.1 200 OK\
Server: sedhttpd/0.3\
Content-type: image/gif\
Connection: close\

b GET
}
/\.jpg / {
a\
HTTP/1.1 200 OK\
Server: sedhttpd/0.3\
Content-type: image/jpeg\
Connection: close\

b GET
} 
/\.jpeg / {
a\
HTTP/1.1 200 OK\
Server: sedhttpd/0.3\
Content-type: image/jpeg\
Connection: close\

b GET
}
/\.png / {
a\
HTTP/1.1 200 OK\
Server: sedhttpd/0.3\
Content-type: image/png\
Connection: close\

b GET
} 
: GET
/ \/sedhttpd\.html / {
s/^MIME / /
t MIME
r /home/mettw/public_html/sedhttpd.html
d
}
/ \/sedhttpd\.txt / {
s/^MIME / /
t MIME
r /home/mettw/public_html/sedhttpd.txt
d
}
/ \/index\.html / {
s/^MIME / /
t MIME
r /home/mettw/public_html/index.html
d
}
/ \/ / {
s/^MIME / /
t MIME
r /home/mettw/public_html/index.html
d
}
/ \/photography\/ / {
s/^MIME / /
t MIME
r /home/mettw/public_html/photography/index.html
d
}
/ \/photography\/tips-and-tricks\.html / {
s/^MIME / /
t MIME
r /home/mettw/public_html/photography/tips-and-tricks.html
d
}
/ \/photography\/nature\.html / {
s/^MIME / /
t MIME
r /home/mettw/public_html/photography/nature.html
d
}
/ \/photography\/misc\.html / {
s/^MIME / /
t MIME
r /home/mettw/public_html/photography/misc.html
d
}
/ \/photography\/cityscapes\.html / {
s/^MIME / /
t MIME
r /home/mettw/public_html/photography/cityscapes.html
d
}
/ \/photography\/img\/bg\.gif / {
s/^MIME / /
t MIME
r /home/mettw/public_html/photography/img/bg.gif
d
}
/ \/photography\/img\/monitor-correction\.gif / {
s/^MIME / /
t MIME
r /home/mettw/public_html/photography/img/monitor-correction.gif
d
}
/ \/photography\/img\/paper-3\.gif / {
s/^MIME / /
t MIME
r /home/mettw/public_html/photography/img/paper-3.gif
d
}
/ \/photography\/img\/paper\.gif / {
s/^MIME / /
t MIME
r /home/mettw/public_html/photography/img/paper.gif
d
}
/ \/photography\/img\/tn_baby-monkey\.gif / {
s/^MIME / /
t MIME
r /home/mettw/public_html/photography/img/tn_baby-monkey.gif
d
}
/ \/photography\/img\/tn_birds\.gif / {
s/^MIME / /
t MIME
r /home/mettw/public_html/photography/img/tn_birds.gif
d
}
/ \/photography\/img\/tn_bridge\.gif / {
s/^MIME / /
t MIME
r /home/mettw/public_html/photography/img/tn_bridge.gif
d
}
/ \/photography\/img\/tn_cloud\.gif / {
s/^MIME / /
t MIME
r /home/mettw/public_html/photography/img/tn_cloud.gif
d
}
/ \/photography\/img\/tn_coloured-fenn\.gif / {
s/^MIME / /
t MIME
r /home/mettw/public_html/photography/img/tn_coloured-fenn.gif
d
}
/ \/photography\/img\/tn_cowra\.gif / {
s/^MIME / /
t MIME
r /home/mettw/public_html/photography/img/tn_cowra.gif
d
}
/ \/photography\/img\/tn_eggs1\.gif / {
s/^MIME / /
t MIME
r /home/mettw/public_html/photography/img/tn_eggs1.gif
d
}
/ \/photography\/img\/tn_eggs2\.gif / {
s/^MIME / /
t MIME
r /home/mettw/public_html/photography/img/tn_eggs2.gif
d
}
/ \/photography\/img\/tn_eggs3\.gif / {
s/^MIME / /
t MIME
r /home/mettw/public_html/photography/img/tn_eggs3.gif
d
}
/ \/photography\/img\/tn_ferry\.gif / {
s/^MIME / /
t MIME
r /home/mettw/public_html/photography/img/tn_ferry.gif
d
}
/ \/photography\/img\/tn_ink-fenn\.gif / {
s/^MIME / /
t MIME
r /home/mettw/public_html/photography/img/tn_ink-fenn.gif
d
}
/ \/photography\/img\/tn_office\.gif / {
s/^MIME / /
t MIME
r /home/mettw/public_html/photography/img/tn_office.gif
d
}
/ \/photography\/img\/tn_operahouse\.gif / {
s/^MIME / /
t MIME
r /home/mettw/public_html/photography/img/tn_operahouse.gif
d
}
/ \/photography\/img\/tn_powder-fenn\.gif / {
s/^MIME / /
t MIME
r /home/mettw/public_html/photography/img/tn_powder-fenn.gif
d
}
/ \/photography\/img\/tn_rbr-fenn\.gif / {
s/^MIME / /
t MIME
r /home/mettw/public_html/photography/img/tn_rbr-fenn.gif
d
}
/ \/photography\/img\/tn_rbw-fenn\.gif / {
s/^MIME / /
t MIME
r /home/mettw/public_html/photography/img/tn_rbw-fenn.gif
d
}
/ \/photography\/img\/tn_sculpture\.gif / {
s/^MIME / /
t MIME
r /home/mettw/public_html/photography/img/tn_sculpture.gif
d
}
/ \/photography\/img\/tn_steps\.gif / {
s/^MIME / /
t MIME
r /home/mettw/public_html/photography/img/tn_steps.gif
d
}
/ \/photography\/img\/tn_sunset\.gif / {
s/^MIME / /
t MIME
r /home/mettw/public_html/photography/img/tn_sunset.gif
d
}
/ \/photography\/img\/tn_three-old-men\.gif / {
s/^MIME / /
t MIME
r /home/mettw/public_html/photography/img/tn_three-old-men.gif
d
}
/ \/photography\/img\/tn_vole\.gif / {
s/^MIME / /
t MIME
r /home/mettw/public_html/photography/img/tn_vole.gif
d
}
/ \/photography\/img\/tn_watercolour-fenn\.gif / {
s/^MIME / /
t MIME
r /home/mettw/public_html/photography/img/tn_watercolour-fenn.gif
d
}
/ \/photography\/img\/tn_window\.gif / {
s/^MIME / /
t MIME
r /home/mettw/public_html/photography/img/tn_window.gif
d
}
/ \/life\.html / {
s/^MIME / /
t MIME
r /home/mettw/public_html/life.html
d
}
/ \/logic\.html / {
s/^MIME / /
t MIME
r /home/mettw/public_html/logic.html
d
}
/ \/ethics\.html / {
s/^MIME / /
t MIME
r /home/mettw/public_html/ethics.html
d
}
/ \/chaos\.html / {
s/^MIME / /
t MIME
r /home/mettw/public_html/chaos.html
d
}
/ \/purpose\.html / {
s/^MIME / /
t MIME
r /home/mettw/public_html/purpose.html
d
}
/ \/output\.gif / {
s/^MIME / /
t MIME
r /home/mettw/public_html/output.gif
d
}
/ \/images\/graph1\.gif / {
s/^MIME / /
t MIME
r /home/mettw/public_html/images/graph1.gif
d
}
/ \/images\/graph2\.gif / {
s/^MIME / /
t MIME
r /home/mettw/public_html/images/graph2.gif
d
}
/ \/images\/graph3\.gif / {
s/^MIME / /
t MIME
r /home/mettw/public_html/images/graph3.gif
d
}
/ \/images\/graph4\.gif / {
s/^MIME / /
t MIME
r /home/mettw/public_html/images/graph4.gif
d
}
/ \/images\/graph5\.gif / {
s/^MIME / /
t MIME
r /home/mettw/public_html/images/graph5.gif
d
}
b ERROR
