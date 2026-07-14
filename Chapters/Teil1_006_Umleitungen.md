# 6 – Umleitungen

In diesem Kapitel entfesseln wir eine der vielleicht coolsten Funktionen der Kommandozeile: die **Ein-/Ausgabeumleitung**, kurz **I/O-Redirection**.

I/O steht für _Input/Output_, also Ein- und Ausgabe. Damit können wir die Eingabe und Ausgabe von Befehlen aus Dateien lesen oder in Dateien schreiben. Ausserdem lassen sich mehrere Befehle zu leistungsfähigen Befehlsketten, sogenannten **Pipelines**, verbinden.

Um diese Möglichkeiten kennenzulernen, beschäftigen wir uns mit folgenden Befehlen:

- `cat` – Dateien zusammenfügen
- `sort` – Textzeilen sortieren
- `uniq` – Wiederholte Zeilen anzeigen oder ausblenden
- `grep` – Zeilen ausgeben, die zu einem Suchmuster passen
- `wc` – Zeilen, Wörter und Bytes einer Datei zählen
- `head` – Den Anfang einer Datei ausgeben
- `tail` – Das Ende einer Datei ausgeben
- `tee` – Von der Standardeingabe lesen und in die Standardausgabe sowie in Dateien schreiben

## Standardeingabe, Standardausgabe und Standardfehlerausgabe

Viele Programme, die wir bisher verwendet haben, erzeugen irgendeine Form von Ausgabe.

Diese Ausgabe besteht häufig aus zwei verschiedenen Arten von Informationen:

- den eigentlichen Ergebnissen des Programms, also den Daten, die es erzeugen soll,
- Status- und Fehlermeldungen, die uns darüber informieren, was das Programm gerade tut oder ob etwas schiefgegangen ist.

Wenn wir uns einen Befehl wie `ls` ansehen, erkennen wir, dass sowohl die Ergebnisse als auch Fehlermeldungen auf dem Bildschirm erscheinen.

Ganz im Sinne des Unix-Grundsatzes **„Alles ist eine Datei“** senden Programme wie `ls` ihre Ergebnisse tatsächlich an eine spezielle Datei namens **Standardausgabe**, häufig als `stdout` abgekürzt.

Status- und Fehlermeldungen werden an eine andere spezielle Datei geschickt: die **Standardfehlerausgabe**, kurz `stderr`.

Standardmässig sind sowohl `stdout` als auch `stderr` mit dem Bildschirm verbunden. Die Ausgaben werden also angezeigt, aber nicht automatisch in einer Datei auf der Festplatte gespeichert.
Ausserdem beziehen viele Programme ihre Eingaben über die sogenannte **Standardeingabe**, kurz `stdin`. Standardmässig ist sie mit der Tastatur verbunden.

Mit der Ein-/Ausgabeumleitung können wir festlegen, wohin Ausgaben geschrieben werden und woher Eingaben kommen. Normalerweise erscheint die Ausgabe auf dem Bildschirm und die Eingabe kommt von der Tastatur. Mit I/O-Redirection lässt sich dieses Verhalten jedoch ändern.

## Die Standardausgabe umleiten

Mit der Ein-/Ausgabeumleitung können wir neu festlegen, wohin die Standardausgabe geschrieben wird.

Um die Standardausgabe statt auf den Bildschirm in eine Datei zu schreiben, verwenden wir den Umleitungsoperator `>` und geben dahinter den Namen der Datei an.

Warum sollten wir das tun?

Oft ist es praktisch, die Ausgabe eines Befehls in einer Datei zu speichern. Wir können die Shell zum Beispiel anweisen, die Ausgabe von `ls` nicht auf dem Bildschirm anzuzeigen, sondern in die Datei `ls-output.txt` zu schreiben:

```text
[me@linuxbox ~]$ ls -l /usr/bin > ls-output.txt
```

Hier haben wir eine ausführliche Verzeichnisauflistung von `/usr/bin` erstellt und das Ergebnis in die Datei `ls-output.txt` umgeleitet.

Schauen wir uns die Datei an:

```text
[me@linuxbox ~]$ ls -l ls-output.txt
-rw-rw-r-- 1 me me 167878 2025-02-01 15:07 ls-output.txt
```

