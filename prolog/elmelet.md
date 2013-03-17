# Prolog Elmélet

----------

#### Források:
[Tamsin Treasure-Jones: Introduction to Prolog](http://www.doc.gold.ac.uk/~mas02gw/prolog_tutorial/prologpages/)
[J.R.Fisher: prolog_tutorial](http://www.csupomona.edu/~jrfisher/www/prolog_tutorial/contents.html)

## 1) Predikátumok (tények/állítások)

Prologban kétféle képpen tudunk predikátumok megfogalmazni: konkrét értékekkel, vagy relációkkal.

### a) Egyszerû predikátumok:

Egyszerû predikátumokra a következõ szabályok érvényesek:

- mindig kisbetûvel kell kezdõdjenek és full stoppal végzõdjenek (`.`)
- tartalmazhatnak bármilyen, és bármennyi betût, vagy számot, és az `_` karaktert
- matematikai mûveletet jelképezõ karaktereket célszerû mellõzni (`+`,`-`,`*`, stb...)

Pár egyszerû predikátum:
```
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

`eszik(feri,alma).`

Hogyan kérdezzük azt le, hogy mit eszik feri? Változó segítségével!

Példa:

Parancs                       | Változó			| Eredmény			| Magyarázat
:---------------------------- | :-------------	| :-------------	| :-------------
`?- eszik(fred,Mit).`         | _Mit=alma_      | `true`			| A _Mit_ változó(k)ba a prolog behelyettesíti a predikátumban megadott értéke(ke)t, ha talál


A változókra az alábbi szabályok érvényesek:

- mindig nagy betûvel kezdõdnek
- a kezdõ karaktert követõen bármennyi kis és nagy betû szerepelhet bennük
- szöveges elemeket elválaszthatunk az `_` segítségével

További példák:

```
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
album(1,van_morrison,astral_weeks,madam_george).
album(2,beatles,sgt_pepper,a_day_in_the_life).
album(3,beatles,abbey_road,something).
album(4,rolling_stones,sticky_fingers,brown_sugar).
album(5,eagles,hotel_california,new_kid_in_town).
```

Ha le akarnánk kérdezni az 5-ös azonosítójú elem adatait:

Parancs                       | Változó			  | Eredmény			| Magyarázat
:---------------------------- | :-------------	  | :-------------	    | :-------------
`?- album(5,Eloado, Album, Kedvenc_Dal).`         | _Eloado = eagles_, _Album = hotel_california_, _Kedvenc_Dal = new_kind_in_town_    | `true`			| van találat (igazzal tér vissza), a változókba bekerülnek a megfelelõ értékek
`?- album(5,Eloado, _, _).`   | _Eloado = eagles_ | `true`			    | van találat (igazzal tér vissza), viszont csak az eloadora voltunk kíváncsiak, a többi adatot mellõzni akartuk, így csak az elõadót kapjuk meg

### c) Paraméter ignorálása

Az elõzõ példán keresztül került szemléltetésre az, hogy hogyan tudunk egyes adatokat ignorálni/kihagyni.

Amennyiben egyes adatokat ignorálni szeretnénk egy lekérdezés esetén:

- az ahhoz az adathoz tartozó paraméter helyébe "`_`" jelet kell tennünk
- semmi más nem szerepelhet az adott paraméter helyen!