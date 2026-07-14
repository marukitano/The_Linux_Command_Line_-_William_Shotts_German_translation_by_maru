# 4 – Dateien und Verzeichnisse verwalten

Jetzt wird es praktisch! In diesem Kapitel lernen wir die folgenden Befehle kennen:

- **`cp`** – Dateien und Verzeichnisse kopieren.
- **`mv`** – Dateien und Verzeichnisse verschieben oder umbenennen.
- **`mkdir`** – Verzeichnisse erstellen.
- **`rm`** – Dateien und Verzeichnisse löschen.
- **`ln`** – Hardlinks und symbolische Links erstellen.

Diese fünf Befehle gehören zu den wichtigsten und am häufigsten verwendeten Werkzeugen unter Linux. Mit ihnen kannst du Dateien und Verzeichnisse erstellen, kopieren, verschieben, umbenennen und löschen.

Ganz ehrlich: Viele dieser Aufgaben lassen sich mit einem grafischen Dateimanager einfacher erledigen. Dort kannst du Dateien per Drag-and-drop verschieben, kopieren oder löschen – ganz bequem.

Warum solltest du also überhaupt diese alten Kommandozeilenprogramme verwenden?

Die Antwort lautet: **Leistung und Flexibilität.**

Einfache Aufgaben sind mit einem grafischen Dateimanager oft schneller erledigt. Sobald es aber etwas komplexer wird, spielt die Kommandozeile ihre Stärken aus.

Angenommen, du möchtest alle HTML-Dateien aus einem Verzeichnis in ein anderes kopieren – allerdings **nur**, wenn sie im Ziel noch nicht vorhanden sind oder neuer als die bereits vorhandenen Dateien sind.

Mit einem grafischen Dateimanager ist das nur schwer möglich.

Auf der Kommandozeile genügt dagegen ein einziger Befehl:

```bash
cp -u *.html destination
```
## Wildcards

Bevor wir mit den einzelnen Befehlen beginnen, sollten wir uns eine der nützlichsten Funktionen der Shell ansehen.

Da die Shell ständig mit Dateinamen arbeitet, stellt sie spezielle Platzhalter zur Verfügung, mit denen sich ganze Gruppen von Dateien auf einmal auswählen lassen.

Diese Platzhalter heißen **Wildcards**. Ihre Verwendung wird häufig auch als **Globbing** bezeichnet.

Mit Wildcards kannst du Dateinamen anhand bestimmter Muster auswählen, anstatt jeden einzelnen Namen ausschreiben zu müssen.

## Tabelle 4-1: Wildcards

| Wildcard | Bedeutung |
|----------|-----------|
| `*` | Beliebig viele Zeichen, auch kein Zeichen. |
| `?` | Genau ein beliebiges Zeichen. |
| `[characters]` | Genau ein Zeichen aus der angegebenen Zeichenmenge `characters`. |
| `[!characters]` oder `[^characters]` | Genau ein Zeichen, das **nicht** zur Zeichenmenge `characters` gehört. |
| `[[:class:]]` | Genau ein Zeichen aus der angegebenen Zeichenklasse. |

Die folgende Tabelle zeigt einige der am häufigsten verwendeten Zeichenklassen.

## Tabelle 4-2: Häufig verwendete Zeichenklassen

| Zeichenklasse | Bedeutung |
|---------------|-----------|
| `[:alnum:]` | Beliebiges alphanumerisches Zeichen (Buchstaben oder Ziffern). |
| `[:alpha:]` | Beliebiger Buchstabe. |
| `[:digit:]` | Beliebige Ziffer (`0`–`9`). |
| `[:lower:]` | Beliebiger Kleinbuchstabe. |
| `[:upper:]` | Beliebiger Großbuchstabe. |

Mit Wildcards lassen sich erstaunlich leistungsfähige Suchmuster für Dateinamen erstellen.

Die folgende Tabelle zeigt einige typische Beispiele.

## Tabelle 4-3: Beispiele für Wildcards

| Muster | Entspricht |
|---------|------------|
| `*` | Alle Dateien. |
| `g*` | Alle Dateien, deren Name mit `g` beginnt. |
| `b*.txt` | Alle Dateien, deren Name mit `b` beginnt und auf `.txt` endet. |
| `Data???` | Alle Dateien, die mit `Data` beginnen und anschließend genau drei weitere Zeichen besitzen. |
| `[abc]*` | Alle Dateien, deren Name mit `a`, `b` oder `c` beginnt. |
| `BACKUP.[0-9][0-9][0-9]` | Alle Dateien, die mit `BACKUP.` beginnen und auf genau drei Ziffern enden. |
| `[[:upper:]]*` | Alle Dateien, deren Name mit einem Großbuchstaben beginnt. |
| `[![:digit:]]*` | Alle Dateien, deren Name **nicht** mit einer Ziffer beginnt. |
| `*[[:lower:]123]` | Alle Dateien, deren Name mit einem Kleinbuchstaben oder einer der Ziffern `1`, `2` oder `3` endet. |

