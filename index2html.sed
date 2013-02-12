#!/usr/bin/sed -f
# index2html.sed - by Aurelio Jargas
#   Get index.sed file and converts it to the main http://sed.sf.net page
#

1i\
<html><head><title>sed.sf.net - The sed $HOME</title></head>\
<meta http-equiv="content-type" content="text/html; charset=utf-8">\
<body bgcolor="#ffffbb" text="black">\
<pre>

:ini
$b end

# /.../ b address -> title big bold
\!^\([[:blank:]]*\)\(/\)\(.*\)\(/[[:blank:]]*b[[:blank:]]\{1,\}\)! s,,\1\2<font size=6><b>\3</b></font>\4,


### HTMLize links:
#
# The link format is @[name|id]@, which converts to <a href="URL">name</a>.
# The id points to the link URL, the "database" is at the end of this file.
#
# If name is '-', the id string will be used as the name.
# If name is '=', the URL will be used as the name.
# If id starts with @, the id (except the @) will be considered a URL.
#
# Examples:
#
#     @[click here|example]@         =>  <a href="http://example.com">click here</a>
#     @[click here|@local/foo.sed]@  =>  <a href="local/foo.sed">click here</a>
#
#     The first link will get its URL from the 'example' id in the database.
#     The second link informs a relative URL: local/foo.sed.
#
#     @[-|example]@  =>  <a href="http://example.com">example</a>
#     @[=|example]@  =>  <a href="http://example.com">http://example.com</a>
#
#     The difference of using - or = as the link name.
#
\,@\[.*]@,{
  # link name == link label
  s,@\[-|\([^]]*\)]@,@[\1|\1]@,g

  :link
  /@\[[^|]*|[^@]/{
    # get the label of the last @[...]@
    h
    s,.*@\[[^|]*|\([^@][^]]*\)]@.*,\1,
    b getlink

    :url
    # put the url of the last @[...]@ on it's place
    G
    s,\(.*\)\n\(.*\)\(@\[[^|]*|\)[^@][^]]*]@,\2\3@\1]@,

    # there is more?
    b link
  }

  # convert all @[=|http:...]@ to @[http:...|http:...]@
  s,@\[=|@\([^]]*\)]@,@[\1|@\1]@,g

  # make html tags for all
  s,@\[\([^|]*\)|@\([^]]*\)]@,<a href="\2">\1</a>,g
}

# // address -> bold
\,^[[:blank:]]*/[^/].*/,{
  # author!
  s= by [[:alpha:]][^/]\{1,\}=<i>&</i>=
  s=^\([[:blank:]]*\)/\([^/<]*\)=\1/<b>\2</b>=
}

# author!
s| by [[:alpha:]é,. ?-]\{1,\}$|<i>&</i>|

# branch -> anchor link
/\( b[[:blank:]]\)\([^[:blank:]]\{1,\}\)/ s,,\1<a href="#\2">\2</a>,

# label -> subtitle
/^\([[:blank:]]*\):[[:blank:]]*\([^[:blank:]]\{1,\}\)/ s,,<a name="\2"><font size=4><b><i>&</i></b></font></a>,

# link it!
#\|\<\(\(https\{0,1\}\|ftp\|news\|telnet\|gopher\|wais\)://\|\(www[23]\{0,1\}\.\|ftp\.\)\)[A-Za-z0-9%._/~:,-]\{1,\}\(#[A-Za-z0-9%.-]\{1,\}\|?[A-Za-z0-9%&=+.@*_-]\{1,\}\)\{0,1\}\>| s,,<a href="&">&</a>,g
#\|<\?\<[A-Za-z0-9_.-]\{1,\}@\([A-Za-z0-9_-]\{1,\}\.\)\{1,\}[A-Za-z]\{1,\}\>>\?| s,,<a href="mailto:&">&</a>,g

# escape & in book names
s/ & / \&amp; /g

:end
$a\
</pre></body></html>
$q

n
b ini


