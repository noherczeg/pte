#Elméleti kérdések:

####1) Milyen utasítással nézné meg, hogy egy adott gép hálózatra van-e kötve és aktív hálózati kapcsolattal bír? Magyarázza el a kimenetet!
`ifconfig`, interfacek listáját mutatja, illetve azoknak az állapotát, információkat (ip, mac, up/down/stb..)

####2) Mi az SMTP és mire használjuk?
Az SMTP a Simple Mail Transfer Protocol rövidítése. Ez egy szabványos kommunikációs protokoll az e-mailek Interneten történő továbbítására.

####3) Mi az MTA és mire használjuk?
Mail Transfer Agent, vagyis maga a levelező kiszolgáló, ami a levelek továbbítását végzi (SMTP protokollon keresztül)

####4) Melyik 2 fileban tárolja a Postfix az alapvető konfigurációs beállításokat?
`/etc/postfix/` mapa: `main.cf` és a `master.cf`

####5) Mit jelent az, ha egy SMTP szerver a data parancs után kiadott "."-ot követően a "250 Ok" üzenetet adja?
Kiadott levél művelet végrehajtva

####6) MySQL konzolban hozzon létre egy új adatbázist ZH néven, és adjon rá teljes jogosultságot a ZHUSER felhasználónak. Bárhonnan érhesse el az adatbázist. A jelszava ZHPASS legyen.
```
CREATE DATABASE ZH;
CREATE USER  ’ZHUSER’@’localhost’ IDENTIFIED by ’ZHPASS’;
GRANT ALL PRIVILEGES on ZH.* to ’ZHUSER’@’localhost’;
```

####7) Írja le a http protokoll működését! Alapértelmezetten milyen porton, protokollon üzemel egy http kiszolgáló? Írjon 3 hibakódot, magyarázza el jelentésüket!
+ A böngésző egy TCP/IP kapcsolatot hoz létre a szerver megfelelő portjával (alapértelmezetten 80)
+ A böngésző egy http kérést (REQUEST) küld a szervernek.
+ A szerver egy http választ küld(RESPONSE), amely ha nincs hiba, akkor a lekért tartalmat és a hozzá tartozó fejléc adatokat tartalmazza (pl. sütik, stb..)

```
400 = Bad Request (a request rosz szintaxist használt)
403 = Forbidden (hiányzó jogosultság miatt tiltott)
404 = Not Found (A dokumentum nem található)
500 = Server error (A szervernek problémája van a kérés kiszolgálásával, nem szeretjük -.-")
```
####8) Mi az Apache?
Az Apache HTTP Server egy nyílt forráskódú webkiszolgáló alkalmazás, szabad szoftver.
 
####9) Írjon egy Apache féle Virtual hostot!
```
<VirtualHost *:80>
    DocumentRoot /www/example2
    ServerName www.example.org
    ServerAlias server
    RewriteEngine On
    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteCond %{REQUEST_FILENAME} !-d
    RewriteRule ^(.*)$ ./index.php?/$1 [L]
</VirtualHost>
```

####10) Írjon 3 Apache modult, magyarázza el mire jók?
+ `mod_ssl` biztonságos adatkapcsolat SSL/TSL használatához kell
+ `mod_log_config` Loggolás testreszabása.
+ `mod_gzip` Tömöríteni tujda a webes tartalmakat, ez által kisebb csomagok, nagyobb órajel igény!

####11) Az Apache-nál mi célt szolgál a Mime Types?
A fájlok típusát segít meghatározni a kiterjesztésük alapján.

####12) Az Apache-nál mi a Handler?
A handlerek vezérlik a web sezerver működését bizonyos file typusok/kiterjesztések esetén

####13 Írjon egy authentikált oldalt Apache webserver alatt! Milyen parancsal lehet generálni jelszót az authentikált oldalhoz?

```
AuthUserFile /var/www/akarmi.hu/backup/.htpasswd
AuthName "Protected Site"
AuthType Basic
Required valid-user user1
```

`htpasswd` parancssal!

####14) Hogyan védené le, hogy ne férjenek hozzá egy vagy több fájlhoz Apache-ban?
Pl. `kedvencek.html` olvasásának tiltása `.htaccess` file-ban:
```
<Files kedvencek.html>
    order allow,deny
    deny from all
</files>
```
####15) Hogyan tiltana le bizonyos funkciókat PHP-ban?
`php.ini` –ben: `disable_functions = "felsorolás vesszővel"`

