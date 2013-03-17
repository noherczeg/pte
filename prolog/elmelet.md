# Prolog Elm�let

----------

#### Forr�sok:
[Tamsin Treasure-Jones](http://www.doc.gold.ac.uk/~mas02gw/prolog_tutorial/prologpages/)
[J.R.Fisher](http://www.csupomona.edu/~jrfisher/www/prolog_tutorial/contents.html)

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

Parancs                       | V�lasz			| Magyar�zat
:---------------------------- | :-------------	| :-------------
_:- esik._                    | `true`			| defini�lva van, teh�t igaz
_:- erik_okos._               | `true`			| defini�lva van, teh�t igaz
_:- john_elorelato._          | `error`			| nincs defini�lva, a prolog nem tal�lja, ez�rt hib�t dob


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

Parancs                       | V�lasz			| Magyar�zat
:---------------------------- | :-------------	| :-------------
_:- kedveli(john,mary)._      | `true`			| van tal�lat
_:- kedveli(mary,john)._      | `false`			| a rel�ci� ebbe az ir�nyba nem volt defini�lva
_:- eszik(jani,alma)._        | `true`			| van tal�lat
_:- eszik(mary,korte)._       | `false`			| nincs defini�lva

## 2) V�ltoz�k alkalmaz�sa

Mostanra tudunk predik�tumokat megfogalmazni, viszont ezzel m�g nem megy�nk sokra. Ahhoz, hogy ezeket komplexebb feladatokra is tudjuk haszn�lni, pl. k�rd�seket(lek�rdez�seket) megfogalmazni sz�ks�g�nk lesz a __v�ltoz�kra__.

Tegy�k fel, hogy defini�lva van az al�bbi:

`eszik(feri,alma).`

Hogyan k�rdezz�k azt le, hogy mit eszik feri? V�ltoz� seg�ts�g�vel!

P�lda:

Parancs                       | V�lasz			| Magyar�zat
:---------------------------- | :-------------	| :-------------
_:- eszik(fred,__Mit__)._     | `Mit=alma`      | A _Mit_ v�ltoz�ba a prolog behelyettes�ti a predik�tumban megadott �rt�ke(ke)t


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

Parancs                       | V�lasz			| Magyar�zat
:---------------------------- | :-------------	| :-------------
_:- szereti(jani,__Kit__)._   | `Kit=marcsi`    | van tal�lat
_:- szereti(marcsi,__Kit__)._ | `false`         | a rel�ci� ebbe az ir�nyba nem volt defini�lva
_:- eszik(marcsi,__Mit__)._   | `false`         | nincs defini�lva
_:- utazik(feri,__Mivel__)._  | `Mivel=busszal`, `Mivel=kocsival`| van tal�lat
