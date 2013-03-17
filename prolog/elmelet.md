# Prolog Elmélet

----------

#### Források:
Tamsin Treasure-Jones: [Introduction to Prolog](http://www.doc.gold.ac.uk/~mas02gw/prolog_tutorial/prologpages/)

J.R.Fisher: [prolog_tutorial](http://www.csupomona.edu/~jrfisher/www/prolog_tutorial/contents.html)

## 1) Predikátumok (tények/állítások)

Prologban kétféle képpen tudunk predikátumok megfogalmazni: konkrét értékekkel, vagy relációkkal.

### a) Egyszerû predikátumok:

Egyszerû predikátumokra a következõ szabályok érvényesek:

- mindig kisbetûvel kell kezdõdjenek és full stoppal végzõdjenek (`.`)
- tartalmazhatnak bármilyen, és bármennyi betût, vagy számot, és az `_` karaktert
- matematikai mûveletet jelképezõ karaktereket célszerû mellõzni (`+`,`-`,`*`, stb...)

Pár egyszerû predikátum:
```
/** predikatumok */
esik.
john_otthon_hagyta_a_kabatjat.
erik_okos.
```

Ezek után ha rákérdezünk az alábbiakra:

Parancs                       | Eredmény		| Magyarázat
:---------------------------- | :-------------	| :-------------
`?- esik.`                    | `true`			| definiálva van, tehát igaz
`?- erik_okos.`               | `true`			| definiálva van, tehát igaz
`?- john_elorelato.`          | `error`			| nincs definiálva, a prolog nem találja, ezért hibát dob


### b) Predikátumok relációkkal:

A relációkra az alábbi szabályok érvényesek:

- mindig kisbetûvel kell kezdõdjenek
- egy predikátum mindig csak a benne felsoroltakra igaz

```
/** predikatumok */
kedveli(john,mary).
eszik(jani,alma).
eszik(feri,narancs).
```

Ezek után, ha megkérdezzük a prologot:

Parancs                       | Eredmény		| Magyarázat
:---------------------------- | :-------------	| :-------------
`?- kedveli(john,mary).`      | `true`			| van találat
`?- kedveli(mary,john).`      | `false`			| a reláció ebbe az irányba nem volt definiálva
`?- eszik(jani,alma).`        | `true`			| van találat
`?- eszik(mary,korte).`       | `false`			| nincs definiálva

## 2) Változók alkalmazása

Mostanra tudunk predikátumokat megfogalmazni, viszont ezzel még nem megyünk sokra. Ahhoz, hogy ezeket komplexebb feladatokra is tudjuk használni, pl. kérdéseket(lekérdezéseket) megfogalmazni szükségünk lesz a __változókra__.

### a) Egyszerû változó használat
Tegyük fel, hogy definiálva van az alábbi:

```
/** predikatum */
eszik(feri,alma).
```

Hogyan kérdezzük azt le, hogy mit eszik feri? Változó segítségével!

Példa:

Parancs                       | Változó			| Eredmény			| Magyarázat
:---------------------------- | :-------------	| :-------------	| :-------------
`?- eszik(feri,Mit).`         | _Mit=alma_      | `true`			| A _Mit_ változó(k)ba a prolog behelyettesíti a predikátumban megadott értéke(ke)t, ha talál


A változókra az alábbi szabályok érvényesek:

- mindig nagy betûvel kezdõdnek
- a kezdõ karaktert követõen bármennyi kis és nagy betû szerepelhet bennük
- szöveges elemeket elválaszthatunk az `_` segítségével

További példák:

```
/** predikatumok */
szereti(jani,marcsi).
szereti(feri,hobbik).
utazik(feri,busszal).
utazik(feri,kocsival).
```

Parancs                       | Változó			| Eredmény			| Magyarázat
:---------------------------- | :-------------	| :-------------	| :-------------
`?- szereti(jani,Kit).`       | _Kit=marcsi_    | `true`			| van találat (igazzal tér vissza), a változóba kerül a megfelelõ érték
`?- szereti(marcsi,Kit).`     |                 | `false`			| ebbe az irányba nem definiáltunk predikátumot, ezért a lekérdezés hamissal tér vissza
`?- szereti(Kit,marcsi).`     | _Kit=jani_      | `true`			| így már van találat
`?- eszik(marcsi,Mit).`       |                 | `false`			| nincs definiálva a predikátum, hamissal tér vissza
`?- utazik(feri,Mivel).`      | _Mivel=busszal_; _Mivel=kocsival_| `true`			| van találat, több is, a változóba több érték is bekerül

### b) Összetett változó használat

Tegyük fel, hogy van egy albumokból álló gyûjteményünk az iTunes-on, aminél:

- a(z) #1 paraméter az album azonosítója
- a(z) #2 paraméter az elõadó neve
- a(z) #3 paraméter az album címe
- a(z) #4 paraméter a kedvenc szám címe az albumról

```
/** predikatumok */
album(1,van_morrison,astral_weeks,madam_george).
album(2,beatles,sgt_pepper,a_day_in_the_life).
album(3,beatles,abbey_road,something).
album(4,rolling_stones,sticky_fingers,brown_sugar).
album(5,eagles,hotel_california,new_kid_in_town).
```

Ha le akarnánk kérdezni az 5-ös azonosítójú elem adatait:

Parancs                       | Változó			  | Eredmény			| Magyarázat
:---------------------------- | :-------------	  | :-------------	    | :-------------
`?- album(5,Eloado,Album,Kedvenc_Dal).`           | _Eloado = eagles_, _Album = hotel_california_, _Kedvenc_Dal = new_kind_in_town_    | `true`			| van találat (igazzal tér vissza), a változókba bekerülnek a megfelelõ értékek
`?- album(5,Eloado,_,_).`     | _Eloado = eagles_ | `true`			    | van találat (igazzal tér vissza), viszont csak az eloadora voltunk kíváncsiak, a többi adatot mellõzni akartuk, így csak az elõadót kapjuk meg

__FIGYELEM!__

Amennyiben megpróbálunk kevesebb paraméterrel lekérdezni predikátumokat, mint amennyivel definiálva lennének, a Prolog hibát fog dobni!

pl. hogy ki utazik az alábbi listából budapestre:
```
/** predikatumok */
utazik(attila, budapest, eger).
utazik(eva, pecs, paks).
```

Parancs                       | Hiba            | Magyarázat
:---------------------------- | :-------------	| :-------------
`?- utazik(Ki,budapest).`     | _Undefined procedure: utazik/2_   | Az utazik lekérdezést 2 paraméterrel próbáltuk meghívni
                              | _However, there are definitions for: utazik/3_   | Ugyanakkor azt 3-mal kellett volna (3 tulajdonság van definiálva az utazik predikátumban)

Helyes lekérdezés: `?- utazik(Ki,budapest,_).`

### c) Paraméter ignorálása

Az elõzõ példán keresztül került szemléltetésre az, hogy hogyan tudunk egyes adatokat ignorálni/eltekinteni paraméterezés során.

Amennyiben egyes adatokat ignorálni szeretnénk egy lekérdezés esetén:

- az ahhoz az adathoz tartozó paraméter helyébe "`_`" jelet kell tennünk
- semmi más nem szerepelhet az adott paraméter helyen!


## 3) Szabályok

### a) Alapok
A szabályok lehetõvé teszik számunkra, hogy feltételes állításokat fogalmazzunk meg a világunkról/valamirõl, és azokra kérdéseket/lekérdezéseket fogalmazzunk meg/értékeljünk ki. Minden szabálynak lehet számos változata, melye(ke)t záradéknak hívunk.

__Vegyük például az alábbit:__ _"Minden ember halandó"_.

Többféleképp is tudjuk ezt szemléltetni, de most az alábbi példánál maradunk:

```
/** szabaly */
halando(X) :-
	ember(X).

/** predikatumok */
ember(szokratesz).
ember(galileo).
isten(zeusz).
```

__Értelmezés:__ Adott `X` esetén `X` akkor _halando_, ha `X` _ember_. Másik értelmezés: `X` -re akkor igaz, hogy _halando_, ha`X` _ember_.

Parancs                       | Eredmény		| Magyarázat
:---------------------------- | :-------------	| :-------------
`?- halando(szokratesz).`     | `true`			| Mivel azt állítottuk, hogy _szokratesz_ ember, ezért teljesult az, hogy halando
`?- halando(zeusz).`          | `false`			| Azt állítottuk, hogy zeusz istten, tehát nem halandó, tehát hamissal tér vissza

Ahhoz, hogy bebizonyítsuk, hogy _szokratesz_ halando, ahhoz elõször a predikátumok között azt kellett állítanunk, hogy ember :)

### b) Lekérdezések

Lekérdezni elemeket a rájuk jellemzõ tulajdoságok alapján hasonló képp lehet, mint az elõzõleg tárgyalt predikátumok esetén.

Lekérdezni a halandókat az a) pontban felvázolt predikátum lista esetén:

Parancs               | Változó			  | Eredmény			| Magyarázat
:-------------------- | :-------------	  | :-------------	    | :-------------
`?- halando(H).`      | _H = szokratesz_, _H = galileo_    | `true`			| Van találat (igazzal tér vissza), a változókba bekerülnek a megfelelõ értékek
`?- ember(E).`        | _E = szokratesz_, _E = galileo_    | `true`			| Természetesen az alap predikátumokra is rá tudunk kérdezni külön (ezt csak ismétlésképp)

