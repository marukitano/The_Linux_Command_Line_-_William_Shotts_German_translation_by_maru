# 5 – Mit Befehlen arbeiten

Bis jetzt haben wir bereits eine ganze Reihe von Befehlen kennengelernt – jeder mit seinen eigenen Optionen und Argumenten.

Vielleicht wirken viele davon noch etwas geheimnisvoll.

Das werden wir jetzt ändern.

In diesem Kapitel schauen wir uns genauer an, wie Befehle eigentlich funktionieren, wie du Informationen über sie findest und wie du sogar deine eigenen Befehle erstellen kannst.

Dabei lernen wir die folgenden Werkzeuge kennen:

- **`type`** – Zeigt an, wie ein Befehlsname von der Shell interpretiert wird.
- **`which`** – Zeigt, welches ausführbare Programm tatsächlich gestartet wird.
- **`help`** – Zeigt die Hilfe zu den in die Shell eingebauten Befehlen.
- **`man`** – Öffnet die Handbuchseite eines Befehls.
- **`apropos`** – Sucht nach Befehlen zu einem bestimmten Thema.
- **`info`** – Zeigt die Info-Dokumentation eines Programms an.
- **`whatis`** – Zeigt eine kurze Beschreibung eines Befehls an.
- **`alias`** – Erstellt einen Alias für einen Befehl.

## Was ist eigentlich ein Befehl?

Ein Befehl kann unter Linux vier verschiedene Dinge sein:

- **Ein ausführbares Programm**

  Das sind die Programme, die wir bereits in Verzeichnissen wie `/usr/bin` kennengelernt haben.

  Dazu gehören sowohl kompilierte Programme – beispielsweise in **C** oder **C++** geschrieben – als auch Skripte, etwa in **Shell**, **Perl**, **Python**, **Ruby** oder anderen Programmiersprachen.

- **Ein in die Shell eingebauter Befehl (_Shell Builtin_)**

  Einige Befehle gehören direkt zur Shell und sind keine eigenständigen Programme.

  Der Befehl `cd` ist beispielsweise ein solches **Shell Builtin**.

- **Eine Shell-Funktion**

  Shell-Funktionen sind kleine Shell-Skripte, die direkt in deine Shell-Umgebung integriert sind.

  Wie du deine Umgebung anpasst und eigene Shell-Funktionen schreibst, lernst du in späteren Kapiteln. Für den Moment genügt es zu wissen, dass es sie gibt.

- **Ein Alias**

  Ein Alias ist ein selbst definierter Kurzbefehl, der einen anderen Befehl oder sogar eine ganze Befehlsfolge ersetzt.

  ## Befehle identifizieren

Oft ist es hilfreich, genau zu wissen, mit welcher der vier Befehlsarten wir es zu tun haben. Linux bietet dafür mehrere Möglichkeiten.

### `type` – Den Typ eines Befehls anzeigen

`type` ist ein in die Shell eingebauter Befehl. Er zeigt an, welche Art von Befehl die Shell ausführt, wenn du einen bestimmten Befehlsnamen eingibst.

Die Syntax sieht so aus:

```text
type command
```

Dabei ist `command` der Name des Befehls, den wir untersuchen möchten.

Schauen wir uns ein paar Beispiele an:

```text
[me@linuxbox ~]$ type type
type is a shell builtin
[me@linuxbox ~]$ type ls
ls is aliased to `ls --color=auto'
[me@linuxbox ~]$ type cp
cp is /usr/bin/cp
```

Hier sehen wir die Ergebnisse für drei verschiedene Befehle.

Achte besonders auf die Ausgabe für `ls`, die von einem Fedora-System stammt. Dort ist `ls` in Wirklichkeit ein Alias für den Befehl `ls`, ergänzt um die Option `--color=auto`.

Jetzt wissen wir auch, warum die Ausgabe von `ls` farbig dargestellt wird!

### `which` – Den Speicherort eines ausführbaren Programms anzeigen

Manchmal sind auf einem System mehrere Versionen desselben ausführbaren Programms installiert. Auf Desktop-Systemen kommt das eher selten vor, auf grossen Servern ist es dagegen nichts Ungewöhnliches.

Mit dem Befehl `which` können wir herausfinden, welches ausführbare Programm tatsächlich verwendet wird und wo es sich befindet.

```text
[me@linuxbox ~]$ which ls
/usr/bin/ls
```

`which` funktioniert allerdings nur mit ausführbaren Programmen. Shell-Builtins und Aliase, die anstelle eines ausführbaren Programms verwendet werden, kann der Befehl nicht erkennen.

Versuchen wir zum Beispiel, `which` mit dem Shell-Builtin `cd` zu verwenden, erhalten wir entweder gar keine Ausgabe oder eine Fehlermeldung:

```text
[me@linuxbox ~]$ which cd
/usr/bin/which: no cd in (/usr/local/bin:/usr/bin:/bin:/usr/local
/games:/usr/games)
```

Das ist lediglich eine etwas umständliche Art zu sagen:

„Befehl nicht gefunden.“

## Die Dokumentation eines Befehls finden

Jetzt, da wir wissen, welche Arten von Befehlen es gibt, können wir nach der passenden Dokumentation für jede dieser Befehlsarten suchen.

### `help` – Hilfe für Shell-Builtins anzeigen

Bash besitzt für jedes Shell-Builtin eine eingebaute Hilfefunktion.

Gib dazu einfach `help` ein, gefolgt vom Namen des Shell-Builtins. Hier ist ein Beispiel:

```text
[me@linuxbox ~]$ help cd
cd: cd [-L|[-P [-e]] [-@]] [dir]
    Change the shell working directory.

    Change the current directory to DIR. The default DIR is the
    value of the HOME shell variable.

    The variable CDPATH defines the search path for the directory
    containing DIR. Alternative directory names in CDPATH are
    separated by a colon (:). A null directory name is the same as
    the current directory. If DIR begins with a slash (/), then
    CDPATH is not used.

    If the directory is not found, and the shell option `cdable_vars'
    is set, the word is assumed to be a variable name. If that
    variable has a value, its value is used for DIR.

    Options:
      -L    force symbolic links to be followed: resolve symbolic
            links in DIR after processing instances of `..'

      -P    use the physical directory structure without following
            symbolic links: resolve symbolic links in DIR before
            processing instances of `..'

      -e    if the -P option is supplied, and the current working
            directory cannot be determined successfully, exit with
            a non-zero status

      -@    on systems that support it, present a file with extended
            attributes as a directory containing the file attributes

    The default is to follow symbolic links, as if `-L' were
    specified. `..' is processed by removing the immediately previous
    pathname component back to a slash or the beginning of DIR.

    Exit Status:
    Returns 0 if the directory is changed, and if $PWD is set
    successfully when -P is used; non-zero otherwise.
```

Noch ein Hinweis zur Schreibweise: Eckige Klammern in der Syntaxbeschreibung eines Befehls kennzeichnen optionale Bestandteile. Ein senkrechter Strich trennt Möglichkeiten, von denen jeweils nur eine gewählt werden kann.

Schauen wir uns dazu noch einmal die Syntax von `cd` an:

```text
cd [-L|[-P [-e]]] [dir]
```

Diese Schreibweise bedeutet, dass auf den Befehl `cd` wahlweise die Option `-L` oder `-P` folgen kann. Wird `-P` verwendet, kann zusätzlich die Option `-e` angegeben werden. Danach kann optional das Argument `dir` folgen.

Die Ausgabe von `help` für den Befehl `cd` ist zwar kurz und präzise, aber keine wirkliche Einführung. Wie du siehst, werden dort ausserdem einige Dinge erwähnt, über die wir bisher noch gar nicht gesprochen haben.

Keine Sorge. Dazu kommen wir noch.

> **Hilfreicher Hinweis:** Wenn du `help` mit der Option `-m` aufrufst, wird die Ausgabe in einem alternativen Format dargestellt, das einer Manpage ähnelt. Mehr zu Manpages erfährst du gleich.

### `--help` – Informationen zur Verwendung anzeigen

Viele ausführbare Programme unterstützen die Option `--help`. Sie zeigt eine Beschreibung der verfügbaren Syntax und Optionen des Befehls an.

