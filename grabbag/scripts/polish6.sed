#! /bin/sed -f
#polish.sedf5: Firstly, however, adverbs
/^\.\\"/!{
/^\.G1/,/^\.G2/!{
/^\.PS/,/^\.PE/!{
/^\.EQ/,/^\.EN/!{
        /^\.TS/,/^\.TE/!{
        /^\.nf/,/^\.fi/!{
                /^[^.]/{
                        / so$/{
                                N
                                s/\ncalled/-called/
                        }
                        /[^md] [a-z][a-z]* [tb][oy]$/{
                                N
                                s/ \([a-z][a-z]*\) \([tb][oy]\)\n\1 / \1-\2-\1 /
                        }
                        /day$/{
                                N
                                s/\nto day/-to-day/
                        }
                }
        }
        }
        /^[^.]/{
                /^[ABFHIMNORT]/{
                s/^Also,/Moreover,/
                s/^Again /Again, /
                s/^By definition /By definition, /
                s/^Furthermore /Furthermore, /
                s/^Hence /Hence, /
                /^In/{
                s/^Instead \([^o]\)/Instead, \1/
                s/^Indeed /Indeed, /
                s/^In particular /In particular, /
                s/^In practice /In practice, /
                }
                s/^Moreover /Moreover, /
                s/^Nonetheless /None the less, /
                s/^Nevertheless /Nevertheless, /
                s/^On the one hand /On the one hand, /
                s/^On the other hand /On the other hand, /
                s/^Overall /Overall, /
                s/^Rather \(...[^ne]\)/Rather, \1/
                s/^Thereafter /Thereafter, /
                s/^Thus /Thus, /
                }
                /owever/{
                s/^However /But /
                s/^However, /But /
                s/\([a-z]\) however /\1, however, /g
                s/\([a-z]\) however$/\1, however,/
                s/\([a-z]\) however\.$/\1, however./
                }
                /or example/{
                s/^For example /For example, /
                s/\([a-z]\) for example /\1, for example, /g
                s/\([a-z]\) for example$/\1, for example,/
                s/\([a-z]\) for example\.$/\1, for example./
                }
                /\([a-z]\) for$/{
                        N
                        s/ for\nexample /, for\
example, /
                }
                s/ so called/ so-called/g
                s/^so called/so-called/
                s/\([^md]\) \([a-z][a-z]*\) \([tb][oy]\) \2 /\1 \2-\3-\2 /g
                s/\([^md]\) \([a-z][a-z]*\) \([tb][oy]\) \2$/\1 \2-\3-\2/
                s/etc\([^.h]\)/etc.\\\&\1/g
                s/\([a-z]\) if any\./\1, if any./g
                /[a-zOJ][a-z]ly/{
                s/\([Ff]\)irstly,/\1irst,/g
                s/\([Ss]\)econdly,/\1econd,/g
                s/\([Tt]\)hirdly,/\1hird,/g
                s/\([Ff]\)ourthly,/\1ourth,/g
                s/\([Ll]\)astly,/\1ast,/g
                s/^Not only,/Not only\\\&/
                /^[A-Z][a-z][a-z]*ly/{
                s/^Firstly/First,/g
                s/^Secondly/Second,/g
                s/^Thirdly/Third,/g
                s/^Fourthly/Fourth,/g
                s/^Lastly/Last,/g
                s/^Finally /Finally, /g
                s/^Especially,/Especially\\\&/
                s/^Carefully,/Carefully\\\&/
                s/^Early,/Early\\\&/
                s/^Freely,/Freely\\\&/
                s/^Supply,/Supply\\\&/
                s/^Simply,/Simply\\\&/
                s/^July,/July\\\&/
                s/^Hourly,/Hourly\\\&/
                s/^Daily,/Daily\\\&/
                s/^Weekly,/Weekly\\\&/
                s/^Monthly,/Monthly\\\&/
                s/^Statistically, sign/Statistically\\\& sign/
                s/^Approximately,/Approximately\\\&/
                s/^Relatively,/Relatively\\\&/
                s/^Only,/Only\\\&/
                s/^Merely,/Merely\\\&/
                s/^Virtually,/Virtually\\\&/
                s/^Possibly,/Possibly\\\&/
                s/^Unfortunately, for/Unfortunately\\\& for/
                s/^Immediately, \([ab][ef]\)/Immediately\\\& \1/
                s/^Surprisingly, \(..[twnh]\)/Surprisingly\\\& \1/
                s/^Strictly, \(speak\)/Strictly \1/
                s/^Fairly,/Fairly\\\&/
                s/^Roughly,/Roughly\\\&/
                }
                }
        }
}
}
}
}
