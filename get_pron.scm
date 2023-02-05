;==========================================
;Title:  build_dict.sh
;Author: Sourya Kakarla
;
;Takes the language code and word as arguments
;Writes kaldi-style lexicon output line to stdout
;==========================================

(set! libdir "/usr/share/festival/")
(load (path-append libdir "init.scm"))
(load "indic_lexicon.scm")
(define lang (car argv))
(define word (cadr argv))
(define pron (car (car (car (cdr (cdr (indic_ml_lts_function word "")))))))
(format t "%s\t%l\n" word pron)