Sehr schön – eine ordentlich grosse Textdatei.

Wenn wir sie mit `less` öffnen, sehen wir, dass `ls-output.txt` tatsächlich die Ausgabe unseres `ls`-Befehls enthält:

```text
[me@linuxbox ~]$ less ls-output.txt
```

Wiederholen wir den Test nun mit einer kleinen Änderung. Dieses Mal geben wir ein Verzeichnis an, das nicht existiert:

```text
[me@linuxbox ~]$ ls -l /bin/usr > ls-output.txt
ls: cannot access /bin/usr: No such file or directory
```

Wir erhalten eine Fehlermeldung. Das ist logisch, denn das Verzeichnis `/bin/usr` existiert nicht.

Aber warum erscheint die Fehlermeldung auf dem Bildschirm, obwohl wir die Ausgabe doch in `ls-output.txt` umgeleitet haben?

Der Grund ist, dass `ls` seine Fehlermeldungen nicht an die Standardausgabe sendet. Wie die meisten gut geschriebenen Unix-Programme verwendet es dafür die Standardfehlerausgabe `stderr`.

Da wir nur die Standardausgabe und nicht die Standardfehlerausgabe umgeleitet haben, wurde die Fehlermeldung weiterhin auf dem Bildschirm angezeigt.

Wie sich auch `stderr` umleiten lässt, schauen wir uns gleich an. Zuerst sehen wir uns aber an, was mit unserer Ausgabedatei passiert ist:

```text
[me@linuxbox ~]$ ls -l ls-output.txt
-rw-rw-r-- 1 me me 0 2025-02-01 15:08 ls-output.txt
```

Die Datei ist jetzt leer!

Das liegt daran, dass der Umleitungsoperator `>` die Zieldatei immer von Anfang an neu schreibt.

Unser `ls`-Befehl erzeugte keine normale Ausgabe, sondern nur eine Fehlermeldung. Die Umleitung leerte daher zuerst die Datei. Da anschliessend keine Standardausgabe geschrieben wurde, blieb sie leer.

Wenn wir eine Datei absichtlich leeren oder eine neue leere Datei erstellen möchten, können wir diesen kleinen Trick verwenden:

```text
[me@linuxbox ~]$ > ls-output.txt
```

Wenn der Umleitungsoperator ohne vorangestellten Befehl verwendet wird, leert er eine vorhandene Datei oder erstellt eine neue leere Datei.

Wie können wir eine Ausgabe nun an eine Datei anhängen, statt deren bisherigen Inhalt zu überschreiben?

Dafür verwenden wir den Umleitungsoperator `>>`:

```text
[me@linuxbox ~]$ ls -l /usr/bin >> ls-output.txt
```

Mit `>>` wird die Ausgabe am Ende der Datei angefügt.

Falls die Datei noch nicht existiert, wird sie neu erstellt – genau wie bei `>`.

Probieren wir es aus, indem wir denselben Befehl mehrmals ausführen und seine Ausgabe immer wieder an dieselbe Datei anhängen:

```text
[me@linuxbox ~]$ ls -l /usr/bin >> ls-output.txt
[me@linuxbox ~]$ ls -l /usr/bin >> ls-output.txt
[me@linuxbox ~]$ ls -l /usr/bin >> ls-output.txt
[me@linuxbox ~]$ ls -l ls-output.txt
-rw-rw-r-- 1 me me 503634 2025-02-01 15:45 ls-output.txt
```

Wir haben den `ls`-Befehl dreimal ausgeführt. Dadurch ist unsere Ausgabedatei nun ungefähr dreimal so gross.

## Befehle gruppieren

Stellen wir uns vor, wir möchten mehrere Befehle nacheinander ausführen und ihre Ausgaben in einer Protokolldatei speichern.

Mit dem Wissen aus den vorherigen Kapiteln könnten wir das so lösen:

```bash
[me@linuxbox ~]$ command1 > logfile.txt
[me@linuxbox ~]$ command2 >> logfile.txt
[me@linuxbox ~]$ command3 >> logfile.txt
```

Der erste Befehl erstellt (oder überschreibt) die Datei `logfile.txt`.

Jeder weitere Befehl hängt seine Ausgabe anschließend an diese Datei an.

