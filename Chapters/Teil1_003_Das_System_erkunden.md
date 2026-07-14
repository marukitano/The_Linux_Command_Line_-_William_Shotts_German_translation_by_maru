# 3 – Das System erkunden

Nachdem wir nun wissen, wie wir uns im Dateisystem bewegen, ist es Zeit für eine kleine Entdeckungstour durch unser Linux-System. Bevor wir starten, lernen wir jedoch noch einige Befehle kennen, die uns unterwegs nützlich sein werden.

- **`ls`** – Listet den Inhalt eines Verzeichnisses auf.
- **`file`** – Bestimmt den Dateityp.
- **`less`** – Zeigt den Inhalt von Dateien an.

## Noch mehr Möglichkeiten mit `ls`

Der Befehl `ls` gehört zu den am häufigsten verwendeten Linux-Befehlen – und das aus gutem Grund. Mit ihm kannst du nicht nur den Inhalt eines Verzeichnisses anzeigen, sondern auch viele wichtige Informationen über Dateien und Verzeichnisse abrufen.

Wie wir bereits gesehen haben, genügt ein einfaches `ls`, um den Inhalt des aktuellen Arbeitsverzeichnisses anzuzeigen.

```bash
[me@linuxbox ~]$ ls
Desktop  Documents  Music  Pictures  Public  Templates  Videos
```

Du kannst aber auch den Inhalt eines beliebigen anderen Verzeichnisses anzeigen, indem du dessen Pfad angibst:

```bash
[me@linuxbox ~]$ ls /usr
bin  games  include  lib  local  sbin  share  src
```

Außerdem lassen sich mehrere Verzeichnisse gleichzeitig angeben. Im folgenden Beispiel werden sowohl das Home-Verzeichnis des aktuellen Benutzers (dargestellt durch das Zeichen `~`) als auch das Verzeichnis `/usr` aufgelistet:

```bash
[me@linuxbox ~]$ ls ~ /usr

/home/me:
Desktop  Documents  Music  Pictures  Public  Templates  Videos
/usr:
bin  games  include  lib  local  sbin  share  src
```

Die Ausgabe lässt sich außerdem in einem anderen Format anzeigen, das deutlich mehr Informationen enthält.

```bash
[me@linuxbox ~]$ ls -l
total 56
drwxrwxr-x 2 me me 4096 2025-10-26 17:20 Desktop
drwxrwxr-x 2 me me 4096 2025-10-26 17:20 Documents
drwxrwxr-x 2 me me 4096 2025-10-26 17:20 Music
drwxrwxr-x 2 me me 4096 2025-10-26 17:20 Pictures
drwxrwxr-x 2 me me 4096 2025-10-26 17:20 Public
drwxrwxr-x 2 me me 4096 2025-10-26 17:20 Templates
drwxrwxr-x 2 me me 4096 2025-10-26 17:20 Videos
```

Durch die Option `-l` wird die Ausgabe im **langen Format** angezeigt.

## Optionen und Argumente

Damit kommen wir zu einem wichtigen Grundprinzip der meisten Linux-Befehle.

Ein Befehl besteht häufig nicht nur aus seinem Namen. Oft folgen darauf eine oder mehrere **Optionen**, die das Verhalten des Befehls verändern, sowie ein oder mehrere **Argumente**, auf die der Befehl angewendet wird.

Die allgemeine Form eines Befehls sieht daher meist so aus:

```text
befehl [OPTIONEN] [ARGUMENTE]
```

Die meisten Optionen bestehen aus einem einzelnen Buchstaben, dem ein Bindestrich vorangestellt wird – zum Beispiel `-l`.

Viele Programme, insbesondere die des GNU-Projekts, unterstützen zusätzlich **lange Optionen**. Diese bestehen aus einem ausgeschriebenen Wort, dem zwei Bindestriche vorangestellt werden.

Außerdem lassen sich mehrere kurze Optionen häufig miteinander kombinieren.

