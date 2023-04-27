#! /bin/sed -f
#polish.sedf2: tbl! : l!=1, Section, .)~ , [a-z]-, [0-9]-, [a-z].
/^\.\\"/!{
/^\.G1/,/^\.G2/!{
/^\.PS/,/^\.PE/!{
/^\.EQ/,/^\.EN/!{
        /^\.TS/,/^\.TE/!{
                /[0-9]/{
                s/l\([0-9]\)/1\1/g
                s/\([^+-sf][0-9]\)l/\11/g
                }
        /^\.nf/,/^\.fi/!{
                /^[^.]/{
                        /section/{
                        /[^-]section$/{
                                N
                                s/section\n\([0-9]\)/Section \1/
                                }
                        /[^-]sections$/{
                                N
                                s/sections\n\([0-9]\)/Sections \1/
                                }
                        }
                        /figure/{
                        /figure$/{
                                N
                                s/figure\n\([0-9]\)/Figure \1/
                                }
                        /figures$/{
                                N
                                s/figures\n\([0-9]\)/Figures \1/
                                }
                        }
                        /table/{
                        /table$/{
                                N
                                s/table\n\([0-9]\)/Table \1/
                                }
                        /tables$/{
                                N
                                s/tables\n\([0-9]\)/Tables \1/
                                }
                        }
                        /[?!.][)"]$/{
                                N
                                s/\([^ds]\.)\)\n\([A-Z]\)/\1~\
\2/
                                s/\."\n\([A-Z]\)/.\\(rq~\
\1/
                                s/\([?!])\)\n\([A-Z]\)/\1~\
\2/
                        }
                        /-$/{
                        /[a-z]-$/{
                                N
                                s/-\n\([a-z]\)/-\1/
                        }
                        /[0-9tdh]-$/{
                                N
                                s/-\n\([0-9]\)/\\-\1/
                                s/-\n\([a-z]\)/-\1/
                                s/-\n\([A-Z]\)/\\-~\
\1/
                        }
                        }
                        /[a-z]\.$/{
                                N
                                s/\.\n\([a-z]\)/.\\\& \1/
                        }
                        /up/{
                        /up to$/{
                                N
                                s/up to\ndate/up-to-date/
                        }
                        /up$/{
                                N
                                s/up\nto date/up-to-date/
                        }
                        }
                        /wear/{
                        /wear$/{
                                N
                                s/wear\nand tear/wear-and-tear/
                        }
                        /wear and$/{
                                N
                                s/wear and\ntear/wear-and-tear/
                        }
                        }
                        /[ivsfhw][ngoie][ehxfrn]ty$/{
                                N
                                s/\n\([otfsen][nwhoie][eoruvxgn]\)/-\1/
                        }
                }
        }
        }
}
}
}
}
