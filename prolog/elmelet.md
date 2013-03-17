# Prolog Elm�let

----------

#### Forr�sok:
[Tamsin Treasure-Jones: Introduction to Prolog](http://www.doc.gold.ac.uk/~mas02gw/prolog_tutorial/prologpages/)
[J.R.Fisher: prolog_tutorial](http://www.csupomona.edu/~jrfisher/www/prolog_tutorial/contents.html)

## 1) Predik�tumok (t�nyek/�ll�t�sok)

Prologban k�tf�le k�ppen tudunk predik�tumok megfogalmazni: konkr�t �rt�kekkel, vagy rel�ci�kkal.

### a) Egyszer� predik�tumok:

Egyszer� predik�tumokra a k�vetkez� szab�lyok �rv�nyesek:

- mindig kisbet�vel kell kezd�djenek �s full stoppal v�gz�djenek (`.`)
- tartalmazhatnak b�rmilyen, �s b�rmennyi bet�t, vagy sz�mot, �s az `_` karaktert
- matematikai m�veletet jelk�pez� karaktereket c�lszer� mell�zni (`+`,`-`,`*`, stb...)

P�r egyszer� predik�tum:
```
esik.
john_otthon_hagyta_a_kabatjat.
erik_okos.
```

Ezek ut�n ha r�k�rdez�nk az al�bbiakra:

Parancs                       | Eredm�ny		| Magyar�zat
:---------------------------- | :-------------	| :-------------
_?- esik._                    | `true`			| defini�lva van, teh�t igaz
_?- erik_okos._               | `true`			| defini�lva van, teh�t igaz
_?- john_elorelato._          | `error`			| nincs defini�lva, a prolog nem tal�lja, ez�rt hib�t dob


### b) Predik�tumok rel�ci�kkal:

A rel�ci�kra az al�bbi szab�lyok �rv�nyesek:

- mindig kisbet�vel kell kezd�djenek
- egy predik�tum mindig csak a benne felsoroltakra igaz

```
kedveli(john,mary).
eszik(jani,alma).
eszik(feri,narancs).
```

Ezek ut�n, ha megk�rdezz�k a prologot:

Parancs                       | Eredm�ny		| Magyar�zat
:---------------------------- | :-------------	| :-------------
_?- kedveli(john,mary)._      | `true`			| van tal�lat
_?- kedveli(mary,john)._      | `false`			| a rel�ci� ebbe az ir�nyba nem volt defini�lva
_?- eszik(jani,alma)._        | `true`			| van tal�lat
_?- eszik(mary,korte)._       | `false`			| nincs defini�lva

## 2) V�ltoz�k alkalmaz�sa

Mostanra tudunk predik�tumokat megfogalmazni, viszont ezzel m�g nem megy�nk sokra. Ahhoz, hogy ezeket komplexebb feladatokra is tudjuk haszn�lni, pl. k�rd�seket(lek�rdez�seket) megfogalmazni sz�ks�g�nk lesz a __v�ltoz�kra__.

Tegy�k fel, hogy defini�lva van az al�bbi:

`eszik(feri,alma).`

Hogyan k�rdezz�k azt le, hogy mit eszik feri? V�ltoz� seg�ts�g�vel!

P�lda:

Parancs                       | V�lasz			| Eredm�ny			| Magyar�zat
:---------------------------- | :-------------	| :-------------	| :-------------
_?- eszik(fred,Mit)._         | `Mit=alma`      | `true`			| A _Mit_ v�ltoz�(k)ba a prolog behelyettes�ti a predik�tumban megadott �rt�ke(ke)t, ha tal�l


A v�ltoz�kra az al�bbi szab�lyok �rv�nyesek:

- mindig nagy bet�vel kezd�dnek
- a kezd� karaktert k�vet�en b�rmennyi kis �s nagy bet� szerepelhet benn�k
- sz�veges elemeket elv�laszthatunk az `_` seg�ts�g�vel

Tov�bbi p�ld�k:

```
szereti(jani,marcsi).
szereti(feri,hobbik).
utazik(feri,busszal).
utazik(feri,kocsival).
```

Parancs                       | V�lasz			| Eredm�ny			| Magyar�zat
:---------------------------- | :-------------	| :-------------	| :-------------
_?- szereti(jani,Kit)._       | `Kit=marcsi`    | `true`			| van tal�lat (igazzal t�r vissza), a v�ltoz�ba ker�l a megfelel� �rt�k
_?- szereti(marcsi,Kit)._     | `false`         | `false`			| marcsira nem defini�ltunk predk�tumot, ez�rt a lek�rdez�s hamissal t�r vissza
_?- eszik(marcsi,Mit)._       | `false`         | `false`			| nincs defini�lva a predik�tum, hamissal t�r vissza
_?- utazik(feri,Mivel)._      | `Mivel=busszal`; `Mivel=kocsival`| `true`			| van tal�lat, t�bb is, a v�ltoz�ba t�bb �rt�k is beker�l
