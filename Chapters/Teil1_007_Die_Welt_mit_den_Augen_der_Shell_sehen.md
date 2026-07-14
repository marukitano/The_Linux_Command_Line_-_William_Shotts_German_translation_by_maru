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