Im folgenden Beispiel erhält `ls` zwei Optionen:

- `-l` zeigt die Ausgabe im langen Format an.
- `-t` sortiert die Ausgabe nach dem Zeitpunkt der letzten Änderung.

```bash
[me@linuxbox ~]$ ls -lt
```

Fügen wir nun noch die lange Option `--reverse` hinzu, wird die Sortierreihenfolge umgekehrt.

```bash
[me@linuxbox ~]$ ls -lt --reverse
```

Beachte, dass Optionen – genau wie Dateinamen unter Linux – zwischen Groß- und Kleinschreibung unterscheiden. Die Optionen `-r` und `-R` haben beispielsweise unterschiedliche Bedeutungen.

Der Befehl `ls` kennt eine Vielzahl von Optionen. In der folgenden Tabelle findest du die am häufigsten verwendeten.

## Tabelle 3-1: Häufig verwendete Optionen für `ls`

| Kurze Option | Lange Option | Beschreibung |
|--------------|--------------|--------------|
| `-a` | `--all` | Zeigt alle Dateien an – auch diejenigen, deren Name mit einem Punkt beginnt und die normalerweise verborgen sind. |
| `-A` | `--almost-all` | Wie `-a`, blendet jedoch `.` (aktuelles Verzeichnis) und `..` (übergeordnetes Verzeichnis) aus. |
| `-d` | `--directory` | Zeigt Informationen über das angegebene Verzeichnis selbst an, statt dessen Inhalt aufzulisten. Besonders nützlich in Kombination mit `-l`. |
| `-F` | `--classify` | Hängt an jeden Dateinamen ein Kennzeichen an. Verzeichnisse erhalten beispielsweise einen Schrägstrich (`/`). |
| `-h` | `--human-readable` | Zeigt Dateigrößen im langen Format (`-l`) in einer leicht lesbaren Form an (z. B. `1.5K`, `42M`, `2.1G`) statt in Bytes. |
| `-l` | – | Zeigt die Ausgabe im langen Format an. |
| `-r` | `--reverse` | Kehrt die Sortierreihenfolge um. Standardmäßig sortiert `ls` alphabetisch in aufsteigender Reihenfolge. |
| `-S` | – | Sortiert die Ausgabe nach der Dateigröße. |
| `-t` | – | Sortiert die Ausgabe nach dem Zeitpunkt der letzten Änderung. |

## Das lange Ausgabeformat im Detail

Wie wir bereits gesehen haben, sorgt die Option `-l` dafür, dass `ls` seine Ausgabe im **langen Format** anzeigt. Dieses Format enthält viele nützliche Informationen über Dateien und Verzeichnisse.

Hier siehst du den Inhalt des Verzeichnisses **Examples** einer älteren Ubuntu-Version:

```text
-rw-r--r-- 1 root root 3576296 2017-04-03 11:05 Experience ubuntu.ogg
-rw-r--r-- 1 root root 1186219 2017-04-03 11:05 kubuntu-leaflet.png
-rw-r--r-- 1 root root   47584 2017-04-03 11:05 logo-Edubuntu.png
-rw-r--r-- 1 root root   44355 2017-04-03 11:05 logo-Kubuntu.png
-rw-r--r-- 1 root root   34391 2017-04-03 11:05 logo-Ubuntu.png
-rw-r--r-- 1 root root   32059 2017-04-03 11:05 oo-cd-cover.odf
-rw-r--r-- 1 root root  159744 2017-04-03 11:05 oo-derivatives.doc
-rw-r--r-- 1 root root   27837 2017-04-03 11:05 oo-maxwell.odt
-rw-r--r-- 1 root root   98816 2017-04-03 11:05 oo-trig.xls
-rw-r--r-- 1 root root  453764 2017-04-03 11:05 oo-welcome.odt
-rw-r--r-- 1 root root  358374 2017-04-03 11:05 ubuntu Sax.ogg
```

