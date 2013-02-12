#!/bin/bash
# htmlize.sh - by Aurelio Jargas, since 2002
#
# Use sedsed to convert sed scripts to colored HTML files.
# The original sed script URL is also added to the HTML footer.
#
# Usage: ./htmlize.sh path/to/script.sed

# TODO local/games/sedermind.sed: ERROR: invalid SED command 'Q' at line 84 (unsupported by sedsed)

url_database="index2html.sed"
output_extension="html"


get_script_url() {
	local label="$1"

	# Label exceptions: displayed script name is different from the file name
	case "$label" in
		hanoi           ) label='towers of hanoi';;
		tictactoe       ) label='tic tac toe';;
		pong1player     ) label='pong (1 player)';;
		pong2players    ) label='pong (2 players)';;
		99-green-bottles) label='99 green bottles';;
		sedermind       ) label='my mastermind';;
		path            ) label='path solver';;
	esac

	# Extract sed script URL from the database
	sed -n "
		# Sample line: s|^foo.sed$|http://sed.sf.net/foo.sed|; t url
		#
		/^s|^$label\(\.sed\)\{0,1\}\$|/ {
			s///
			s/|.*//p
		}
		" "$url_database"
}


while test "$1"
do
	input_path="$1"
	output_path="$input_path".$output_extension

	input_basename=$(echo "$input_path" | sed 's,.*/,, ; s/\.sed$//')
	url=$(get_script_url "$input_basename")

	printf "*** $input_basename\t$url\n"

	# Convert to HTML and add original URL to the footer
	sedsed --htmlize -f "$input_path" |
		sed "/>### colorized by/ s,</b>,\\
### original script: <a href=\"$url\">$url</a>&," > "$output_path"

	echo "Saved $output_path"

	# Remove the current file name from the to-do list
	shift
done