####16) Hogyan kapcsolná ki, hogy a PHP scriptek által generált hibák ne jelenjenek meg a weboldal megnyitásakor?
`php.ini` –ben: `display_errors off`-ra állítani

####17) Változtassa meg a MySql jelszavát konzol alol!
```
USE mysql;
UPDATE mysql.user SET password=PASSWORD(’jelszó’) WHERE user=’usernév’ AND Host='localhost';
FLUSH PRIVILEGES;
```

####18) Indokolja meg, hogy miért éri meg áttérni a syslog-ng rendszerre a Debianon alapból installált rsyslog helyett?
+ Megbízható továbbítás (TCP)
+ Lemez alapú log bufferelés
+ Közvetlen adatbázis elérés (MySQL, MSSQL, Oracle)
+ Titkosított és időbélyeggel ellátott log tárolás
+ Filterek, parse-olás és rewrite lehetőség

####19) Mi az a VirtualHost egy webserver esetében
Több weboldalt tudunk üzemeltetni egy serveren. Lehetnek IP alapú és név alapúak. A kliens oldalon ez nem egyértelmű

####20) Mi a Spam?
A spam kéretlen elektronikus reklámüzenet, mely terjedhet e-mailben, SMS-ben, de gyakran használják a kifejezést a papírformában terjesztett szórólapokra is.

####21) Soroljon fel Spam formákat(legalább 3-at)!
+ Kéretlen e-mail
+ Vírusos üzenet
+ Joe-jobbing
+ Backscatter

####22) Mit tud az aktív és passzív módú FTP szerverről, átvitelről? Különbségek, előnyök, hátrányok, portok, protokollok.
Az FTP serverek két csatornát használnak: adat, és parancs
A különbség lényegében annyi, hogy egyik esetben a kliens, másik esetben pedig a server létesíti az adatkapcsolatot.

+ Passive: kliens létesíti _mindkét kapcsolatot_, a server mondja meg milyen portot használjanak adat csatornaként
+ Active: a kliens létesíti a _parancs kapcsolatot_ (kliens port X-ről server port 21-re) a server létesíti az _adatkapcsolatot_ (server port 20-ról kliens port Y-ra, Y-t a kliens adta meg)

Manapság a passive van használatban inkább, mert könnyebb használni tűzfalak mellett is.

####23) Mi az a Greylisting? Hogyan alkalmazzuk? Hol nem alkalmazható?
Spam és egyéb kéretlen tartalmak elleni védekezés egy viszonylag új módja.

Alapelve, hogy a nem whitelisten lévő szerverektől jövő leveleket egy ideiglenes hibaüzenettel eldobja, amire válaszul minden RFC követő levelezőszerver egy bizonyos időintervallumon belül újra próbálkozik. A spamküldő zombik túlnyomó többsége nem próbálkozik újra soha.

Hátránya, hogy az open relay serverek ellen hatástalan (mivel az teljes MTA), illetve a nem whitelistelt szerverekről érkező levelek kis késést szenvednek.
 
####24) Soroljon fel legalább 5 Spammer trükköt!
+ Random karakterek, szövegrészek beillesztése
+ Szándékosan hibás írásmód
+ Hibás, nem létező HTML tagek
+ wildcard DNS rekordok
+ különböző IP blokkból több IP cím a webszervernek

####25) Mi történik, ha beírjuk a parancssorba, hogy "pwd"?
Kiírja az aktuális könyvtárat.

####26) Mit jelent, ha telnettel rákapcsolódik egy szerver 25-ös portjára és az a válasz érkezik, hogy connection refused?
Valószínüleg a mail server csak localhoston „hallgatózik”, ezt lehet ellenőrizni a ```sudo netstat –plntu``` paranccsal.

Ha így van, akkor a mail server konfigurációt át kell írnunk, hogy minden interfacen hozzá lehessen férni

####27) Hogyan kell Telnettel e-mailt küldeni?
```
MAIL FROM: teszt@test.kliens.hu
RCPT TO: teszt@teszt.szerver.hu
DATA
üzenet…
.
QUIT
```
####28) Mi az a Postfixadmin? Mire való? Mit tud?
Ez egy adminisztrációs program, levéltovábbító ügynök.

####29) Hova kerülnek a feldolgozatlan levelek egy levelező szervernél?
Karanténba