Die folgende Tabelle zeigt die einzelnen Bestandteile einer solchen Ausgabe und erklärt ihre Bedeutung.

## Tabelle 3-2: Die Felder der langen `ls`-Ausgabe

| Feld | Bedeutung |
|------|-----------|
| `-rw-r--r--` | **Zugriffsrechte** der Datei. Das erste Zeichen gibt den Dateityp an. Ein führendes `-` kennzeichnet eine gewöhnliche Datei, ein `d` ein Verzeichnis. Die nächsten drei Zeichen beschreiben die Rechte des Besitzers, die folgenden drei die Rechte der Gruppe und die letzten drei die Rechte aller übrigen Benutzer. In Kapitel 9 gehen wir darauf ausführlich ein. |
| `1` | Anzahl der **Hardlinks** auf diese Datei. Die Abschnitte **„Symbolische Links“** und **„Hardlinks“** weiter hinten in diesem Kapitel erklären dieses Thema genauer. |
| `root` | Benutzername des Dateibesitzers. |
| `root` | Name der Gruppe, der die Datei gehört. |
| `32059` | Größe der Datei in Byte. |
| `2017-04-03 11:05` | Datum und Uhrzeit der letzten Änderung. |
| `oo-cd-cover.odf` | Name der Datei. |

## Den Dateityp mit `file` bestimmen

Während wir unser Linux-System erkunden, ist es oft hilfreich zu wissen, welche Art von Daten sich in einer Datei befinden. Dafür verwenden wir den Befehl `file`. Wie bereits erwähnt, muss ein Dateiname unter Linux nichts über den tatsächlichen Inhalt einer Datei verraten. Eine Datei mit dem Namen `picture.jpg` enthält zwar normalerweise ein JPEG-Bild, Linux schreibt das jedoch nicht vor.

Der Befehl `file` wird folgendermaßen verwendet:

```text
file dateiname
```

Nach dem Aufruf gibt `file` eine kurze Beschreibung des Dateiinhalts aus.

Zum Beispiel:

```bash
[me@linuxbox ~]$ file picture.jpg
picture.jpg: JPEG image data, JFIF standard 1.01
```

Unter Linux gibt es die unterschiedlichsten Dateitypen. Tatsächlich gehört diese Aussage zu den Grundideen von Unix-ähnlichen Betriebssystemen:

> **Alles ist eine Datei.**

Im Laufe dieses Buches wirst du sehen, wie viel Wahrheit in diesem Satz steckt. Einige Dateitypen kennst du wahrscheinlich bereits – etwa MP3-Dateien oder JPEG-Bilder. Andere sind weniger offensichtlich, und manche wirken auf den ersten Blick sogar ziemlich ungewöhnlich.

## Den Inhalt einer Datei mit `less` anzeigen

Der Befehl `less` dient zum Anzeigen von **Textdateien**. Auf einem Linux-System gibt es zahlreiche Dateien, deren Inhalt für Menschen lesbar ist. `less` bietet eine komfortable Möglichkeit, solche Dateien anzusehen, ohne sie bearbeiten zu müssen.

::: note
## Was ist eigentlich „Text“?

Es gibt viele Möglichkeiten, Informationen auf einem Computer darzustellen. Allen gemeinsam ist, dass sie Daten in Zahlen umwandeln. Computer verstehen schließlich nur Zahlen – jede Information muss daher in eine numerische Form übersetzt werden. Manche dieser Darstellungsformen sind sehr komplex, etwa komprimierte Videodateien. Andere sind erstaunlich einfach. Eine der ältesten und zugleich einfachsten Methoden ist **ASCII-Text**.

**ASCII** (ausgesprochen: _Aski_) steht für **American Standard Code for Information Interchange**. Dabei handelt es sich um einen Zeichensatz, der ursprünglich für Fernschreiber (_Teletypes_) entwickelt wurde. Jedem Zeichen wird dabei genau eine Zahl zugeordnet.

