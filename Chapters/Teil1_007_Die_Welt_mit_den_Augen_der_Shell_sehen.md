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