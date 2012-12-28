##### [+] Virtuális lemez mérete:
`fdisk –l | grep Disk` -> kiolvas

##### [+] Felhasználó legelső belépési dátuma:
`who /var/log/wtmp | grep [felh. név] –m 1`

##### [+] Bejelentkezés utáni üdvözlő szöveg:
`vi /etc/motd`

##### [+] Van-e olyan csomag, aminek a neve "aajm"? Ha van ki a karbantartója?
`apt-cache show aajm | grep Maintainer`

##### [+] Gép nevének módosítása:
+ `hostname [újnév]` -> nem marad meg restart után
+ `vi /etc/hostname` -> megmarad

##### [+] Linux kernel mérete (KB):
`du /boot/vmlinuz-` -> végére TAB-ot nyomni!

##### [?] slashdot.org-ért ki a felelős (e-mail, zóna file)?
+ `cat /etc/bind/named.conf` -> fileok listája
+ `cat /etc/bind/named.conf.local` (elvileg ebben)

##### [+] /etc/passwd inode száma (plusz egyebek):
`ls –i /etc/passwd`

##### [?] Hozzon létre "frissit" felhasználót debian-ban és mysql-ben is "backup88" jelszóval, állítsa be, hogy minden hónap 12. napján a teljes mysql adatbázist elmenti a /home/frissit könyvtárba! Írja le hol és mit állított be!
+ `adduser frissit --home /home/frissit` -> jelszó megadása -> tetszés szerint kitölt/kihagy
+ `cd /etc/init.d/`
+ `mysql -u root -p` -> belépés
+ `> USE mysql;`
+ `> INSERT INTO USER (User, Password) VALUES („frissit”, PASSWORD(„backup88”));`
+ `> FLUSH PRIVILEGES;`
+ `> quit`
+ `crontab -e`
+ `* * 12 * * /usr/bin/mysqldump -u root dbname -p 1234 > /home/frissit/dbmentes.sql`
+ `Ctrl + X` -> y

##### [+] Installáljuk fel az ftpd csomagot, majd állítsuk be, hogy a  "hallgato" felhasználó ne használhassa a szolgáltatást!
+ `apt-get install ftpd ftp`
+ `vi /etc/ftpusers` -> beír: hallgato

##### [+] Állítsa be, hogy az FTP daemonhoz csak a 192.168.56.1-ről lehessen hozzáférni, máshonnan nem!
+ `vi hosts.deny` -> ftpd: ALL
+ `vi hosts.allow` -> ftpd: 192.168.56.1

##### [+] Keresse meg a merevlemezen az összes olyan filet, aminek a nevében szerepel az "alma" szó. Ezeket másolja át az /etc/alma -ba!
+ `mkdir /etc/alma` -> ha még nem létezett a cél mappa
+ `find . -iname "*alma*" -exec cp {} /etc/alma \;`

##### [?] Csomagolja + tömörítse össze a /etc könyvtárat etc.tgz néven. Töltse le a virtuális ....
`tar cvzf etc.tgz /etc`

##### [+] Mi az alap(default) futási szint a rendszeren?
`cat /etc/inittab | grep id: | cut -f 2 -d :`

##### [+] Mi az aktuális futási szint a rendszeren?
`who -r`

##### [+] Melyik csomagba tartozik a "/usr/bin/tbl" nevű program és mire jó?
+ `dpkg -S /usr/bin/tbl` -> név elől, megjegyez/felír
+ `apt-cache show [csom.név]` -> Description-ből kiolvas mire jó, stb..

##### [+] Hány blokkot foglal le a "/lib/libc-2.11.3.so" file?
`stat /lib/libc-2.11.3.so` -> kiolvas

