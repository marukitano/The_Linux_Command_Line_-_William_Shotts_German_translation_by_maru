# 7 – Die Welt mit den Augen der Shell sehen

In diesem Kapitel werfen wir einen Blick hinter die Kulissen der Shell.

Bisher haben wir Befehle eingegeben und ihre Ausgabe betrachtet. Dabei scheint es oft so, als würde die Shell genau das ausführen, was wir eingetippt haben.

Tatsächlich passiert jedoch noch etwas dazwischen.

Sobald wir die **ENTER-Taste** drücken, analysiert `bash` die Eingabe und verändert sie gegebenenfalls, bevor der eigentliche Befehl gestartet wird.

Dieser Vorgang gehört zu den faszinierendsten Eigenschaften der Shell und sorgt dafür, dass viele scheinbar einfache Befehle erstaunlich leistungsfähig werden.

In diesem Kapitel lernen wir dafür nur einen einzigen neuen Befehl kennen:

- `echo` – Text auf der Standardausgabe ausgeben

## Expansion

Jedes Mal, wenn wir einen Befehl eingeben und anschließend **ENTER** drücken, führt `bash` mehrere Verarbeitungsschritte auf unserer Eingabe aus.

Einer dieser Schritte heißt **Expansion**.

Dabei ersetzt die Shell bestimmte Zeichen oder Ausdrücke durch ihren tatsächlichen Wert, **bevor** der Befehl ausgeführt wird.

Wir haben dieses Verhalten bereits kennengelernt, ohne es ausdrücklich zu benennen.

Erinnerst du dich an den Stern (`*`)?

Er steht als Platzhalter für beliebige Dateinamen.

Schauen wir uns nun genauer an, wie das funktioniert.

Dazu verwenden wir den Befehl `echo`.

`echo` ist ein **Shell Builtin**. Seine Aufgabe könnte kaum einfacher sein:

Er gibt alle übergebenen Argumente unverändert auf der Standardausgabe aus.

Zum Beispiel:

```bash
[me@linuxbox ~]$ echo this is a test
this is a test
```

Alles wie erwartet.

`echo` gibt einfach den übergebenen Text aus.

Probieren wir nun etwas anderes:

```bash
[me@linuxbox ~]$ echo *
Desktop Documents ls-output.txt Music Pictures Public Templates Videos
```

Moment ...

Warum wurde jetzt **nicht** einfach ein Stern (`*`) ausgegeben?

Die Antwort lautet:

`echo` hat den Stern überhaupt nie gesehen.

Bevor `echo` gestartet wurde, hat die Shell den Platzhalter `*` bereits erweitert.

Sie hat nach allen Dateien und Verzeichnissen im aktuellen Arbeitsverzeichnis gesucht und den Stern durch deren Namen ersetzt.

Erst anschließend wurde `echo` ausgeführt.

Für `echo` sah der eigentliche Befehl also ungefähr so aus:

```bash
echo Desktop Documents ls-output.txt Music Pictures Public Templates Videos
```

Deshalb verhält sich `echo` völlig korrekt.

Es gibt lediglich genau die Argumente aus, die es von der Shell erhalten hat.

Die eigentliche Arbeit wurde bereits vorher von `bash` erledigt.

Dieses Verhalten nennt man **Expansion**.

Sie gehört zu den wichtigsten Konzepten der Shell und begegnet uns im weiteren Verlauf des Buches immer wieder.

## Pfadnamen-Expansion

Die Art von Expansion, die wir bisher mit Wildcards kennengelernt haben, nennt sich **Pfadnamen-Expansion** (_pathname expansion_).

Immer dann, wenn die Shell Platzhalter wie `*`, `?` oder Zeichenklassen erkennt, ersetzt sie diese **vor der Ausführung des Befehls** durch passende Dateinamen.

Nehmen wir an, unser Home-Verzeichnis enthält folgende Dateien und Verzeichnisse:

```bash
[me@linuxbox ~]$ ls
Desktop
Documents
ls-output.txt
Music
Pictures
Public
Templates
Videos
```

Dann können wir beispielsweise Folgendes eingeben:

```bash
[me@linuxbox ~]$ echo D*
Desktop Documents
```

Der Ausdruck `D*` bedeutet:

> **Alle Dateinamen, die mit einem `D` beginnen.**

Ebenso funktioniert:

```bash
[me@linuxbox ~]$ echo *s
Documents Pictures Templates Videos
```

Hier sucht die Shell nach allen Namen, die auf den Buchstaben `s` enden.

Natürlich lassen sich auch Zeichenklassen verwenden:

```bash
[me@linuxbox ~]$ echo [[:upper:]]*
Desktop Documents Music Pictures Public Templates Videos
```

In diesem Beispiel werden alle Dateien und Verzeichnisse ausgewählt, deren Name mit einem Großbuchstaben beginnt.

Wildcards funktionieren übrigens nicht nur im aktuellen Verzeichnis.

Auch komplette Pfadangaben können Platzhalter enthalten:

```bash
[me@linuxbox ~]$ echo /usr/*/share
/usr/kerberos/share
/usr/local/share
```

Hier ersetzt die Shell den Stern durch alle passenden Unterverzeichnisse innerhalb von `/usr`.

---

:::note
## Pfadnamen-Expansion und versteckte Dateien

Wie wir bereits gelernt haben, gelten Dateien, deren Name mit einem Punkt (`.`) beginnt, unter Linux als **versteckt**.

Diese Regel berücksichtigt auch die Pfadnamen-Expansion.

Deshalb liefert

```bash
echo *
```

standardmäßig **keine versteckten Dateien**.

Naheliegend wäre deshalb:

```bash
echo .*
```

Unter aktuellen Bash-Versionen (ab **5.2**) funktioniert das in der Regel problemlos, da die Shell-Option `globskipdots` standardmäßig aktiviert ist.

Auf älteren Systemen kann die Ausgabe jedoch zusätzlich

```text
.
..
```

enthalten.

Diese beiden besonderen Verzeichnisse stehen für

- `.` – das aktuelle Verzeichnis
- `..` – das übergeordnete Verzeichnis

Das kann leicht zu unerwarteten Ergebnissen führen.

Mit folgendem Befehl lässt sich das beobachten:

```bash
ls -d .* | less
```

Möchtest du versteckte Dateien möglichst zuverlässig auswählen, ist dieses Muster besser geeignet:

```bash
echo .[!.]*
```

Es wählt alle Dateinamen aus,

- die mit genau einem Punkt beginnen,
- deren zweites Zeichen **kein weiterer Punkt** ist.

Für die meisten Anwendungsfälle ist das ausreichend.

Noch einfacher ist häufig die Verwendung der passenden `ls`-Option:

```bash
ls -A
```

Im Gegensatz zu `ls -a` werden dabei die Einträge `.` und `..` ausgeblendet, alle übrigen versteckten Dateien jedoch angezeigt.
:::

## Tilde-Expansion

Die erste Form der Expansion haben wir bereits verwendet, ohne sie bewusst wahrzunehmen.

Es geht um das Tilde-Zeichen (`~`).

Steht es am Anfang eines Pfades, ersetzt die Shell es automatisch durch das Home-Verzeichnis eines Benutzers.

Ohne Benutzernamen ist damit dein eigenes Home-Verzeichnis gemeint:

```bash
[me@linuxbox ~]$ echo ~
/home/me
```

Gibst du stattdessen einen Benutzernamen an, wird dessen Home-Verzeichnis eingesetzt:

```bash
[me@linuxbox ~]$ echo ~bob
/home/bob
```

Auch hier gilt wieder:

Nicht `echo` ersetzt das `~`.

Die Shell erledigt die Expansion bereits **vor** dem Start des Befehls.

---

## Arithmetische Expansion

Die Shell kann sogar einfache Berechnungen durchführen.