Das funktioniert zwar, ist aber ziemlich umständlich.

Es muss doch einen einfacheren Weg geben.

Wie wir im vorherigen Kapitel gesehen haben, lassen sich mehrere Befehle in einer Zeile hintereinander ausführen:

```bash
[me@linuxbox ~]$ command1; command2; command3
```

Natürlich könnten wir auch alle Umleitungen in diese Zeile schreiben:

```bash
[me@linuxbox ~]$ command1 > logfile.txt; command2 >> logfile.txt; command3 >> logfile.txt
```

Eleganter ist es jedoch, die gesamte Befehlsfolge als **einen einzigen Befehl** zu behandeln.

Dazu werden die Befehle in geschweifte Klammern gesetzt:

```bash
[me@linuxbox ~]$ { command1; command2; command3; } > logfile.txt
```

Für die Shell verhält sich die gesamte Befehlsgruppe nun wie ein einzelner Befehl.

Dadurch genügt **eine einzige Umleitung**, um die Ausgabe aller Befehle gemeinsam in dieselbe Datei zu schreiben.

Beachte dabei zwei Besonderheiten:

- Zwischen den geschweiften Klammern und den Befehlen müssen Leerzeichen stehen.
- Der letzte Befehl muss mit einem Semikolon (`;`) oder einem Zeilenumbruch enden.

---

## Standardfehler umleiten

Bisher haben wir nur die **Standardausgabe** umgeleitet.

Auch die **Standardfehlerausgabe** (_Standard Error_) lässt sich umleiten.

Dafür verwendet die Shell sogenannte **Dateideskriptoren** (_File Descriptors_).

Jeder Prozess besitzt mehrere Ein- und Ausgabekanäle. Die ersten drei sind:

| Dateideskriptor | Bedeutung |
|----------------:|-----------|
| `0` | Standardeingabe (`stdin`) |
| `1` | Standardausgabe (`stdout`) |
| `2` | Standardfehler (`stderr`) |

Da die Standardfehlerausgabe den Dateideskriptor **2** besitzt, lässt sie sich folgendermaßen umleiten:

```bash
[me@linuxbox ~]$ ls -l /bin/usr 2> ls-error.txt
```

Die `2` vor dem Umleitungsoperator weist die Shell an, die Standardfehlerausgabe in die Datei `ls-error.txt` umzuleiten.

---

## Standardausgabe und Standardfehler gemeinsam umleiten

Oft möchte man sowohl die normale Ausgabe als auch Fehlermeldungen in derselben Datei speichern.

Die klassische Schreibweise lautet:

```bash
[me@linuxbox ~]$ ls -l /bin/usr > ls-output.txt 2>&1
```

Hier werden zwei Umleitungen ausgeführt:

1. Die Standardausgabe (`stdout`) wird in `ls-output.txt` umgeleitet.
2. Anschließend wird auch die Standardfehlerausgabe (`stderr`) auf dieselbe Ausgabe umgeleitet.

::: warning
**Wichtig:** Die Reihenfolge ist entscheidend.

Nur diese Schreibweise funktioniert wie erwartet:

```bash
> ls-output.txt 2>&1
```

Vertauschst du die Reihenfolge,

```bash
2>&1 > ls-output.txt
```

wird die Standardfehlerausgabe **nicht** in die Datei umgeleitet, sondern weiterhin auf dem Bildschirm angezeigt.
:::

Moderne Versionen von **bash** bieten dafür eine deutlich kürzere Schreibweise:

```bash
[me@linuxbox ~]$ ls -l /bin/usr &> ls-output.txt
```

Mit `&>` werden Standardausgabe und Standardfehler gleichzeitig in dieselbe Datei umgeleitet.

Möchtest du die Ausgaben an eine bereits vorhandene Datei anhängen, verwendest du `&>>`:

```bash
[me@linuxbox ~]$ ls -l /bin/usr &>> ls-output.txt
```

## Unerwünschte Ausgaben verwerfen

Manchmal gilt: **Weniger ist mehr.**

Nicht jede Ausgabe eines Befehls ist interessant. Oft möchten wir Fehlermeldungen oder Statusmeldungen einfach unterdrücken.

Dafür stellt Linux eine besondere Gerätedatei bereit: `/dev/null`.