Text ist also nichts weiter als eine einfache Zuordnung von Zeichen zu Zahlen.

Diese Darstellung ist sehr platzsparend: Ein Text mit 50 Zeichen benötigt lediglich 50 Byte Speicherplatz.

Wichtig ist jedoch, den Unterschied zwischen **reinem Text** (_Plain Text_) und einem **Textdokument** zu verstehen.

Ein **Textdokument**, das beispielsweise mit Microsoft Word oder LibreOffice Writer erstellt wurde, enthält nicht nur den eigentlichen Text. Es speichert zusätzlich Informationen über Schriftarten, Überschriften, Seitenränder, Formatierungen und viele weitere Eigenschaften.

Eine reine **Textdatei** enthält dagegen lediglich die Zeichen selbst sowie einige wenige Steuerzeichen. Ob diese Zeichen mit **ASCII**, **UTF-8** oder einer anderen Zeichenkodierung gespeichert werden, spielt für das grundlegende Prinzip keine Rolle.

Unter Linux werden sehr viele Dateien als Text gespeichert. Außerdem gibt es eine große Zahl von Werkzeugen, die speziell für die Verarbeitung solcher Textdateien entwickelt wurden.

Auch Windows kennt dieses Format. Das bekannte Programm **Editor** (`NOTEPAD.EXE`) dient beispielsweise zum Bearbeiten einfacher Textdateien.
:::

Warum sollten wir uns überhaupt Textdateien ansehen?

Ganz einfach: Viele Dateien mit Systemeinstellungen – sogenannte **Konfigurationsdateien** – werden in diesem Format gespeichert. Wenn du sie lesen kannst, verstehst du dein Linux-System gleich viel besser.

Außerdem liegen einige der Programme, die das System selbst verwendet, ebenfalls als Textdateien vor. Dabei handelt es sich um sogenannte **Skripte**.

In späteren Kapiteln lernst du, wie du Textdateien bearbeitest, Systemeinstellungen anpasst und deine eigenen Skripte schreibst. Im Moment beschränken wir uns aber darauf, ihren Inhalt anzusehen.

Der Befehl `less` wird folgendermaßen verwendet:

```text
less dateiname
```

Nach dem Start kannst du dich mit `less` vorwärts und rückwärts durch eine Textdatei bewegen.

Schauen wir uns als Beispiel die Datei an, in der alle Benutzerkonten des Systems aufgeführt sind:

```bash
[me@linuxbox ~]$ less /etc/passwd
```

Nach dem Start von `less` wird der Inhalt der Datei angezeigt. Ist die Datei länger als eine Bildschirmseite, kannst du darin nach oben und unten scrollen.

Zum Beenden drückst du einfach **`q`**.

Die folgende Tabelle zeigt die wichtigsten Tastenkombinationen von `less`.

## Tabelle 3-3: Wichtige Tastenkombinationen in `less`

| Taste | Funktion |
|-------|----------|
| `Page Up` oder `b` | Eine Seite zurückblättern |
| `Page Down` oder `Leertaste` | Eine Seite vorblättern |
| `↑` | Eine Zeile nach oben |
| `↓` | Eine Zeile nach unten |
| `G` | Zum Ende der Datei springen |
| `1G` oder `g` | Zum Anfang der Datei springen |
| `/text` | Vorwärts nach `text` suchen |
| `n` | Zum nächsten Treffer der letzten Suche springen |
| `h` | Die Hilfe anzeigen |
| `q` | `less` beenden |

::: note
## Warum heißt `less` eigentlich „less“?

Der Name `less` ist ein Wortspiel. Das Programm wurde als verbesserter Nachfolger eines älteren Unix-Programms namens `more` entwickelt.

Während `more` nur vorwärts durch eine Datei blättern konnte, ermöglicht `less` das Blättern in beide Richtungen und bietet viele weitere Funktionen.

