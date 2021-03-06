# Prolog Elm�let

----------

#### Forr�sok:
Tamsin Treasure-Jones: [Introduction to Prolog](http://www.doc.gold.ac.uk/~mas02gw/prolog_tutorial/prologpages/)

J.R.Fisher: [prolog_tutorial](http://www.csupomona.edu/~jrfisher/www/prolog_tutorial/contents.html)

## 1) Predik�tumok (t�nyek/�ll�t�sok)

Prologban k�tf�le k�ppen tudunk predik�tumok megfogalmazni: konkr�t �rt�kekkel, vagy rel�ci�kkal.

### a) Egyszer� predik�tumok:

Egyszer� predik�tumokra a k�vetkez� szab�lyok �rv�nyesek:

- mindig kisbet�vel kell kezd�djenek �s full stoppal v�gz�djenek (`.`)
- tartalmazhatnak b�rmilyen, �s b�rmennyi bet�t, vagy sz�mot, �s az `_` karaktert
- matematikai m�veletet jelk�pez� karaktereket c�lszer� mell�zni (`+`,`-`,`*`, stb...)

P�r egyszer� predik�tum:
```
/** predikatumok */
esik.
john_otthon_hagyta_a_kabatjat.
erik_okos.
```

Ezek ut�n ha r�k�rdez�nk az al�bbiakra:

Parancs                       | Eredm�ny		| Magyar�zat
:---------------------------- | :-------------	| :-------------
`?- esik.`                    | `true`			| defini�lva van, teh�t igaz
`?- erik_okos.`               | `true`			| defini�lva van, teh�t igaz
`?- john_elorelato.`          | `error`			| nincs defini�lva, a prolog nem tal�lja, ez�rt hib�t dob


### b) Predik�tumok rel�ci�kkal:

A rel�ci�kra az al�bbi szab�lyok �rv�nyesek:

- mindig kisbet�vel kell kezd�djenek
- egy predik�tum mindig csak a benne felsoroltakra igaz

```
/** predikatumok */
kedveli(john,mary).
eszik(jani,alma).
eszik(feri,narancs).
```

Ezek ut�n, ha megk�rdezz�k a prologot:

Parancs                       | Eredm�ny		| Magyar�zat
:---------------------------- | :-------------	| :-------------
`?- kedveli(john,mary).`      | `true`			| van tal�lat
`?- kedveli(mary,john).`      | `false`			| a rel�ci� ebbe az ir�nyba nem volt defini�lva
`?- eszik(jani,alma).`        | `true`			| van tal�lat
`?- eszik(mary,korte).`       | `false`			| nincs defini�lva

## 2) V�ltoz�k alkalmaz�sa

Mostanra tudunk predik�tumokat megfogalmazni, viszont ezzel m�g nem megy�nk sokra. Ahhoz, hogy ezeket komplexebb feladatokra is tudjuk haszn�lni, pl. k�rd�seket(lek�rdez�seket) megfogalmazni sz�ks�g�nk lesz a __v�ltoz�kra__.

### a) Egyszer� v�ltoz� haszn�lat
Tegy�k fel, hogy defini�lva van az al�bbi:

```
/** predikatum */
eszik(feri,alma).
```

Hogyan k�rdezz�k azt le, hogy mit eszik feri? V�ltoz� seg�ts�g�vel!

P�lda:

Parancs                       | V�ltoz�			| Eredm�ny			| Magyar�zat
:---------------------------- | :-------------	| :-------------	| :-------------
`?- eszik(feri,Mit).`         | _Mit=alma_      | `true`			| A _Mit_ v�ltoz�(k)ba a prolog behelyettes�ti a predik�tumban megadott �rt�ke(ke)t, ha tal�l


A v�ltoz�kra az al�bbi szab�lyok �rv�nyesek:

- mindig nagy bet�vel kezd�dnek
- a kezd� karaktert k�vet�en b�rmennyi kis �s nagy bet� szerepelhet benn�k
- sz�veges elemeket elv�laszthatunk az `_` seg�ts�g�vel

Tov�bbi p�ld�k:

```
/** predikatumok */
szereti(jani,marcsi).
szereti(feri,hobbik).
utazik(feri,busszal).
utazik(feri,kocsival).
```

Parancs                       | V�ltoz�			| Eredm�ny			| Magyar�zat
:---------------------------- | :-------------	| :-------------	| :-------------
`?- szereti(jani,Kit).`       | _Kit=marcsi_    | `true`			| van tal�lat (igazzal t�r vissza), a v�ltoz�ba ker�l a megfelel� �rt�k
`?- szereti(marcsi,Kit).`     |                 | `false`			| ebbe az ir�nyba nem defini�ltunk predik�tumot, ez�rt a lek�rdez�s hamissal t�r vissza
`?- szereti(Kit,marcsi).`     | _Kit=jani_      | `true`			| �gy m�r van tal�lat
`?- eszik(marcsi,Mit).`       |                 | `false`			| nincs defini�lva a predik�tum, hamissal t�r vissza
`?- utazik(feri,Mivel).`      | _Mivel=busszal_; _Mivel=kocsival_| `true`			| van tal�lat, t�bb is, a v�ltoz�ba t�bb �rt�k is beker�l

### b) �sszetett v�ltoz� haszn�lat

Tegy�k fel, hogy van egy albumokb�l �ll� gy�jtem�ny�nk az iTunes-on, amin�l:

- a(z) #1 param�ter az album azonos�t�ja
- a(z) #2 param�ter az el�ad� neve
- a(z) #3 param�ter az album c�me
- a(z) #4 param�ter a kedvenc sz�m c�me az albumr�l

```
/** predikatumok */
album(1,van_morrison,astral_weeks,madam_george).
album(2,beatles,sgt_pepper,a_day_in_the_life).
album(3,beatles,abbey_road,something).
album(4,rolling_stones,sticky_fingers,brown_sugar).
album(5,eagles,hotel_california,new_kid_in_town).
```

Ha le akarn�nk k�rdezni az 5-�s azonos�t�j� elem adatait:

Parancs                       | V�ltoz�			  | Eredm�ny			| Magyar�zat
:---------------------------- | :-------------	  | :-------------	    | :-------------
`?- album(5,Eloado,Album,Kedvenc_Dal).`           | _Eloado = eagles_, _Album = hotel_california_, _Kedvenc_Dal = new_kind_in_town_    | `true`			| van tal�lat (igazzal t�r vissza), a v�ltoz�kba beker�lnek a megfelel� �rt�kek
`?- album(5,Eloado,_,_).`     | _Eloado = eagles_ | `true`			    | van tal�lat (igazzal t�r vissza), viszont csak az eloadora voltunk k�v�ncsiak, a t�bbi adatot mell�zni akartuk, �gy csak az el�ad�t kapjuk meg

__FIGYELEM!__

Amennyiben megpr�b�lunk kevesebb param�terrel lek�rdezni predik�tumokat, mint amennyivel defini�lva lenn�nek, a Prolog hib�t fog dobni!

pl. hogy ki utazik az al�bbi list�b�l budapestre:
```
/** predikatumok */
utazik(attila, budapest, eger).
utazik(eva, pecs, paks).
```

Parancs                       | Hiba            | Magyar�zat
:---------------------------- | :-------------	| :-------------
`?- utazik(Ki,budapest).`     | _Undefined procedure: utazik/2_   | Az utazik lek�rdez�st 2 param�terrel pr�b�ltuk megh�vni
                              | _However, there are definitions for: utazik/3_   | Ugyanakkor azt 3-mal kellett volna (3 tulajdons�g van defini�lva az utazik predik�tumban)

Helyes lek�rdez�s: `?- utazik(Ki,budapest,_).`

### c) Param�ter ignor�l�sa

Az el�z� p�ld�n kereszt�l ker�lt szeml�ltet�sre az, hogy hogyan tudunk egyes adatokat ignor�lni/eltekinteni param�terez�s sor�n.

Amennyiben egyes adatokat ignor�lni szeretn�nk egy lek�rdez�s eset�n:

- az ahhoz az adathoz tartoz� param�ter hely�be "`_`" jelet kell tenn�nk
- semmi m�s nem szerepelhet az adott param�ter helyen!


## 3) Szab�lyok

### a) Alapok
A szab�lyok lehet�v� teszik sz�munkra, hogy felt�teles �ll�t�sokat fogalmazzunk meg a vil�gunkr�l/valamir�l, �s azokra k�rd�seket/lek�rdez�seket fogalmazzunk meg/�rt�kelj�nk ki. Minden szab�lynak lehet sz�mos v�ltozata, melye(ke)t z�rad�knak h�vunk.

__Vegy�k p�ld�ul az al�bbit:__ _"Minden ember haland�"_.

T�bbf�lek�pp is tudjuk ezt szeml�ltetni, de most az al�bbi p�ld�n�l maradunk:

```
/** szabaly */
halando(X) :-
	ember(X).

/** predikatumok */
ember(szokratesz).
ember(galileo).
isten(zeusz).
```

__�rtelmez�s:__ Adott `X` eset�n `X` akkor _halando_, ha `X` _ember_. M�sik �rtelmez�s: `X` -re akkor igaz, hogy _halando_, ha`X` _ember_.

Parancs                       | Eredm�ny		| Magyar�zat
:---------------------------- | :-------------	| :-------------
`?- halando(szokratesz).`     | `true`			| Mivel azt �ll�tottuk, hogy _szokratesz_ ember, ez�rt teljesult az, hogy halando
`?- halando(zeusz).`          | `false`			| Azt �ll�tottuk, hogy zeusz isten, teh�t nem haland�, teh�t hamissal t�r vissza

Ahhoz, hogy bebizony�tsuk, hogy _szokratesz_ halando, ahhoz el�sz�r a predik�tumok k�z�tt azt kellett �ll�tanunk, hogy ember :)

### b) Lek�rdez�sek

Lek�rdezni elemeket a r�juk jellemz� tulajdos�gok alapj�n hasonl� k�pp lehet, mint az el�z�leg t�rgyalt predik�tumok eset�n.

Lek�rdezni a haland�kat az a) pontban felv�zolt predik�tum lista eset�n:

Parancs               | V�ltoz�			  | Eredm�ny			| Magyar�zat
:-------------------- | :-------------	  | :-------------	    | :-------------
`?- halando(H).`      | _H = szokratesz_, _H = galileo_    | `true`			| Van tal�lat (igazzal t�r vissza), a v�ltoz�kba beker�lnek a megfelel� �rt�kek
`?- ember(E).`        | _E = szokratesz_, _E = galileo_    | `true`			| Term�szetesen az alap predik�tumokra is r� tudunk k�rdezni k�l�n (ezt csak ism�tl�sk�pp)

### c) �sszetett szab�lyok

A val� �letben az�rt a fentebb bemutatott p�ld�kn�l bonyolultabb a helyzet, t�bb szempont alapj�n kell �ltal�ban d�nteni.

Amit egy�b programoz�si nyelvek eset�n el�gaz�soknak, felt�teleknek szoktunk nevezni, na most azokr�l lesz sz�!

Tegy�k fel, hogy ahhoz, hogy valami tetszen az al�bbiaknak kell teljes�lni:

```
/** szabalyok */
tetszik(X) :-
    piros(X),
    auto(X).

tetszik(X) :-
    kek(X),
    motor(X).

auto(vw_beatle).
auto(ford_escort).
motor(harley_davidson).
kek(vw_beatle).
piros(ford_escort).
kek(harley_davidson).
```

### d) Lek�rdez�si pr�b�k arra, hogy melyik tetszhet:

Parancs                    | Eredm�ny        | Magyar�zat
:------------------------- | :-------------	 | :-------------
`?- tetszik(vw_beatle).`   | `false`	     | aut�, de k�k
`?- tetszik(ford_escort)`  | `true`		     | piros �s aut� is

Kilist�zni, hogy mi:

Parancs              | V�ltoz�          | Eredm�ny           | Magyar�zat
:--------------------| :-------------	| :-------------	 | :-------------
`?- tetszik(Mi).`    | _Mi = ford_escort ._, _Mi = harley_davidson_	| `true`     | Csak a Beatle felelt felelt meg a felsorolt felteteleknek