Wildcards können mit jedem Befehl verwendet werden, der Dateinamen als Argumente akzeptiert.

Wie vielseitig sie tatsächlich sind, werden wir in Kapitel 7 noch genauer kennenlernen.

::: note
## Vorsicht bei Zeichenbereichen

Wenn du bereits Erfahrung mit Unix oder Linux hast oder andere Bücher gelesen hast, bist du vielleicht schon auf Schreibweisen wie `[A-Z]` oder `[a-z]` gestoßen.

Diese Bereiche gehören zur klassischen Unix-Syntax und werden auch heute noch von vielen Shells unterstützt.

Allerdings liefern sie nicht immer das erwartete Ergebnis. Je nach Sprach- und Ländereinstellungen des Systems (`Locale`) kann beispielsweise `[A-Z]` mehr Zeichen auswählen als nur die 26 Großbuchstaben des englischen Alphabets.

Aus diesem Grund verwenden moderne Shell-Skripte und viele Linux-Projekte in der Regel **Zeichenklassen** wie `[:upper:]`, `[:lower:]` oder `[:digit:]` anstelle von Bereichen wie `[A-Z]`.

Sie sind robuster und funktionieren unabhängig von den Spracheinstellungen des Systems zuverlässiger.
:::

## Versteckte Dateien

Wenn wir uns den Inhalt unseres Home-Verzeichnisses mit `ls -a` ansehen, fallen uns zahlreiche Dateien und Verzeichnisse auf, deren Name mit einem Punkt beginnt.

Wie wir bereits gelernt haben, handelt es sich dabei um **versteckte Dateien**.

Der führende Punkt ist jedoch **kein besonderes Dateiattribut**. Er bewirkt lediglich, dass die Datei von `ls` standardmäßig nicht angezeigt wird. Erst mit den Optionen `-a` oder `-A` erscheint sie in der Ausgabe.

Dasselbe gilt auch für **Wildcards**. Standardmäßig werden versteckte Dateien von Mustern wie `*` nicht berücksichtigt. Möchtest du sie ebenfalls auswählen, muss dein Suchmuster mit einem Punkt beginnen, zum Beispiel:

```text
.*
```

Je nach Konfiguration deiner Shell kann dieses Muster allerdings auch die beiden besonderen Verzeichnisse `.` (aktuelles Verzeichnis) und `..` (übergeordnetes Verzeichnis) mit einschließen.

Falls du diese ausschließen möchtest, kannst du stattdessen eines der folgenden Muster verwenden:

```text
.[!.]*
```

oder