####30) Mi az a cron rendszer és mire való?
Időzíthető feladat ütemező (programok, scriptek futtatása), lehet rendszer szintű és felhasználó szintű is. Jellemzően backup, szinkronizáció, takarítási feladatokat indít.

####31) Mi az a szuperszerver? Miért kell, mire való? Előnyök, hátrányok?
Unix tipusu rendszereken van jelen. Más szolgáltatások nevében hallgatózik, ha kell, elindítja őket. Kis erőforrás igény készenléti módban. Ideális inetd és SSH serverek esetén pl. A sub-daemonokhoz való csatlakozás picit lassabb, ezért standalone server rendszerekhez képest az egész lassabb.

`inetd`: Internet Daemon, konfig fileja mondja meg mi induljon el (`/etc/inetd.conf`)

####32) Mi az RPC és mire jó? Soroljon fel RPC szolgáltatásokat!
Remote Procedure Call (távoli parancs végrehajtás)

Lehetővé teszi a távoli eljárások meghívását, miközben elrejti a felhasználó elől az alsóbb hálózati rétegeket.

+ rLogin
+ rSh
+ rCp

####33) Shell script, jelszó ellenőrzés argumentumból(nem olvas/ír filet!)
```
#!/bin/sh

if [ $# -ne 1 ]; then
    echo "Nem kaptam argumentumot!"
else
    if echo $1 | grep -Eq '^([a-zA-Z][0-9][\!\@\#\$\%\^\&\*]+)$'; then
        echo "valos jelszo!"
    else
        echo "nem megfelelo jelszo!"
    fi
fi
```

####34) Jellemezze a Debian operációs rendszert
+ open source
+ linux kernelt használ
+ ingyenes (pár csomag fizetős)
+ több hardvert/architektúrát is támogat

####35) Mik azok a DLL-ek, nevük linux alatt, helyük, használt dll-ek listája
DLL mint betűszó, a Dynamically Linked Library-t takarja, azaz dinamikusan csatolt függvénykönyvtár. Ezek gyakran használt eljárásokat implementálnak, a dinamikusan fordított programok használják őket (dynamically compiled), amely futásidőben betölti a saját kódja mellé a library-kban levő eljárásokat is.
Linux alatt "library", .so kiterjesztés, `/lib, /usr/lib, /usr/local/lib` mappákban, csomag kezelők kezelik őket

####36) Milyen filerendszert installálunk a swap partícióra? Mire kell?
Semmilyet, nyers formátumban tároljuk benne az adatokat, lapozás helye

####37) Milyen logokat generál a MySql? Jellemezze ezeket!
/var/log/mysql.log
+ error: a daemon szabványos hiba kimenete, pl. hostnev.err
+ Bináris log: minden adatmódosítást rögzít, biztonsági mentéseknél használható
+ Lassú lekérdezés log: (slow query log), azok a műveletek amelyek tovább tartanak mint egy megadott érték

####38) Mit jelent a /etc/syslog.conf-ban: kern.crit /var/adm/kernel
Az összes kritikus üzenet a `/var/adm/kernel` fájlba kerülnek

####39) Adjon meg minimum 4 db gTLD-t!
.com, .org, .net, .info

####40) Mutassa be az ethernet technológiát röviden!
Alapsávú LAN-ra vonatkozó specifikáció. Az ütközések feloldására a CSMA/CD-t használják. Kábeltipusok: koax, réz, stb. Minimum 10Mbps, classic, fast, gigabit

Adott pillanatban csak egy gép "használhatja a kábelt", a kiküldött jel minden gépet elér.

####41) Mi a primary és secondary DNS? Mi a szerepük?
+ Primary: Zóna adatokat egy file-ból olvassa, fennhatósággal (authority) rendelkezik a zóna felett
+ Secondary: Zóna adatok egy másik nameserver-től kapja, átveheti a kieső primary helyét

####42) Soroljon fel legalább 4 féle DNS rekord tipust, írja le, hogy melyik mit ad meg!
+ SOA: Start Of Authority, fennhatóságot definiál egy zónára
+ NS: A zóna nameserver-einek listája
+ CNAME: Canonical név
+ PTR: Címből név feloldás

####43) Indokolja meg, hogy .... Gentoo saját package managert használ/fejleszt!
Neve: Portage. Univerzális (BSD, MAC OS, Solaris, stb..) csomagkezelőt akartak, aminek a segítségével elkerülhetőek az inkonzisztenciák a különböző egyéb PM-ek között.