Zum Beispiel:

```text
[me@linuxbox ~]$ mkdir --help
Usage: mkdir [OPTION] DIRECTORY...
Create the DIRECTORY(ies), if they do not already exist.

Mandatory arguments to long options are mandatory for short options
too.

  -m, --mode=MODE       set file mode (as in chmod), not a=rwx – umask
  -p, --parents         no error if existing, make parent directories as
                        needed
  -v, --verbose         print a message for each created directory
      --help            display this help and exit
      --version         output version information and exit
  -Z, --context=CONTEXT (SELinux) set security context to CONTEXT

Report bugs to <bug-coreutils@gnu.org>.
```

Einige Programme unterstützen die Option `--help` nicht. Probieren solltest du sie trotzdem. Häufig erscheint dann eine Fehlermeldung, die ebenfalls Informationen zur korrekten Verwendung des Befehls enthält.

### `man` – Die Handbuchseite eines Programms anzeigen

Für die meisten ausführbaren Programme, die für die Kommandozeile gedacht sind, gibt es eine ausführliche Dokumentation. Sie wird als Handbuchseite oder kurz **Manpage**  (Manuel Page - Handbuch Seite) bezeichnet.

Zum Anzeigen dieser Seiten wird das spezielle Seitenanzeigeprogramm `man` verwendet.

Die Syntax sieht so aus:

```text
man program
```

Dabei steht `program` für den Namen des Befehls, dessen Manpage wir anzeigen möchten.

Manpages können sich im Aufbau etwas unterscheiden, enthalten aber normalerweise folgende Bestandteile:

* einen Titel mit dem Namen der Seite,
* eine Zusammenfassung der Befehlssyntax,
* eine Beschreibung des Zwecks des Befehls,
* eine Liste und Beschreibung der verfügbaren Optionen.

Manpages enthalten allerdings nur selten Beispiele. Sie sind als Nachschlagewerk gedacht, nicht als Einführung.

Schauen wir uns als Beispiel die Manpage des Befehls `ls` an:

```text
[me@linuxbox ~]$ man ls
```

Auf den meisten Linux-Systemen verwendet `man` das Programm `less`, um die Handbuchseite anzuzeigen. Deshalb kannst du beim Lesen einer Manpage alle bereits bekannten Befehle von `less` verwenden.

Das von `man` angezeigte Handbuch ist in verschiedene Abschnitte unterteilt. Es behandelt nicht nur normale Benutzerbefehle, sondern auch Befehle zur Systemadministration, Programmierschnittstellen, Dateiformate und vieles mehr.

Tabelle 5-1 zeigt den Aufbau des Handbuchs.

**Tabelle 5-1: Gliederung der Manpages**

| Abschnitt | Inhalt                                                    |
| --------: | --------------------------------------------------------- |
|         1 | Benutzerbefehle                                           |
|         2 | Programmierschnittstellen für Systemaufrufe des Kernels   |
|         3 | Programmierschnittstellen der C-Bibliothek                |
|         4 | Spezielle Dateien wie Geräteknoten und Treiber            |
|         5 | Dateiformate                                              |
|         6 | Spiele und Unterhaltung, beispielsweise Bildschirmschoner |
|         7 | Verschiedenes                                             |
|         8 | Befehle zur Systemadministration                          |

Manchmal müssen wir einen bestimmten Abschnitt des Handbuchs angeben, um das Gesuchte zu finden.

Das ist besonders dann wichtig, wenn ein Dateiformat denselben Namen wie ein Befehl trägt. Geben wir keine Abschnittsnummer an, zeigt `man` immer den ersten passenden Eintrag an. Das ist meistens ein Eintrag aus Abschnitt 1.

Um gezielt einen bestimmten Abschnitt aufzurufen, verwenden wir `man` so:

```text
man section search_term
```

Hier ist ein Beispiel:

```text
[me@linuxbox ~]$ man 5 passwd
```

Dieser Befehl zeigt die Manpage an, in der das Dateiformat der Datei `/etc/passwd` beschrieben wird.

### `apropos` – Passende Befehle finden