Alles, was in diese Datei geschrieben wird, verschwindet sofort. Deshalb wird `/dev/null` oft auch als **Bit Bucket** oder **schwarzes Loch** bezeichnet.

Möchten wir beispielsweise die Fehlermeldungen eines Befehls unterdrücken, können wir sie dorthin umleiten:

```bash
[me@linuxbox ~]$ ls -l /bin/usr 2> /dev/null
```

---

:::note
## `/dev/null` in der Unix-Kultur

`/dev/null` gehört seit Jahrzehnten zur Unix-Welt und ist weit mehr als nur eine technische Besonderheit.

Der Name taucht immer wieder in Witzen, Foren und Gesprächen unter Linux-Nutzern auf.

Wenn dir beispielsweise jemand sagt:

> *"Dein Vorschlag wurde nach `/dev/null` umgeleitet."*

bedeutet das sinngemäß:

> **Er wurde einfach ignoriert.**

Auch außerhalb der Shell ist `/dev/null` deshalb zu einem kleinen Stück Unix-Kultur geworden.

Wenn dich das interessiert, lohnt sich ein Blick in den Wikipedia-Artikel zu `/dev/null`.
:::

## Standardeingabe umleiten

Bisher haben wir vor allem mit der **Standardausgabe** gearbeitet.

Die **Standardeingabe** haben wir dagegen kaum bewusst verwendet.

Genau genommen aber doch – wir haben es nur noch nicht bemerkt.

Jedes Mal, wenn du einen Befehl eingibst oder auf eine Eingabeaufforderung antwortest, nutzt das Programm bereits die Standardeingabe.

Schauen wir uns nun einen Befehl an, mit dem sich das besonders gut demonstrieren lässt.

## `cat` – Dateien zusammenführen und ausgeben

Der Befehl `cat` liest eine oder mehrere Dateien und schreibt deren Inhalt auf die Standardausgabe.

Die allgemeine Syntax lautet:

```text
cat [file...]
```

In vielen Fällen kannst du `cat` mit dem DOS-Befehl `TYPE` vergleichen.

Er eignet sich hervorragend, um kurze Textdateien direkt im Terminal anzuzeigen.

Beispielsweise gibt der folgende Befehl den Inhalt der Datei `ls-output.txt` aus:

```bash
[me@linuxbox ~]$ cat ls-output.txt
```

Da `cat` mehrere Dateien als Argument akzeptiert, kann der Befehl außerdem Dateien hintereinander ausgeben oder zusammenführen.

Angenommen, eine große Videodatei wurde in mehrere Teile aufgeteilt:

```text
movie.mpeg.001
movie.mpeg.002
...
movie.mpeg.099
```

Dann kannst du sie mit folgendem Befehl wieder zu einer einzigen Datei zusammensetzen:

```bash
cat movie.mpeg.0* > movie.mpeg
```

Da Wildcards ihre Treffer alphabetisch sortieren, werden die einzelnen Dateiteile automatisch in der richtigen Reihenfolge verarbeitet.

Soweit so gut.

Doch was passiert eigentlich, wenn wir `cat` **ohne Argumente** starten?

```bash
[me@linuxbox ~]$ cat
```

Auf den ersten Blick scheint nichts zu passieren.

Der Befehl wartet jedoch lediglich auf Eingaben über die **Standardeingabe**.

Da diese standardmäßig mit der Tastatur verbunden ist, wartet `cat` darauf, dass wir etwas eintippen.

Versuche einmal Folgendes:

```text
[me@linuxbox ~]$ cat
The quick brown fox jumps over the lazy dog.
```

Drücke anschließend **Ctrl+D**.

Damit teilst du `cat` mit, dass das Ende der Eingabe (**EOF – End Of File**) erreicht ist.

Daraufhin erscheint:

```text
[me@linuxbox ~]$ cat
The quick brown fox jumps over the lazy dog.
The quick brown fox jumps over the lazy dog.
```

Warum wird der Satz zweimal angezeigt?

Ganz einfach:

`cat` kopiert alles, was über die Standardeingabe hereinkommt, direkt auf die Standardausgabe.

Du hast den Satz einmal eingegeben, und `cat` hat ihn unmittelbar wieder ausgegeben.

### Eine kleine Textdatei erstellen

