##Kuvallinen ohje löytyy osoitteesta: https://selvinen.wordpress.com/2016/11/08/palvelinten-hallinta-viides-linux-tehtava-h5/
“h5. Tee moduli git-varastoon ja kirjoita raportti sinne MarkDownilla.”

http://terokarvinen.com/2016/aikataulu-palvelinten-hallinta-ict4tn022-1-5-op-uusi-ops-loppusyksy-2016

Tehtävä on tehty Ubuntu 16.04.1 LTS versiolla.

Aloitin tehtävän livetikkua käyttäen ajamalla komennot:

setxkbmap fi
sudo ufw enable
sudo apt-get update

Tehtävää jatkettu siitä mihin tässä: https://selvinen.wordpress.com/2016/11/04/palvelinten-hallinta-neljas-linux-tehtava-h4/ jäätiin.

Aloitin ajamalla aikaisemmista tehtävistä tutun asennus - modulini. Tein tämän sen takia, että testasin koodin, jotta se olisi toimiva, jonka laitan githubiin.

Moduli toimi ongelmitta ja siirryin itse tehtävään ja latasin gitin komennolla:

sudo apt-get install git

Tämän jälkeen siirryin osoitteeseen: https://github.com/ - jonne olin jo aikaisemmin rekisteröityinyt.
Aloitin uuden projektin ja nimesin sen linux, tein siitä julkisen ja pääsin näkymään:

git

Tästä jatkoin tekemällä kotihakemistooni seuraavan polun:

/home/xubuntu/Code/testi

Testin sisällä aloitin gitin käytön komennolla:

git init - vastaus:
Initialized empty Git repository in /home/xubuntu/Code/testi/.git

Seuraavaksi kloonasin tiedot githubistani komennolla:

git clone https://github.com/mikaselvinen/linux.git - ja vastaus:
Cloning into 'linux'...
remote: Counting objects: 3, done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
Unpacking objects: 100% (3/3), done.
Checking connectivity... done.

Seuraavaksi loin tiedoston, johon moduulini koodi tulisi:
nano koodi - tallennus, jonka jälkeen tunnilla opitun mukaisesti:

git add .
git commit

Tässä vaiheessa järjestelmä ilmoitti seuraavaa:

*** Please tell me who you are.

Run

git config --global user.email "you@example.com"
git config --global user.name "Your Name"

Joten tein työtä käskettyä komennoilla:

git config --global user.email "mika.selvinen@luukku.com"
git config --global user.name "Mika Selvinen" - ajoin uudestaan commit - komennon tuloksella:
[master (root-commit) c2f75c9] started the code
2 files changed, 38 insertions(+)
create mode 100644 koodi
create mode 160000 linux

Tämän jälkeen kokeilin git pull - komentoja, joka odotetusta ilmoitta, että mitään ei ole joten jatkoin git push - komennolla, vastauksena sain seuraavan:

use

git push --set-upstream mikaselvinen master

Tein kyseisen muutoksen ja käytin komentoa:

git push https://github.com/mikaselvinen/linux.git - vastauksena:

Username for 'https://github.com': mikaselvinen - jouduin syöttämään manuaalisesti käyttäjänimeni
Password for 'https://mikaselvinen@github.com':  - tähän salasanani
Counting objects: 3, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 584 bytes | 0 bytes/s, done.
Total 3 (delta 0), reused 0 (delta 0)
To https://github.com/mikaselvinen/linux.git
2378b58..782375d master -> master

Lopputulos:

final
Koodin sisältö:
koodi

Bonus

Jatkoin samantien ja käynnistin koneen uudestaan. Kuten aina ennenkin ajoin komennot:

setxkbmap fi
sudo ufw enable
sudo apt-get update

Asensin gitin komennolla:

sudo apt-get install git

Loin gitille polun:
/home/xubuntu/Code/testi

Käynnistin gitin:

git init ﻿ja hain projektini:

git clone https://github.com/mikaselvinen/linux.git

Tarkistin myös, että tavarat oikeasti tulivat:

xubuntu@xubuntu:~/Code/testi/linux$ ls
koodi LICENSE

Seuraavaksi asensin puppetin:

sudo apt-get install puppet

Loin oikeat tiedosto polut:

/etc/puppet/modules/asennus/manifests
/home/xubuntu/public_html

Siirsin moduuli koodini oikeaan kansioon ja nimesin sen samalla init.ppksi:

xubuntu@xubuntu:/etc/puppet/modules/asennus/manifests$ sudo mv koodi init.pp

Tarkistin myös, että koodi näyttää oikealta ja on se minkä laitoin githubiin:

xubuntu@xubuntu:/etc/puppet/modules/asennus/manifests$ cat init.pp
class asennus{

Package { ensure => 'installed', allowcdrom => "true" }
package { 'apache2':}
package { 'gedit':}
package { 'vlc':}
package { 'pinta':}
package { 'tree':}
package { 'darktable':}
package { 'rawtherapee':}

file{"/var/www/html/index.html":
content => "Hello world!\n",
}

file{"/home/xubuntu/public_html/index.html":
content => "Hello User!\n",
}

file{"/etc/apache2/mods-enabled/userdir.conf":
ensure => "link",
target => "../mods-available/userdir.conf",
notify => Service["apache2"],
}

file{"/etc/apache2/mods-enabled/userdir.load":
ensure => 'link',
target => '../mods-available/userdir.load',
notify => Service["apache2"],
}

service {"apache2":
ensure => "true",
enable => "true",
}
}


