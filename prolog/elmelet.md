# Prolog Elmélet

----------

#### Források:
(Tamsin Treasure-Jones)[http://www.doc.gold.ac.uk/~mas02gw/prolog_tutorial/prologpages/]
(J.R.Fisher)[http://www.csupomona.edu/~jrfisher/www/prolog_tutorial/contents.html]

# 1) Tények

Prologban kétféle képpen tudunk tényeket megfogalmazni: konkrét értékekkel, vagy relációkkal.

Pár egyszerû tény:
```
esik.
john_otthon_hagyta_a_kabatjat.
erik_okos.
```

Ezek után ha rákérdezünk dolgokra:

Parancs                       | Válasz
:---------------------------- | :-------------
_:- esik._                    | `true`
_:- erik_okos._               | `true`
_:- john_elorelato._          | `false`