Der Name spielt auf den englischen Ausspruch **„Less is more“** („Weniger ist mehr“) an – ein bekanntes Motto aus Architektur und Design.
:::

## Auf Entdeckungstour

Der Aufbau des Dateisystems unter Linux ähnelt dem anderer Unix-ähnlicher Betriebssysteme. Tatsächlich gibt es dafür sogar einen offiziellen Standard: den **Filesystem Hierarchy Standard (FHS)**. Zwar halten sich nicht alle Linux-Distributionen bis ins kleinste Detail daran, die meisten orientieren sich jedoch sehr eng an diesem Standard.

Jetzt machen wir uns auf eine kleine Entdeckungstour durch das Dateisystem und schauen uns an, was unser Linux-System im Innersten zusammenhält. Dabei kannst du gleichzeitig deine Navigationskenntnisse vertiefen.

Unterwegs wirst du feststellen, dass viele interessante Dateien ganz gewöhnliche Textdateien sind.

Versuche bei jedem Verzeichnis, das wir besuchen, Folgendes:

1. Wechsle mit `cd` in das Verzeichnis.
2. Lass dir den Inhalt mit `ls -l` anzeigen.
3. Entdeckst du eine interessante Datei, untersuche sie mit `file`.
4. Handelt es sich wahrscheinlich um eine Textdatei, öffne sie mit `less`.
5. Falls du versehentlich eine Binärdatei mit `less` öffnest und dadurch die Terminalanzeige durcheinandergerät, kannst du sie mit dem Befehl `reset` wieder zurücksetzen.

::: note
**Hinweis:** Erinnere dich an die Kopier- und Einfügefunktion des Terminals. Du kannst einen Dateinamen markieren und mit **`Ctrl` + `Shift` + `C`** kopieren. Mit **`Ctrl` + `Shift` + `V`** fügst du ihn anschließend bequem in den nächsten Befehl ein.
:::

Hab keine Scheu, dich ein wenig umzusehen. Als normaler Benutzer kannst du in den meisten Verzeichnissen keinen Schaden anrichten – dafür müsste man schon Systemadministrator sein.

Falls ein Befehl einmal eine Fehlermeldung ausgibt, ist das kein Problem. Probier einfach etwas anderes aus.

Nimm dir ruhig Zeit zum Entdecken.

Das System gehört dir.

Erkunde es.

Und vergiss nicht: Unter Linux gibt es keine Geheimnisse.

In Tabelle 3-4 findest du einige Verzeichnisse, mit denen du beginnen kannst. Je nach Linux-Distribution können sie leicht unterschiedlich aussehen. Schau dich ruhig auch darüber hinaus um – es gibt jede Menge zu entdecken.

## Tabelle 3-4: Wichtige Verzeichnisse unter Linux