##### [+] Állítsa be, hogy minden bootolás során mountolja a rendszer a 3. primary partíciót
+ `fdisk -l` -> kinézni a nevét a 3. primary-nak
+ mkdir /mnt/harmadik` -> létrehozzuk a fogadó mappát
+ `vi /etc/fstab` -> `/dev/[neve]  /mnt/harmadik  auto  defaults  0  0`

##### [+] Mountolja fel a 3. primary partíciót, csomagolja be tar.gz formátumra a tartalmát, mekkora lesz a csomagolt file?
+ `mount /dev/sda3 /mnt/harmadik`
+ `tar -cvzf csomagolt.tar.gz /mnt/harmadik`
+ `stat csomagolt.tar.gz -> kiolvas méretet`

##### [?] Melyik fileba logolja a local5 facility eseményeit?
`grep "local" /etc/rsyslog.conf` -> kiolvas

##### [?] magyarázza el a rendszeren található tűzfal beállításait
`iptables -L` -> leolvas

##### [?] Az apache web server nem indul el, oldja meg, hogy minden bootoláskor elinduljon!
+ `ifconfig –a` -> IP cím van-e? UP-e a kártya?
+ Ha nem, akkor: `dhclient`.
+ Ha igen, akkor:
+ \- megnézzük az ifconfigban, hogy mi a neve a hálókártyának (pl. eth1)
+ \- `vi /etc/network/interfaces` -> összes nem stimmelő eth[sorszám] –ot átírunk az interface valós nevére (pl. eth1)
+ \-  `ifup eth[sorszám]` -> bekapcsoljuk a kártyát
+ \- `cd /etc/init.d/` -> `./apache2 start`
+ Ha nem megy mi a hiba? Hiányolja a `libpcre.so.3`-mat a /lib-ben. Át lett nevezve (?) tehát mondjuk lérehozunk egy soft linket a megfelelő névvel:
+ `cd /lib` -> `ln –s libpcre.so.3.12.1 libpcre.so.3`
+ Újabb próba hátha már megy: Ha még mindig nem, akkor iptables (minden mehet akár acceptre, nem volt megszorítás a feladat szövegében!):
```
iptables –P INPUT ACCEPT
iptables –P FORWARD ACCEPT
iptables –P OUTPUT ACCEPT
```
+ Újabb próba: `cd /etc/init.d/` -> `./apache2 start` -> így már mennie kell

##### [?] Állítsa be, hogy a weboldalakat a /home/web könyvtárból szolgálja ki! Állítsa be, hogy a /home/web/private könyvtárat csak a 192.168.56.1-ről érhessék el!
+ `vi httpd.conf` -> `DocumentRoot "/home/web"`
+ `vi httpd.conf` -ba a következőt:
```
<Directory /home/web/private>
    Order allow,deny
    Allow from 192.168.56.1
    Deny from all
