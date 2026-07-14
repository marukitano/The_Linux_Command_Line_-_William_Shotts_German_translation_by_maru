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