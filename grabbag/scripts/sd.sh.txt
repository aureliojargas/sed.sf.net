: sd
#*TAG:39985 20:1973-09-17:0755:../d.proj-sd/sd
# Author: Brian Hiles <bsh@iname.com>
# Date: 1998/11/20
# Description: sed debugger with conditional spypoints
# License: copyright (c) 1996-2002
# Name: sd
# Project: @(#)sd-standalone.sh 3.3 2001-04 bsh@iname.com (Brian Hiles)
# Requires: echon(3S), expr(1), rm(1), sed(1)
# Thanks-to: Walter Briscoe <w.briscoe@ponl.com> for AIX compatibility
# Usage: sd [global-opts] [[-s spypoint-set] [local-opts]]... sedsrc ...
# Version: 3.03

#01 USAGE INFO
usage=\
'usage: sd [global-opts] [-s char local-opts]... [--] script [script-opts]
-?          - print this usage info
-c <pat>    - set pattern or numerical range to conditionally trace (*)
-C|+c <pat> - set pattern or numerical range to conditionally exclude trace (*)
-d <dir>    - get all -s option spypoints from directory <dir>. ["."]
-e <shell>  - shell to execute traced script in. [$SHELL]
-h          - trace the hold buffer. [pattern buffer]
-l          - preceed trace by the input file line number being processed
-o <file>   - file to output trace to ["sd.out"] (*)
-p          - print non-printable characters as octal codes
-q          - emit spypoint code suitable within double-quoted script(s)
              [single-quoted]
-r          - remove extraneous spypoint-labels
-s <char>   - select the spypoint-set to activate in the sed script by the
              filename expansion form [A-Z]* of corresponding filenames ["X"]
-v          - show characters newline and tab visibly as "^M" and "^I"
-x          - copy the internal sed script and transformed -f option script to
              "sd.munge" and "sd.code" respectively. For the curious only :-)
--          - use to separate "sd" args from args to be passed to traced script
(*) These options may be specified multiple times to increase scope of option.
Note: Defaults are in brackets. Default configuration is: -d. -osd.out -sX'

#02
#XXX
echon() # [string]...
# portable echo without terminating newline
{ case ${ECHON:=`echo -n X`} in
-n*) # SysV echo emulation
echo "$@"\\c ;;
X) # BSD echo emulation
echo -n "$@" ;; # Bug: "echo -n -- X" prints "-- X" !
*) # other: try once more
if ECHON=
echon "$@"
then :
else echo 'echon: error: cannot determine echo version' >&2
return 1
fi ;;
esac
return 0
}

#03
test 0$# -eq 0 && echo "$usage" && exit 0
#XXX. ${SIDEROOT:?'set and export variable SIDEROOT'}/lib/echon
# make variables representing tab, newline, and default unique character
eval "`echo 'TAB=\"X\" NL=\"Y\" CTRLA=\"Z\"' | tr XYZ '\011\012\001'`"
# uniqch: set to a non-printing char (or string) not appearing in input text
PATH=/bin${PATH:+:$PATH} RB=} global=g_ lblno=0 \
: ${uniqch:="$CTRLA"} ${TMPDIR:=/tmp}
# Warning: these test commands have been known to fail inexplicably:
#XXX bug: works in sh, but not ksh!
if test -c /dev/stderr -a -w /dev/stderr
then ostream=/dev/stderr # use this stderr (Solaris...)
elif test -c /dev/fd/2 -a -w /dev/fd/2
then ostream=/dev/fd/2 # use this stderr (IRIX, HP/UX, Ultrix...)
else ostream=/dev/tty # echo directly to terminal (SunOS, SVR2/3...)
fi
ostream=/dev/tty #XXX
eval ${DIAG:+'echo >&2 [ sd: terminal output: $ostream ]'}