</Directory>
```

##### [?] Melyek azok a felhasználók, akik korábban léteztek a rendszeren, de már nem, viszont maradt utánuk file?
`find / -nouser`

##### [+] Milyen algoritmust használ a rendszer a jelszavak titkosítására?
`cat /etc/pam.d/common-password | grep obscure` -> végén (pl. md5, sha512, stb...)

##### [+] Mekkora azoknak az installált fileoknak az össz mérete, amelyek olyan csomagból származnak, melynek nevében szerepel az "util" szó?
`dpkg-query -Wf '${Installed-Size}\t${Package}\n' | grep "util" | awk '{total += $1} END {print total}'`

##### [+] Install openssh-server és konfig!
+ `apt-get install openssh-server`
+ `vi /etc/ssh/sshd_config`

opcionálisan:
+ kulcs generálás : `ssh-keygen –f ssh_host_rsa_key`
+ szintén: `ssh-keygen –t dsa –f ssh_host_dsa_key`
+ `vi /etc/hosts.allow` -> `sshd: [lokál ip]`
+ engedélyezett kulcsok: cp id_rsa.pub authorized_keys

##### [+] Mi a bootolható partíció kezdő cilinderének száma
`fdisk -l` -> kiolvasni a "start"-ot a *-ozott sorban

##### [+] Milyen szolgáltatás tartozik a 2628-as porthoz
`netstat -tulpn | grep :2628`

##### [+] Hány darab érvényes shellt definiál a rendszer?
`cat /etc/shells | wc -l`

##### [?] Ha kiadjuk a "ping windows" parancsot melyik IP címet pingeljük?
`ping windows` ?????

##### [+] Ha egy új felhasználót létrehozzunk, akkor a shadow fileban a 4. mező értéke 999. Mi ez, hol van beállítva?
`cat /etc/shadow | more` -> ott a leírásban, hogy "minimum napok száma jelszó váltások közt"

##### [+] Mi az installált Debian rendszer verziója?
+ `lsb_release -a`, vagy:
+ `cat /etc/debian_version`

##### [+] Amikor egy felhasználóként belépünk, akkor létezik egy MONITOR shell változó. Írja le, hogy hol van ez beállítva!
+ `cat /etc/skel/.profile`, vagy
+ `cat [HOME]/.bash_profile`, vagy
+ `cat [HOME]/.bash_login`

##### [+] Hány darab dinamikus könyvtárat használ az SSH server?
`ldd /usr/sbin/sshd | wc -l`

##### [+] Az SSH server melyik porton hallgatózik?
`netstat -tulpn | grep sshd`

##### [+] Generáljon új SSH kulcsokat a rendszer számára!
+ `cd /etc/ssh`
+ `mkdir backup`
+ `mv ssh_host* backup`
+ `ssh-keygen -f ssh_host_rsa_key`
+ `ssh-keygen -t dsa -f ssh_host_dsa_key`

##### [+] Hány darab dinamikus könyvtárat használ az apache server?
+ `apache2ctl -M | wc -l` -> számuk
+ `apache2ctl -M` -> lista

##### [-] Installáljuk fel a "dosftools" nevű csomagot, amivel a lemezen levő maradék helyen hozzon létre FAT16 file rendszert! Az fsck.vfat segítségével állapítsuk meg, hogy hány cluster található benne!
+ `apt-get install dosftools`
+ `man dosftools` :D

##### [+] Milyen processzort lát  virtuális gép?
+ `cat /proc/cpuinfo` -> kiolvas

##### [+] Hány csomag van felinstallálva?
+ `dpkg - | wc -l`

##### [?] A "guest455" felhasználó speciálisan lett létrehozva, a többi "guest" felhasználóhoz képet több beállítása is más. Állítsa be a "guest456" felhasználót hasonló módon!
+ `/etc/passwd, /etc/shadow, /etc/group` : ezekben kell tevékenykedni
+ `groups guest455` -> guest455 csoportját írja ki

##### [+] A linuxon egyszerre hány terminált (device) lehetne definiálni? Több mint 10. Hogy állapította meg?
`cat /proc/sys/kernel/pty/max`

##### [+] A mysql servernek nem ismert a jelszava, változtassa meg "123"-ra! Határozza meg hány gépről lehet hozzáférni a SAP101 adatb.-hoz!
+ `service mysql stop`
+ `mysqld_safe –skip-grant-tables &`
+ `mysql –u root -p` -> belépés
+ `> use mysql;`
+ `> update user set password=password('123') where user=’root’;`
+ `> flush privileges;`
+ `> quit`
+ `service mysql restart`
+ `mysql –u root -p` -> belépés
+ `> use mysql;`
+ `> select count(distinct Host) from db where Db = 'SAP101';`

##### [+] A GRUB bootolható konfig fileja a Debian alatt több fileból generálódik, hol vannak ezek?
+ `cat /boot/grub/grub.cfg` -> megmondja, hogy hol vannak a konfigok (felül keresd)!
+ `ls /etc/grub.d/` -> itt vannak

##### [+] Kapcsolja be a userdir modult az apache-ban. Állítsa be, hogy minden felhasználó a "public" könyvtárából szolgálja ki a fileokat!
+ `a2enmod userdir` -> bekapcs
+ `vi /etc/apache2/mods-enabled/userdir.conf
` -> átírni erre: "<Directory /home/*/public/>


##### [+] Állítsa be, hogy ne csak a root, hanem az összes felhasználó újraindíthassa a számítógépet!
_telepíteni a sudo-t, majd beállítani a sudoers-t:_

+ `apt-get install sudo`
+ `visudo` -> beír "ALL     ALL=(ALL)   ALL"

_teszt:_

+ teszt userrel be kell jelentkezni
+ `sudo reboot`  -> megadjuk a jelszavunk

##### [+] Melyik fileba loggoljuk a cron alrendszer üzeneteit?
+ `cat /etc/syslog.conf | grep cron`

##### [?] Határozza meg hány olyan felhasználó van, aki be tud lépni, létezik, de már nem létezik a home könyvtára.
+ `cat /etc/shadow | grep '[:][*|!][:]' -v | cut -f1 -d:` -> userek listája, akik tudnak logolni (negált grep, azokra kiknek a sorában *, vagy ! van :) )
+ `ls /home` -> könyvtárak listája (root nélkül!)
+ konkluzió leírása (bash script kell az egy lépéséses kiíráshoz)...

##### [+] A linuxon ha CDROM-ot akarunk felcsatolni milyen eszközt csatolnánk fel? Mi a CDROM eszköz neve?
+ neve: `find /dev -name cdrom`
+ `mkdir /mnt/cdrom` -> ha kell
+ `mount /dev/cdrom /mnt/cdrom`

##### [?] Az SSH server nem indul, írja le mi a probléma, oldja meg!
Itt lehet gebasz:
```
/etc/ssh/sshd_config
~/.ssh/config: felülírhatja az ssh_configot
~/.ssh/authorized-keys: jelszó nélkül hozzáférés
/etc/hosts.allow -> sshd: [lokál ip]
```
Ez is fog valamit csinálni, ami nem árthat:
+ `dpkg-reconfigure openssh-server`
+ `service ssh start`

iptables:
```
iptables -P INPUT DROP -> Alap strategia megadasa
iptables -F -> flush
iptables -A INPUT --protocol tcp --destination-port ssh -J ACCEPT -> Nem fog mukodni lokalisan, csak tavolrol
iptables -A INPUT --protocol tcp --source-port ssh -J ACCEPT
iptables -P INPUT DROP
```

##### [-] Hány darab dinamikus könyvtárat használ a DNS server?
`ldd /etc/bind/namedconf | wc -l` -> KB NEM EZ KELL

##### [+] Állítsa be, hogy a lokális DNS servert is használja a rendszer!
`vi /etc/resolv.conf` -> `nameserver [lokális ip]`

##### [?] A lokális DNS szerver szolgáltatja a "proba.net" zónát, amiben definiálva van egy "gep1" nevű számítógép. Ha megpróbálja lekérdezni a gép IP címét mégsem adja vissza. Miért? Hogyan kell kijavítani?
+ `/etc/bind/named.conf`
+ `/etc/bind/named.conf.local`
+ `/etc/resolv.conf`

##### [+] Van-e szabad hely a lemezen? Miért nem lehet új partíciót létrehozni?
+ `df` -> leolvas
+ nem emlékszem :P

##### [?] A gyökérkönyvtáron kívül milyen más könyvtárak vannak külön partíción? Írja le melyik könyvtár melyik partíción van!
`df` -> leolvas

##### [+] Egy feltételezett "QNX4.x" tipusú partíciónak mi a tipusszáma?
`sfdisk -T | grep QNX4.x` -> kiolvas

##### [+] Állítsuk be, hogy a 4. futási szinten csak 2db virtuális terminál induljon!
+ `vi /etc/inittab`
+ ahol volt 4-es bejegyzés, onnan a 4-est kivenni, majd:
```
[n+1]:4:respawn:/sbin/mingetty tty[n+1]
[n+2]:4:respawn:/sbin/mingetty tty[n+2]
```

##### [+] Az "rxvt" csomag 3 másik csomagtól függ, melyik az a 3?
`apt-cache depends rxvt`

##### [+] Mekkora a bootolható partíció mérete?
`df &#x60;fdisk -l | awk '{if ($2 == "*") print $1;}'&#x60; | grep -n 2 | awk '{print $2;}'`

##### [+] A virtuális gép által látott processzor hány MHz-es?
`cat /proc/cpuinfo | grep MHz`

##### [+] Mi az inode száma az "/etc/passwd" filenak?
+ `ls -i /etc/passwd`, vagy
+ `stat /etc/passwd | grep Inode`