Dadurch lässt sie sich hervorragend als kleiner Taschenrechner verwenden.

```bash
[me@linuxbox ~]$ echo $((2 + 2))
4
```

Die allgemeine Schreibweise lautet:

```text
$((Ausdruck))
```

Innerhalb der doppelten Klammern kannst du Zahlen und Rechenoperatoren verwenden.

Wichtig ist dabei:

Die arithmetische Expansion unterstützt ausschließlich **Ganzzahlen**.

Dezimalzahlen oder Fließkommazahlen können damit nicht berechnet werden.

### Unterstützte Operatoren

| Operator | Bedeutung |
|-----------|-----------|
| `+` | Addition |
| `-` | Subtraktion |
| `*` | Multiplikation |
| `/` | Ganzzahlige Division |
| `%` | Rest einer Division (Modulo) |
| `**` | Potenz |

Leerzeichen spielen innerhalb eines Ausdrucks keine Rolle.

Auch Klammern lassen sich wie in der Mathematik verwenden.

Beispielsweise:

```bash
[me@linuxbox ~]$ echo $(((5**2) * 3))
75
```

Hier wird zunächst

```
5²
```

berechnet und anschließend mit 3 multipliziert.

### Ganzzahlige Division

Besonders wichtig ist das Verhalten der Division.

Da Bash ausschließlich mit Ganzzahlen rechnet, werden Nachkommastellen einfach verworfen.

```bash
[me@linuxbox ~]$ echo $((5/2))
2
```

Der Rest kann mit dem Modulo-Operator `%` bestimmt werden:

```bash
[me@linuxbox ~]$ echo $((5%2))
1
```

Die arithmetische Expansion werden wir in Kapitel 34 noch wesentlich ausführlicher kennenlernen.

---

## Brace Expansion

Eine der ungewöhnlichsten Formen der Expansion ist die **Brace Expansion**.

Sie erzeugt mehrere Textfolgen aus einem einzigen Muster.

Zum Beispiel:

```bash
[me@linuxbox ~]$ echo Front-{A,B,C}-Back
Front-A-Back Front-B-Back Front-C-Back
```

Hier wird der Ausdruck in den geschweiften Klammern mehrfach eingesetzt.

Eine Brace Expansion besteht aus drei möglichen Teilen:

- einem Präfix (vor den Klammern),
- der eigentlichen Brace Expansion,
- einem Suffix (nach den Klammern).

Innerhalb der Klammern können entweder

- einzelne Werte

```bash
{A,B,C}
```

oder

- Bereiche

```bash
{1..5}
```

angegeben werden.

Zum Beispiel:

```bash
[me@linuxbox ~]$ echo Number_{1..5}
Number_1 Number_2 Number_3 Number_4 Number_5
```

### Führende Nullen

Seit Bash 4 können Zahlenbereiche auch mit führenden Nullen erzeugt werden.

```bash
[me@linuxbox ~]$ echo {01..15}
```

ergibt

```text
01 02 03 ... 15
```

Ebenso funktioniert:

```bash
echo {001..15}
```

### Rückwärts zählen

Bereiche müssen nicht aufsteigend sein.

```bash
[me@linuxbox ~]$ echo {Z..A}
```

liefert

```text
Z Y X W ... A
```

### Verschachtelte Brace Expansion

Brace Expansions lassen sich sogar ineinander verschachteln.

```bash
[me@linuxbox ~]$ echo a{A{1,2},B{3,4}}b
aA1b aA2b aB3b aB4b
```

---

## Wofür braucht man das?

Die häufigste Anwendung ist das Erzeugen vieler Dateien oder Verzeichnisse.

Angenommen, wir möchten unsere Urlaubsfotos nach Jahren und Monaten sortieren.

Dann könnten wir zunächst ein Verzeichnis anlegen:

```bash
mkdir Photos
cd Photos
```

Und anschließend mit nur einem einzigen Befehl sämtliche Monatsordner für drei Jahre erzeugen:

```bash
mkdir {2007..2009}-{01..12}
```

