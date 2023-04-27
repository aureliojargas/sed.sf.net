#! /bin/sed -f
#polish.sedf4: Vol.23, non, post, ith, ie, 9,999
/^\.\\"/!{
/^\.G1/,/^\.G2/!{
/^\.PS/,/^\.PE/!{
/^\.EQ/,/^\.EN/!{
        /\../{
        /[0-9]/{
        s/Vol\.\([0-9]\)/Vol.\\^\1/g
        s/Vol\. \([0-9]\)/Vol.\\^\1/g
        s/No\.\([0-9]\)/No.\\^\1/g
        s/No\. \([0-9]\)/No.\\^\1/g
        }
        }
        /^\./!{
                s/\([^,]\) respectively\./\1, respectively./g
                s/\([^,;?.]\) see \([(\A-Z]\)/\1, see \2/g
                /[Nn]on /{
                s/Non \([a-zA-Z]\)/Non-\1/g
                s/\([   (]\)non \([a-zA-Z]\)/\1non-\2/g
                s/^non \([a-zA-Z]\)/non-\1/
                }
                /[Mm]ulti /{
                s/Multi \([a-zA-Z]\)/Multi-\1/g
                s/\([   (]\)multi \([a-zA-Z]\)/\1multi-\2/g
                s/^multi \([a-zA-Z]\)/multi-\1/
                }
                /[Ss]elf /{
                s/Self \([a-zA-Z]\)/Self-\1/g
                s/\([   (]\)self \([a-zA-Z]\)/\1self-\2/g
                s/^self \([a-zA-Z]\)/self-\1/
                }
                /[Ii]nter /{
                s/Inter \([a-zA-Z].[^i][^a]\)/Inter-\1/g
                s/\([   (]\)inter \(.[^l]\)/\1inter-\2/g
                s/^inter \(.[^l]\)/inter-\1/
                }
                /[Mm]id /{
                s/Mid \([a-zA-Z0-9]\)/Mid-\1/g
                s/\([   (]\)mid \([a-zA-Z0-9]\)/\1mid-\2/g
                s/^mid \([a-zA-Z0-9]\)/mid-\1/
                }
                s/Post \([a-zA-Z]\)/Post-\1/g
                /[ijknx]th/{
                s/\([ (]\)\([ijknx]\)th/\1\\f2\2\\fPth/g
                s/^\([ijknx]\)th/\\f2\1\\fPth/g
                }
                s/\([ (]\)ie\([, ]\)/\1i.e.\\\&\2/g
                s/\([ (]\)ie\.\([, ]\)/\1i.e.\\\&\2/g
                s/\([ (]\)eg\([, ]\)/\1e.g.\\\&\2/g
                s/\([ (]\)eg\.\([, ]\)/\1e.g.\\\&\2/g
                /[0-9]/{
                /[Ss]\../{
                        s/\([ (]\)s\.\([0-9]\)/\1s.\\^\2/g
                        s/\([ (]\)s\. \([0-9]\)/\1s.\\^\2/g
                        s/\([ (]\)S\.\([0-9]\)/\1s.\\^\2/g
                        s/\([ (]\)S\. \([0-9]\)/\1s.\\^\2/g
                        }
                s/\([0-9]\)\([0-9][0-9][0-9]\)\([0-9][0-9][0-9][^0-9]\)/\1,\2,\3/g
                s/\([0-9]\)\([0-9][0-9][0-9]\)\([0-9][0-9][0-9]\)$/\1,\2,\3/
                s/\([^.][^.][0-9]\)\([0-9][0-9][0-9][^0-9]\)/\1,\2/g
                s/\([^.][^.][0-9]\)\([0-9][0-9][0-9][^0-9]\)/\1,\2/g
                s/\([^.][^.][0-9]\)\([0-9][0-9][0-9]\)$/\1,\2/
                s/^\([0-9]\)\([0-9][0-9][0-9][^0-9]\)/\1,\2/
                }
                s/\([Rr]\)ight hand/\1ight-hand/g
                s/\([Ll]\)eft hand/\1eft-hand/g
                s/foregone \([^c]\)/forgone \1/g
                s/foregone\.$/forgone./
                s/([Ee]d)/(ed.)/g
        }
        /^\.TS/,/^\.TE/!{
        /^\.nf/,/^\.fi/!{
                /^[^.]/{
                        /[ uniLlg][nltmgeo][oteihfn][nirdte]$/{
                        / non$/{
                                N
                                s/\n/-/
                        }
                        / multi$/{
                                N
                                s/\n/-/
                        }
                        / inter$/{
                                N
                                s/\n\(.[^l]\)/-\1/
                        }
                        / mid$/{
                                N
                                s/\n/-/
                        }
                        /[Rr]ight$/{
                                N
                                s/\nhand/-hand/
                                }
                        /[Ll]eft$/{
                                N
                                s/\nhand/-hand/
                                }
                        /foregone$/{
                                N
                                s/foregone\n\([^c]\)/forgone \1/
                        }
                        }
                }
        }
        }
}
}
}
}