Dieses Verhalten können wir sogar nutzen, um einfache Textdateien anzulegen.

Angenommen, wir möchten eine Datei namens `lazy_dog.txt` erstellen.

Dann schreiben wir:

```bash
[me@linuxbox ~]$ cat > lazy_dog.txt
```

Nun geben wir den gewünschten Text ein:

```text
The quick brown fox jumps over the lazy dog.
```

Zum Abschluss drücken wir **Ctrl+D**.

Damit wird die Datei gespeichert.

Mit

```bash
[me@linuxbox ~]$ cat lazy_dog.txt
```

können wir anschließend ihren Inhalt überprüfen:

```text
The quick brown fox jumps over the lazy dog.
```

Natürlich gibt es heute deutlich komfortablere Texteditoren.

Trotzdem zeigt dieses kleine Beispiel sehr schön, wie flexibel sich Ein- und Ausgaben in Unix miteinander verbinden lassen.

## Standardeingabe aus einer Datei lesen

Nachdem wir gesehen haben, dass `cat` Eingaben von der Tastatur lesen kann, probieren wir nun eine Umleitung der Standardeingabe aus.

```bash
[me@linuxbox ~]$ cat < lazy_dog.txt
```

```text
The quick brown fox jumps over the lazy dog.
```

Der Operator `<` weist die Shell an, die Standardeingabe nicht von der Tastatur, sondern aus der Datei `lazy_dog.txt` zu lesen.

Das Ergebnis ist identisch zu

```bash
cat lazy_dog.txt
```

Dieses Beispiel ist zwar nicht besonders praktisch, zeigt aber sehr gut, wie die Umleitung der Standardeingabe funktioniert.

Im weiteren Verlauf des Buches werden wir Befehle kennenlernen, die dieses Prinzip wesentlich intensiver nutzen.

Bevor wir weitermachen, lohnt sich noch ein Blick in die Handbuchseite von `cat`.

Der Befehl bietet nämlich noch einige interessante Optionen, die wir hier nicht behandelt haben.

## Pipes

Dass viele Befehle Daten über die **Standardeingabe** lesen und ihre Ergebnisse über die **Standardausgabe** ausgeben können, macht eine der mächtigsten Funktionen der Shell überhaupt möglich: **Pipelines**, meist einfach **Pipes** genannt.

Mit dem Pipe-Operator `|` wird die Standardausgabe eines Befehls direkt an die Standardeingabe eines anderen Befehls weitergeleitet.

Die allgemeine Syntax lautet:

```text
command1 | command2
```

Um das zu demonstrieren, verwenden wir einen Befehl, den wir bereits kennen: `less`.

Erinnerst du dich? `less` kann nicht nur Dateien anzeigen, sondern auch Daten lesen, die über die Standardeingabe ankommen.

Dadurch lässt sich beispielsweise die Ausgabe von `ls` seitenweise anzeigen:

```bash
[me@linuxbox ~]$ ls -l /usr/bin | less
```

Das ist ausgesprochen praktisch.

Anstatt dass `ls` seine gesamte Ausgabe auf einmal auf dem Bildschirm ausgibt, wird sie an `less` weitergereicht. Dort kannst du sie bequem Seite für Seite durchsuchen.

Dasselbe Prinzip funktioniert mit jedem Befehl, der seine Ausgabe auf die Standardausgabe schreibt.

---

:::note
## Der Unterschied zwischen `>` und `|`

Auf den ersten Blick sehen der Umleitungsoperator `>` und der Pipe-Operator `|` ähnlich aus.

Tatsächlich erfüllen sie jedoch ganz unterschiedliche Aufgaben.

Der Umleitungsoperator verbindet einen Befehl mit einer **Datei**:

```text
command1 > file1
```

Die Ausgabe von `command1` wird in `file1` geschrieben.

Der Pipe-Operator dagegen verbindet **zwei Befehle** miteinander:

```text
command1 | command2
```

Die Ausgabe von `command1` wird dabei unmittelbar zur Eingabe von `command2`.

Man kann sich das so merken:

- `>` verbindet einen **Befehl mit einer Datei**.
- `|` verbindet **zwei Befehle miteinander**.

Viele Einsteiger probieren früher oder später neugierig Folgendes aus:

```text
command1 > command2
```

Schließlich sieht das fast genauso aus wie eine Pipe.

Die Antwort lautet:

**Tu das lieber nicht.**

Im schlimmsten Fall kann es unangenehme Folgen haben.

William Shotts berichtet von einem echten Beispiel eines Lesers, der einen Linux-Server administrierte.

Als `root` führte er folgende Befehle aus:

```bash
# cd /usr/bin
# ls > less
```

Der erste Befehl wechselt in das Verzeichnis `/usr/bin`, in dem sich die meisten Programme des Systems befinden.

Der zweite Befehl weist die Shell an, die Ausgabe von `ls` in eine Datei mit dem Namen `less` zu schreiben.

Das Problem:

In `/usr/bin` existierte bereits eine Datei namens `less` – nämlich das Programm selbst.

Da `>` vorhandene Dateien ohne Rückfrage überschreibt, wurde das Programm `less` durch die Textausgabe von `ls` ersetzt.

Damit war das Programm zerstört und ließ sich nicht mehr starten.

Ein kleines Zeichen (`>` statt `|`) genügte also, um ein wichtiges Systemprogramm zu überschreiben.
:::

:::warning
## Vorsicht beim Umleiten mit `>`

Der Umleitungsoperator `>` erstellt Dateien oder überschreibt vorhandene Dateien **ohne Rückfrage**.

Deshalb solltest du ihn immer mit Bedacht verwenden.

Insbesondere wenn du als `root` arbeitest, kann ein kleiner Tippfehler ausreichen, um wichtige Dateien oder sogar Programme zu überschreiben.
:::

## Filter

Pipelines werden häufig verwendet, um Daten Schritt für Schritt zu verarbeiten.

Dabei wird die Ausgabe eines Befehls an den nächsten weitergegeben, der sie verändert und wiederum an den nächsten Befehl übergibt.

Befehle, die auf diese Weise Daten entgegennehmen, verändern und wieder ausgeben, nennt man **Filter**.

Eine Pipeline kann daher aus beliebig vielen Filtern bestehen.

Schauen wir uns einige besonders nützliche Vertreter an.

## `sort` – Zeilen sortieren

Beginnen wir mit `sort`.

Angenommen, wir möchten eine gemeinsame Liste aller Programme aus `/bin` und `/usr/bin` erstellen, alphabetisch sortieren und anschließend bequem betrachten.

```bash
[me@linuxbox ~]$ ls /bin /usr/bin | sort | less
```

Ohne `sort` würde `ls` zwei getrennte Listen erzeugen – jeweils eine für jedes Verzeichnis.

Durch den zusätzlichen Filter `sort` entsteht daraus eine einzige alphabetisch sortierte Gesamtliste.

`sort` ist ein äußerst leistungsfähiger Befehl mit zahlreichen Optionen.

Ausführlich beschäftigen wir uns damit in Kapitel 20.

---

## `uniq` – Doppelte Zeilen entfernen

Der Befehl `uniq` wird häufig zusammen mit `sort` verwendet.

`uniq` erwartet eine bereits sortierte Eingabe und entfernt standardmäßig alle aufeinanderfolgenden doppelten Zeilen.

Dadurch können wir beispielsweise sicherstellen, dass Programme, die sowohl in `/bin` als auch in `/usr/bin` vorkommen, nur einmal angezeigt werden.

```bash
[me@linuxbox ~]$ ls /bin /usr/bin | sort | uniq | less
```

Möchtest du stattdessen nur die doppelten Einträge sehen, verwendest du die Option `-d`:

```bash
[me@linuxbox ~]$ ls /bin /usr/bin | sort | uniq -d | less
```

---

## `wc` – Zeilen, Wörter und Bytes zählen

Der Name `wc` steht für **Word Count** (Wörter zählen).

Mit diesem Befehl lassen sich die Anzahl der Zeilen, Wörter und Bytes einer Datei bestimmen.

```bash
[me@linuxbox ~]$ wc ls-output.txt
7902 64566 503634 ls-output.txt
```

Die drei Zahlen bedeuten:

1. Anzahl der Zeilen
2. Anzahl der Wörter
3. Anzahl der Bytes

Wie viele andere Unix-Werkzeuge kann auch `wc` Daten über die Standardeingabe lesen.

