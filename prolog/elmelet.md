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
_?- esik._                    | `true`			| definiálva van, tehát igaz
_?- erik_okos._               | `true`			| definiálva van, tehát igaz
_?- john_elorelato._          | `error`			| nincs definiálva, a prolog nem találja, ezért hibát dob


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
_?- kedveli(john,mary)._      | `true`			| van találat
_?- kedveli(mary,john)._      | `false`			| a reláció ebbe az irányba nem volt definiálva
_?- eszik(jani,alma)._        | `true`			| van találat
_?- eszik(mary,korte)._       | `false`			| nincs definiálva

## 2) Változók alkalmazása

Mostanra tudunk predikátumokat megfogalmazni, viszont ezzel még nem megyünk sokra. Ahhoz, hogy ezeket komplexebb feladatokra is tudjuk használni, pl. kérdéseket(lekérdezéseket) megfogalmazni szükségünk lesz a __változókra__.

Tegyük fel, hogy definiálva van az alábbi:

`eszik(feri,alma).`

Hogyan kérdezzük azt le, hogy mit eszik feri? Változó segítségével!

Példa:

Parancs                       | Válasz			| Eredmény			| Magyarázat
:---------------------------- | :-------------	| :-------------	| :-------------
_?- eszik(fred,Mit)._         | `Mit=alma`      | `true`			| A _Mit_ változó(k)ba a prolog behelyettesíti a predikátumban megadott értéke(ke)t, ha talál


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

Parancs                       | Válasz			| Eredmény			| Magyarázat
:---------------------------- | :-------------	| :-------------	| :-------------
_?- szereti(jani,Kit)._       | `Kit=marcsi`    | `true`			| van találat (igazzal tér vissza), a változóba kerül a megfelelõ érték
_?- szereti(marcsi,Kit)._     | `false`         | `false`			| marcsira nem definiáltunk predkátumot, ezért a lekérdezés hamissal tér vissza
_?- eszik(marcsi,Mit)._       | `false`         | `false`			| nincs definiálva a predikátum, hamissal tér vissza
_?- utazik(feri,Mivel)._      | `Mivel=busszal`; `Mivel=kocsival`| `true`			| van találat, több is, a változóba több érték is bekerül
