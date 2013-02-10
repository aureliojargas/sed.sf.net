## The sed.sf.net website

Since 2002, <http://sed.sf.net> is the main portal for sed information and community scripts. Created and maintained by [Aurelio Jargas][].


## Nerdgasm
The site's main page is a valid sed script file ([index.sed][]) that's converted to HTML by another sed script ([index2html.sed][]). The resulting index.html file, [when rendered by the browser][], is also a valid sed script.


## Instructions

To update the index.html file:

    sed -f index2html.sed index.sed > index.html

To update the HTML version of the generator script:

    sedsed --htmlize -f index2html.sed > index2html.sed.html



[index.sed]:      https://github.com/aureliojargas/sed-website/blob/master/index.sed
[index2html.sed]: https://github.com/aureliojargas/sed-website/blob/master/index2html.sed
[Aurelio Jargas]: http://aurelio.net/about.html
[when rendered by the browser]: http://sed.sf.net
