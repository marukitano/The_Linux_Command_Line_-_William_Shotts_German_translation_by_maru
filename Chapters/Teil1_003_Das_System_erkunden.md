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

Wichtig ist jedoch, den Unterschied zwischen **reinem Text** (*Plain Text*) und einem **Textdokument** zu verstehen.

Eine Datei, die beispielsweise mit Microsoft Word oder LibreOffice Writer erstellt wurde, enthält nicht nur den eigentlichen Text. Sie speichert zusätzlich Informationen über Schriftarten, Überschriften, Seitenränder, Formatierungen und viele weitere Eigenschaften.

Eine reine ASCII-Textdatei enthält dagegen nur die Zeichen selbst sowie einige wenige Steuerzeichen, beispielsweise Tabulatoren, Wagenrückläufe und Zeilenumbrüche.

Unter Linux werden sehr viele Dateien als Text gespeichert. Außerdem gibt es eine große Zahl von Werkzeugen, die speziell für die Verarbeitung solcher Textdateien entwickelt wurden.

Auch Windows kennt dieses Format. Das bekannte Programm **Editor** (`NOTEPAD.EXE`) dient beispielsweise zum Bearbeiten einfacher Textdateien.
:::