Ajoin komennon sudo puppet apply -e 'class{asennus:}' :kaksi kertaa ja sain:
Notice: Compiled catalog for xubuntu.elisa-laajakaista.fi in environment production in 0.33 seconds
Notice: /Stage[main]/Asennus/Package[rawtherapee]/ensure: ensure changed 'purged' to 'present'
Notice: /Stage[main]/Asennus/Package[tree]/ensure: ensure changed 'purged' to 'present'
Notice: /Stage[main]/Asennus/Package[vlc]/ensure: ensure changed 'purged' to 'present'
Notice: /Stage[main]/Asennus/Package[gedit]/ensure: ensure changed 'purged' to 'present'
Notice: /Stage[main]/Asennus/File[/home/xubuntu/public_html/index.html]/ensure: defined content as '{md5}f35485265e205150d9cabead670dbc7e'
Notice: /Stage[main]/Asennus/Package[pinta]/ensure: ensure changed 'purged' to 'present'
Error: Could not set 'link' on ensure: No such file or directory @ dir_chdir - /etc/apache2/mods-enabled at 24:/etc/puppet/modules/asennus/manifests/init.pp
Error: Could not set 'link' on ensure: No such file or directory @ dir_chdir - /etc/apache2/mods-enabled at 24:/etc/puppet/modules/asennus/manifests/init.pp
Wrapped exception:
No such file or directory @ dir_chdir - /etc/apache2/mods-enabled
Error: /Stage[main]/Asennus/File[/etc/apache2/mods-enabled/userdir.conf]/ensure: change from absent to link failed: Could not set 'link' on ensure: No such file or directory @ dir_chdir - /etc/apache2/mods-enabled at 24:/etc/puppet/modules/asennus/manifests/init.pp
Error: Could not set 'link' on ensure: No such file or directory @ dir_chdir - /etc/apache2/mods-enabled at 30:/etc/puppet/modules/asennus/manifests/init.pp
Error: Could not set 'link' on ensure: No such file or directory @ dir_chdir - /etc/apache2/mods-enabled at 30:/etc/puppet/modules/asennus/manifests/init.pp
Wrapped exception:
No such file or directory @ dir_chdir - /etc/apache2/mods-enabled
Error: /Stage[main]/Asennus/File[/etc/apache2/mods-enabled/userdir.load]/ensure: change from absent to link failed: Could not set 'link' on ensure: No such file or directory @ dir_chdir - /etc/apache2/mods-enabled at 30:/etc/puppet/modules/asennus/manifests/init.pp
Notice: /Stage[main]/Asennus/Service[apache2]: Dependency File[/etc/apache2/mods-enabled/userdir.conf] has failures: true
Notice: /Stage[main]/Asennus/Service[apache2]: Dependency File[/etc/apache2/mods-enabled/userdir.load] has failures: true
Warning: /Stage[main]/Asennus/Service[apache2]: Skipping because of failed dependencies
Notice: /Stage[main]/Asennus/Package[darktable]/ensure: ensure changed 'purged' to 'present'
Notice: /Stage[main]/Asennus/Package[apache2]/ensure: ensure changed 'purged' to 'present'
Notice: /Stage[main]/Asennus/File[/var/www/html/index.html]/content: content changed '{md5}9ad421244b28db9cb4a6857edd297ef5' to '{md5}59ca0efa9f5633cb0371bbc0355478d8'
Notice: Finished catalog run in 67.26 seconds
xubuntu@xubuntu:~$ sudo puppet apply -e 'class{asennus:}'
Notice: Compiled catalog for xubuntu.elisa-laajakaista.fi in environment production in 0.34 seconds
Notice: /Stage[main]/Asennus/File[/etc/apache2/mods-enabled/userdir.conf]/ensure: created
Notice: /Stage[main]/Asennus/File[/etc/apache2/mods-enabled/userdir.load]/ensure: created
Notice: /Stage[main]/Asennus/Service[apache2]: Triggered 'refresh' from 2 events
Notice: Finished catalog run in 2.57 seconds

Testasin kaikki toiminnot ja ne toimivat, tässä yksi kuva:
hello_taas
Ajattelin, että olisi hyvä muuttaa koodi tiedonston nimi, joten tein sen:

xubuntu@xubuntu:~/Code/testi/linux$ mv koodi init.pp

Tämän jälkeen päivitin tiedot githubiin:


git add .
git commit

Pääsin taas vastaamaan kysymykseen:

*** Please tell me who you are.

Tietojen täytön jälkeen:

xubuntu@xubuntu:~/Code/testi/linux$ git commit
[master e1fe17b] nimen muutos
1 file changed, 0 insertions(+), 0 deletions(-)
rename koodi => init.pp (100%)
xubuntu@xubuntu:~/Code/testi/linux$ git push - Tässä vaiheessa git push ei pyytänyt mitään ylimääräistä vaan pääsin suoraan:
Username for 'https://github.com': mikaselvinen - manuaali täyttö
Password for 'https://mikaselvinen@github.com':  - salasanani
Counting objects: 2, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (2/2), 269 bytes | 0 bytes/s, done.
Total 2 (delta 0), reused 0 (delta 0)
To https://github.com/mikaselvinen/linux.git
782375d..e1fe17b master -> master
xubuntu@xubuntu:~/Code/testi/linux$

Päivitetty hub:
final_1





