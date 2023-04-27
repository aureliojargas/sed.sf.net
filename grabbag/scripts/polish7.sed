#! /bin/sed -f
#polish.sedf6: TS/TE sub- but PtyLtd -order defn avg whereas `` '' "
/^\.\\"/!{
/^\.TS/,/^\.TE/{
        /(.*)/{
        s/\([   ^]\)(\([0-9\(-.mi ,]*\))\1/\1\\s-2(\2)\\s+2\1/g
        s/\([   ^]\)(\([0-9\(-.mi ,]*\))\1/\1\\s-2(\2)\\s+2\1/g
        s/\([   ^]\)(\([0-9\(-.mi ,]*\))$/\1\\s-2(\2)\\s+2/
        s/^(\([0-9\(-.mi ,]*\))\([      ^]\)/\\s-2(\1)\\s+2\2/
        }
        /-/{
        s/\([   ^]\)-\1/\1\\(em\1/g
        s/\([   ^]\)-\1/\1\\(em\1/g
        s/\([   ^]\)-$/\1\\(em/
        s/^-\([ ^]\)/\\(em\1/
        }
        s/^\.SP/.sp/
}
/^\.G1/,/^\.G2/!{
/^\.PS/,/^\.PE/!{
/^\.EQ/,/^\.EN/!{
        /[!$@`]/!{
                s/ sub / sub-/g
        }
        /^[^.]/{
                /\(['`]\)\1/{
                        s/``/\\(lq/g
                        s/''/\\(rq/g
                }
                /[!`$]/!{
                /"/{
                        s/say "/say, \\(lq/g
                        s/said "/said, \\(lq/g
                        s/^"\([^ {}"]\)/\\(lq\1/
                        s/\([([]\)"\([^ {}"]\)/\1\\(lq\2/g
                        s/\([   ]\)"\([^ {}"]\)/\1\\(lq\2/g
                        s/\\(em"\([^ {}"]\)/\\(em\\(lq\1/g
                        s/\([^ {}"]\)"\\(em/\1\\(rq\\(em/g
                        s/\([.!?]\)"$/\1\\(rq~/
                        s/\([.!?]\)"[~]$/\1\\(rq~/
                        s/"\([.!?]\)$/\\(rq\1/
                        s/\([^ {}"]\)"$/\1\\(rq/
                        s/\([^ {}"]\)"\([])}]\)/\1\\(rq\2/g
                        s/\([^ {}"]\)"\([       ]\)/\1\\(rq\2/g
                        s/\([^ {}"]\)"\([.,;:?!]\)/\1\\(rq\2/g
                }
                }
                /[PL]t/{
                s/Pty /Pty.\\\& /g
                s/Pty$/Pty.\\\&/
                s/Ltd /Ltd.\\\& /g
                s/Ltd$/Ltd.\\\&/
                }
                / [tobw][hren]/{
                s/\([a-z][^sn,]\) though /\1, though, /g
                s/\([a-z][^sn,]\) though$/\1, though,/
                s/\([Ffeti][ichg][roih][snre][tdr]\) order/\1-order/g
                s/\([Ffe][ic][ro][sn][td]\) best/\1-best/g
                s/\([a-z0-9]\) on average\.$/\1, on average./
                s/\([a-z0-9]\) whereas/\1, whereas/g
                }
                s/\([eE]\)ntrepot/\1ntrep\\o'o^'t/g
                s/\([cC]\)liche/\1lich\\o'e\\(aa'/g
                /[Rr]ee/{
                s/\([Pp]\)reempt/\1re\\o'e\\(..'mpt/g
                s/\([Rr]\)eexam/\1e\\o'e\\(..'xam/g
                s/\([Rr]\)eenact/\1e\\o'e\\(..'nact/g
                s/\([Rr]\)eemerge/\1e\\o'e\\(..'merge/g
                s/\([Rr]\)eelect/\1e\\o'e\\(..'lect/g
                s/\([Rr]\)eestim/\1e\\o'e\\(..'stim/g
                s/\([Pp]\)reemin/\1re\\o'e\\(..'min/g
                }
                /[Rr]e-e/{
                s/\([Pp]\)re-empt/\1re\\o'e\\(..'mpt/g
                s/\([Rr]\)e-exam/\1e\\o'e\\(..'xam/g
                s/\([Rr]\)e-enact/\1e\\o'e\\(..'nact/g
                s/\([Rr]\)e-emerge/\1e\\o'e\\(..'merge/g
                s/\([Rr]\)e-elect/\1e\\o'e\\(..'lect/g
                s/\([Rr]\)e-estim/\1e\\o'e\\(..'stim/g
                s/\([Pp]\)re-emin/\1re\\o'e\\(..'min/g
                }
                /[Ee]lite/{
                s/^elite/\\o'e\\(\\\\''lite/
                s/ elite/ \\o'e\\(\\\\''lite/
                s/Elite/\\o'\\s-2E\\s0\\(\\\\''lite/
                }
        }
        /^\.TS/,/^\.TE/!{
        /^\.nf/,/^\.fi/!{
                /[`!$]/!{
                /^[^.]/{
                        / sub$/{
                                N
                                s/\n/-/
                        }
                }
                }
                /^[^.]/{
                        /[Ffei][icg][roh][sne][tdr]$/{
                                N
                                s/\norder/-order/
                                s/\nbest/-best/
                        }
                }
        }
        }
}
}
}
}
