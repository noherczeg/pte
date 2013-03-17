# Prolog Elmélet

----------

#### Források:
(Tamsin Treasure-Jones)[http://www.doc.gold.ac.uk/~mas02gw/prolog_tutorial/prologpages/]
(J.R.Fisher)[http://www.csupomona.edu/~jrfisher/www/prolog_tutorial/contents.html]

## 1) Tények

Prologban kétféle képpen tudunk tényeket megfogalmazni: konkrét értékekkel, vagy relációkkal.

### a) Pár egyszerû tény:
```
esik.
john_otthon_hagyta_a_kabatjat.
erik_okos.
```

Ezek után ha rákérdezünk dolgokra:

Parancs                       | Válasz			| Magyarázat
:---------------------------- | :-------------	| :-------------
_:- esik._                    | `true`			| definiálva van, tehát igaz
_:- erik_okos._               | `true`			| definiálva van, tehát igaz
_:- john_elorelato._          | `error`			| nincs definiálva, a prolog nem találja, ezért hibát dob


### b) Tények relációkkal:

A relációkra az alábbi szabályok érvényesek:

- mindig kisbetûvel kell kezdõdjenek
- egy tény mindig a benne felsoroltakra igaz , ezért a feldolgozási logikával figyelni kell!

```
`kedveli(john,mary).`
`eszik(jani,alma).`
`eszik(feri,narancs).`
```

Ezek után, ha megkérdezzük a prologot:

Parancs                       | Válasz			| Magyarázat
:---------------------------- | :-------------	| :-------------
_:- kedveli(john,mary)._      | `true`			| van találat
_:- kedveli(mary,john)._      | `false`			| a reláció ebbe az irányba nem volt definiálva
_:- eszik(jani,alma)._        | `true`			| van találat
_:- eszik(mary,korte)._       | `false`			| nincs definiálva