#04 DEBUGGER POST-AMBLE
trap \
'if test -f $TMPDIR/sd$$.1
then echon "${NL}cleaning up file(s)"
for _inst in $g_oflist $cumflist
do if test -s $_inst
then ex -sc "%s/$uniqch^\([IM]\)$uniqch/^\1/g|\
%s;$uniqch/$;/;|w|q" $_inst
echon "${cdrflag:+,} $_inst"
cdrflag=ON
fi
done
echo .
fi >&2
if test X$g_savefiles = XON
then echon "saving internal file(s)"
mv -f $TMPDIR/sd$$.1 sd.munge 2>/dev/null && echon " sd.munge"
mv -f $TMPDIR/sd$$.2 sd.code 2>/dev/null && echon ", sd.code"
echo .
else set +f
rm -f $TMPDIR/sd$$.[12]
fi >&2
trap 0
exit' 0 1 2 3 15

#05 SED META-CODE
metacode() # spypoint-set-char
{ case $1 in
-) # no-op (use to escape out of global options)
delim= dquote= emitln= filter= flist= \
holdbuf= octalout= ofcmd= oflist= spych= visible= return 0 ;;
[A-Z]) ;;
*) # error: spypoint syntax!
echo "sd: error: invalid spypoint-set \"$1\" -- skipping" >&2
delim= dquote= emitln= filter= flist= \
holdbuf= octalout= ofcmd= oflist= spych= visible= return 1 ;;
esac
regexp=$g_filter$filter endblk=$delim$g_delim ofcmd= spylabels=
regexp="`
echo \"$regexp\" | sed \
-e '/^$/b' \
-e 's/\\\\/_!BS!_/g' \
-e \"s/_!BS!_/&&${g_dquote:+&&}/g\" \
-e 's/@/_!BS!_@/g' \
-e 's/$/{_!BS!_/' \
-e 's/_!BS!_/\\\\/g'
`"
eval ${DIAG:+'echo >&2 [ sd: metacode: regexp: "$regexp" ]'}
#XXX? shouldn't the command below be _before_ regexp construction above?
: ${dquote:=$g_dquote} ${emitln:=$g_emitln} \
${holdbuf:=$g_holdbuf} ${visible:=$g_visible}
if test X$holdbuf = X
then ldelim=[ rdelim=] # to mark patt buffer spypoint
else ldelim=\< rdelim=\> # to mark hold buffer spypoint
fi
test X$g_oflist = X -o X$g_oflist = 'X ' && g_oflist=sd.out
eval ${DIAG:+'echo >&2 [ sd: metacode: global-output-files: $g_oflist ]'}
spylabels=`cd ${g_dir:-.}; echo $1*`
case $spylabels in
?\*) spylabels=$1spy ;;
*) case " $spylabels " in
*" $1spy "*)
;;
*) spylabels="$spylabels $1spy" ;;
esac ;;
esac
eval ${DIAG:+'echo >&2 [ sd: metacode: spypoint-labels: $spylabels ]'}
spychset=$spychset$1
for _inst in $oflist '' $g_oflist # process output file arguments
do test X$_inst = X && cumflist="$cumflist $flist" && continue
if test -w $_inst >$_inst
#XXX bug! newline is always prepended onto $ofcmd ...!
then flist="$flist $_inst" ofcmd="$ofcmd${TAB}w $_inst\\$NL"
else echo "can't open file \"$_inst\" --skipping..." >&2
fi
done
eval ${DIAG:+'echo >&2 [ sd: metacode: output-files: $flist ]'}
echon 'tracing spypoint(s)' >&2
for _inst in $spylabels # foreach spypt, write sed code
do case $_inst in
?spy) ;;
*[!0-9A-Z_a-z]*)
echo " $_inst (ignored: spypoint syntax),"
continue ;;
?????????*)
echo " $_inst (ignored: spypoint is >8 chars),"
continue ;;
*) test ! -f $_inst -o -s $_inst && continue ;;
esac >&2
sep=$TAB #XXX!
#case $_inst in # to line up in same column
#????*) sep=$TAB ;;
#*) sep=$TAB$TAB ;;
#esac
echon " $_inst" >&2
echo \
"/^[$TAB ]*: \\{0,1\\}$_inst.\\{0,2\\}$/ {$NL\
$TAB/\\./ {$NL$TAB$TAB/$_inst\\.[0-9]$/!b skip$1$lblno$NL$TAB}$NL\
$TAB/\\./ !{$NL$TAB$TAB/$_inst$/!b skip$1$lblno$NL$TAB}$NL\
${TAB}s@^.*$_inst\\([.0-9]\\{0,2\\}\\)\$@\\${NL}\
${regexp:-{\\}$NL\
${holdbuf:+${TAB}x\\${NL}}\
${TAB}t _sd$lblno\\1\\$NL${TAB}s/$/$uniqch/\\$NL\
$TAB: _sd$lblno\\1\\${NL}\
${emitln:+$TAB=\\${NL}}\
${visible:+${TAB}s;"${dquote:+'\\\\'}"\\\\n;$uniqch^M$uniqch;g\\$NL}\
${visible:+${TAB}s;$TAB;$uniqch^I$uniqch;g\\${NL}}\
${TAB}s;^;$ldelim$_inst\\1$rdelim$sep/;\\$NL\
${TAB}s;$;/;\\"
lblno=`expr 0$lblno + 1`
if test X$octalout = XON
then # output for files with non-printable characters:
echo "${TAB}l\\"
else # output for files that are text-only:
echo "${TAB}w $ostream\\"
fi
#XXX! holdbuf:+... has "\\" entrained because $endblk has its own escnl
#XXX old: ${TAB}s;^[^/]*/\\\\(.*\\\\)/$;\\\\1;\\$NL\
#XXX why does the below have to be "echon" to
#XXX not make non-terminating empty line?!
echon \
"$ofcmd\
${visible:+${TAB}s;$uniqch^I$uniqch;$TAB;g\\$NL}\
${visible:+${TAB}s;$uniqch^M$uniqch;"${dquote:+'\\\'}"\\\\\\$NL;g\\$NL}\
${TAB}s;^[^/]*/\\\\(.*\\\\)/$;\\\\1;\\$NL\
$TAB/$uniqch$/{\\$NL$TAB${TAB}s///\\$NL$TAB${TAB}t _sd$lblno\\1\\$NL\
$TAB$TAB: _sd$lblno\\1\\$NL$TAB}\
${holdbuf:+\\$NL${TAB}x}\
${endblk:-\\$NL$RB\\$NL}"
lblno=`expr 0$lblno - 1`
echo "@$NL${TAB}p; b$NL$TAB: skip$1$lblno$NL}$NL"
lblno=`expr 0$lblno + 2`
done >&3
echo ", to file(s)$flist;" >&2
# spych is set to null to flag redundant call on last spypoint-set...
delim= dquote= emitln= filter= flist= \
holdbuf= octalout= ofcmd= oflist= spych= visible=
}

#06
# To suppress initializing from .sdrc, set SDRC=' '.
# Example: $ SDRC=' ' export SDRC
# sample .sdrc: -ev 'sed -f'
eval set -- `
if test -n "$SDRC"
then echo "$SDRC"
elif test -r .sdrc
then echo "\`cat .sdrc\`"
elif test -r $HOME/.sdrc
then echo "\`cat $HOME/.sdrc\`"
fi
for _inst
do echo "'$_inst'"
done
`

#07 SED PREAMBLE
#XXX old: : gettext${NL}s/\\\\\\\\/_!ESCBS!_/g${NL}s/\\\\#/_!ESCOCT!_/g${NL}\
#XXX old: /^[$TAB ]*#CBEGIN$/,/^[$TAB ]*#CEND$/d$NL\
exec 3>$TMPDIR/sd$$.1
echo >&3 \
"#n sd.munge: convert selected sed labels into sed code to print trace$NL\
: gettext${NL}s/\\\\\\\\/_!ESCBS!_/g${NL}s/\\\\#/_!ESCOCT!_/g${NL}\
s/\\([^$TAB ;&|()<>]\\)#/\\1_!OCT!_/g$NL/\\\\$/ {$NL$TAB/#/ !{$NL\
$TAB$TAB\$!N$NL$TAB$TAB\$!b gettext$NL$TAB}$NL}$NL\
/^[$TAB ]*#CBEGIN$/,/^[$TAB ]*#CEND$/ s/.*//$NL\
/^[$TAB ]\\{1,\\}#/ {$NL$TAB/#n/!d$NL}$NL/^#[^!n]/d$NL/^#$/d${NL}\
s/_!OCT!_/#/g${NL}s/_!ESCOCT!_/\\\\#/g${NL}\
s/_!ESCBS!_/\\\\\\\\/g$NL"

#08
OPTARG= OPTIND=1
eval ${DIAG:+'echo >&2 [ sd: command-line-parameters: $* ]'}
while getopts :\?C:c:d:e:HhLlo:PpQqRrs:VvXx opt
do case $opt in
c) eval eval \
${global}filter="\"'\$${global}filter''\$OPTARG$NL\\
'\"" ${global}delim="\"'\$${global}delim\\\\$NL}'\"" ;;
C) eval eval \
${global}filter="\"'\$${global}filter''\$OPTARG!$NL\\
'\"" ${global}delim="\"'\$${global}delim\\\\$NL}'\"" ;;
d) g_dir=$OPTARG ;;
e) g_shell=$OPTARG ;;
h) eval ${global}holdbuf=ON ;;
+h|H) eval ${global}holdbuf= ;;
l) eval ${global}emitln=ON ;; # only echoes to stdout!
+l|L) eval ${global}emitln= ;;
o) eval ${global}oflist="\"$OPTARG \$${global}oflist\"" ;;
p) eval ${global}octalout=ON ;;
+p|P) eval ${global}octalout= ;;
q) eval ${global}dquote=ON ;; # invoke before -c/-C!
+q|Q) eval ${global}dquote= ;; # invoke before -c/-C!
r) g_rmlabels=ON ;;
+r|R) g_rmlabels= ;;
s) if test X$global = Xg_
then global= spych=$OPTARG
else metacode $spych
spych=$OPTARG
fi ;;
v) eval ${global}visible=ON ;;
+v|V) eval ${global}visible= ;;
x) g_savefiles=ON ;;
+x|X) g_savefiles= ;;
[:?]) echo "error: no such option \"$OPTARG\"" >&2
echo "$usage" >&2
trap '' 0
exit 2 ;;
esac
done
set X "$@"; shift $OPTIND # do: shift `expr 0$OPTIND - 1`
g_prog=${1:?'missing sed script argument'} shift
metacode $spych
case $spychset in *X*) ;; *) metacode X ;; esac # default spypoint-set "X"

#09 SED POST-AMBLE
if test X$g_rmlabels = XON
then # insert sed code that eliminates inactive spypoint-labels
echo "/^[$TAB ]*: \\{0,1\\}[$spychset][0-9A-Z_a-z]*[.0-9]\\{0,2\\}$/d"
else echo p
fi >&3
exec 3>&-

#10 DEBUGGER PREAMBLE
if test X$g_prog = X-
then g_prog=
echo 'executing script <stdin>...'
else #XXX reimplement with "predictshell" ??
if test -z "$g_shell"
then g_shell=`sed 1q $g_prog`
g_shell="`
case $g_shell in
\#!*) echo $g_shell ;;
*) echo $SHELL ;;
esac | sed 's/^#![$TAB ]*//'
`"
fi
echo "executing script \"$g_shell $g_prog${*:+ $*}\"..."
fi >&2
sed -f $TMPDIR/sd$$.1 $g_prog >$TMPDIR/sd$$.2
trailws=`sed -n "/[$TAB ]$/=" $g_prog`
test -n "$trailws" &&
echo 'sd: warning: trailing whitespace on line(s)' $trailws >&2
${g_shell:-${SHELL:-sh}} $TMPDIR/sd$$.2 ${1+"$@"}
# uncomment following "exit" to exit with return code of shprog, not debugger
exit
exit 0
--

#10 EMBEDDED MAN-PAGE FOR "src2man"
#++
NAME
sd - sed debugger with conditional spypoints

SYNOPSIS
sd [global-opts] [[-s spypoint-set] [local-opts]]... sedsrc [options]
sd -?

DESCRIPTION
Sed script debugging is a difficult nuisance if only for the lack in
older versions of a simple commenting operator. The only attempt at
providing any facility for debugging is the "=" command, which prints
only the source line number necessarily to stdout. To help make up
for these deficiencies, this program dynamically generates and
executes a custom sed script which will instrument any sed script(s)
in the shprog argument (use "-" for stdin) you wish debugged so that
sed labels of a conforming format will be substituted into sed code
that will itself print the current pattern (or hold) buffer.

A label of this nature in the sed code is called a "spypoint-label."
Spypoint-labels must appear alone on their own line. The first
character of these spypoint-labels must start with the capitalized
letter [A-Z]. A "spypoint-set" is all spypoint-labels starting with
the same first character. The notion of spypoint-sets is to define
related groups of spypoint-labels in the sed script.

To "enable" a spypoint-set is to instruct sd(1S) to potentially
debug at spypoint-labels of this particular spypoint-set; otherwise,
they are left all unchanged to remain as ordinary sed labels. The
notion of enabling is to conveniently turn on or turn off spypoint-
labels of a particular spypoint-set without needing to comment or
delete them. By default, the "X" spypoint-set is always enabled.

To finally "activate" a particular spypoint-label in a sed script is
to have sd(1S) substitute sed code to debug at that location. Use
"touch ..." or "> ..." to create an empty file by the same name as
the spypoint-label (in the current working directory). To disable a
spypoint-label, merely delete the corresponding file or do not
activate that spypoint-set through an "-s" option. One need not edit
out inactive spypoint labels not used; most sed implementations will
ignore extraneous labels if they are unique. By default, the spypoint-
label "Xspy" is always activated -- creating file "Xspy" is redundant.

Options defined before the first "-s" option will apply globally to
all subsequent spypoint-sets being defined. Options following a "-s"
up to the next "-s" option or end-of-options apply locally only to
that spypoint-set. Invoke this program with any non-sd(1S) command
line parameters following one "--" option.

All sed labels, whether a spypoint-label or not, must be uniquely
named, so as a convenience a filename will activate all similar
labels otherwise ending with ".[0-9]". Otherwise, the spypoint-
label must be comprised of alphanumerics or an underscore.

As a convenience, options may be set from variable SDRC, or if that
is null or unset: file ./.sdrc, or if that does not exist: file
$HOME/.sdrc. Command line arguments will override these settings.

The sed code to echo the trace does not use and possibly overwrite
the hold buffer, nor will it interfere with the "t" command; however,
any null substitution R.E. (i.e. s//.../) will be redefined by the
intervening trace code.

The easiest way to debug a standalone executable sed script is to
command: sd -e "sed -f" file.sed.

All comments appearing alone on their own line with be deleted. In
addition, one may comment out several consecutive lines by delimiting
those lines with the special comments #CBEGIN and #CEND.

While debugging, it is preferable to extract any sed script temporarily
to a separate file, and execute "sed -f sd.code" from the shprog.

OPTIONS
-?          - Print this usage information.
-c <opt>    - Set pattern or numerical range to conditionally trace
              output. May be specified multiple times.
-C|+c <pat> - Set pattern or numerical range to conditionally exclude
              trace output. May be specified multiple times.
-d <dir>    - Get all -s option spypoints from directory <dir>. ["."]
-e <shell>  - Shell to execute traced script in. [$SHELL]
-h          - Trace the hold buffer. [pattern buffer]
-l          - Preceed trace by input file line number being processed.
-o <file>   - File to output trace to. May be specified multiple times.
              ["sd.out"]
-p          - Print non-printable characters as octal codes.
-q          - Emit spypoint code suitable within double-quoted script.
              [single]
-r          - Remove extraneous spypoint-labels.
-s <char>   - Select spypoint-set to activate in the sed script by the
              filename expansion form [A-Z]* of corresponding
              filenames. ["X"]
-v          - Show characters newline and tab as "^M" and "^I".
-x          - Copy the internal sed script and transformed -f option
              script to "sd.munge" and "sd.code" respectively.
              For the curious only ;)
--          - Use to separate "sd" args from args to be passed to
              traced script.

Note: Defaults are in brackets. Default config is: -d. -osd.out -sX

EXAMPLE
Assuming the default spypoint-label ":Xspy" exists in script
"shprog.sh" taking parameters "params"...

$ sd shprog.sh params

Explanation: This is the simplest case for debugging: with no options
given, trace the pattern buffer at the location of any of the spypoint-
labels ": Xspy" or ": Xspy.[0-9]".

Assuming "script.sed" is an executable sed script, and empty files
"Xpatt" and "Yhold" have been created in the current directory...

$ touch Xpatt Yhold
$ sd -e 'sed -f' -sX -c4,10 -sY -hc4,10 script.sed

Explanation: between lines 4 to 10 of the input to "script.sed", trace
the pattern buffer at spypoint-label ":Xpatt" (and ":Xpatt.[0-9]"),
and the hold buffer at spypoint-label ":Yhold" (and ":Yhold.[0-9]").

Assuming the spypoint-labels ":Xspy", ":Yspy.0", and ":Yspy.1" exist
in the sed code to be traced, embedded in the file "shprog.sh"...

$ touch Xspy Yspy
$ sd -v -c9,$ -ot.all -sX -C'/^#/' -ot.X -sY -h -ot.Y shprog.sh -opts

Explanation: tracing the script "sedtest.sh -opts", at spypoint-
label "Xspy" echo to file "t.X" the pattern buffer, except when in
the form of "#" comments. At spypoint-labels "Yspy.[01]" echo the
hold buffer to file "t.Y". The above is done only starting from line
9 of the input file, and all output (which will have tabs and newlines
converted to visible characters) is additionally captured to file
"t.all" and the terminal. The default spypoint-labels "Xspy" and
"Yspy" are also enabled.

Any of the "sd" options above may be placed in file ".sdrc" to
automatically use these as if they had been typed at the terminal.

ENVIRONMENT
SDRC - optional command line options

FILES
sd$$.1 (sd.munge) - script to munge embedded sed script in shprog
sd$$.2 (sd.code) - file copy of munged shprog file
sd.out - default output capture file of "sd" output
.sdrc - initialization script of "sd" options
/dev/tty
/dev/fd/2
/dev/stderr

DIAGNOSTICS

SEE ALSO
ad(1S), side(1S)

AUTHOR
Brian Hiles <bsh@iname.com>

BUGS
Since sed opens and closes all "w" command arguments per process,
similarly named spypoints in different sed processes will mutually
overwrite "o" option files, including and especially the default
trace file, "sd.out".

Keep in mind that the k/sh builtin ":" may have the same syntax
as a sed label, since the transformation of the object script
is a simple pattern substitution.

Because "sd" adds sed code and strips comments, any diagnostics that
report the line number will be inaccurate to the original source. XXX

The dynamically created sed script sd$$.1 (sd.munge) can potentially
be too large for some sed versions to run, if too many spypoint-sets
are defined by "-s" options.

If the -r option to remove unused spypoint-labels is used, it is
prudent that no labels in the debugged sed script start with a
capital letter that are not intended to be a spypoint-label.

If multiple sed scripts are embedded in a shell script, the option
to apply single- or double-quote spypoint code applies to all of
these scripts.

#--
