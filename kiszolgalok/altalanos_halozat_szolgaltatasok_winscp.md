# Általános debug:
Ezeket a lépéseket célszerű azonnal véghez vinni, vagy ez alapján ellenőrizni a beállításokat.

## Boot haxx:
Ha nem ad meg root  jelszót és nem tudunk vele belépni, akkor az alábbiakat kell csinálni:

+ Grubban nyomni egy "e"-t
+ A "linux kernel" sor végére: `init=/bin/sh rw`, majd Ctrl + X
+ `passwd root` -> megadunk egy jelszót
+ `sync`, majd `reboot`

## Interface debug:
A kártya nevének megkeresése, és javítása, ha el lenne rontva:

+ `ifconfig -a` -> kiolvasni az eth[szam]-ot
+ `vi /etc/network/interfaces` -> kijavítani a potenciális hibás részeket

```
auto eth[szam]
iface eth[szam] inet dhcp
```

Újraindítás:

+ `/etc/init.d/networking restart`
+ `ifup eth[szam]`
+ `dhclient`

__Kaphatunk új IP-t, ezért ellenőrizzük ismét__, hogy mi az: `ifconfig -a`

## DNS debug:
Megnézni, hogy vannak-e definiálva serverek és megpingelni őket: `cat /etc/resolv.conf`

Ha nem találjuk őket, vagy üres a file, akkor: `vi /etc/resolv.conf`

```
nameserver 8.8.8.8
```

## TCP Wrapper:
A hosts.allow-nak precedenciája van a deny-al szemben, ezért, ha mindent engedni akarunk: `vi /etc/hosts.allow`

```
ALL: ALL
```

## iptables:
Amennyiben nincs megkötés semelyik feladatban sem arra nézve, hogy ne bántsuk, akkor a legegyszerűbb módszer, ha mindent engedünk :(

+ `iptables -P INPUT ACCEPT`
+ `iptables -P FORWARD ACCEPT`
+ `iptables -P OUTPUT ACCEPT`
+ `iptables -F`

## Repository:
`vi /etc/apt/sources.list`

```
deb http://ftp.hu.debian.org/debian stable main non-free
deb http://ftp.debian.org/debian/ squeeze-updates main non-free
deb http://security.debian.org/ squeeze/updates main non-free
```

Végén frissíteni a meta adatokat: `apt-get update`

# Szolgáltatás debug:
__Kulcs gondolatok:__

+ A következő beállítások feltételezik, hogy a hálózatunk tökéletesen működik!
+ Az iptables sok helyen bekavarhat, ezért: __ha nem full ACCEPTEN van és üres listával__, akkor azt célszerű lehet ellenőrizni, vagy azzá tenni!
+ Ha az `/etc/hosts.allow`-ban szerepel az `ALL:ALL`, akkor azzal nem kell foglalkozni, ellenkező esetben vagy írjuk be mi, vagy külön a szolgáltatásokat adjuk hozzá!

## SSH:
+ Először megnézzük fut-e: `netstat -tulpn | grep ssh`
+ Ha nem akkor: `service ssh restart`
+ Ha nem indul, akkor `apt-get install openssh-server openssh-client`
+ Ha fel van telepítve, akkor bele lehet bújni a configokba:
+ Nem árt ha létezik egy `/etc/enviroment` file, ezt ellenőrizni kell, és ha nem létezne, akkor célszerű üresen létrehozni `touch /etc/enviroment`.
+ Ha az `/etc/hosts.allow`-ban nincs `ALL:ALL`, akkor írjuk be azt, vagy: `sshd:ALL`, de utóbbi nyilván csak az ssh-t engedélyezi!
+ Az `/etc/ssh/sshd_config`-ban szerepeljen:

```
ListenAddress ::
ListenAddress 0.0.0.0
HostKey /etc/ssh/ssh_host_rsa_key
HostKey /etc/ssh/ssh_host_dsa_key
PasswordAuthentication yes
Port 22
PermitRootLogin yes
UsePAM yes
```

+ `service ssh restart` futtatása esetén a server újraindul
+ ellenőrizni tudjuk, hogy fut-e a `netstat -tulpn | grep sshd`-vel
+ belépni az ` ssh root@[ipcím]` paranccsal tudunk mind a virtuális gépen, mind kívülről

## Apache2:

+ Először megnézzük fut-e: `netstat -tulpn | egrep 'apache|http'`
+ Ha nem akkor: `service apache2 restart`
+ Különben config túrás ismét:

Az `/etc/apache2/apache2.conf`-ban szerepeljenek a következők:

```
include httpd.conf
include ports.conf
include mods-enabled/*.load
include mods-enabled/*.conf
```

Az `/etc/apache2/httpd.conf`-ban kötelezően kell szerepeljenek a következők:

```
ServerName 127.0.0.1
Listen 80
DocumentRoot "/var/www"
ServerRoot "/etc/apache2"
DefaultType text/html
```
_Ha nem működne valami_, akkor hozzáadhatjuk még a következőket:

```
User www-data
Group www-data
ErrorLog /var/log/apache2/error.log
PidFile /var/run/apache2.pid
```

## MySQL:

+ megnézni, hogy fut-e: `netstat -tulpn | grep mysql`
+ ha nem, akkor restart: `service mysql restart`
+ ha gebasz van, akkor: `vi /etc/hosts.allow` és tegyük bele `mysqld: ALL`, vagy a szokásos `ALL:ALL`-t :P

# WinSCP:

__VirtualBox:__

File -> Beállítások -> Hálózat (ha nincs kártya, akkor adjunk egyet hozzá) -> szerkesztés

Kártya:
```
IPv4 cím: 192.168.56.1
IPv4 hálózati maszk: 255.255.255.0
```

DHCP szerver:
```
Szerver címe: 192.168.56.100
Szerver maszkja: 255.255.255.0
Alsó címhatár: 192.168.56.101
Felső címhatár: 192.168.56.254
```

__Virtual gép:__

Gép -> Konfigurálás -> Hálózat: Host-Only hálózat

+ `dhclient`
+ `ifconfig -a` -> kiír/megjegyez IP-t

__WinSCP:__

+ Új kapcsolat hozzáadása: New -> Host name: [ip-ifconfigbol], Port: 22, User name: root, Password: [jelszava] -> Save
+ Kapcsolódás: Login -> felugró ablaknál `Yes`