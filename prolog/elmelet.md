# Prolog Elm�let

----------

#### Forr�sok:
(Tamsin Treasure-Jones)[http://www.doc.gold.ac.uk/~mas02gw/prolog_tutorial/prologpages/]
(J.R.Fisher)[http://www.csupomona.edu/~jrfisher/www/prolog_tutorial/contents.html]

# 1) T�nyek

Prologban k�tf�le k�ppen tudunk t�nyeket megfogalmazni: konkr�t �rt�kekkel, vagy rel�ci�kkal.

P�r egyszer� t�ny:
```
esik.
john_otthon_hagyta_a_kabatjat.
erik_okos.
```

Ezek ut�n ha r�k�rdez�nk dolgokra:

Parancs                       | V�lasz
:---------------------------- | :-------------
_:- esik._                    | `true`
_:- erik_okos._               | `true`
_:- john_elorelato._          | `false`