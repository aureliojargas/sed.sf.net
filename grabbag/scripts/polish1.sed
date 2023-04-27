#! /bin/sed -f
#polish.sedf1: EQ, 0. , %, -0. , digraphs, spelling, \-, USA/UK, (abc), 1987a, \f2n\fP
/^\.\\"/!{
/^\.G1/,/^\.G2/!{
/^\.PS/,/^\.PE/!{
/^\.EQ/,/^\.EN/!{
        /^[^.]/{
                /[0-9]/{
                s/\([0-9]\) percent\([^ai]\)/\1\%\2/g
                s/\([0-9]\) percent$/\1\%/
                s/\([0-9]\) per cent/\1%/g
                s/\([ ^ `"/(~#i]\)\.\([0-9]\)/\10.\2/g
                s/^\.\([0-9][^a-zA-Z]\)/0.\1/
                s/\([ ^ `"/(~#]\)-\.\([0-9]\)/\1\\-0.\2/g
                s/^-\.\([0-9]\)/\\-0.\1/
                s/\(1[89][0-9][0-9]\)\([abcdef]\)/\1\\f2\2\\fP/g
                }
                s/\([Cc]\)ooperat/\1o\\o'o\\(..'perat/g
                s/\([Cc]\)oordinat/\1o\\o'o\\(..'rdinat/g
                s/\([Cc]\)o-o\([rp][a-z]\)/\1o\\o'o\\(..'\2/g
                s/^\([Rr]\)ole/\1\\o'o^'le/
                s/\([- '/q`"(]\)\([Rr]\)ole/\1\2\\o'o^'le/g
                s/\([Nn]\)aive/\1a\\o'\\(ui\\(..'ve/g
                s/vis[ -]a[ -]vis/vis-\\o'a\\(ga'-vis/g
                s/^\([Rr]\)esume/\1\\o'e\\(aa'sum\\o'e\\(aa'/
                s/\([ -'/q`"(]\)\([Rr]\)esume/\1\2\\o'e\\(aa'sum\\o'e\\(aa'/g
                s/\([Ff]\)acade/\1a\\o'c\\(cd'ade/g
                s/\([Ff]\)ocuss/\1ocus/g
                s/\([Nn]\)onetheless/\1one the less/g
                s/d'etre/d'\\o'e^'tre/g
                /oe/{
                s/^oe\([a-z][a-z]\)/\\(oe\1/
                s/\([ -'/q`"(]\)oe\([a-z][a-z]\)/\1\\(oe\2/g
                s/oeuvre/\\(oeuvre/g
                }
                /[Aa]e/{
                s/\([a-z][a-z]\)ae\([ \.,;:)]\)/\1\\(ae\2/g
                s/^ae\([cdgoqst][a-z]\)/\\(ae\1/
                s/\([ -'/q`"(]\)ae\([cdgoqst][a-z]\)/\1\\(ae\2/g
                s/aesth/\\(aesth/g
                s/Ae\([aglnostcdq][a-z]\)/\\(AE\1/g
                }
                s/medieval/medi\\(aeval/g
                s/(cf /(see /g
                s/(c\.f\. /(see /g
                s/\([Ii]\)bid\([^e.]\)/\1bid.\\\&\2/g
                /U[SK]/{
                s/^U\([SK]\) /U.\1.\\\& /
                s/^U\([SK]\)\.$/U.\1./
                s/\([ (]\)U\([SK]\) /\1U.\2.\\\& /g
                s/\([ (]\)U\([SK]\)$/\1U.\2.\\\&/
                s/\([ (]\)U\([SK]\)\.$/\1U.\2./
                s/\([ (]\)U\([SK]\)\([,;:)]\)/\1U.\2.\3/g
                s/^USA /U.S.A.\\\& /
                s/^USA\.$/U.S.A./
                s/\([ (]\)USA /\1U.S.A.\\\& /g
                s/\([ (]\)USA$/\1U.S.A.\\\&/
                s/\([ (]\)USA\.$/\1U.S.A./
                s/\([ (]\)USA\([,;:)]\)/\1U.S.A.\2/g
                }
                /([abcdefgh])/{
                s/^(\([abcdefgh]\))/(\\f2\1\\fP)/
                s/\([   ]\)(\([abcdefgh]\))\([  ]\)/\1(\\f2\2\\fP)\3/g
                s/\([   ]\)(\([abcdefgh]\))\([  ]\)/\1(\\f2\2\\fP)\3/g
                s/\([   ]\)(\([abcdefgh]\))$/\1(\\f2\2\\fP)/
                }
        }
        /[`!$]/!{
        /^\.nf/,/^\.fi/!{
                /^[^.]/{
                        s/: \([`"([\\0-9a-zA-Z]\)/:  \1/g
                        /^[^ ][^ ]*[:;?][~#][^~#]/!s/:[~#]\([`"([\\0-9a-zA-Z]\)/:  \1/g
                        /^[^ ][^ ]*[:;?]\([^ ]\)\1/!s/\([:;?]\)\([^ ]\)\2\([`"([\\0-9a-zA-Z]\)/\1  \3/g
                        /^[^ ][^ ]*;[~#]/!s/;[#~]\([`"([\\0-9a-zA-Z]\)/; \1/g
                }
        }
                /^[^.]/{
                        /[0-9]/{
                        /-/{
                        s/\([ ^ `"/(]\)-\([0-9]\)/\1\\-\2/g
                        s/\([0-9]\)-\([0-9]\)/\1\\-\2/g
                        s/\([0-9])\)-\(([0-9]\)/\1\\-\2/g
                        s/\([0-9]\)-\$\([0-9.]\)/\1\\-$\2/g
                        s/\([0-9]\) - \([0-9]\)/\1 \\- \2/g
                        s/\([0-9]\)- /\1\\- /g
                        }
                        }
                }
                /^\.TS/,/^\.TE/!{
                /^\.nf/,/^\.fi/!{
                        /^[^.]/{
                                s/\.   *\([\A-Z]\)/.\
\1/g
                        }
                }
                        /^[^.]/{
                                s/^\([bcdefghijklmnpqrstuvwxyzBCDEFGHJKLMNPQRSTUVWXYZ]\)\([ ']\)/\\f2\1\\fP\2/
                                s/ \([bcdefghijklmnpqrstuvwxyzBCDEFGHJKLMNPQRSTUVWXYZ]\)$/ \\f2\1\\fP/
                                s/\([ (]\)\([bcdefghijklmnpqrstuvwxyzBCDEFGHJKLMNPQRSTUVWXYZ]\)\([ ']\)/\1\\f2\2\\fP\3/g
                                s/ \([bcdefghijklmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ]\)\([;:,)^       ]\) / \\f2\1\\fP\2 /g
                                s/ \([bcdefghijklmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ]\)\.$/ \\f2\1\\fP./
                                s/ \([bcdefghijklmnpqrstuvwxyzBCDEFGHJKLMNPQRSTUVWXYZ]\) / \\f2\1\\fP /g
                                s/ \([bcdefghijklmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ]\)\([;:,^        ]\) / \\f2\1\\fP\2 /g
                                s/ \([bcdefghijklmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ]\)\.$/ \\f2\1\\fP./
                                s/\([^A-Zx:;,. ] \)A\([ ']\)/\1\\f2A\\fP\2/g
                                s/ A)/ \\f2A\\fP)/g
                        }
                }
        }
}
}
}
}