Besonders praktisch ist die Option `-l`, die ausschließlich die Anzahl der Zeilen ausgibt.

Damit lässt sich beispielsweise zählen, wie viele Programme sich in unserer Liste befinden:

```bash
[me@linuxbox ~]$ ls /bin /usr/bin | sort | uniq | wc -l
2728
```

---

## `grep` – Nach Mustern suchen

`grep` gehört zu den wichtigsten Werkzeugen der Unix-Welt.

Mit ihm lassen sich Dateien oder Texte nach bestimmten Mustern durchsuchen.

Die allgemeine Syntax lautet:

```text
grep pattern [file...]
```

Findet `grep` das angegebene Muster, wird die entsprechende Zeile ausgegeben.

Im Moment beschränken wir uns auf einfache Textmuster.

Die deutlich leistungsfähigeren **regulären Ausdrücke** lernen wir in Kapitel 19 kennen.

Angenommen, wir möchten alle Programme finden, deren Name `zip` enthält:

```bash
[me@linuxbox ~]$ ls /bin /usr/bin | sort | uniq | grep zip
```

```text
bunzip2
bzip2
gunzip
gzip
unzip
zip
zipcloak
zipgrep
zipinfo
zipnote
zipsplit
```

Einige häufig verwendete Optionen sind:

| Option | Bedeutung |
|---------|-----------|
| `-i` | Groß- und Kleinschreibung ignorieren |
| `-l` | Nur die Namen der Dateien ausgeben, die einen Treffer enthalten |
| `-v` | Alle Zeilen ausgeben, die **nicht** zum Suchmuster passen |
| `-w` | Nur vollständige Wörter suchen |

---

## `head` und `tail` – Anfang und Ende einer Datei anzeigen

Nicht immer interessiert uns der komplette Inhalt einer Datei.

Oft genügen die ersten oder die letzten Zeilen.

`head` gibt standardmäßig die ersten zehn Zeilen aus.

`tail` zeigt die letzten zehn Zeilen.

Mit der Option `-n` lässt sich diese Anzahl ändern.

```bash
[me@linuxbox ~]$ head -n 5 ls-output.txt
```

```bash
[me@linuxbox ~]$ tail -n 5 ls-output.txt
```

Natürlich lassen sich beide Befehle auch in einer Pipeline verwenden.

```bash
[me@linuxbox ~]$ ls /usr/bin | tail -n 5
```

```text
znew
zonetab2pot.py
zonetab2pot.pyc
zonetab2pot.pyo
zsoelim
```

---

### Einen Ausschnitt aus der Mitte einer Datei auswählen

Durch die Kombination von `head` und `tail` lässt sich sogar ein bestimmter Bereich aus einer Datei ausschneiden.

Angenommen, eine Datei besitzt einen fünfzeiligen Kopf und einen fünfzeiligen Fuß, die entfernt werden sollen.

Dann könnte das so aussehen:

```bash
head -n -5 text_header_footer.txt | tail -n +6 > text.txt
```

Dabei bedeutet

- `head -n -5`: alle Zeilen **außer den letzten fünf**
- `tail -n +6`: Ausgabe **ab Zeile 6**

Auf diese Weise bleiben nur die eigentlichen Nutzdaten übrig.

---

## Dateien in Echtzeit beobachten

Eine besonders praktische Funktion von `tail` ist die Option `-f` (_follow_).

Damit verfolgt `tail` eine Datei live und zeigt neue Zeilen sofort an, sobald sie geschrieben werden.

Das ist besonders hilfreich beim Beobachten von Logdateien.

```bash
[me@linuxbox ~]$ tail -f /var/log/messages
```

Während neue Meldungen entstehen, erscheinen sie automatisch im Terminal.

Die Ausgabe läuft so lange weiter, bis du sie mit **Ctrl+C** beendest.

Je nach Linux-Distribution befinden sich die wichtigsten Systemprotokolle allerdings nicht mehr in `/var/log/messages` oder `/var/log/syslog`.

Viele moderne Distributionen verwenden stattdessen **systemd-journald**.

Dort übernimmt häufig der Befehl

```bash
journalctl -f
```

die gleiche Aufgabe.