:getlink
t resett
:resett
#download
s|^GNU sed v3.02.80 source code$|ftp://alpha.gnu.org/pub/gnu/sed/sed-3.02.80.tar.gz|; t url
s|^GNU sed v3.02.80 for Linux (RPM)$|http://aurelio.net/sed/sed-3.02.80-4cl.i386.rpm|; t url
s|^GNU sed v3.02.80 for OS2$|http://www2s.biglobe.ne.jp/~vtgf3mpr/gnu/sed.htm|; t url
s|^GNU sed v3.02.80 for Windows (3x, 9x, NT, 2K)$|http://www.student.northpark.edu/pemente/sed/sed3028a.zip|; t url
s|^GNU sed v3.02 for HPUX$|http://hpux.connect.org.uk/hppd/hpux/Gnu/sed-3.02|; t url
s|^GNU sed v4.x source code$|ftp://ftp.gnu.org/gnu/sed|; t url
s|^HHsed v1.5 source code (Turbo C)$|http://www.student.northpark.edu/pemente/sed/sed15.zip|; t url
s|^HHsed v1.5 for MS-DOS$|http://www.student.northpark.edu/pemente/sed/sed15x.zip|; t url
s|^HHsed v1.5 for Windows$|http://www.student.northpark.edu/pemente/sed/sed15exe.zip|; t url
s|^super sed v3.60 source code$|http://sed.sf.net/grabbag/ssed/sed-3.60.tar.gz|; t url
s|^super sed v3.59 for Windows$|http://sed.sf.net/grabbag/ssed/sed-3.59.zip|; t url
s|^Complete list of available versions$|http://sed.sourceforge.net/sedfaq2.html#s2.2|; t url
#doc
s|^THE SED FAQ$|http://sed.sf.net/sedfaq.html|; t url
s|^SED FAQ$|http://www.dreamwvr.com/sed-info/sed-faq.html|; t url
s|^The sed one-liners$|http://sed.sf.net/sed1line.txt|; t url
s|^GNU sed info$|http://directory.fsf.org/sed.html|; t url
s|^The sed man page$|http://www.opengroup.org/onlinepubs/7908799/xcu/sed.html|; t url
s|^sed, a stream editor$|http://www.gnu.org/software/sed/manual/html_mono/sed.html|; t url
s|^Sed by example, Part 1$|http://www-106.ibm.com/developerworks/linux/library/l-sed1.html|; t url
s|^Do it with sed$|http://sed.sf.net/grabbag/tutorials/do_it_with_sed.txt|; t url
s|^A small tutorial about sed$|http://www.math.fu-berlin.de/~leitner/sed/tutorial.html|; t url
s|^An introduction to sed$|http://www.cs.hmc.edu/tech_docs/qref/sed.html|; t url
s|^A Non-interactive Text Editor$|http://sed.sf.net/grabbag/tutorials/sed_mcmahon.txt|; t url
s|^Introduction to Unix's SED editor$|http://psr.rice.edu/sed.html|; t url
s|^Tips on using sed on MS-DOS$|http://users.cybercity.dk/~bse26236/batutil/help/SED.HTM#sed|; t url
s|^Using sed to create a book index$|http://www.student.northpark.edu/pemente/sed/bookindx.txt|; t url
s|^Doing if/elseif/else with sed$|http://www.student.northpark.edu/pemente/sed/ifelse.txt|; t url
s|^Example of state machine in sed$|http://aurelio.net/sed/programas/sm.sed|; t url
s|^Program state in sed$|http://sed.sf.net/grabbag/tutorials/sed_state.txt|; t url
s|^Using lookup tables with s///$|http://sed.sf.net/grabbag/tutorials/lookup_tables.txt|; t url
s|^A lookup-table counter$|http://sed.sf.net/grabbag/tutorials/lookup_table_counter.txt|; t url
s|^How to count words$|http://sed.sf.net/grabbag/tutorials/greg_wc.txt|; t url
s|^How add numbers$|http://sed.sf.net/grabbag/tutorials/greg_add.txt|; t url
s|^Analyzing a sed SQL interpreter$|http://www.dbnet.ece.ntua.gr/~george/sed/OLD/sedql.html|; t url
s|^Graphical sed (state diagram)$|http://www.dbnet.ece.ntua.gr/~george/sed/OLD/sed.logic.txt|; t url
s|^Sed in (pseudo) microcode$|http://www.dbnet.ece.ntua.gr/~george/sed/OLD/sed-microcode.html|; t url
s|^Proposal of a custom sed$|http://www.ptug.org/sed/custom_sed.html|; t url
s|^Netscape frame-free with sed$|ftp://ftp.sgi.com/sgi/graphics/grafica/framefree/sed.html|; t url
s|^SED emulating UNIX commands$|http://sed.sf.net/local/docs/emulating_unix.txt|; t url
s|^sed-HOWTO (in portuguese)$|http://aurelio.net/sed/sed-HOWTO/|; t url
#books
s|^Sed & Awk, 2nd ed.$|http://shop.oreilly.com/product/9781565922259.do|; t url
s|^Sed & Awk Pocket Reference$|http://shop.oreilly.com/product/9781565927292.do|; t url
s|^Unix Awk and Sed Programmer's Interactive Workbook$|http://cwx.prenhall.com/patsis/|; t url
s|^Awk und Sed$|http://www.addison-wesley.de/main/main.asp?page=home/bookdetails\&ProductID=37214|; t url
s|^Mastering Regular Expressions, 3rd ed.$|http://regex.info/book.html|; t url
s|^Definitive Guide to sed$|http://www.sed-book.com/|; t url
#scripts
s|^add_decs.sed$|http://sed.sf.net/grabbag/scripts/add_decs.sed|; t url
s|^anagrams.sed$|http://sed.sf.net/grabbag/scripts/anagrams.sed|; t url
s|^bf2c.sed$|http://sed.sf.net/grabbag/scripts/bf2c.sed|; t url
s|^brainf__k.sed$|http://www.edwardrosten.com/code/sed/brainf__k.sed|; t url
s|^bre2ere.sed$|http://sed.sf.net/local/scripts/bre2ere.sed|; t url
s|^cal.sh.txt$|http://sed.sf.net/grabbag/scripts/cal.sh.txt|; t url
s|^cal-year.sh.txt$|http://sed.sf.net/grabbag/scripts/cal-year.sh.txt|; t url
s|^cat-b.sed$|http://sed.sf.net/grabbag/scripts/cat-b.sed|; t url
s|^cat-b.sh.txt$|http://sed.sf.net/grabbag/scripts/cat-b.sh.txt|; t url
s|^cat-n.sed$|http://sed.sf.net/grabbag/scripts/cat-n.sed|; t url
s|^cat-n.sh.txt$|http://sed.sf.net/grabbag/scripts/cat-n.sh.txt|; t url
s|^cat-s.sed$|http://sed.sf.net/grabbag/scripts/cat-s.sed|; t url
s|^centre_1.sed$|http://sed.sf.net/grabbag/scripts/centre_1.sed|; t url
s|^centre_2.sed$|http://sed.sf.net/grabbag/scripts/centre_2.sed|; t url
s|^cflword1.sed$|http://sed.sf.net/grabbag/scripts/cflword1.sed|; t url
s|^cflword2.sed$|http://sed.sf.net/grabbag/scripts/cflword2.sed|; t url
s|^cflword3.sed$|http://sed.sf.net/grabbag/scripts/cflword3.sed|; t url
s|^cflword4.sed$|http://sed.sf.net/grabbag/scripts/cflword4.sed|; t url
s|^cflword5.sed$|http://sed.sf.net/grabbag/scripts/cflword5.sed|; t url
s|^cgrep.sh.txt$|http://sed.sf.net/grabbag/scripts/cgrep.sh.txt|; t url
s|^commify1.sed$|http://sed.sf.net/grabbag/scripts/commify1.sed|; t url
s|^commify2.sed$|http://sed.sf.net/grabbag/scripts/commify2.sed|; t url
s|^commify3.sed$|http://sed.sf.net/grabbag/scripts/commify3.sed|; t url
s|^config.sed$|http://sed.sf.net/grabbag/scripts/config.sed|; t url
s|^crlf.tar.gz$|http://sed.sf.net/grabbag/scripts/crlf.tar.gz|; t url
s|^dc.sed$|http://sed.sf.net/grabbag/scripts/dc.sed|; t url
s|^diffhtml.sed$|http://www.bitterberg.de/tilmann/diffhtml.sed|; t url
s|^dtree.sh.txt$|http://sed.sf.net/grabbag/scripts/dtree.sh.txt|; t url
s|^expand.sed$|http://sed.sf.net/grabbag/scripts/expand.sed|; t url
s|^fbasename.sed$|http://sed.sf.net/grabbag/scripts/fbasename.sed|; t url
s|^fdirname.sed$|http://sed.sf.net/grabbag/scripts/fdirname.sed|; t url
s|^fmt.sed$|http://sed.sf.net/grabbag/scripts/fmt.sed|; t url
s|^get_html_title.sed$|http://sed.sf.net/grabbag/scripts/get_html_title.sed|; t url
s|^hbanner.sed$|http://sed.sf.net/grabbag/scripts/hbanner.sed|; t url
s|^head.sed$|http://sed.sf.net/grabbag/scripts/head.sed|; t url
s|^html2iso.sed$|http://sed.sf.net/grabbag/scripts/html2iso.sed|; t url
s|^html_lc.sed$|http://sed.sf.net/grabbag/scripts/html_lc.sed|; t url
s|^html_uc.sed$|http://sed.sf.net/grabbag/scripts/html_uc.sed|; t url
s|^impossible.sed$|http://sed.sf.net/local/scripts/impossible.sed|; t url
s|^incr_num.sed$|http://sed.sf.net/grabbag/scripts/incr_num.sed|; t url
s|^indentls.sed$|http://sed.sf.net/grabbag/scripts/indentls.sed|; t url
s|^indexer.sed$|http://sed.sf.net/grabbag/scripts/indexer.sed|; t url
s|^indexhtml.sed$|http://www.bitterberg.de/tilmann/indexhtml.sed|; t url
s|^iso2html.sed$|http://sed.sf.net/grabbag/scripts/iso2html.sed|; t url
s|^italbold.sed$|http://sed.sf.net/grabbag/scripts/italbold.sed|; t url
s|^joinfile.sed$|http://sed.sf.net/grabbag/scripts/joinfile.sed|; t url
s|^justify.sed$|http://aurelio.net/sed/programas/justify.sed|; t url
s|^list_urls.sed$|http://sed.sf.net/grabbag/scripts/list_urls.sed|; t url
s|^mail-iso2txt.sed$|http://aurelio.net/sed/programas/mail-iso2txt.sed|; t url
s|^maketarg.sed$|http://sed.sf.net/grabbag/scripts/maketarg.sed|; t url
s|^masm2gas.sed$|http://sed.sf.net/grabbag/scripts/masm2gas.sed|; t url
s|^overstrk.sed$|http://sed.sf.net/local/scripts/overstrk.sed|; t url
s|^palindrome.sed$|http://laurent.le-brun.eu/pub/palindrome.sed|; t url
s|^pine_addr_2_vim_ab.sed$|http://www.bitterberg.de/tilmann/pine_addr_2_vim_ab.sed|; t url
s|^polish.html$|http://www.agsm.unsw.edu.au/~bobm/odds+ends/scripts/polish.html|; t url
s|^remccoms1.sed$|http://sed.sf.net/grabbag/scripts/remccoms1.sed|; t url
s|^remccoms2.sh.txt$|http://sed.sf.net/grabbag/scripts/remccoms2.sh.txt|; t url
s|^remccoms3.sed$|http://sed.sf.net/grabbag/scripts/remccoms3.sed|; t url
s|^revchr_1.sed$|http://sed.sf.net/grabbag/scripts/revchr_1.sed|; t url
s|^revchr_2.sed$|http://sed.sf.net/grabbag/scripts/revchr_2.sed|; t url
s|^revlines.sed$|http://sed.sf.net/grabbag/scripts/revlines.sed|; t url
s|^rot13.sed$|http://sed.sf.net/grabbag/scripts/rot13.sed|; t url
s|^sedhttpd.sed$|http://awk.geht.net:8080/contrib/sedhttpd/sedhttpd0.2.txt|; t url
s|^sm.sed$|http://aurelio.net/sed/programas/sm.sed|; t url
s|^sodelnum.sed$|http://sed.sf.net/grabbag/scripts/sodelnum.sed|; t url
s|^splitdig.sed$|http://sed.sf.net/grabbag/scripts/splitdig.sed|; t url
s|^strip_html_comments.sed$|http://sed.sf.net/grabbag/scripts/strip_html_comments.sed|; t url
s|^subwords.sed$|http://sed.sf.net/grabbag/scripts/subwords.sed|; t url
s|^tex2xml.sed$|http://sed.sf.net/grabbag/scripts/tex2xml.sed|; t url
s|^tolower2.sed$|http://sed.sf.net/grabbag/scripts/tolower2.sed|; t url
s|^tolower.sed$|http://sed.sf.net/grabbag/scripts/tolower.sed|; t url
s|^toupper2.sed$|http://sed.sf.net/grabbag/scripts/toupper2.sed|; t url
s|^turing.sed$|http://sed.sf.net/grabbag/scripts/turing.sed|; t url
s|^txt2html.sed$|http://sed.sf.net/grabbag/scripts/txt2html.sed|; t url
s|^undblspc.sed$|http://sed.sf.net/grabbag/scripts/undblspc.sed|; t url
s|^unlambda.sed$|ftp://quatramaran.ens.fr/pub/madore/unlambda/contrib/unlambda.sed|; t url
s|^untroff.sed$|http://sed.sf.net/grabbag/scripts/untroff.sed|; t url
s|^yahoogroups-kill-sig.sed$|http://aurelio.net/sed/programas/yahoogroups-kill-sig.sed|; t url
#games
s|^99 green bottles$|http://www.edwardrosten.com/code/sed/99-green-bottles.sed|; t url
s|^tic tac toe$|http://www-jcsu.jesus.cam.ac.uk/~gsb29/sedgames.html|; t url
s|^pong (1 player)$|http://www-jcsu.jesus.cam.ac.uk/~gsb29/sedgames.html|; t url
s|^pong (2 players)$|http://www-jcsu.jesus.cam.ac.uk/~gsb29/sedgames.html|; t url
s|^sokoban$|http://aurelio.net/sed/sokoban/sokoban.sed|; t url
s|^arkanoid$|http://aurelio.net/bin/sed/arkanoid/arkanoid.sed|; t url
s|^towers of hanoi$|http://sed.sf.net/grabbag/tutorials/hanoi.htm|; t url
s|^my mastermind$|http://laurent.le-brun.eu/pub/sedermind.sed|; t url
s|^puzzle$|http://laurent.le-brun.eu/pub/puzzle.sed|; t url
s|^path solver$|http://laurent.le-brun.eu/pub/path.sed|; t url
s|^connect4$|http://laurent.le-brun.eu/pub/connect4.sed|; t url
s|^sudoku solver$|http://www.edwardrosten.com/code/sed/sedoku.sed|; t url