####44) Mire való a szuperblokk, inode, indirekciós blokk, könyvtárblokk?
+ `superblock`: A teljes file rendszerről tartalmaz információt
+ `inode`: Egy file-ról mindent tartalmaz, kivéve a neve, file-hoz tartozó adatblokkok számai
+ `indirekciós blokk`: tárolja többi blokk címét, ami az inode-ba nem fért el
+ `könyvtár blokk`: File nevek és inode-számok

####45) Mit jelent: "GRANT INSERT, UPDATE, DELETE ON aaa.bbb TO ccc@ddd
`insert`, `update`, `delete` jogot ad az _aaa_ adatbázis _bbb_ táblájára a _ccc_ nevű ffelhasználónak a _ddd_ hoston

####46) Mutassa be a zóna és a domain közötti különbségeket!
+ Zóna: pl.: valami.hu esetén a "valami" egy zóna lesz, mely: függetlenül adminisztrált és független a ".hu" többi részétől.
+ Domain: Csak a delegációs információt tartalmaz

####47) MySql esetén milyen biztonsági lépéseket érdemes megtenni?
+ A MySQL daemon mysql felhasználó jogosultságaival fusson (ne root, ne nobody)
+ Amennyire lehet pontos gép neveket használjunk
+ Csak a root férjen hozzá az adatbázis user táblájához
+ Grant_priv és File_priv csak a root-nak legyen
+ A felhasználót korlátozzuk egy adatbázisra, táblára
+ A jelszót ne a parancssorba adjuk meg

####48) 192.1.50.70/27, hálózat, broadcast cím?
```
Address:   192.1.50.70        11000000.00000001.00110010.010|00110
Netmask:   255.255.255.224    11111111.11111111.11111111.111|00000
Halozat:   192.1.50.64/27     11000000.00000001.00110010.010|00000
Broadcast: 192.1.50.95        11000000.00000001.00110010.010|11111
HostMin:   192.1.50.65        11000000.00000001.00110010.010|00001
HostMax:   192.1.50.94        11000000.00000001.00110010.010|11110
```

####49) Ismertesse a MySQL adatbázis kezelő rendszer architechtúráját!
+ Szálakat kezel: Minden kérés külön szál, Cache-elve vannak, Nem kell mindig létrehozni
+ Fa szerkezetben tárolja a kéréseket: Optimalizálható
+ Lekérdezésnél: `SELECT` esetén ha van cache-elve a lekérdezés, akkor onnan olvas, ha nincs, akkor frissen futtat

####50) A csomagszűrő rendszer milyen három listát használ? Írja le, hogy melyik lista milyen forgalmat jelent!
Nem a halózati kártyát jelenti
+ Input: az a pont ahol a kernel megkapja a csomagot
+ Forward: továbbított csomagok
+ Output: az a pont ahol egy csomag elhagyja a kernelt

####51) Milyen információkat tartalmaz általában egy csomag file neve?
`<név>-<verzió>-<release>-<acrh>.<kiterj>`

####52) Hasonlítsa össze a repeater, hub, switch, router, bridge eszközöket!
+ Repeater: Lényegében egy erősítő
+ Hub: Multi-port repeater
+ Bridge: Hardware eszköz, ami szűrőként működik (nagy forgalmú hálózati részeket választ le, ütközési zónák csökkentése)
+ Switch: Multiport Bridge
+ Router: Gép ami több hálózati szegmenshez kapcsolódik és egyik hálózatból a másikba irányít (korlátoz) adatot

####53) Hasonlítsa össze a csomagkezelést és az installerek használatát!
+ Csomagkezelő: operációs rendszer része, egyetlen adatbázis, az összes csomagot tudja ellenőrizni és kezelni (konzisztens), egyféle rendszer, egyféle formátum
+ Installerek: egyedi termékkel együtt jön, egyedi bejegyzéseket készít az installálásról, csak egy termékre vonatkozik, többféle rendszer, többféle formátum

####54) Mit jelent a SOA DNS esetén?
Start Of Authority, tennhatóságot (authority) definiál egy zónára

####55) Hogyan és hol kell beállítani a TCP wrappert, hogy az FTP-t engedélyezzük a 193.22.33.64/27-es alhálózatról, más gépről tiltsuk?
+ `/etc/host.deny`-ban: ALL:ALL
+ `/etc/host.allow`-ban: ftp: 193.22.33.64/255.255.255.224

