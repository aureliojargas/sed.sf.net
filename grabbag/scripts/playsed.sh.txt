#! /bin/bash
# playsed - a simple script to play sed games
# 20020409 <aurelio@verde666.org> debut
#
# WARNING: works only with GNU sed >= 3.02.80 and bash >= 2.0

usage(){ echo "usage: $0 [--level N|--timeout N] file.sed"; exit 1 ; }
error(){ echo "ERROR: $*"
  echo 'Sorry, you cannot run this program.'; exit 1 ;}

[ "$1" ] || usage
### defaults
level=1
tmout="-t 1"

### parse cmdline options
while [ "$2" ] ; do
  case "$1" in
    --level|-l) level=$2 ; shift;;
	--timeout|-t) tmout="-t $2" ; shift ;;
	*) usage;;
  esac
  shift
done  
file="$1"
name="echo $file | sed 's,.*/,,;s/\.sed$//'"

### test for sed, read and $file
if ! echo | sed -u -e d ; then
error "your sed does not support the --unbuffered option."
fi
if ! echo | read $tmout -n 1; then
error "your read (shell builtin) does not support the -t or -n option."
fi
[ -f $file ] || error "file not found: $file"

### get game options for sed
firstline=`sed q $file`
id=`echo $firstline | sed 's/^\(..\).*/\1/'`
if [ "$id" = '#!' ]; then
  sedopts=`echo $firstline | sed 's/[^ ]*//;s/-\?f$//'`
fi

### game specific settings
case "$name" in
  sokoban) tmout='';;
esac  

### run game!
( echo -e "\n$level"
  tmoutorig="$tmout"
  while [ 1 ] ; do
	read $tmout -n 1 cmd
	fullcmd="$fullcmd$cmd"
	case "$fullcmd" in 
	  :)  tmout= ; continue;;
	  :g) tmout= ; continue;;
	  ) tmout= ; continue;;
	  [) tmout= ; continue;;
	  :g[0-9]) tmout= ; continue;;
	esac	
	echo $fullcmd
	fullcmd='' ; cmd=''; tmout="$tmoutorig"
  done
) | sed $sedopts -u -f $file