Das Ergebnis:

```text
2007-01
2007-02
...
2009-12
```

Mit erstaunlich wenig Aufwand entstehen auf diese Weise 36 Verzeichnisse.

Ziemlich elegant, oder?

:::note
## Brace Expansion arbeitet nur mit Text

Im Gegensatz zu Wildcards durchsucht die Brace Expansion **nicht** das Dateisystem.

Sie erzeugt lediglich neue Zeichenfolgen.

Deshalb funktioniert

```bash
echo {1..5}
```

auch dann, wenn überhaupt keine Dateien existieren.

Erst der eigentliche Befehl (`echo`, `mkdir`, `cp` usw.) verwendet anschließend die erzeugten Texte.\
:::

## Parameter-Expansion

Bisher haben wir bereits verschiedene Arten der Expansion kennengelernt.

Nun kommt eine weitere hinzu: die **Parameter-Expansion**.

Sie spielt vor allem in Shell-Skripten eine wichtige Rolle, lässt sich aber auch direkt auf der Kommandozeile verwenden.

Im Kern geht es dabei um **Variablen**.

Eine Variable speichert einen Wert unter einem Namen, damit dieser später wiederverwendet werden kann.

Die Shell stellt bereits zahlreiche solcher Variablen bereit.

Eine davon heißt `USER` und enthält den Namen des aktuell angemeldeten Benutzers.

Mit einer Parameter-Expansion können wir ihren Inhalt anzeigen:

```bash
[me@linuxbox ~]$ echo $USER
me
```

Das Dollarzeichen (`$`) weist die Shell an, den Namen der Variablen durch ihren gespeicherten Wert zu ersetzen.

Auch hier gilt wieder:

Nicht `echo` ersetzt `$USER`.

Die Shell führt die Expansion bereits **vor** dem Start des Befehls durch.

Möchtest du alle aktuell gesetzten Umgebungsvariablen anzeigen, kannst du folgenden Befehl verwenden:

```bash
[me@linuxbox ~]$ printenv | less
```

Dort findest du unter anderem Variablen wie:

- `USER` – Name des aktuell angemeldeten Benutzers
- `HOME` – Pfad zum eigenen Home-Verzeichnis
- `PATH` – Verzeichnisse, in denen die Shell nach ausführbaren Programmen sucht
- `LANG` – eingestellte Sprache und Zeichencodierung

Daneben gibt es noch viele weitere Variablen, die Informationen über deine aktuelle Shell-Umgebung enthalten.

### Was passiert bei einem Tippfehler?

Vielleicht ist dir bereits aufgefallen, dass Wildcards unverändert bleiben, wenn sie keine Treffer finden.

Bei Variablen verhält sich die Shell anders.

Schreibst du den Variablennamen falsch,

```bash
[me@linuxbox ~]$ echo $SUER
```

erscheint einfach keine Ausgabe.

Der Grund ist einfach:

Die Variable `SUER` existiert nicht.

Existiert eine Variable nicht, ersetzt Bash sie standardmäßig durch eine **leere Zeichenkette**.

:::note
## Alle Expansionen folgen demselben Prinzip

Ob Wildcards,

```bash
echo *
```

Variablen,

```bash
echo $USER
```

oder Befehlsersetzungen,

```bash
echo $(ls)
```

die Shell arbeitet immer nach demselben Muster:

1. Du gibst einen Befehl ein.
2. Bash führt alle notwendigen Expansionen durch.
3. Erst danach startet sie das eigentliche Programm.

Die meisten Programme wissen deshalb gar nichts von Wildcards, Variablen oder Befehlsersetzungen. Sie erhalten lediglich das fertige Ergebnis der Expansion.
:::

## Befehlsersetzung (Command Substitution)

Eine besonders praktische Form der Expansion ist die **Befehlsersetzung** (*Command Substitution*).

Dabei wird nicht der Name einer Variablen ersetzt, sondern die Ausgabe eines Befehls.

Die allgemeine Schreibweise lautet:

```text
$(command)
```

Schauen wir uns ein einfaches Beispiel an:

```bash
[me@linuxbox ~]$ echo $(ls)
Desktop Documents ls-output.txt Music Pictures Public Templates Videos
```

Zuerst führt die Shell den Befehl

```bash
ls
```

aus.

Anschließend ersetzt sie `$(ls)` durch dessen Ausgabe.

Erst danach startet sie `echo`.

Ein besonders schönes Beispiel ist dieses:

```bash
[me@linuxbox ~]$ ls -l $(which cp)
-rwxr-xr-x 1 root root 71516 2025-12-05 08:58 /bin/cp
```

Was passiert hier?

1. `which cp` sucht den vollständigen Pfad des Programms `cp`.
2. Die Shell ersetzt `$(which cp)` durch diesen Pfad.
3. Anschließend erhält `ls -l` den fertigen Dateinamen als Argument.

Für die Shell sieht der Befehl letztlich ungefähr so aus:

```bash
ls -l /bin/cp
```

Natürlich können innerhalb einer Befehlsersetzung auch komplette Pipelines verwendet werden.

```bash
[me@linuxbox ~]$ file $(ls -d /usr/bin/* | grep zip)
```

In diesem Beispiel geschieht Folgendes:

1. `ls` erzeugt eine Liste aller Programme.
2. `grep` filtert daraus alle Namen, die `zip` enthalten.
3. Die Shell ersetzt die gesamte Befehlsersetzung durch diese Dateinamen.
4. `file` untersucht anschließend jede dieser Dateien.

Auf diese Weise entstehen oft überraschend kurze und gleichzeitig sehr leistungsfähige Befehle.

### Die alte Schreibweise mit Backticks

Vielleicht begegnest du in älteren Skripten noch einer anderen Schreibweise:

```bash
[me@linuxbox ~]$ ls -l `which cp`
-rwxr-xr-x 1 root root 71516 2025-12-05 08:58 /bin/cp
```

