#! /bin/sed -f
#polish.sedf3:  -ly-, -$&c, et al, .\&, p.79, v., 80s, figure, times, adverbs,endofline
/^\.\\"/!{
/^\.G1/,/^\.G2/!{
/^\.PS/,/^\.PE/!{
/^\.EQ/,/^\.EN/!{
        /^\.TS/,/^\.TE/!{
                /^[^.]/{
                        s/\([a-zA-Z]\)\. \([0-9(\a-zA-Z]\)/\1.\\\& \2/g
                        /ly/{
                        s/^\([A-Z][a-z]*\)ly /\1ly, /
                        s/^Not \([a-z]*\)ly /Not \1ly, /
                        s/^More \([a-z]*\)ly /More \1ly, /
                        s/\([a-z][a-oq-z][a-oq-z]*\)ly-\([a-z]\)/\1ly \2/g
                        }
                        /[A-Z][A-Z]/{
                        s/\([ (/]\)\([A-Z][A-Z][A-Z]*\)\([ ),;?!'./\:]\)/\1\\s-1\2\\s+1\3/g
                        s/^\([A-Z][A-Z][A-Z]*\)\([ ),;?!'./\:]\)/\\s-1\1\\s+1\2/
                        s/\([ (]\)\([A-Z][A-Z][A-Z]*\)$/\1\\s-1\2\\s+1/
                        }
                        s/\([MD]r\) /\1.\\\& /g
                        s/Mrs /Mrs.\\\& /g
                        s/^\([A-Z][a-z-]*\)wise /\1wise, /
                        s/\([Uu]\)p to date/\1p-to-date/g
                        s/\([Ww]\)ear and tear/\1ear-and-tear/g
                        s/\([^,]\) in particular\.$/\1, in particular./
                        s/\([^,]\) in that order\.$/\1, in that order./
                        s/\([0-9]\) below\.$/\1, below./
                        s/\([^,]\) of course\([^,.a-z)]\)/\1, of course,\2/g
                        s/\([^,]\) of course\.$/\1, of course./
                        s/\([ivsfhw][ngoie][ehxfrn]\)ty \([otfsen][nwhoie][eoruvxgn]\)/\1ty-\2/g
                }
                /[`$!]/!{
                        /^[^.]/{
                                s/( \([a-zA-Z\0-9]\)/(\1/g
                                s/\([a-zA-Z0-9)]\) \([,;:)?]\)/\1\2/g
                                /v/{
                                s/ vs / \\f1v.\\\&\\fP /g
                                s/^vs /\\f1v.\\\&\\fP /
                                s/ vs$/ \\f1v.\\\&\\fP/
                                s/ v / \\f1v.\\\&\\fP /g
                                s/^v /\\f1v.\\\&\\fP /
                                s/ v$/ \\f1v.\\\&\\fP/
                                s/ v\. / \\f1v.\\\&\\fP /g
                                s/^v\. /\\f1v.\\\&\\fP /
                                s/ v\.$/ \\f1v.\\\&\\fP/
                                s/ v\.\\\& / \\f1v.\\\&\\fP /g
                                s/^v\.\\\& /\\f1v.\\\&\\fP /
                                s/ v\.\\\&$/ \\f1v.\\\&\\fP/
                                }
                                /[<>+]/{
                                s/ + /\\^\\(pl\\^/g
                                s/+/\\^\\(pl\\^/g
                                s/\([<>]\)/\\^\1\\^/g
                                s/ \([<>]\) /\\^\1\\^/g
                                }
                                s/, ns\([^.]\)/, n.s.\1/g
                                s/, sd\([^.]\)/, s.d.\1/g
                        }
                }
        }
        /^[^.]/{
                s/\([cC]\)o-eff/\1oeff/g
                /\$/{
                s/\$\.\([1-9][0-9]\)\([0-9]\)\([^mMbBtT]\)/\1.\2\\(ct\3/g
                s/\$\.0\([0-9]\)\([0-9]\)\([^mMbBtT]\)/\1.\2\\(ct\3/g
                s/\$\.\([1-9][0-9]\)\([^mMbBtT]\)/\1\\(ct\2/g
                s/\$\.0\([0-9]\)\([^mMbBtT]\)/\1\\(ct\2/g
                }
                /al/{
                s/ et al\([^.]\)/ et al.\\\&\1/g
                s/^et al\([^.]\)/et al.\\\&\1/
                s/^al /al.\\\& /
                s/et al$/et al.\\\&/
                }
                s/\([ (p]\)p\([0-9A-Z]\)/\1p.\\^\2/g
                /\../{
                        /p\./{
                        s/\([ (p]\)p\.\([0-9A-Z]\)/\1p.\\^\2/g
                        s/\([ (p]\)p\. \([0-9A-Z]\)/\1p.\\^\2/g
                        s/^p\.\([0-9A-Z]\)/p.\\^\1/
                        s/^p\. \([0-9A-Z]\)/p.\\^\1/
                        }
                        s/fn\.\([0-9]\)/fn.\\^\1/g
                        s/fn\. \([0-9]\)/fn.\\^\1/g
                        s/para\.\([0-9]\)/para.\\^\1/g
                        s/para\. \([0-9]\)/para.\\^\1/g
                        s/pg\.\([0-9A-Z]\)/p.\\^\1/
                        s/pg\. \([0-9A-Z]\)/p.\\^\1/
                }
                /[0-9]/{
                s/\(1[89][0-9][0-9]\)'s/\1s/g
                s/\([0-9][0-9]\)'s/\1s/g
                s/\([^-]\)section \([0-9]\)/\1Section \2/g
                s/\([^-]\)sections \([0-9]\)/\1Sections \2/g
                s/figure \([0-9]\)/Figure \1/g
                s/figures \([0-9]\)/Figures \1/g
                s/table \([0-9]\)/Table \1/g
                s/tables \([0-9]\)/Tables \1/g
                s/\([0-9]\)x\([0-9]\)/\1\\^\\(mu\\^\2/g
                s/\([0-9]\)X\([0-9]\)/\1\\^\\(mu\\^\2/g
                }
                /;$/{
                        N
                        s/;\n\.\([^Lb]\)/:\
.\1/
                }
        }
}
}
}
}