## `tee` – Eingaben gleichzeitig anzeigen und speichern

Passend zur Rohrleitungs-Metapher gibt es unter Linux den Befehl `tee`.

Ein **T-Stück** in einer Wasserleitung leitet das Wasser gleichzeitig in zwei Richtungen weiter.

Ganz ähnlich funktioniert `tee`:

Es liest Daten von der **Standardeingabe**, gibt sie unverändert auf der **Standardausgabe** aus und schreibt sie gleichzeitig in eine oder mehrere Dateien.

Dadurch kann die Pipeline wie gewohnt weiterarbeiten, während du zusätzlich eine Kopie der Daten speicherst.

Das ist besonders praktisch, wenn du den Zustand einer Pipeline an einer bestimmten Stelle festhalten möchtest.

Im folgenden Beispiel speichern wir zunächst die komplette Liste aller Programme in der Datei `ls.txt`.

Anschließend filtert `grep` wie gewohnt nur die Programme heraus, deren Name `zip` enthält:

```bash
[me@linuxbox ~]$ ls /usr/bin | tee ls.txt | grep zip
```

```text
bunzip2
bzip2
gunzip
gzip
unzip
zip
zipcloak
zipgrep
zipinfo
zipnote
zipsplit
```

Nach der Ausführung enthält `ls.txt` die **vollständige** Programmliste, während auf dem Bildschirm lediglich die von `grep` gefilterten Zeilen erscheinen.

---

:::note
## Warum heißt der Befehl `tee`?

Der Name stammt aus der Sanitärtechnik.

Ein **T-Stück** (_Tee fitting_) teilt eine Rohrleitung in zwei Abzweigungen auf.

Der Befehl `tee` macht genau dasselbe mit einem Datenstrom:

- Ein Zweig wird in eine Datei geschrieben.
- Der andere fließt durch die Pipeline zum nächsten Befehl weiter.
:::

## Zusammenfassung

In diesem Kapitel hast du einige der wichtigsten Werkzeuge der Linux-Kommandozeile kennengelernt.

Vor allem die Ein- und Ausgabeumleitung sowie Pipes gehören zu den mächtigsten Konzepten der Unix-Welt.

Nimm dir ruhig etwas Zeit, um mit ihnen zu experimentieren.

Viele der hier vorgestellten Befehle besitzen zahlreiche weitere Optionen, die wir nur kurz gestreift haben.

Ein Blick in die jeweilige Handbuchseite lohnt sich daher immer.

Mit zunehmender Erfahrung wirst du feststellen, dass sich selbst komplexe Aufgaben oft durch das geschickte Kombinieren einfacher Befehle lösen lassen.

Genau darin liegt eine der größten Stärken der Linux-Kommandozeile.

:::note
## Linux lebt von deiner Fantasie

Wenn mich jemand nach dem Unterschied zwischen Windows und Linux fragt, erkläre ich ihn oft mit einem Vergleich.

Windows ist ein bisschen wie eine Spielkonsole.

Du kaufst sie, schaltest sie ein und spielst die Spiele, die dafür angeboten werden. Irgendwann möchtest du etwas ganz Bestimmtes machen und fragst nach einem passenden Spiel.

Die Antwort lautet oft:

> „So ein Spiel gibt es leider nicht.“

Oder schlimmer noch:

> „Dafür gibt es keinen Markt.“

Du bist darauf angewiesen, dass jemand anderes genau das entwickelt, was du brauchst.

Linux funktioniert anders.

Stell dir einen riesigen Technik-Baukasten vor – voller Zahnräder, Motoren, Schrauben, Sensoren und unzähliger weiterer Bauteile.

Am Anfang baust du nach Anleitung.

Dann veränderst du ein paar Dinge.

Irgendwann baust du deine eigenen Konstruktionen.

Du musst nicht darauf warten, dass jemand eine fertige Lösung verkauft.

Die Bausteine sind bereits da.

Du kombinierst sie einfach auf neue Weise.

Genau das macht Linux aus.

Es passt sich nicht deinen Gewohnheiten an.

Du passt Linux an deine Ideen an.

Und irgendwann merkst du, dass deiner Fantasie kaum noch Grenzen gesetzt sind.

Welche Art von Spielzeug würdest du lieber besitzen?
:::