Du kannst die Liste der Manpages auch nach einem Suchbegriff durchsuchen. Die Suche ist zwar recht einfach, kann aber trotzdem hilfreich sein.

Hier suchen wir zum Beispiel nach Manpages zum Begriff `partition`:

```text
[me@linuxbox ~]$ apropos partition
addpart (8)     - simple wrapper around the "add partition"...
all-swaps (7)   - event signalling that all swap partitions...
cfdisk (8)      - display or manipulate disk partition table
cgdisk (8)      - Curses-based GUID partition table (GPT)...
delpart (8)     - simple wrapper around the "del partition"...
fdisk (8)       - manipulate disk partition table
fixparts (8)    - MBR partition table repair utility
gdisk (8)       - Interactive GUID partition table (GPT)...
mpartition (1)  - partition an MSDOS hard disk
partprobe (8)   - inform the OS of partition table changes
partx (8)       - tell the Linux kernel about the presence...
resizepart (8)  - simple wrapper around the "resize partition"...
sfdisk (8)      - partition table manipulator for Linux
sgdisk (8)      - Command-line GUID partition table (GPT)...
```

Das erste Feld jeder Zeile enthält den Namen der Manpage. Die Zahl in Klammern zeigt, zu welchem Abschnitt des Handbuchs sie gehört.

Übrigens: Der Befehl `man` führt mit der Option `-k` genau dieselbe Suche aus wie `apropos`.

```text
man -k partition
```

### `whatis` – Kurzbeschreibung einer Manpage anzeigen

Das Programm `whatis` zeigt den Namen und eine einzeilige Beschreibung einer Manpage an, die zu einem bestimmten Suchbegriff passt:

```text
[me@linuxbox ~]$ whatis ls
ls (1) - list directory contents
```

:::note
## Die brutalste Manpage von allen

Wie wir gesehen haben, sind die mit Linux und anderen Unix-ähnlichen Systemen gelieferten Manpages als Nachschlagewerke gedacht – nicht als Einführungen.

Viele Manpages sind schwer zu lesen. Den Hauptpreis für die schwierigste Manpage verdient meiner Meinung nach aber eindeutig die von `bash`.

Während der Arbeit an diesem Buch habe ich die `bash`-Manpage gründlich durchgesehen, um sicherzugehen, dass ich die meisten ihrer Themen behandle. Ausgedruckt ist sie mehr als 80 Seiten lang, extrem dicht geschrieben und so aufgebaut, dass sie für Einsteiger praktisch überhaupt keinen Sinn ergibt.

Andererseits ist sie sehr präzise, knapp formuliert und aussergewöhnlich vollständig.

Schau sie dir also ruhig an – wenn du dich traust. Und freu dich auf den Tag, an dem du sie liest und plötzlich alles einen Sinn ergibt.
:::

### `info` – Den Info-Eintrag eines Programms anzeigen

Das GNU-Projekt bietet für seine Programme eine Alternative zu Manpages an: die sogenannten **Info-Seiten**.

Angezeigt werden sie mit einem passenden Leseprogramm namens `info`. Info-Seiten enthalten Hyperlinks und funktionieren damit ein wenig wie Webseiten.

Hier ist ein Beispiel:

```text
File: coreutils.info, Node: ls invocation, Next: dir invocation,
Up: Directory listing

10.1 `ls': List directory contents
==================================

The `ls' program lists information about files (of any type,
including directories). Options and file arguments can be intermixed
arbitrarily, as usual.

For non-option command-line arguments that are directories, by
default `ls' lists the contents of directories, not recursively, and
omitting files with names beginning with `.'. For other non-option
arguments, by default `ls' lists just the filename. If no non-option
argument is specified, `ls' operates on the current directory, acting
as if it had been invoked with a single argument of `.'.

