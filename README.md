## The sed.sf.net website

Since 2002, <http://sed.sf.net> is the main portal for sed information and community scripts. Created and maintained by [Aurelio Jargas][].

Please contribute adding links, fixing broken links and updating information. You can do it by [opening an issue ticket][] or even better, submitting a pull request.


## Nerdgasm

The site's main page is a valid sed script file ([index.sed][]) that's converted to HTML by another sed script ([index2html.sed][]). The resulting index.html file, [when rendered by the browser][], is also a valid sed script.


## Instructions

To update the index.html file:

    sed -f index2html.sed index.sed > index.html

To update the HTML version of the generator script:

    ./htmlize.sh index2html.sed

To update the HTML version of some local script:

    ./htmlize.sh local/scripts/foo.sed

To include a new script in the repository:

1. Add the text line to `index.sed`, mentioning the script and the author
2. Add the script original URL to `index2html.sed`
3. Add the original script file to the `local/scripts` (or `local/games`) folder
4. Convert the original script to HTML using `htmlize.sh`
5. Update `index.html` and `index2html.sed.html` files (see instructions above)


## Deploy

The deploy is still an old school manual `rsync` to the SourceForge's `htdocs` directory.

    rsync --dry-run --verbose --archive --update --compress \
          --exclude .git \
          --exclude .gitignore \
          --exclude README.md \
          . \
          aureliojargas,sed@web.sourceforge.net:/home/groups/s/se/sed/htdocs

Remember to remove the `--dry-run` option to actually upload the files.


[index.sed]:      https://github.com/aureliojargas/sed.sf.net/blob/master/index.sed
[index2html.sed]: https://github.com/aureliojargas/sed.sf.net/blob/master/index2html.sed
[Aurelio Jargas]: http://aurelio.net/about.html
[opening an issue ticket]: https://github.com/aureliojargas/sed.sf.net/issues/new
[when rendered by the browser]: http://sed.sf.net