| Verzeichnis | Beschreibung |
|-------------|--------------|
| `/` | Das **Wurzelverzeichnis**. Hier beginnt der gesamte Verzeichnisbaum. |
| `/bin` | Enthält wichtige Programme, die zum Starten und Betreiben des Systems benötigt werden. Auf modernen Linux-Systemen ist `/bin` meist nur noch ein symbolischer Link auf `/usr/bin`. |
| `/boot` | Enthält den Linux-Kernel sowie Dateien, die zum Starten des Systems benötigt werden, darunter den Bootloader und die Initial-RAM-Disk. Interessant sind unter anderem `grub.cfg` und die Kernel-Datei `vmlinuz`. |
| `/dev` | Enthält **Gerätedateien** (_Device Nodes_). Unter Linux werden auch Hardwaregeräte als Dateien dargestellt. |
| `/etc` | Enthält die systemweiten Konfigurationsdateien. Die meisten davon sind einfache Textdateien. Besonders interessant sind `crontab`, `fstab` und `passwd`. |
| `/home` | Hier befinden sich die Home-Verzeichnisse der Benutzer. Eigene Dateien und Einstellungen werden in der Regel hier gespeichert. |
| `/lib` | Enthält gemeinsam genutzte Bibliotheken für Systemprogramme. Auf modernen Distributionen verweist dieses Verzeichnis meist auf `/usr/lib`. |
| `/lost+found` | Wird von Dateisystemen wie ext4 für die Wiederherstellung beschädigter Dateisysteme verwendet. Im Normalfall bleibt dieses Verzeichnis leer. |
| `/media` | Einhängepunkte für Wechseldatenträger wie USB-Sticks oder DVDs, die automatisch eingebunden werden. |
| `/mnt` | Traditioneller Ort zum manuellen Einhängen von Dateisystemen. |
| `/opt` | Installationsort für zusätzliche oder kommerzielle Software, die nicht zur Distribution gehört. |
| `/proc` | Ein **virtuelles Dateisystem**, das Informationen über den Kernel und laufende Prozesse bereitstellt. Die Dateien existieren nicht auf der Festplatte, sondern werden vom Kernel dynamisch erzeugt. |
| `/root` | Das Home-Verzeichnis des Benutzers `root`. |
| `/run` | Enthält Laufzeitinformationen des Systems. Dieses Verzeichnis liegt im Arbeitsspeicher und wird bei jedem Systemstart neu erstellt. |
| `/sbin` | Enthält wichtige Systemprogramme für die Administration. Auf modernen Distributionen ist `/sbin` meist ein symbolischer Link auf `/usr/sbin`. |
| `/sys` | Ein virtuelles Dateisystem mit detaillierten Informationen über Geräte und Hardware, die vom Kernel erkannt wurden. |
| `/tmp` | Hier legen Programme temporäre Dateien ab. Viele Distributionen leeren dieses Verzeichnis beim Neustart automatisch. |
| `/usr` | Das größte Verzeichnis eines Linux-Systems. Es enthält Programme, Bibliotheken und gemeinsam genutzte Daten für Benutzerprogramme. |
| `/usr/bin` | Enthält die meisten ausführbaren Programme eines Linux-Systems. |
| `/usr/lib` | Bibliotheken, die von den Programmen in `/usr/bin` verwendet werden. |
| `/usr/local` | Hier werden Programme installiert, die nicht zur Linux-Distribution gehören. Selbst kompilierte Software landet häufig in `/usr/local/bin`. |
| `/usr/sbin` | Weitere Programme für die Systemadministration. |
| `/usr/share` | Gemeinsam genutzte Daten wie Symbole, Übersetzungen, Dokumentationen, Hintergrundbilder und Standardkonfigurationen. |
| `/usr/share/doc` | Dokumentation installierter Programme und Pakete. |
| `/var` | Enthält Daten, die sich während des Betriebs verändern, etwa Datenbanken, Caches, E-Mails oder Logdateien. |
| `/var/log` | Protokolldateien des Systems. Hier kannst du nachvollziehen, was auf deinem Computer passiert. |
| `~/.config` | Benutzerspezifische Konfigurationsdateien von Desktop-Anwendungen (XDG-Standard). |
| `~/.local` | Benutzerspezifische Programme und Anwendungsdaten (XDG-Standard). |
| \`~/.cache\` | Enthält Zwischenspeicher (\*Caches\*) von Programmen. Hier legen Anwendungen Daten ab, die sie schneller starten oder arbeiten lassen. Der Inhalt dieses Verzeichnisses kann in der Regel gefahrlos gelöscht werden, da die Programme ihn bei Bedarf automatisch neu erstellen. |

## Symbolische Links

Beim Erkunden des Dateisystems wirst du wahrscheinlich früher oder später auf einen Eintrag wie diesen stoßen (zum Beispiel in `/usr/lib`):

```text
lrwxrwxrwx 1 root root 11 2025-08-11 07:34 libc.so.6 -> libc-2.6.so
```

Vielleicht fällt dir auf, dass die erste Spalte mit einem **`l`** beginnt und der Eintrag scheinbar zwei Dateinamen enthält.

Dabei handelt es sich um einen **symbolischen Link** (englisch: _symbolic link_), oft auch **Symlink** genannt.

Unter Linux kann eine Datei unter mehreren Namen erreichbar sein. Auf den ersten Blick wirkt das vielleicht ungewöhnlich, tatsächlich ist es aber eine äußerst praktische Funktion.

Nehmen wir an, ein Programm benötigt eine gemeinsam genutzte Bibliothek mit dem Namen `foo`. Von dieser Bibliothek erscheinen regelmäßig neue Versionen. Damit jederzeit erkennbar ist, welche Version installiert ist, bietet es sich an, die Versionsnummer in den Dateinamen aufzunehmen – zum Beispiel `foo-2.6`.

Dadurch entsteht allerdings ein Problem: Würden alle Programme direkt auf `foo-2.6` verweisen, müsste jedes einzelne Programm nach einem Update angepasst werden, damit es stattdessen `foo-2.7` verwendet.

Genau hier kommen symbolische Links ins Spiel.

Angenommen, du installierst `foo-2.6` und legst anschließend einen symbolischen Link mit dem Namen `foo` an, der auf `foo-2.6` verweist.

Greift nun ein Programm auf `foo` zu, öffnet Linux automatisch die Datei `foo-2.6`.

Alle sind zufrieden:

- Programme können weiterhin einfach `foo` verwenden.
- Gleichzeitig bleibt jederzeit sichtbar, welche Version tatsächlich installiert ist.

Erscheint später `foo-2.7`, musst du lediglich den symbolischen Link aktualisieren, sodass er auf die neue Version zeigt. Die Programme selbst müssen nicht geändert werden.

Ein weiterer Vorteil: Mehrere Versionen können gleichzeitig installiert sein. Sollte sich beispielsweise herausstellen, dass `foo-2.7` einen Fehler enthält (ja, so etwas kommt vor 😉), genügt es, den symbolischen Link wieder auf `foo-2.6` zeigen zu lassen.

Das Beispiel vom Anfang dieses Abschnitts zeigt genau dieses Prinzip:

```text
libc.so.6 -> libc-2.6.so
```

Programme greifen auf `libc.so.6` zu, tatsächlich verwendet das System aber die Datei `libc-2.6.so`.

Wie du eigene symbolische Links erstellst, lernst du im nächsten Kapitel.

## Hardlinks

Neben symbolischen Links gibt es noch eine zweite Art von Verknüpfungen: **Hardlinks**.

Auch Hardlinks ermöglichen es, eine Datei unter mehreren Namen erreichbar zu machen. Sie funktionieren jedoch nach einem anderen Prinzip als symlinks.

Den Unterschied zwischen symlinks und Hardlinks schauen wir uns im nächsten Kapitel genauer an.

## Zusammenfassung

Auf unserer kleinen Entdeckungstour hast du viele wichtige Bereiche eines Linux-Systems kennengelernt. Du hast verschiedene Verzeichnisse erkundet, Dateien untersucht und erste Einblicke in den Aufbau des Systems gewonnen.

Vor allem hast du gesehen, wie offen Linux aufgebaut ist. Viele wichtige Dateien sind als einfacher, menschenlesbarer Text gespeichert. Anders als bei vielen proprietären Betriebssystemen kannst du unter Linux nahezu alles ansehen, untersuchen und verstehen.

## Weiterführende Informationen

- **Filesystem Hierarchy Standard (FHS)**
<https://refspecs.linuxfoundation.org/fhs.shtml>

- **Verzeichnisstruktur von Unix und Unix-ähnlichen Betriebssystemen**
<https://en.wikipedia.org/wiki/Unix_directory_structure>

- **ASCII – Der klassische Zeichensatz für Textdateien**
<https://en.wikipedia.org/wiki/ASCII>