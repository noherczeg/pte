# Prolog Elm�let

----------

#### Forr�sok:
(Tamsin Treasure-Jones)[http://www.doc.gold.ac.uk/~mas02gw/prolog_tutorial/prologpages/]
(J.R.Fisher)[http://www.csupomona.edu/~jrfisher/www/prolog_tutorial/contents.html]

## 1) T�nyek

Prologban k�tf�le k�ppen tudunk t�nyeket megfogalmazni: konkr�t �rt�kekkel, vagy rel�ci�kkal.

### a) P�r egyszer� t�ny:
```
esik.
john_otthon_hagyta_a_kabatjat.
erik_okos.
```

Ezek ut�n ha r�k�rdez�nk dolgokra:

Parancs                       | V�lasz			| Magyar�zat
:---------------------------- | :-------------	| :-------------
_:- esik._                    | `true`			| defini�lva van, teh�t igaz
_:- erik_okos._               | `true`			| defini�lva van, teh�t igaz
_:- john_elorelato._          | `error`			| nincs defini�lva, a prolog nem tal�lja, ez�rt hib�t dob


### b) T�nyek rel�ci�kkal:

A rel�ci�kra az al�bbi szab�lyok �rv�nyesek:

- mindig kisbet�vel kell kezd�djenek
- egy t�ny mindig a benne felsoroltakra igaz , ez�rt a feldolgoz�si logik�val figyelni kell!

```
`kedveli(john,mary).`
`eszik(jani,alma).`
`eszik(feri,narancs).`
```

Ezek ut�n, ha megk�rdezz�k a prologot:

Parancs                       | V�lasz			| Magyar�zat
:---------------------------- | :-------------	| :-------------
_:- kedveli(john,mary)._      | `true`			| van tal�lat
_:- kedveli(mary,john)._      | `false`			| a rel�ci� ebbe az ir�nyba nem volt defini�lva
_:- eszik(jani,alma)._        | `true`			| van tal�lat
_:- eszik(mary,korte)._       | `false`			| nincs defini�lva