```text
.??*
```
Das Muster \`.\[!.]\*\` findet versteckte Dateien, deren Name mindestens zwei Zeichen lang ist und nicht mit \`..\` beginnt. \` .??\*\` ergänzt Dateien mit längeren Namen. Beide Muster werden häufig zusammen verwendet, um alle versteckten Dateien auszuwählen, ohne \`.\` und \`..\` einzuschließen.

::: note
## Wildcards funktionieren auch in grafischen Dateimanagern

Wildcards sind nicht nur auf der Kommandozeile nützlich. Viele grafische Dateimanager unterstützen sie ebenfalls – zum Beispiel beim Suchen oder Filtern von Dateien.

So kannst du beispielsweise nach allen Dateien suchen, deren Name mit einem kleinen `u` beginnt:

```text
u*
```

Oder nach allen Markdown-Dateien:

```text
*.md
```

Welche Funktionen genau zur Verfügung stehen, hängt vom verwendeten Dateimanager ab. Ob GNOME, KDE, Cinnamon oder XFCE – viele Ideen der Kommandozeile finden sich auch in den grafischen Oberflächen wieder.

Genau das macht Linux so leistungsfähig: Du kannst dieselben Konzepte sowohl auf der Kommandozeile als auch im grafischen Desktop nutzen.
:::

## `mkdir` – Verzeichnisse erstellen

Mit dem Befehl `mkdir` werden neue Verzeichnisse erstellt.

Die allgemeine Syntax lautet:

```text
mkdir directory...
```

### Ein Hinweis zur Schreibweise

Stehen hinter einem Argument drei Punkte (`...`), bedeutet das, dass dieses Argument beliebig oft wiederholt werden kann.

Der folgende Befehl erstellt beispielsweise ein einzelnes Verzeichnis mit dem Namen `dir1`:

```bash
mkdir dir1
```

Dieser Befehl erstellt dagegen drei Verzeichnisse mit den Namen `dir1`, `dir2` und `dir3`:

```bash
mkdir dir1 dir2 dir3
```

## `cp` – Dateien und Verzeichnisse kopieren

Mit dem Befehl `cp` kannst du Dateien und Verzeichnisse kopieren.

Dabei gibt es zwei grundlegende Verwendungsweisen.

Mit der ersten Variante kopierst du eine einzelne Datei oder ein einzelnes Verzeichnis von `item1` nach `item2`:

```text
cp item1 item2
```

Mit der zweiten Variante kopierst du mehrere Dateien oder Verzeichnisse in ein Zielverzeichnis:

```text
cp item... directory
```

## Nützliche Optionen und Beispiele

Die folgende Tabelle zeigt einige der am häufigsten verwendeten Optionen von `cp`.

## Tabelle 4-4: Häufig verwendete Optionen für `cp`

| Option | Lange Option | Bedeutung |
|--------|--------------|-----------|
| `-a` | `--archive` | Kopiert Dateien und Verzeichnisse einschließlich ihrer Attribute, etwa Besitzer, Zugriffsrechte und Zeitstempel. Standardmäßig erhalten Kopien die Attribute des Benutzers, der den Kopiervorgang ausführt. Mit Dateiberechtigungen beschäftigen wir uns ausführlich in Kapitel 9. |
| `-i` | `--interactive` | Fragt vor dem Überschreiben einer vorhandenen Datei nach einer Bestätigung. Ohne diese Option überschreibt `cp` vorhandene Dateien ohne Rückfrage. |
| `-r` | `--recursive` | Kopiert Verzeichnisse einschließlich ihres gesamten Inhalts. Diese Option (oder `-a`) ist erforderlich, wenn Verzeichnisse kopiert werden sollen. |
| `-u` | `--update` | Kopiert nur Dateien, die im Ziel noch nicht vorhanden oder neuer als die dort vorhandene Version sind. Das spart Zeit, wenn große Datenmengen kopiert werden. |
| `-v` | `--verbose` | Zeigt während des Kopiervorgangs ausführliche Informationen an. |

Die folgende Tabelle zeigt einige typische Einsatzmöglichkeiten von `cp`.

## Tabelle 4-5: Typische Anwendungen von `cp`

| Befehl | Ergebnis |
|--------|----------|
| `cp file1 file2` | Kopiert `file1` nach `file2`. Existiert `file2` bereits, wird die Datei überschrieben. Andernfalls wird sie neu erstellt. |
| `cp -i file1 file2` | Wie oben, allerdings fragt `cp` vor dem Überschreiben einer vorhandenen Datei nach einer Bestätigung. |
| `cp file1 file2 dir1` | Kopiert `file1` und `file2` in das Verzeichnis `dir1`. Das Verzeichnis `dir1` muss bereits existieren. |
| `cp dir1/* dir2` | Kopiert mithilfe einer Wildcard alle Dateien aus `dir1` nach `dir2`. Das Verzeichnis `dir2` muss bereits existieren. |
| `cp -r dir1 dir2` | Kopiert den gesamten Inhalt von `dir1` nach `dir2`. Existiert `dir2` noch nicht, wird das Verzeichnis angelegt und enthält anschließend denselben Inhalt wie `dir1`.<br><br>Existiert `dir2` bereits, wird `dir1` mitsamt seinem Inhalt **in** `dir2` kopiert. |

## `mv` – Dateien verschieben und umbenennen

Der Befehl `mv` dient sowohl zum **Verschieben** als auch zum **Umbenennen** von Dateien und Verzeichnissen. Welche der beiden Aktionen ausgeführt wird, hängt davon ab, wie der Befehl verwendet wird.

In beiden Fällen gilt: Nach der Ausführung existiert der ursprüngliche Name nicht mehr.

Die Syntax ähnelt der von `cp`.

Um eine Datei oder ein Verzeichnis von `item1` nach `item2` zu verschieben oder umzubenennen, verwendest du:

```text
mv item1 item2
```

Mehrere Dateien oder Verzeichnisse lassen sich mit folgendem Befehl in ein Zielverzeichnis verschieben:

```text
mv item... directory
```

## Nützliche Optionen und Beispiele

Viele Optionen von `mv` entsprechen denen von `cp`.

## Tabelle 4-6: Häufig verwendete Optionen für `mv`

| Option | Lange Option | Bedeutung |
|--------|--------------|-----------|
| `-i` | `--interactive` | Fragt vor dem Überschreiben einer vorhandenen Datei nach einer Bestätigung. Ohne diese Option überschreibt `mv` vorhandene Dateien ohne Rückfrage. |
| `-u` | `--update` | Verschiebt nur Dateien, die im Ziel noch nicht vorhanden oder neuer als die dort vorhandene Version sind. |
| `-v` | `--verbose` | Zeigt während des Verschiebens ausführliche Informationen an. |

Die folgende Tabelle zeigt einige typische Einsatzmöglichkeiten von `mv`.

## Tabelle 4-7: Typische Anwendungen von `mv`

| Befehl | Ergebnis |
|--------|----------|
| `mv file1 file2` | Verschiebt `file1` nach `file2`. Existiert `file2` bereits, wird sie ersetzt und `file1` erhält den Namen `file2`. Existiert `file2` nicht, wird `file1` einfach in `file2` umbenannt. In beiden Fällen existiert `file1` anschließend nicht mehr. |
| `mv -i file1 file2` | Wie oben, allerdings fragt `mv` vor dem Ersetzen einer vorhandenen Datei nach einer Bestätigung. |
| `mv file1 file2 dir1` | Verschiebt `file1` und `file2` in das Verzeichnis `dir1`. Das Verzeichnis `dir1` muss bereits existieren. |
| `mv dir1 dir2` | Existiert `dir2` nicht, wird `dir1` in `dir2` umbenannt.<br><br>Existiert `dir2` bereits, wird `dir1` mitsamt seinem gesamten Inhalt in das Verzeichnis `dir2` verschoben. |

## `rm` – Dateien und Verzeichnisse löschen

Der Befehl `rm` dient zum Löschen von Dateien und Verzeichnissen.

Die allgemeine Syntax lautet:

```text
rm item...
```

Dabei steht `item` für eine oder mehrere Dateien oder Verzeichnisse.

## Nützliche Optionen und Beispiele

Die folgende Tabelle zeigt einige der am häufigsten verwendeten Optionen von `rm`.

## Tabelle 4-8: Häufig verwendete Optionen für `rm`

| Option | Lange Option | Bedeutung |
|--------|--------------|-----------|
| `-i` | `--interactive` | Fragt vor dem Löschen einer Datei nach einer Bestätigung. Ohne diese Option löscht `rm` Dateien ohne Rückfrage. |
| `-r` | `--recursive` | Löscht Verzeichnisse einschließlich ihres gesamten Inhalts rekursiv. Diese Option ist erforderlich, um Verzeichnisse zu löschen. |
| `-f` | `--force` | Ignoriert nicht vorhandene Dateien und unterdrückt Rückfragen. Überschreibt die Option `--interactive`. |
| `-v` | `--verbose` | Zeigt während des Löschvorgangs ausführliche Informationen an. |

Die folgende Tabelle zeigt einige typische Einsatzmöglichkeiten von `rm`.

## Tabelle 4-9: Typische Anwendungen von `rm`

| Befehl | Ergebnis |
|--------|----------|
| `rm file1` | Löscht `file1` ohne Rückfrage. |
| `rm -i file1` | Wie oben, allerdings fragt `rm` vor dem Löschen nach einer Bestätigung. |
| `rm -r file1 dir1` | Löscht `file1` sowie das Verzeichnis `dir1` mitsamt seinem gesamten Inhalt. |
| `rm -rf file1 dir1` | Wie oben, allerdings werden fehlende Dateien oder Verzeichnisse ignoriert und es erfolgen keine Rückfragen. |

::: warning
## Vorsicht mit `rm`!

Unix-ähnliche Betriebssysteme wie Linux kennen keinen **„Rückgängig“-Befehl** für gelöschte Dateien.

Wenn du eine Datei mit `rm` löschst, ist sie in der Regel dauerhaft verschwunden. Linux geht davon aus, dass du genau weißt, was du tust.

Besondere Vorsicht ist beim Einsatz von **Wildcards** geboten.

Angenommen, du möchtest alle HTML-Dateien in einem Verzeichnis löschen:

```bash
rm *.html
```

Dieser Befehl ist korrekt.

Ein versehentliches Leerzeichen an der falschen Stelle kann jedoch weitreichende Folgen haben:

```bash
rm * .html
```

In diesem Fall löscht `rm` **alle Dateien** im aktuellen Verzeichnis und meldet anschließend, dass keine Datei mit dem Namen `.html` gefunden wurde.

### Ein nützlicher Tipp

Wenn du `rm` zusammen mit Wildcards verwendest, solltest du das Suchmuster zuerst mit `ls` testen:

```bash
ls *.html
```

So kannst du kontrollieren, welche Dateien ausgewählt werden.

Ist die Ausgabe korrekt, drückst du einfach die **Pfeiltaste nach oben**, um den letzten Befehl wieder aufzurufen, ersetzt `ls` durch `rm` und führst den Befehl anschließend aus.
:::

## `ln` – Links erstellen

Mit dem Befehl `ln` kannst du **Hardlinks** oder **Symlinks** erstellen.

Für Hardlinks verwendest du folgende Syntax:

```text
ln file link
```

Ein Symlink wird mit der Option `-s` erstellt:

```text
ln -s item link
```

Dabei steht `item` für eine Datei oder ein Verzeichnis.

## Hardlinks

Hardlinks sind die ursprüngliche Methode von Unix, um mehrere Namen für dieselbe Datei zu vergeben. Symbolische Links wurden erst später eingeführt.

Standardmäßig besitzt jede Datei genau einen Hardlink – nämlich den Verzeichniseintrag, der ihr ihren Namen gibt.

Wenn du einen Hardlink erzeugst, legst du keinen zweiten Dateiinhalt an. Stattdessen wird lediglich ein weiterer Verzeichniseintrag erstellt, der auf dieselben Daten verweist.

Hardlinks haben allerdings zwei wichtige Einschränkungen:

1. Ein Hardlink kann nur auf Dateien innerhalb desselben Dateisystems verweisen. Er kann also keine Datei auf einer anderen Partition oder einem anderen Datenträger referenzieren.
2. Hardlinks können nicht auf Verzeichnisse zeigen.

Ein Hardlink ist von der ursprünglichen Datei praktisch nicht zu unterscheiden. Anders als bei Symlinks gibt `ls` keinen besonderen Hinweis darauf aus, dass es sich um einen Hardlink handelt.

Wird ein Hardlink gelöscht, verschwindet lediglich dieser Verzeichniseintrag. Die eigentlichen Dateidaten bleiben erhalten, solange mindestens ein weiterer Hardlink auf sie verweist.

Auch wenn Hardlinks heute nur noch selten direkt verwendet werden, solltest du ihre Funktionsweise kennen. Im Alltag wirst du jedoch wesentlich häufiger Symlinks begegnen.

## Symlinks (Symbolische Links)

Symlinks wurden eingeführt, um die Einschränkungen von Hardlinks zu umgehen.

Ein Symlink ist eine besondere Datei, die lediglich auf eine andere Datei oder ein anderes Verzeichnis verweist.

Dieses Prinzip ähnelt einer **Verknüpfung** unter Windows – mit dem Unterschied, dass Symlinks dieses Konzept schon viele Jahre früher eingeführt haben.

Für die meisten Programme verhalten sich ein symbolischer Link und die eigentliche Datei nahezu identisch.

Schreibst du beispielsweise Daten in einen symbolischen Link, landen diese in der Datei, auf die der Link verweist.

Löschst du dagegen den symbolischen Link, bleibt die eigentliche Datei erhalten.

Wird jedoch zuerst die Zieldatei gelöscht, bleibt der symbolische Link bestehen, verweist aber ins Leere. Ein solcher Link wird als **defekter** oder **gebrochener symbolischer Link** (_broken link_) bezeichnet.

Viele Versionen von `ls` heben defekte symbolische Links farblich hervor – häufig in Rot –, damit sie leicht zu erkennen sind.

Falls dir das Konzept von Links im Moment noch etwas abstrakt erscheint, keine Sorge.

Wir werden gleich selbst damit arbeiten.

Dann wird vieles deutlich verständlicher.

## Einen Spielplatz anlegen

Da wir nun anfangen werden, Dateien und Verzeichnisse tatsächlich zu bearbeiten, richten wir uns zunächst einen sicheren Ort zum Experimentieren ein.

Wir erstellen dazu in unserem Home-Verzeichnis ein neues Verzeichnis mit dem Namen `playground`.

### Verzeichnisse erstellen

Mit `mkdir` werden Verzeichnisse angelegt.

Zunächst stellen wir sicher, dass wir uns im Home-Verzeichnis befinden, und erstellen anschließend unser neues Arbeitsverzeichnis:

```bash
[me@linuxbox ~]$ cd
[me@linuxbox ~]$ mkdir playground
```

Damit unser Spielplatz nicht ganz so leer aussieht, legen wir darin gleich zwei weitere Verzeichnisse mit den Namen `dir1` und `dir2` an.

Dazu wechseln wir zunächst in `playground` und führen `mkdir` erneut aus:

```bash
[me@linuxbox ~]$ cd playground
[me@linuxbox playground]$ mkdir dir1 dir2
```

Beachte, dass `mkdir` mehrere Argumente akzeptiert. Dadurch können wir beide Verzeichnisse mit einem einzigen Befehl erstellen.

## Dateien kopieren

Jetzt bringen wir etwas Leben in unseren Spielplatz und kopieren eine Datei hinein.

Dazu verwenden wir `cp` und kopieren die Datei `passwd` aus dem Verzeichnis `/etc` in unser aktuelles Arbeitsverzeichnis.

```bash
[me@linuxbox playground]$ cp /etc/passwd .
```

Der einzelne Punkt (`.`) am Ende des Befehls steht als Kurzschreibweise für das **aktuelle Arbeitsverzeichnis**.

Wenn wir uns den Inhalt nun mit `ls` ansehen, finden wir unsere kopierte Datei:

```text
[me@linuxbox playground]$ ls -l
total 12
drwxrwxr-x 2 me me 4096 2025-01-10 16:40 dir1
drwxrwxr-x 2 me me 4096 2025-01-10 16:40 dir2
-rw-r--r-- 1 me me 1650 2025-01-10 16:07 passwd
```

Probieren wir denselben Kopiervorgang noch einmal aus – diesmal mit der Option `-v` (_verbose_), damit `cp` anzeigt, was gerade passiert.

```bash
[me@linuxbox playground]$ cp -v /etc/passwd .
```

```text
`/etc/passwd' -> `./passwd'
```

Die Datei wurde erneut kopiert. Dieses Mal zeigt `cp` zusätzlich eine kurze Meldung über den ausgeführten Vorgang an.

Vielleicht ist dir aufgefallen, dass `cp` die vorhandene Datei **ohne Rückfrage** überschrieben hat.

Auch hier gilt: Linux geht davon aus, dass du weißt, was du tust.

Wenn du vor dem Überschreiben eine Bestätigung erhalten möchtest, verwendest du die Option `-i` (_interactive_):

```bash
[me@linuxbox playground]$ cp -i /etc/passwd .
```

```text
cp: overwrite `./passwd'?
```

Antwortest du mit `y`, wird die Datei überschrieben.

Bei jeder anderen Eingabe – beispielsweise `n` – bleibt die vorhandene Datei unverändert.

## Dateien verschieben und umbenennen

Der Name `passwd` klingt für unseren Spielplatz etwas langweilig.

Benennen wir die Datei deshalb in `fun` um:

```bash
[me@linuxbox playground]$ mv passwd fun
```

Nun lassen wir unsere Datei ein wenig herumwandern.

Zunächst verschieben wir sie nach `dir1`:

```bash
[me@linuxbox playground]$ mv fun dir1
```

Anschließend verschieben wir sie von `dir1` nach `dir2`:

```bash
[me@linuxbox playground]$ mv dir1/fun dir2
```

Und schließlich holen wir sie wieder in unser aktuelles Arbeitsverzeichnis zurück:

```bash
[me@linuxbox playground]$ mv dir2/fun .
```

Schauen wir uns nun an, wie sich `mv` beim Verschieben von Verzeichnissen verhält.

Zuerst verschieben wir unsere Datei erneut nach `dir1`:

```bash
[me@linuxbox playground]$ mv fun dir1
```

Nun verschieben wir das gesamte Verzeichnis `dir1` nach `dir2` und kontrollieren anschließend das Ergebnis:

```bash
[me@linuxbox playground]$ mv dir1 dir2
[me@linuxbox playground]$ ls -l dir2
```

```text
total 4
drwxrwxr-x 2 me me 4096 2025-01-11 06:06 dir1
```

```bash
[me@linuxbox playground]$ ls -l dir2/dir1
```

```text
total 4
-rw-r--r-- 1 me me 1650 2025-01-10 16:33 fun
```

Da `dir2` bereits existierte, wurde `dir1` **in** dieses Verzeichnis verschoben.

Hätte `dir2` dagegen noch nicht existiert, hätte `mv` `dir1` einfach in `dir2` umbenannt.

Zum Schluss bringen wir alles wieder an seinen ursprünglichen Platz:

```bash
[me@linuxbox playground]$ mv dir2/dir1 .
[me@linuxbox playground]$ mv dir1/fun .
```

## Hardlinks erstellen

Jetzt probieren wir Hardlinks aus.

Wir erstellen zunächst drei Hardlinks zu unserer Datei `fun`:

```bash
[me@linuxbox playground]$ ln fun fun-hard
[me@linuxbox playground]$ ln fun dir1/fun-hard
[me@linuxbox playground]$ ln fun dir2/fun-hard
```

Jetzt existieren vier Verzeichniseinträge, die auf dieselbe Datei verweisen.

Schauen wir uns unser Arbeitsverzeichnis an:

```text
[me@linuxbox playground]$ ls -l
total 16
drwxrwxr-x 2 me me 4096 2025-01-14 16:17 dir1
drwxrwxr-x 2 me me 4096 2025-01-14 16:17 dir2
-rw-r--r-- 4 me me 1650 2025-01-10 16:33 fun
-rw-r--r-- 4 me me 1650 2025-01-10 16:33 fun-hard
```

Vielleicht ist dir aufgefallen, dass in der zweiten Spalte sowohl bei `fun` als auch bei `fun-hard` die Zahl **4** steht.

Sie gibt an, dass derzeit **vier Hardlinks** auf dieselbe Datei verweisen.

Denke daran: Jede Datei besitzt mindestens einen Hardlink – nämlich den Verzeichniseintrag, der ihr ihren Namen gibt.

Woher wissen wir aber, dass `fun` und `fun-hard` tatsächlich dieselbe Datei sind?

Mit der normalen Ausgabe von `ls` lässt sich das nicht eindeutig erkennen. Zwar haben beide Dateien dieselbe Größe, doch das allein beweist noch nichts.

Dafür benötigen wir eine zusätzliche Information.

### Inodes

Um Hardlinks besser zu verstehen, hilft folgendes Modell:

Eine Datei besteht vereinfacht aus zwei Teilen:

1. den eigentlichen **Dateidaten**
2. einem **Verzeichniseintrag**, der den Namen der Datei enthält

Wenn wir einen Hardlink erstellen, entsteht lediglich ein weiterer Verzeichniseintrag, der auf dieselben Dateidaten verweist.

Intern verwaltet Linux diese Daten über sogenannte **Inodes**. Ein Inode enthält Informationen über eine Datei und verweist auf die Datenblöcke auf dem Datenträger.

Jeder Hardlink zeigt auf denselben Inode.

Mit der Option `-i` kann `ls` die Inode-Nummer anzeigen:

```bash
[me@linuxbox playground]$ ls -li
```

```text
total 16
12353539 drwxrwxr-x 2 me me 4096 2025-01-14 16:17 dir1
12353540 drwxrwxr-x 2 me me 4096 2025-01-14 16:17 dir2
12353538 -rw-r--r-- 4 me me 1650 2025-01-10 16:33 fun
12353538 -rw-r--r-- 4 me me 1650 2025-01-10 16:33 fun-hard
```

Ganz links siehst du nun die **Inode-Nummer**.

Da sowohl `fun` als auch `fun-hard` dieselbe Nummer besitzen, ist klar: Beide Namen verweisen tatsächlich auf **dieselbe Datei**.

## Symbolische Links erstellen

Symbolische Links wurden entwickelt, um die beiden Einschränkungen von Hardlinks zu überwinden:

1. Hardlinks können keine Dateisystemgrenzen überschreiten.
2. Hardlinks können nur auf Dateien, nicht aber auf Verzeichnisse verweisen.

Ein symbolischer Link ist eine besondere Datei, die auf eine andere Datei oder ein anderes Verzeichnis verweist.

Das Erstellen symbolischer Links funktioniert ähnlich wie das Anlegen von Hardlinks:

```bash
[me@linuxbox playground]$ ln -s fun fun-sym
[me@linuxbox playground]$ ln -s ../fun dir1/fun-sym
[me@linuxbox playground]$ ln -s ../fun dir2/fun-sym
```

Der erste Befehl ist recht einfach zu verstehen: Mit der Option `-s` wird anstelle eines Hardlinks ein symbolischer Link erstellt.

Doch warum verwenden die beiden anderen Befehle den Pfad `../fun`?

Denke daran: Ein symbolischer Link speichert den Pfad zu seinem Ziel. Wird ein **relativer Pfad** verwendet, bezieht er sich immer auf den Speicherort des Links selbst.

Das wird in der Ausgabe von `ls` deutlich:

```bash
[me@linuxbox playground]$ ls -l dir1
```

```text
total 4
-rw-r--r-- 4 me me 1650 2025-01-10 16:33 fun-hard
lrwxrwxrwx 1 me me    6 2025-01-15 15:17 fun-sym -> ../fun
```

Der Eintrag `fun-sym` beginnt mit einem **`l`** und ist damit als symbolischer Link erkennbar.

Außerdem siehst du, dass der Link auf `../fun` verweist. Das ist korrekt, denn aus Sicht des Verzeichnisses `dir1` befindet sich die Datei `fun` eine Ebene höher.

Vielleicht fällt dir noch etwas auf: Die Größe des symbolischen Links beträgt **6 Byte**.

Das liegt daran, dass ein symbolischer Link lediglich den Text `../fun` speichert – also genau sechs Zeichen – und **nicht** den Inhalt der eigentlichen Datei.

Beim Erstellen symbolischer Links kannst du sowohl **absolute** als auch **relative Pfade** verwenden.

Ein Beispiel mit einem absoluten Pfad:

```bash
[me@linuxbox playground]$ ln -s /home/me/playground/fun dir1/fun-sym
```

In den meisten Fällen sind **relative Pfade** jedoch die bessere Wahl.

Wird ein gesamtes Verzeichnis später verschoben oder umbenannt, funktionieren relative Links häufig weiterhin, während absolute Links dadurch ungültig werden können.

Symbolische Links können übrigens nicht nur auf Dateien, sondern auch auf Verzeichnisse verweisen.

```bash
[me@linuxbox playground]$ ln -s dir1 dir1-sym
[me@linuxbox playground]$ ls -l
```

```text
total 16
drwxrwxr-x 2 me me 4096 2025-01-15 15:17 dir1
lrwxrwxrwx 1 me me    4 2025-01-16 14:45 dir1-sym -> dir1
drwxrwxr-x 2 me me 4096 2025-01-15 15:17 dir2
-rw-r--r-- 4 me me 1650 2025-01-10 16:33 fun
-rw-r--r-- 4 me me 1650 2025-01-10 16:33 fun-hard
lrwxrwxrwx 1 me me    3 2025-01-15 15:15 fun-sym -> fun
```

## Dateien und Verzeichnisse löschen

Wie bereits zuvor beschrieben, dient der Befehl `rm` zum Löschen von Dateien und Verzeichnissen.

Jetzt räumen wir unseren Spielplatz wieder etwas auf.

Zunächst löschen wir einen der Hardlinks:

```bash
[me@linuxbox playground]$ rm fun-hard
[me@linuxbox playground]$ ls -l
```

```text
total 12
drwxrwxr-x 2 me me 4096 2025-01-15 15:17 dir1
lrwxrwxrwx 1 me me    4 2025-01-16 14:45 dir1-sym -> dir1
drwxrwxr-x 2 me me 4096 2025-01-15 15:17 dir2
-rw-r--r-- 3 me me 1650 2025-01-10 16:33 fun
lrwxrwxrwx 1 me me    3 2025-01-15 15:15 fun-sym -> fun
```

Alles hat wie erwartet funktioniert.

`fun-hard` wurde gelöscht und die Anzahl der Hardlinks von `fun` ist von **4** auf **3** gesunken. Diese Zahl findest du in der zweiten Spalte der Ausgabe.

Löschen wir nun die eigentliche Datei `fun`. Zur Demonstration verwenden wir wieder die Option `-i`:

```bash
[me@linuxbox playground]$ rm -i fun
```

```text
rm: remove regular file `fun'?
```

Bestätigst du die Rückfrage mit `y`, wird die Datei gelöscht.

Schauen wir uns anschließend erneut die Ausgabe von `ls` an:

```bash
[me@linuxbox playground]$ ls -l
```

```text
total 8
drwxrwxr-x 2 me me 4096 2025-01-15 15:17 dir1
lrwxrwxrwx 1 me me    4 2025-01-16 14:45 dir1-sym -> dir1
drwxrwxr-x 2 me me 4096 2025-01-15 15:17 dir2
lrwxrwxrwx 1 me me    3 2025-01-15 15:15 fun-sym -> fun
```

Was ist mit `fun-sym` passiert?

Der symbolische Link existiert noch, sein Ziel jedoch nicht mehr.

Der Link ist jetzt **defekt** (_broken link_).

Viele Linux-Distributionen stellen defekte symbolische Links farblich dar – häufig in Rot –, damit sie sofort auffallen.

Versuchen wir trotzdem, den Link zu verwenden:

```bash
[me@linuxbox playground]$ less fun-sym
```

```text
fun-sym: No such file or directory
```

Wie erwartet kann `less` die Datei nicht mehr öffnen.

Räumen wir weiter auf und löschen die beiden symbolischen Links:

```bash
[me@linuxbox playground]$ rm fun-sym dir1-sym
[me@linuxbox playground]$ ls -l
```

```text
total 8
drwxrwxr-x 2 me me 4096 2025-01-15 15:17 dir1
drwxrwxr-x 2 me me 4096 2025-01-15 15:17 dir2
```

Ein wichtiger Unterschied zu Hardlinks:

Die meisten Dateioperationen wirken bei symbolischen Links auf deren **Ziel**, nicht auf den Link selbst.

`rm` bildet hier eine Ausnahme.

Beim Löschen eines symbolischen Links wird **nur der Link** entfernt – die eigentliche Datei bleibt unverändert.

Zum Schluss entfernen wir unseren gesamten Spielplatz.

Dazu wechseln wir zunächst in unser Home-Verzeichnis und löschen anschließend das Verzeichnis `playground` mitsamt seinem gesamten Inhalt:

```bash
[me@linuxbox playground]$ cd
[me@linuxbox ~]$ rm -r playground
```

::: note
## Symbolische Links im Dateimanager erstellen

Auch mit einem grafischen Dateimanager kannst du symbolische Links erstellen.

Wie das genau funktioniert, hängt von deiner Desktop-Umgebung und dem verwendeten Dateimanager ab. Häufig findest du dafür im Kontextmenü eine Funktion wie **„Link erstellen“** oder **„Verknüpfung anlegen“**. Manche Dateimanager bieten diese Möglichkeit außerdem beim Ziehen und Ablegen einer Datei an.

Unter KDE Plasma zeigt Dolphin beim Ablegen einer Datei in der Regel ein kleines Menü an. Dort kannst du auswählen, ob die Datei kopiert, verschoben oder verknüpft werden soll.

Die genaue Bedienung kann sich je nach Version und Dateimanager unterscheiden. Das Prinzip bleibt jedoch dasselbe: Statt eine Datei zu kopieren, wird ein symbolischer Link auf sie angelegt.
:::

## Zusammenfassung

In diesem Kapitel haben wir viele neue Werkzeuge kennengelernt. Nimm dir ruhig etwas Zeit, bis sich alles gesetzt hat.

Wiederhole die Übungen im `playground` ruhig mehrmals. Je häufiger du mit den Befehlen arbeitest, desto selbstverständlicher werden sie.

Ein gutes Verständnis der grundlegenden Befehle zur Dateiverwaltung und der Wildcards ist besonders wichtig. Sie gehören zu den Werkzeugen, die du auf der Kommandozeile immer wieder verwenden wirst.

Erweitere deinen `playground` ruhig um weitere Dateien und Verzeichnisse. Experimentiere mit Wildcards und probiere aus, wie sich die verschiedenen Befehle in unterschiedlichen Situationen verhalten.

Auch das Konzept der Links wirkt anfangs vielleicht etwas ungewohnt.

Keine Sorge.

Sobald du selbst ein wenig damit gearbeitet hast, wird vieles ganz selbstverständlich.

Und wenn du später einmal komplexere Aufgaben erledigst, wirst du merken, wie hilfreich Links sein können.

## Weiterführende Informationen

- **Symbolische Links**
<https://en.wikipedia.org/wiki/Symbolic_link>