Diese verwendet sogenannte **Backticks** (`` ` ``) anstelle von `$(...)`.

Beide Varianten funktionieren in Bash.

Heute gilt jedoch eindeutig die Schreibweise

```bash
$(command)
```

als Best Practice.

Sie ist leichter zu lesen, einfacher zu verschachteln und deshalb in modernen Shell-Skripten praktisch immer die bessere Wahl.

## Quoting

Bisher haben wir verschiedene Arten der Expansion kennengelernt.

Das ist äußerst praktisch – manchmal aber auch genau das Gegenteil von dem, was wir möchten.

Schauen wir uns zwei Beispiele an.

```bash
[me@linuxbox ~]$ echo this is a      test
this is a test
```

Obwohl zwischen `a` und `test` mehrere Leerzeichen stehen, gibt `echo` nur eines aus.

Oder dieses Beispiel:

```bash
[me@linuxbox ~]$ echo The total is $100.00
The total is 00.00
```

Warum?

Die Shell interpretiert `$1` als Variablenname.

Da diese Variable nicht existiert, ersetzt Bash sie durch eine leere Zeichenkette.

Übrig bleibt lediglich:

```text
00.00
```

Damit wir dieses Verhalten bei Bedarf unterdrücken können, stellt die Shell **Quoting** zur Verfügung.

Durch Anführungszeichen bestimmen wir, welche Expansionen stattfinden dürfen – und welche nicht.

## Doppelte Anführungszeichen

Beginnen wir mit den **doppelten Anführungszeichen** (`"`).

Sie unterdrücken einen Teil der Expansionen, aber nicht alle.

Folgende Expansionen werden deaktiviert:

- Worttrennung (_Word Splitting_)
- Pfadnamen-Expansion (_Pathname Expansion_)
- Tilde-Expansion
- Brace Expansion

Diese Expansionen funktionieren dagegen weiterhin:

- Parameter-Expansion
- Arithmetische Expansion
- Befehlsersetzung

Der häufigste Anwendungsfall sind Dateinamen mit Leerzeichen.

Angenommen, wir hätten eine Datei mit dem Namen

```text
two words.txt
```

Dann schlägt folgender Befehl fehl:

```bash
[me@linuxbox ~]$ ls -l two words.txt
ls: cannot access two: No such file or directory
ls: cannot access words.txt: No such file or directory
```

Die Shell trennt den Dateinamen nämlich an der Leerstelle und übergibt zwei verschiedene Argumente an `ls`.

Mit doppelten Anführungszeichen bleibt der Dateiname dagegen erhalten:

```bash
[me@linuxbox ~]$ ls -l "two words.txt"
-rw-rw-r-- 1 me me 18 2016-02-20 13:03 two words.txt
```

Noch besser ist es natürlich, Dateien gar nicht erst mit Leerzeichen zu benennen.

Wir können sie direkt umbenennen:

```bash
[me@linuxbox ~]$ mv "two words.txt" two_words.txt
```

Jetzt benötigen wir künftig keine Anführungszeichen mehr.

### Expansion innerhalb doppelter Anführungszeichen

Doppelte Anführungszeichen verhindern **nicht** jede Expansion.

Parameter, Berechnungen und Befehlsersetzungen funktionieren weiterhin:

```bash
[me@linuxbox ~]$ echo "$USER $((2+2)) $(df -h)"
me 4
Filesystem      Size Used Avail Use% Mounted on
...
```

### Worttrennung und doppelte Anführungszeichen

Erinnern wir uns an dieses Beispiel:

```bash
[me@linuxbox ~]$ echo this is a      test
this is a test
```

Die Shell betrachtet Leerzeichen, Tabulatoren und Zeilenumbrüche standardmäßig als Trennzeichen zwischen einzelnen Argumenten.

Mehrere Leerzeichen werden deshalb nicht als Teil des Textes übernommen.

Setzen wir den Text dagegen in doppelte Anführungszeichen,

```bash
[me@linuxbox ~]$ echo "this is a      test"
this is a      test
```

bleiben sämtliche Leerzeichen erhalten.

Für die Shell besteht der Befehl jetzt aus einem einzigen Argument.

### Doppelte Anführungszeichen bei der Befehlsersetzung

Besonders interessant wird dieses Verhalten bei der Befehlsersetzung.

Ohne Anführungszeichen:

```bash
[me@linuxbox ~]$ echo $(df -h)
```

ersetzt die Shell alle Zeilenumbrüche durch Leerzeichen.

Die komplette Ausgabe erscheint dadurch in einer einzigen langen Zeile.

Mit doppelten Anführungszeichen:

```bash
[me@linuxbox ~]$ echo "$(df -h)"
```

bleiben Zeilenumbrüche und Leerzeichen erhalten.

Die formatierte Tabellenausgabe von `df` bleibt deshalb lesbar.

Der Unterschied ist größer, als es zunächst scheint.

Im ersten Fall zerlegt die Shell die Ausgabe in viele einzelne Argumente.

Im zweiten Fall bleibt die komplette Ausgabe ein einziges Argument.

:::
## Eine der wichtigsten Regeln beim Shell-Scripting

Sobald eine Variable oder eine Befehlsersetzung Leerzeichen enthalten könnte, solltest du sie fast immer in doppelte Anführungszeichen setzen.

Zum Beispiel:

```bash
"$USER"
"$(pwd)"
"$HOME"
"$filename"
```

Das verhindert viele schwer zu findende Fehler und gehört zu den wichtigsten Best Practices beim Schreiben von Shell-Skripten.

Im weiteren Verlauf des Buches werden wir deshalb häufig Anführungszeichen um Variablen sehen.
:::

## Einfache Anführungszeichen

Möchten wir **sämtliche Expansionen** unterdrücken, verwenden wir **einfache Anführungszeichen** (`'`).

Der Unterschied wird in folgendem Beispiel deutlich:

Ohne Anführungszeichen:

```bash
[me@linuxbox ~]$ echo text ~/*.txt {a,b} $(echo foo) $((2+2)) $USER
text /home/me/ls-output.txt a b foo 4 me
```

Mit doppelten Anführungszeichen:

```bash
[me@linuxbox ~]$ echo "text ~/*.txt {a,b} $(echo foo) $((2+2)) $USER"
text ~/*.txt {a,b} foo 4 me
```

Mit einfachen Anführungszeichen:

```bash
[me@linuxbox ~]$ echo 'text ~/*.txt {a,b} $(echo foo) $((2+2)) $USER'
text ~/*.txt {a,b} $(echo foo) $((2+2)) $USER
```

Mit jeder Stufe des Quotings werden mehr Expansionen unterdrückt.

| Schreibweise | Expansionen |
|--------------|-------------|
| Ohne Anführungszeichen | Alle Expansionen sind möglich. |
| Doppelte Anführungszeichen (`"`) | Worttrennung, Wildcards, Tilde- und Brace-Expansion werden unterdrückt. Parameter-Expansion, arithmetische Expansion und Befehlsersetzung bleiben aktiv. |
| Einfache Anführungszeichen (`'`) | Sämtliche Expansionen werden unterdrückt. Der Inhalt wird exakt so übernommen, wie er geschrieben wurde. |

Wenn du dir nur eine Regel merken möchtest, dann diese:

- **Doppelte Anführungszeichen** erlauben noch einige Expansionen.
- **Einfache Anführungszeichen** verhindern praktisch alle Expansionen.

Dieses Wissen gehört zu den wichtigsten Grundlagen für das Arbeiten mit der Shell und wird uns im weiteren Verlauf des Buches immer wieder begegnen.

## Zeichen maskieren (Escaping)

Bisher haben wir ganze Textabschnitte in einfache oder doppelte Anführungszeichen gesetzt.

Manchmal möchten wir jedoch nur **ein einzelnes Zeichen** vor einer Expansion schützen.

Dafür verwenden wir den **Backslash** (`\`).

In diesem Zusammenhang nennt man ihn das **Escape-Zeichen**.

Der Backslash hebt die besondere Bedeutung des unmittelbar folgenden Zeichens auf.

Ein typisches Beispiel ist ein Dollarzeichen innerhalb doppelter Anführungszeichen:

```bash
[me@linuxbox ~]$ echo "The balance for user $USER is: \$5.00"
The balance for user me is: $5.00
```

Hier passiert Folgendes:

- `$USER` wird weiterhin expandiert.
- `\$` wird **nicht** als Variablenanfang interpretiert.
- Deshalb erscheint das Dollarzeichen ganz normal in der Ausgabe.

Der Backslash ermöglicht also, einzelne Zeichen gezielt vor einer Expansion zu schützen, ohne gleich den gesamten Text in einfache Anführungszeichen setzen zu müssen.

### Sonderzeichen in Dateinamen

Der Backslash wird häufig auch verwendet, wenn Dateinamen Zeichen enthalten, die für die Shell eine besondere Bedeutung besitzen.

Dazu gehören beispielsweise:

- Leerzeichen
- `$`
- `&`
- `!`
- `*`
- `?`

Angenommen, eine Datei heißt

```text
bad&filename
```

Dann könnte sie mit folgendem Befehl umbenannt werden:

```bash
[me@linuxbox ~]$ mv bad\&filename good_filename
```

Der Backslash sorgt dafür, dass `&` als normales Zeichen behandelt wird.

Möchtest du einen Backslash selbst schreiben, musst du ihn ebenfalls maskieren:

```text
\\
```

Innerhalb einfacher Anführungszeichen (`'...'`) verliert der Backslash übrigens seine Sonderfunktion und wird wie jedes andere Zeichen behandelt.

### Aliase umgehen

Der Backslash kann noch etwas Überraschendes.

Er verhindert auch die Verwendung von **Aliases**.

Angenommen, dein System enthält folgenden Alias:

```bash
alias ls='ls --color=auto'
```

Dann wird normalerweise bei jedem Aufruf von `ls` automatisch die Option `--color=auto` ergänzt.

Möchtest du stattdessen den ursprünglichen Befehl ohne Alias ausführen, genügt ein Backslash:

```bash
\ls
```

Die Shell ignoriert den Alias und startet direkt das eigentliche Programm.

:::
## Wann verwendet man Escaping und wann Anführungszeichen?

Beides dient dazu, die automatische Interpretation durch die Shell zu steuern.

Der Unterschied ist einfach:

- Mit einem **Backslash** (`\`) maskierst du **ein einzelnes Zeichen**.
- Mit **doppelten Anführungszeichen** (`"`) schützt du einen ganzen Textbereich, erlaubst aber weiterhin einige Expansionen.
- Mit **einfachen Anführungszeichen** (`'`) schützt du den gesamten Inhalt vollständig vor der Interpretation durch die Shell.

Welche Methode die richtige ist, hängt davon ab, wie viel der Shell du noch erlauben möchtest.
:::

:::
## Backslash-Escape-Sequenzen

Der Backslash dient nicht nur zum Maskieren einzelner Zeichen.

Er wird auch verwendet, um sogenannte **Escape-Sequenzen** zu schreiben.

Dabei handelt es sich um eine Kurzschreibweise für Steuerzeichen, die sich nicht direkt eingeben lassen.

Zu den häufigsten gehören:

| Escape-Sequenz | Bedeutung |
|----------------|-----------|
| `\a` | Signalton (Bell) |
| `\b` | Rücktaste (Backspace) |
| `\n` | Zeilenumbruch |
| `\r` | Wagenrücklauf (Carriage Return) |
| `\t` | Tabulator |

Diese Schreibweise stammt ursprünglich aus der Programmiersprache **C** und wurde später von vielen anderen Programmiersprachen und auch von der Shell übernommen.

Standardmäßig behandelt `echo` diese Sequenzen als normalen Text.

Mit der Option `-e` werden sie interpretiert:

```bash
echo -e "Hallo\nWelt"
```

Ausgabe:

```text
Hallo
Welt
```

Alternativ können Escape-Sequenzen auch innerhalb der speziellen Schreibweise `$'...'` verwendet werden:

```bash
echo $'Hallo\nWelt'
```

Beide Befehle erzeugen dieselbe Ausgabe.

Ein kleines Beispiel:

```bash
sleep 10
echo -e "Zeit ist um!\a"
```

Oder alternativ:

```bash
sleep 10
echo "Zeit ist um!" $'\a'
```

Nach zehn Sekunden erscheint die Meldung und zusätzlich wird – sofern dein Terminal dies unterstützt – ein Signalton ausgegeben.
:::

## Zusammenfassung

Mit diesem Kapitel haben wir die wichtigsten Arten der Expansion kennengelernt.

Die Shell ersetzt nicht einfach Zeichenfolgen.

Sie analysiert unsere Eingabe Schritt für Schritt und führt verschiedene Expansionen aus, **bevor** der eigentliche Befehl gestartet wird.

Ebenso wichtig ist das **Quoting**.

Durch Anführungszeichen und Escaping entscheiden wir selbst, welche Expansionen stattfinden dürfen und welche nicht.

Dieses Wissen bildet eine der wichtigsten Grundlagen für den sicheren Umgang mit der Shell.

Viele scheinbar rätselhafte Verhaltensweisen von Bash werden verständlich, sobald man weiß, **wann** die Shell eine Expansion durchführt und **wann nicht**.

Im weiteren Verlauf des Buches werden wir immer wieder auf diese Konzepte zurückkommen.

## Weiterführende Literatur

- Die Handbuchseite (`man bash`) enthält ausführliche Kapitel über **Expansion** und **Quoting**.
- Auch das **Bash Reference Manual** behandelt beide Themen sehr detailliert:
https://www.gnu.org/software/bash/manual/bashref.html