By default, the output is sorted alphabetically, according to the
--zz-Info: (coreutils.info.gz)ls invocation, 63 lines --Top----------
```

Das Programm `info` liest sogenannte Info-Dateien. Diese sind baumartig aufgebaut und in einzelne **Knoten** unterteilt. Jeder Knoten behandelt ein bestimmtes Thema.

Info-Dateien enthalten Hyperlinks, mit denen du von einem Knoten zum nächsten springen kannst. Einen solchen Link erkennst du an einem vorangestellten Sternchen. Um ihn zu öffnen, bewegst du den Cursor auf den Link und drückst **Enter**.

Um `info` zu starten, gibst du einfach `info` ein. Optional kannst du dahinter den Namen eines Programms angeben.

Tabelle 5-2 zeigt die wichtigsten Befehle zur Bedienung des Readers.

**Tabelle 5-2: Befehle in `info`**

| Befehl | Aktion |
|---|---|
| `?` | Hilfe zu den verfügbaren Befehlen anzeigen |
| `PgUp` oder `Backspace` | Vorherige Seite anzeigen |
| `PgDn` oder `Space` | Nächste Seite anzeigen |
| `n` | Zum nächsten Knoten springen |
| `p` | Zum vorherigen Knoten springen |
| `u` | Zum übergeordneten Knoten springen, normalerweise einem Menü |
| `Enter` | Dem Hyperlink an der Cursorposition folgen |
| `q` | `info` beenden |

Die meisten Kommandozeilenprogramme, über die wir bisher gesprochen haben, gehören zum Paket `coreutils` des GNU-Projekts.

Mit folgendem Befehl:

```text
[me@linuxbox ~]$ info coreutils
```

wird eine Menüseite angezeigt, die Hyperlinks zu allen Programmen im Paket `coreutils` enthält.

### `README` und andere Dokumentationsdateien

Viele Softwarepakete, die auf unserem System installiert sind, bringen zusätzliche Dokumentationsdateien mit. Du findest sie normalerweise im Verzeichnis `/usr/share/doc`.

Die meisten dieser Dateien liegen als einfacher Text vor, häufig im Markdown-Format. Du kannst sie mit `less` anzeigen.

Einige Dokumentationen sind im HTML-Format gespeichert und lassen sich mit einem Webbrowser öffnen.

Manche Dateien enden auf `.gz`. Das bedeutet, dass sie mit dem Programm `gzip` komprimiert wurden.

Zum Paket `gzip` gehört eine spezielle Variante von `less` namens `zless`. Damit kannst du den Inhalt von gzip-komprimierten Textdateien direkt anzeigen.

## Eigene Befehle mit `alias` erstellen

Jetzt machen wir unsere ersten Schritte in Richtung Programmierung!

Mit dem Befehl `alias` erstellen wir einen eigenen Befehl. Bevor wir anfangen, schauen wir uns aber noch einen kleinen Trick für die Kommandozeile an.

Du kannst mehrere Befehle in eine einzige Zeile schreiben, indem du sie mit Semikolons voneinander trennst:

```text
command1; command2; command3...
```

Für unser Beispiel verwenden wir folgende Befehlsfolge:

```text
[me@linuxbox ~]$ cd /usr; ls; cd -
bin games include lib local sbin share src
/home/me
[me@linuxbox ~]$
```

Wie du siehst, haben wir drei Befehle in einer Zeile kombiniert.

Zuerst wechseln wir in das Verzeichnis `/usr`. Danach zeigen wir dessen Inhalt mit `ls` an. Zum Schluss kehren wir mit `cd -` in das vorherige Verzeichnis zurück.

Am Ende befinden wir uns also wieder dort, wo wir angefangen haben.

Jetzt wollen wir diese Befehlsfolge mit `alias` in einen neuen Befehl verwandeln. Dafür brauchen wir zuerst einen Namen.

Versuchen wir es mit `test`.

Bevor wir diesen Namen verwenden, sollten wir prüfen, ob er bereits vergeben ist. Dafür können wir wieder den Befehl `type` verwenden:

```text
[me@linuxbox ~]$ type test
test is a shell builtin
```

Hoppla! Der Name `test` ist bereits vergeben.

Probieren wir stattdessen `foo`:

```text
[me@linuxbox ~]$ type foo
bash: type: foo: not found
```

Perfekt! `foo` ist noch frei.

Also erstellen wir unseren Alias:

```text
[me@linuxbox ~]$ alias foo='cd /usr; ls; cd -'
```

Schauen wir uns den Aufbau dieses Befehls genauer an:

```text
alias name='string'
```

Nach dem Befehl `alias` geben wir dem Alias einen Namen. Direkt danach folgt ein Gleichheitszeichen – ohne Leerzeichen davor oder danach.

Anschliessend folgt eine Zeichenkette in Anführungszeichen. Sie enthält den Befehl oder die Befehlsfolge, die dem Namen zugewiesen werden soll.

Nachdem wir den Alias definiert haben, können wir ihn überall dort verwenden, wo die Shell einen Befehl erwartet.

Probieren wir es aus:

```text
[me@linuxbox ~]$ foo
bin games include lib local sbin share src
/home/me
[me@linuxbox ~]$
```

Mit `type` können wir uns unseren Alias ebenfalls anzeigen lassen:

```text
[me@linuxbox ~]$ type foo
foo is aliased to `cd /usr; ls; cd -'
```