####56) Adatbázis esetén mi az a lockolás és mi köze van a sebességhez?
He egyszerre több kérés akar hozzáférni egy táblához pl., akkor lockolni tudjuk, viszont a zárolási művelet, és annak az adminisztrációja időigényes, ezért lassítja a rendszert!

####57) Milyen rekordot kell bejegyezni egy DNS serverbe, ha levelező servert szeretnénk készíteni?
MX (Mail Exchanger): Továbbít, vagy feldolgoz leveleket. A hurok elkerüléséhez preferencia érték is tartozik a rekordhoz.

pl. `peets.mpk.ca.us IN MX 10 relay.hp.com`

####58) Ismertesse a syslog-ng rendszer három működési módját!
+ Kliens: olvas a gépről és hálózaton továbbít
+ Relay: hálózaton fogad és küld tovább
+ Szerver: hálózaton fogad és lokálisan tárol

####59) Mik az APT csomagkezelő rendszer komponensei, jellemzés!
+ config fileok
+ sources.list: `/etc/apt/sources.list`, HTTP, FTP címek, ahonnan a comagok/iformációk jönnek
+ apt-get: kezelik a függőségeket és konfliktusokat: `install`, `remove`, `upgrade`
+ apt-cache: minden csomagról információt ad (nem telepítettről is), függőségek, méret, leírás, stb..

####60) Mikor és miért kell kiadni FLUSH PRIVILEGES parancsokat MySQL alatt?
Felhasználó kezeléskor pl. `GRANT`, `REVOKE`. Azért, hogy a változások életbe lépjenek

####61) Lehet-e csomagot digitálisan aláírni? Ha igen melyik csomag tipust?
RPM-et lehet: MD5, PGP

####62) Manapság mire használják a telnet protokolt?
Protokoll debugolás: port szám megadható, amit gépelünk azt küldi el

####63) Mik azok a futási szintek (min. 4)?
`runlevel`: megadja hogy mely szinten fut a rendszer
```
0 -        leállított vagy ki lehet kapcsni
1 -        Rendszer admin állípot, egy felhasználó
S vagy s - Single user mód
2 -        Multi user (Unixtól független)
3 -        Távoli fájlrendszer állapota: szerverek alapvető futási szintje
4,7,8,9 -  Admin adja meg
5 -        ua mint a 3.de Grafikus felülettel
6 -        Ujraindítás 0. szint és új indítása
Q,q,a,b -  Pseudo állapotok
```

####64) Soroljon fel legalább 4 féle logot unix rendszeren, melyik mit tárol?
+ `/var/log/messages`: boot, I/O hiba, hálózati üzenetek, általános hibák
+ `/var/log/Xfree86.0.log`: X-Window server utolsó futásáról ad információt
+ `/var/log/wtmp`: belépések rögzítése
+ `/var/log/mail.*`: mail üzenetek

####65) A rendszergazda szeretné engedélyezni a telnet, FTP, SMTP, és web szolgáltatásokat a tűzfal beállításai között. Melyik portokat kell engedélyezni?
+ FTP: 20, 21
+ SMTP: 25
+ web: 80

####66) Ismertesse a crontab file alapvető formátumát!
`* * * * * /bin/execute/this/script.sh`
+ 1. perc (1-59)
+ 2. óra (0-23)
+ 3. nap (1-31)
+ 4. hónap (1-12)
+ 5. hét napjai (0-6, 0 = vasárnap)

####67) Mi az anonymous FTP? Mire való, miért használjuk manapság?
+ fileok cseréje több "ismeretlen" felhasználóval
+ email címet kér a server, de nem ellenőrzi

pl. feltöltőszerverhez lehet használni

####68) Melyik adatbázis motort választana MySQL alatt, ha tranzakciókezelést is szeretne használni? Mi a tranzakció és mire jó?
InnoDB

Tranzakciók: olyan SQL utasítások csoportja, melyeket egyben kell végrehajtani. Bármelyik fázisában a műveleteknek hiba történik: az összes változás visszaállítása (rollback).

####69) Mi a különbség az update és az upgrade parancsok között az APT rendszer esetén?
+ upgrade: már installált csomagot frissít
+ update: akkor kell használni, ha módosítottuk a `/etc/apt/sources.list` filet.

####70) Mire jó a Tripwire program?
Adatintegritás ellenőrő program, ellenőrzi, hogy a fileok megváltoztak-e (pl. betörés után). Checksumokkal.

