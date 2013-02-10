#n

1 i\
                                                                       \
                      (( Welcome to sed.sf.net ))                      \
                           - the SED $HOME -                           \
                                                                       \
       BEWARE! Boring man page description on the way:                 \
                                                                       \
       Sed  is  a stream editor.  A stream editor is used to per-      \
       form basic text transformations on an input stream (a file      \
       or  input from a pipeline).  While in some ways similar to      \
       an editor which permits scripted edits (such as  ed),  sed      \
       works by  making only one  pass over  the input(s), and is      \
       consequently  more efficient.  But it is sed's  ability to      \
       filter text in a pipeline which particularly distinguishes      \
       it from other types of editors.                                 \
                                                                       \
       See all the links below or browse the @[local mirror|@local]@.             \
                                                                       \
       Please report broken links to: verde (a) aurelio net.           \


/ DOWNLOAD      / b download
/ DOCUMENTATION / b docs
/ BOOKS         / b books
/ SCRIPTS       / b scripts
/ GAMES         / b gamez
/ TOOLS         / b tools
/ MAILING LIST  / b mailing
/ SEDLOVERS     / b sedlovers


########################################################################

:download

/  sed is available for various systems  /{

r  + @[-|GNU sed v4.x source code]@ by Paolo Bonzini
r  + @[-|GNU sed v3.02.80 source code]@ by Ken Pizzini
r  + @[-|GNU sed v3.02.80 for Linux (RPM)]@
r  + @[-|GNU sed v3.02.80 for OS2]@
r  + @[-|GNU sed v3.02.80 for Windows (3x, 9x, NT, 2K)]@
r  + @[-|GNU sed v3.02 for HPUX]@
r  + @[-|HHsed v1.5 source code (Turbo C)]@ by Howard Helman
r  + @[-|HHsed v1.5 for MS-DOS]@ by Howard Helman
r  + @[-|HHsed v1.5 for Windows]@ by Howard Helman
r  + @[-|super sed v3.60 source code]@ by Paolo Bonzini
r  + @[-|super sed v3.59 for Windows]@ by Paolo Bonzini
r  + @[-|Complete list of available versions]@ by Eric Pement
}

########################################################################

:docs