Um einen Alias wieder zu entfernen, verwenden wir den Befehl `unalias`:

```text
[me@linuxbox ~]$ unalias foo
[me@linuxbox ~]$ type foo
bash: type: foo: not found
```

Wir haben bewusst vermieden, unserem Alias den Namen eines bereits vorhandenen Befehls zu geben. Trotzdem ist es durchaus üblich, genau das zu tun.

So kann man einem häufig verwendeten Befehl automatisch eine bestimmte Option hinzufügen.

Wir haben bereits gesehen, dass `ls` oft so definiert wird, dass seine Ausgabe farbig dargestellt wird:

```text
[me@linuxbox ~]$ type ls
ls is aliased to `ls --color=auto'
```

Um alle aktuell definierten Aliase anzuzeigen, rufst du `alias` ohne weitere Argumente auf.

Hier sind einige Aliase, die auf einem Fedora-System standardmässig eingerichtet sind:

```text
[me@linuxbox ~]$ alias
alias l.='ls -d .* --color=auto'
alias ll='ls -l --color=auto'
alias ls='ls --color=auto'
```

Versuche herauszufinden, was die einzelnen Aliase bewirken.

Es gibt allerdings ein kleines Problem mit Aliasen, die direkt in der Kommandozeile erstellt werden: Sie verschwinden, sobald die aktuelle Shell-Sitzung endet.

In Kapitel 11 werden wir sehen, wie wir eigene Aliase in den Dateien speichern, die bei jeder Anmeldung unsere Umgebung einrichten.

Bis dahin kannst du dich darüber freuen, dass du gerade deinen ersten – wenn auch noch winzigen – Schritt in die Welt der Shell-Programmierung gemacht hast!

## Zusammenfassung

Jetzt wissen wir, wie wir die Dokumentation zu Befehlen finden.

Schau dir als Nächstes die Dokumentation aller Befehle an, die uns bisher begegnet sind. Finde heraus, welche zusätzlichen Optionen sie bieten, und probiere sie aus!

## Weiterführende Informationen

Im Internet findest du viele gute Dokumentationen zu Linux und zur Kommandozeile. Hier sind einige der besten Anlaufstellen:

- Das **Bash Reference Manual** ist das offizielle Referenzhandbuch zur Bash-Shell. Es bleibt zwar ein Nachschlagewerk, enthält aber Beispiele und ist deutlich leichter zu lesen als die `bash`-Manpage.
<http://www.gnu.org/software/bash/manual/bashref.html>

- Die **Bash FAQ** beantwortet häufig gestellte Fragen zu Bash. Sie richtet sich eher an fortgeschrittene Nutzerinnen und Nutzer, enthält aber viele nützliche Informationen.
<http://mywiki.wooledge.org/BashFAQ>

- Das **GNU-Projekt** stellt umfangreiche Dokumentationen zu seinen Programmen bereit. Diese Programme bilden einen grossen Teil dessen, was wir im Alltag als Linux-Kommandozeile erleben. Eine vollständige Übersicht findest du hier:
<http://www.gnu.org/manual/manual.html>

- Auch Wikipedia bietet einen interessanten Artikel über Manpages:
<http://en.wikipedia.org/wiki/Man_page>