####71) Hasonlítsa össze az UDP és TCP protokollokat! Az OSI modell melyik rétegéhez tartoznak?
+ Transzport réteghez tartoznak
+ UDP: kapcsolat nélküli, ICMP üzenettel kommunikál hiba esetén
+ TCP: kapcsolat orientált, van minden esetben válasz. Garantálja a csomagok megérkezését. Újraküldés hiányzó/hibás csomag esetén. Csúszó ablakozást használ.

####72) Script írása, argumentum ellenőrzéssel, file tipus függő kicsomagolással
```
#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Hiba: nem adtad meg parameterkent a file nevet!"
else
    if file $1 | egrep "gzip" > /dev/null; then
        tar -xvf $1
    else
        if file $1 | egrep "zip" > /dev/null; then
            unzip $1
        fi
    fi
fi
```

####73) Script írása, argumentum ellenőrzéssel (képes), ha létezik hibát ír, különben egy adott könyvtár html filejainak első két sorát teszi bele (NEM TELJES MEGOLDÁS, hiányos feladat szöveg!!!)
```
#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Hiba: nem adtad meg a kert argumentumot!"
else
    if [ -f $1 ]; then
        echo "Hiba: A megadott file mar letezik!"
    else
        touch $1
        for file in `file -name "*.html"`
        do
            head -n 2 $file >> $1
        done
    fi
fi
```

####74) /etc/inittab fileban mit jelent a következő sor és konkrétan mit jelent a respawn kifejezés: 2:234:respawn:/sbin/getty 9600 tty2 ?
+ 2, 3, 4 futási szinteken mindig fut (újraindítja, ha leáll)
+ Megjeleníti a login sort a console-on (tty2)

####75) Mit jelent a rekurzív DNS lekérés?
+ A nameserver addig folytatja a kéréseket amíg meg nem találja az információt
+ A megkérdezett nameserver-t terhelik!
+ Mindig a teljes kérést küldik!!!!

####76) Ábra: MTA, MTU, POP, IMAP, magyarázat!
![da kép](http://i.imgur.com/Qs251.png)

+ MTA (Mail Transfer Agent): Levelező kiszolgáló, ami a levelek elküldését végzi, SMTP protokoll-t használ. Sendmail, postfix, exim
+ MUA (Mail User Agent): Felhasználói program, levelek megjelenítését végzi. Outlook, the bat, pine, thunderbird
+ SMTP (Simple Mail Transfer Protocol): Szöveg alapú protokoll. Telnettel szimulálható,TCP, 25-ös port, DNS MX rekordot használ. Ha nincs, megpróbálhatja elküldeni a domain A rekordjára
+ POP3: Csak levelek letöltése, port: 110
+ IMAP: Másik levél kezelési rendszer, a kiszolgálón tudjuk kezelni a leveleinket

####77) Mit jelent a chroot környezet? Mire való? Mit kell beállítani?
A chroot egy művelet Unix operációs rendszerekben, ami egy parancsot vagy az interaktív shellt a paraméterben megadott speciális gyökérkönyvtárral futtatja. A futó folyamat mintegy be van börtönözve ebbe a könyvtárba, nem tudja az azon kívüli fájlokat elérni.

+ Tesztelés és fejlesztés
+ Kompatibilitás (legacy szoftverekhez)
+ Privilégium szeparáció
```
chdir(dir);        // explicit módon váltsunk a könyvtárba
chroot(dir);
setXXuid(nonroot); // adjuk fel a root jogokat
```

####78) ACID ...
+ Atomicity: nincs részbeni végrehajtás
+ Consistency: Az adatbázis egy konzisztens állapotból egy másik konzisztens állapotba kerül
+ Isolation: Tranzakció láthatatlan mások számára amíg végre nem hajtódik
+ Durability: Tartósság, ha egyszer lefutott akkor a változás végleges

####79) Az alábbi rekordban magyarázza el az első sor jelentését, illetve ki, vagy mi fogja használni az időzítő számlálókat?
`proba.edu IN SOA val.proba.edu. al.proba.edu. (
1
3600
3600
3600
3600)`

+ `proba.edu`: zóna
+ `IN`: internet
+ `val.proba.edu`: primary nameserver
+ `al.proba.edu`: a felelős személy mail címe, @ helyett pontot használunk

Slave használja az időzítéseket