#tools
s|^sd$|http://sed.sf.net/grabbag/scripts/sd.sh.txt|; t url
s|^sdk$|http://www.student.northpark.edu/pemente/sed/sd.ksh.txt|; t url
s|^sedsed$|http://aurelio.net/projects/sedsed/|; t url
s|^sedcheck$|http://lvogel.free.fr/sed/sedcheck.sed|; t url
s|^bsed$|http://www.cskk.ezoshosting.com/cs/css/bin/bsed|; t url
s|^mod_sed$|http://www.happygiraffe.net/mod_sed.html|; t url
s|^csed$|http://colorifer.sourceforge.net|; t url
#ml
s|^sed-users$|http://groups.yahoo.com/group/sed-users/|; t url
s|^sed-br$|http://br.groups.yahoo.com/group/sed-br/|; t url
#users
s|^Aurelio Jargas$|http://aurelio.net/sed/|; t url
s|^Eric Pement$|http://www.student.northpark.edu/pemente/sed/|; t url
s|^Laurent Le Brun$|http://laurent.le-brun.eu/geek|; t url
s|^Tilmann Bitterberg$|http://www.bitterberg.de/tilmann/sed-en.html|; t url
s|^Paolo Bonzini$|http://sed.sf.net/grabbag/|; t url
s|^Felix von Leitner$|http://www.math.fu-berlin.de/~leitner/sed/|; t url
s|^Yiorgos Adamopoulos$|http://www.dbnet.ece.ntua.gr/~george/sed/OLD/|; t url
s|^Yao-Jen Chang$|http://main.rtfiber.com.tw/~changyj/sed/|; t url
#end
s|^sedindex2html$|http://sed.sf.net/index2html.sed.html|; t url
s|^github$|https://github.com/aureliojargas/sed-website|; t url

b url