/  you must read these docs to understand the sed world  /{

r                       @[-|THE SED FAQ]@ by Eric Pement
r                           @[-|SED FAQ]@ by DREAMWVR.COM
r                @[-|The sed one-liners]@ by Eric Pement
r                      @[-|GNU sed info]@ by FSF
r                  @[-|The sed man page]@ by The Open Group
r              @[-|sed, a stream editor]@ by Ken Pizzini
r            @[-|Sed by example, Part 1]@ by Daniel Robbins
r                    @[-|Do it with sed]@ by Carlos Jorge G. Duarte
r            @[-|An introduction to sed]@ by Andrew M. Ross
r     @[-|A Non-interactive Text Editor]@ by Lee E. McMahon
r @[-|Introduction to Unix's SED editor]@ by F. Curtis Michel
r       @[-|Tips on using sed on MS-DOS]@ by Benny Pedersen
r  @[-|Using sed to create a book index]@ by Eric Pement
r     @[-|Doing if/elseif/else with sed]@ by Eric Pement
r   @[-|Example of state machine in sed]@ by Carlos Jorge G. Duarte
r              @[-|Program state in sed]@ by Greg Ubben
r     @[-|Using lookup tables with s///]@ by Greg Ubben
r            @[-|A lookup-table counter]@ by Greg Ubben
r                @[-|How to count words]@ by Greg Ubben
r                   @[-|How add numbers]@ by Greg Ubben
r   @[-|Analyzing a sed SQL interpreter]@ by Simon Taylor
r     @[-|Graphical sed (state diagram)]@ by Al Aab
r         @[-|Sed in (pseudo) microcode]@ by Carlos Jorge G. Duarte
r          @[-|Proposal of a custom sed]@ by Simon Taylor
r      @[-|Netscape frame-free with sed]@ by Paul Haeberli
r       @[-|SED emulating UNIX commands]@ by Aurelio Marinho Jargas
r         @[-|sed-HOWTO (in portuguese)]@ by Aurelio Marinho Jargas
}

########################################################################

:books

/  sed is also available on paper  /{

r   @[-|Sed & Awk, 2nd ed.]@
r      by Dougherty, Dale and Robbins, Arnold
r      from Oreilly & Associates, ISBN 1-56592-225-5
r   @[-|Sed & Awk Pocket Reference]@
r      by Robbins, Arnold
r      from Oreilly & Associates, ISBN 1-56592-729-X
r   @[-|Unix Awk and Sed Programmer's Interactive Workbook]@
r      by Patsis, Peter
r      from Prentice Hall Computer Books, ISBN 0130826758
r   @[-|Awk und Sed]@
r      by Helumt Herold
r      from Addison-Wesley (written in german), ISBN 3-8273-2094-1
r   @[-|Mastering Regular Expressions, 2nd ed.]@
r      by Jeffrey E. F. Friedl
r      from O'Reilly & Associates, ISBN 0-596-00289-0
}

########################################################################

:scripts

/  it's sed art  /{

r                @[add_decs|add_decs.sed]@ [@[colored|@local/scripts/add_decs.sed.html]@] by Paolo Bonzini
r                @[anagrams|anagrams.sed]@ [@[colored|@local/scripts/anagrams.sed.html]@] by Paolo Bonzini
r                    @[bf2c|bf2c.sed]@ [@[colored|@local/scripts/bf2c.sed.html]@] by Graham Bell
r               @[brainf__k|brainf__k.sed]@ [@[colored|@local/scripts/brainf__k.sed.html]@] by Edward Rosten
r                 @[bre2ere|bre2ere.sed]@ [@[colored|local/scripts/bre2ere.sed.html]@] by Laurent Vogel
r                  @[cal.sh|cal.sh.txt]@ [nocolor] by Paolo Bonzini
r             @[cal-year.sh|cal-year.sh.txt]@ [nocolor] by Paolo Bonzini
r                   @[cat-b|cat-b.sed]@ [@[colored|@local/scripts/cat-b.sed.html]@] by Paolo Bonzini
r                @[cat-b.sh|cat-b.sh.txt]@ [nocolor] by Sed One-liners Document
r                   @[cat-n|cat-n.sed]@ [@[colored|@local/scripts/cat-n.sed.html]@] by Paolo Bonzini
r                @[cat-n.sh|cat-n.sh.txt]@ [nocolor] by Sed One-liners Document
r                   @[cat-s|cat-s.sed]@ [@[colored|@local/scripts/cat-s.sed.html]@] by Carlos Jorge G. Duarte
r                @[centre_1|centre_1.sed]@ [@[colored|@local/scripts/centre_1.sed.html]@] by Paolo Bonzini
r                @[centre_2|centre_2.sed]@ [@[colored|@local/scripts/centre_2.sed.html]@] by Paolo Bonzini
r                @[cflword1|cflword1.sed]@ [@[colored|@local/scripts/cflword1.sed.html]@] by Paolo Bonzini
r                @[cflword2|cflword2.sed]@ [@[colored|@local/scripts/cflword2.sed.html]@] by Paolo Bonzini
r                @[cflword3|cflword3.sed]@ [@[colored|@local/scripts/cflword3.sed.html]@] by Carlos Jorge G. Duarte
r                @[cflword4|cflword4.sed]@ [@[colored|@local/scripts/cflword4.sed.html]@] by Carlos Jorge G. Duarte
r                @[cflword5|cflword5.sed]@ [@[colored|@local/scripts/cflword5.sed.html]@] by Carlos Jorge G. Duarte
r                @[cgrep.sh|cgrep.sh.txt]@ [nocolor] by Greg Ubben
r                @[commify1|commify1.sed]@ [@[colored|@local/scripts/commify1.sed.html]@] by Paolo Bonzini
r                @[commify2|commify2.sed]@ [@[colored|@local/scripts/commify2.sed.html]@] by Paolo Bonzini
r                @[commify3|commify3.sed]@ [@[colored|@local/scripts/commify3.sed.html]@] by Paolo Bonzini
r                  @[config|config.sed]@ [@[colored|@local/scripts/config.sed.html]@] by Nathan D. Ryan
r             @[crlf.tar.gz|crlf.tar.gz]@ [nocolor] by Paolo Bonzini
r                      @[dc|dc.sed]@ [@[colored|@local/scripts/dc.sed.html]@] by Greg Ubben
r                @[diffhtml|diffhtml.sed]@ [nocolor] by Tilmann Bitterberg
r                @[dtree.sh|dtree.sh.txt]@ [nocolor] by Stewart Ravenhall
r                  @[expand|expand.sed]@ [@[colored|@local/scripts/expand.sed.html]@] by Greg Ubben
r               @[fbasename|fbasename.sed]@ [@[colored|@local/scripts/fbasename.sed.html]@] by Carlos Jorge G. Duarte
r                @[fdirname|fdirname.sed]@ [@[colored|@local/scripts/fdirname.sed.html]@] by Carlos Jorge G. Duarte
r                     @[fmt|fmt.sed]@ [@[colored|@local/scripts/fmt.sed.html]@] by Carlos Jorge G. Duarte
r          @[get_html_title|get_html_title.sed]@ [@[colored|@local/scripts/get_html_title.sed.html]@] by Casper Boden-Cummins
r                 @[hbanner|hbanner.sed]@ [nocolor] by Carlos Jorge G. Duarte
r                    @[head|head.sed]@ [@[colored|@local/scripts/head.sed.html]@] by Paolo Bonzini
r                @[html2iso|html2iso.sed]@ [@[colored|@local/scripts/html2iso.sed.html]@] by Paolo Bonzini
r                 @[html_lc|html_lc.sed]@ [@[colored|@local/scripts/html_lc.sed.html]@] by Paolo Bonzini
r                 @[html_uc|html_uc.sed]@ [@[colored|@local/scripts/html_uc.sed.html]@] by Paolo Bonzini
r              @[impossible|impossible.sed]@ [@[colored|@local/scripts/impossible.sed.html]@] by Greg Ubben
r                @[incr_num|incr_num.sed]@ [@[colored|@local/scripts/incr_num.sed.html]@] by Bruno Haible
r                @[indentls|indentls.sed]@ [@[colored|@local/scripts/indentls.sed.html]@] by Paolo Bonzini
r                 @[indexer|indexer.sed]@ [@[colored|@local/scripts/indexer.sed.html]@] by Eric Pement
r               @[indexhtml|indexhtml.sed]@ [nocolor] by Tilmann Bitterberg
r                @[iso2html|iso2html.sed]@ [@[colored|@local/scripts/iso2html.sed.html]@] by Paolo Bonzini
r                @[italbold|italbold.sed]@ [@[colored|@local/scripts/italbold.sed.html]@] by Eric Pement
r                @[joinfile|joinfile.sed]@ [@[colored|@local/scripts/joinfile.sed.html]@] by Paolo Bonzini
r                 @[justify|justify.sed]@ [@[colored|@local/scripts/justify.sed.html]@] by Aurelio Marinho Jargas
r               @[list_urls|list_urls.sed]@ [@[colored|@local/scripts/list_urls.sed.html]@] by Paolo Bonzini
r            @[mail-iso2txt|mail-iso2txt.sed]@ [@[colored|@local/scripts/mail-iso2txt.sed.html]@] by Aurelio Marinho Jargas
r                @[maketarg|maketarg.sed]@ [@[colored|@local/scripts/maketarg.sed.html]@] by Carlos Jorge G. Duarte
r                @[masm2gas|masm2gas.sed]@ [@[colored|@local/scripts/masm2gas.sed.html]@] by Louis J. LaBash Jr.
r                @[overstrk|overstrk.sed]@ [@[colored|@local/scripts/overstrk.sed.html]@] by ecbyahoo
r              @[palindrome|palindrome.sed]@ [@[colored|@local/scripts/palindrome.sed.html]@] by Laurent Le Brun
r      @[pine_addr_2_vim_ab|pine_addr_2_vim_ab.sed]@ [@[colored|@local/scripts/pine_addr_2_vim_ab.sed.html]@] by Tilmann Bitterberg
r             @[polish.html|polish.html]@ [nocolor] by Robert Marks
r               @[remccoms1|remccoms1.sed]@ [@[colored|@local/scripts/remccoms1.sed.html]@] by Paolo Bonzini
r            @[remccoms2.sh|remccoms2.sh.txt]@ [nocolor] by Stewart Ravenhall
r               @[remccoms3|remccoms3.sed]@ [@[colored|@local/scripts/remccoms3.sed.html]@] by Brian Hiles
r                @[revchr_1|revchr_1.sed]@ [@[colored|@local/scripts/revchr_1.sed.html]@] by Paolo Bonzini
r                @[revchr_2|revchr_2.sed]@ [@[colored|@local/scripts/revchr_2.sed.html]@] by Paolo Bonzini
r                @[revlines|revlines.sed]@ [@[colored|@local/scripts/revlines.sed.html]@] by Paolo Bonzini
r                   @[rot13|rot13.sed]@ [@[colored|@local/scripts/rot13.sed.html]@] by Paolo Bonzini
r                @[sedhttpd|sedhttpd.sed]@ [@[colored|@local/scripts/sedhttpd.sed.html]@] by Matthew Parry
r                      @[sm|sm.sed]@ [@[colored|@local/scripts/sm.sed.html]@] by Carlos Jorge G. Duarte
r                @[sodelnum|sodelnum.sed]@ [@[colored|@local/scripts/sodelnum.sed.html]@] by Paolo Bonzini
r                @[splitdig|splitdig.sed]@ [@[colored|@local/scripts/splitdig.sed.html]@] by Aaro Koskinen
r     @[strip_html_comments|strip_html_comments.sed]@ [@[colored|@local/scripts/strip_html_comments.sed.html]@] by Stewart Ravenhall
r                @[subwords|subwords.sed]@ [nocolor] by Casper Boden-Cummins
r                 @[tex2xml|tex2xml.sed]@ [@[colored|@local/scripts/tex2xml.sed.html]@] by Tilmann Bitterberg
r                @[tolower2|tolower2.sed]@ [nocolor] by Paolo Bonzini
r                 @[tolower|tolower.sed]@ [@[colored|@local/scripts/tolower.sed.html]@] by Paolo Bonzini
r                @[toupper2|toupper2.sed]@ [nocolor] by Paolo Bonzini
r                  @[turing|turing.sed]@ [@[colored|@local/scripts/turing.sed.html]@] by Christophe Blaess
r                @[txt2html|txt2html.sed]@ [@[colored|@local/scripts/txt2html.sed.html]@] by Paolo Bonzini
r                @[undblspc|undblspc.sed]@ [@[colored|@local/scripts/undblspc.sed.html]@] by Sed One-liners Document
r                @[unlambda|unlambda.sed]@ [@[colored|@local/scripts/unlambda.sed.html]@] by Laurent Vogel
r                 @[untroff|untroff.sed]@ [@[colored|@local/scripts/untroff.sed.html]@] by Paolo Bonzini
r    @[yahoogroups-kill-sig|yahoogroups-kill-sig.sed]@ [@[colored|@local/scripts/yahoogroups-kill-sig.sed.html]@] by Aurelio Marinho Jargas
}

########################################################################

:gamez

/  want some fun? try them all!  /{

r        @[-|99 green bottles]@ [@[colored|local/games/99-green-bottles.sed.html]@] by Edward Rosten
r             @[-|tic tac toe]@ [@[colored|local/games/tictactoe.sed.html]@] by Graham Bell
r         @[-|pong (1 player)]@ [@[colored|local/games/pong1player.sed.html]@] by Graham Bell
r        @[-|pong (2 players)]@ [@[colored|local/games/pong2players.sed.html]@] by Graham Bell
r                 @[-|sokoban]@ [@[colored|local/games/sokoban.sed.html]@] by Aurelio Marinho Jargas
r                @[-|arkanoid]@ [@[colored|local/games/arkanoid.sed.html]@] by Aurelio Marinho Jargas
r         @[-|towers of hanoi]@ [@[colored|local/games/hanoi.sed.html]@] by George Bergman
r                @[-|connect4]@ [@[colored|local/games/connect4.sed.html]@] by Laurent Le Brun
r           @[-|my mastermind]@ [@[colored|local/games/sedermind.sed.html]@] by Laurent Le Brun
r             @[-|path solver]@ [@[colored|local/games/path.sed.html]@] by Laurent Le Brun
r                  @[-|puzzle]@ [@[colored|local/games/puzzle.sed.html]@] by Laurent Le Brun
}

########################################################################

:tools

/  tools related to sed /{

r   @[sd - Sed Debugger|sd]@                          by Brian Hiles
r      written in Bourne Shell
r   @[sd - Sed Debugger|sdk]@                          by Brian Hiles
r      written in Korn Shell
r   @[sedsed - Sed Debugger/Indenter/HTMLizer|sedsed]@    by Aurelio Marinho Jargas
r      written in Python
r   @[sedcheck - POSIX compatibility checker|sedcheck]@     by Laurent Vogel
r      written in Sed!  [@[colored|local/debug/sedcheck.sed.html]@]
r   @[bsed - Batch edit with Sed|bsed]@                 by Cameron Simpson
r      written in Bourne Shell
r   @[mod_sed - Sed Apache module|mod_sed]@                by Dom Mitchell
r      written in C
r   @[csed - Add colors to patterns|csed]@              by Stanislav Ievlev
r      written in C
}

########################################################################

:mailing

s| @[sed-users (english)|sed-users]@ | sed-users-subscribe@yahoogroups.com           |
s| @[sed-br (portuguese)|sed-br]@ | sed-br-subscribe@yahoogrupos.com.br           |


########################################################################

:sedlovers

s|  Aurelio M. Jargas  | @[=|Aurelio Jargas]@                       |
s|     Eric Pement     | @[=|Eric Pement]@ |
s|   Laurent Le Brun   | @[=|Laurent Le Brun]@                |
s|    Paolo Bonzini    | @[=|Paolo Bonzini]@                    |
s| Tilmann Bitterberg  | @[=|Tilmann Bitterberg]@  |
s|    Yao-Jen Chang    | @[=|Yao-Jen Chang]@      |
s| Yiorgos Adamopoulos | @[=|Yiorgos Adamopoulos]@ |


########################################################################
#
# The End.
#
# Note 1: This page was completely generated @[by a sed script|sedindex2html]@.
# Note 2: This page is a valid sed script.
#         You can copy&paste and run it with sed -f.
#
$!N
