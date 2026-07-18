# 8 – Fortgeschrittene Tastaturtricks

Ich beschreibe Unix gern scherzhaft als **„das Betriebssystem für Menschen, die gerne tippen.“**

Dass Unix überhaupt eine Kommandozeile besitzt, scheint diese Behauptung zunächst zu bestätigen.

Tatsächlich tippen erfahrene Nutzerinnen und Nutzer aber erstaunlich wenig.

Warum hätten Befehle sonst so kurze Namen wie `cp`, `ls`, `mv` oder `rm`?

Eines der wichtigsten Ziele der Kommandozeile ist nämlich Bequemlichkeit:

**Mit möglichst wenigen Tastendrücken möglichst viel erledigen.**

Ein weiteres Ziel ist es, die Hände möglichst gar nicht von der Tastatur nehmen zu müssen.

Jeder Griff zur Maus kostet Zeit und unterbricht den Arbeitsfluss.

In diesem Kapitel lernen wir einige Funktionen von `bash` kennen, mit denen sich die Arbeit auf der Kommandozeile deutlich schneller und komfortabler erledigen lässt.

Dabei begegnen uns unter anderem folgende Befehle:

- `clear` – Terminalbildschirm leeren
- `history` – Befehlsverlauf anzeigen

## Kommandozeilenbearbeitung

Für die Bearbeitung der Kommandozeile verwendet `bash` eine Bibliothek namens **Readline**.

Eine Bibliothek (_Library_) ist eine Sammlung fertiger Programmfunktionen, die von verschiedenen Programmen gemeinsam genutzt werden können.

Readline stellt zahlreiche Funktionen bereit, mit denen sich Eingaben bequem bearbeiten lassen.

Einige davon kennst du bereits.

So bewegen beispielsweise die Pfeiltasten den Cursor innerhalb der aktuellen Eingabe.

Readline bietet jedoch noch viele weitere Tastenkombinationen, mit denen sich Befehle schneller eingeben, bearbeiten und wiederverwenden lassen.

Du musst sie nicht alle auswendig lernen.

Suche dir einfach diejenigen aus, die gut zu deinem Arbeitsstil passen.

Mit der Zeit werden sie ganz automatisch in Fleisch und Blut übergehen.

:::
### Hinweis

Einige der folgenden Tastenkombinationen – insbesondere solche mit der **Alt**-Taste – werden unter grafischen Desktop-Umgebungen möglicherweise bereits für andere Funktionen verwendet.

In einer **virtuellen Konsole** (TTY) stehen dagegen alle Tastenkombinationen von Readline uneingeschränkt zur Verfügung.
:::

## Den Cursor bewegen

Bevor wir Befehle schneller bearbeiten können, müssen wir den Cursor effizient bewegen.

Natürlich funktionieren dafür die Pfeiltasten.

Mit Readline stehen jedoch deutlich schnellere Tastenkombinationen zur Verfügung.

| Tastenkombination | Funktion |
|-------------------|----------|
| `Ctrl`+`a` | Cursor an den Anfang der Zeile bewegen |
| `Ctrl`+`e` | Cursor an das Ende der Zeile bewegen |
| `Ctrl`+`f` | Cursor ein Zeichen nach rechts bewegen (entspricht →) |
| `Ctrl`+`b` | Cursor ein Zeichen nach links bewegen (entspricht ←) |
| `Alt`+`f` | Cursor ein Wort nach rechts bewegen |
| `Alt`+`b` | Cursor ein Wort nach links bewegen |
| `Ctrl`+`l` | Terminalbildschirm leeren und den Cursor oben links positionieren (entspricht dem Befehl `clear`) |

Gerade `Ctrl`+`a` und `Ctrl`+`e` gehören zu den Tastenkombinationen, die viele Linux-Nutzer täglich verwenden.

---

## Text bearbeiten

Vertippt man sich bei einem Befehl, muss man ihn nicht komplett neu eingeben.

Readline stellt zahlreiche Tastenkombinationen bereit, mit denen sich einzelne Zeichen oder ganze Wörter schnell bearbeiten lassen.

| Tastenkombination | Funktion |
|-------------------|----------|
| `Ctrl`+`d` | Zeichen unter dem Cursor löschen |
| `Ctrl`+`t` | Zeichen unter dem Cursor mit dem vorherigen vertauschen |
| `Alt`+`t` | Aktuelles Wort mit dem vorherigen vertauschen |
| `Alt`+`l` | Wort ab Cursor in Kleinbuchstaben umwandeln |
| `Alt`+`u` | Wort ab Cursor in Großbuchstaben umwandeln |

Gerade `Ctrl`+`t` ist erstaunlich praktisch.

Vertippst du dich beispielsweise und schreibst versehentlich

```text
sl
```

statt

```text
ls
```

kann `Ctrl`+`t` die beiden Buchstaben einfach vertauschen.

---

## Text ausschneiden und einfügen

Readline verwendet für Ausschneiden und Einfügen etwas ungewohnte Begriffe.

Statt von **Cut** und **Paste** spricht die Dokumentation von **Kill** und **Yank**.

Inhaltlich ist jedoch dasselbe gemeint.

Ausgeschnittener Text wird in einem temporären Speicher abgelegt, dem sogenannten **Kill Ring**.

Von dort kann er später wieder eingefügt werden.

| Tastenkombination | Funktion |
|-------------------|----------|
| `Ctrl`+`k` | Text vom Cursor bis zum Zeilenende ausschneiden |
| `Ctrl`+`u` | Text vom Cursor bis zum Zeilenanfang ausschneiden |
| `Alt`+`d` | Text vom Cursor bis zum Ende des aktuellen Wortes ausschneiden |
| `Alt`+`Backspace` | Text vom Cursor bis zum Wortanfang ausschneiden. Befindet sich der Cursor bereits am Wortanfang, wird das vorherige Wort entfernt. |
| `Ctrl`+`y` | Zuletzt ausgeschnittenen Text wieder einfügen |

Obwohl die Begriffe zunächst ungewohnt wirken, wirst du in der Readline-Dokumentation fast ausschließlich auf **Kill** und **Yank** stoßen.

:::
## Die Meta-Taste

In der Readline-Dokumentation begegnet dir häufig der Begriff **Meta-Taste**.

Auf heutigen Tastaturen entspricht sie in den meisten Fällen der **Alt**-Taste.

Historisch war das jedoch nicht immer so.

Als Unix entstand, arbeiteten viele Benutzer nicht direkt an einem Computer, sondern an sogenannten **Terminals**.

Ein Terminal bestand im Wesentlichen aus einer Tastatur, einem Textbildschirm und etwas Elektronik zur Kommunikation mit einem zentralen Rechner.

Da es damals zahlreiche unterschiedliche Terminaltypen gab, konnte Readline nicht davon ausgehen, dass jede Tastatur eine spezielle Zusatztaste wie `Alt` besaß.

Deshalb führte Readline den allgemeinen Begriff **Meta** ein.

Heute übernimmt meistens die **Alt**-Taste diese Funktion.

Falls sie einmal nicht funktioniert oder von deiner Desktop-Umgebung abgefangen wird, kannst du stattdessen häufig auch kurz `Esc` drücken und anschließend die gewünschte Taste.

Beispielsweise haben

```text
Alt+f
```

und

```text
Esc, dann f
```

in vielen Terminals dieselbe Wirkung.
:::

## Autovervollständigung (Completion)

Eine der größten Zeitersparnisse beim Arbeiten mit der Shell ist die **Autovervollständigung**.

Sie wird durch die **Tabulatortaste** (`Tab`) ausgelöst.

Schauen wir uns ein Beispiel an.

Angenommen, dein Home-Verzeichnis sieht so aus:

```bash
[me@linuxbox ~]$ ls
Desktop  Documents  ls-output.txt  Music  Pictures  Public  Templates  Videos
```

Gib nun Folgendes ein – aber drücke **noch nicht** `Enter`:

```bash
[me@linuxbox ~]$ ls l
```

Drücke jetzt `Tab`.

```bash
[me@linuxbox ~]$ ls ls-output.txt
```

Die Shell hat den Dateinamen automatisch vervollständigt.

### Mehrdeutige Eingaben

Versuchen wir noch ein Beispiel.

```bash
[me@linuxbox ~]$ ls D
```

Drücke jetzt `Tab`.

Es passiert ... nichts.

Warum?

Weil mehrere Einträge mit **D** beginnen:

- `Desktop`
- `Documents`

Die Shell weiß also nicht, welchen du meinst.

Erst wenn deine Eingabe eindeutig wird,

```bash
[me@linuxbox ~]$ ls Do
```

kann `Tab` den Rest ergänzen:

```bash
[me@linuxbox ~]$ ls Documents
```

Je eindeutiger dein Präfix ist, desto besser funktioniert die Autovervollständigung.

## Mehr als nur Dateinamen

Die meisten denken bei der Tab-Vervollständigung zuerst an Dateinamen.

Tatsächlich kann Bash aber noch viel mehr automatisch ergänzen.

Je nach Situation lassen sich unter anderem vervollständigen:

- Datei- und Verzeichnisnamen
- Befehlsnamen
- Umgebungsvariablen (wenn das Wort mit `$` beginnt)
- Benutzernamen (wenn das Wort mit `~` beginnt)
- Hostnamen (wenn das Wort mit `@` beginnt)

Hostnamen können allerdings nur vervollständigt werden, wenn sie beispielsweise in `/etc/hosts` eingetragen sind.

## Weitere Tastenkombinationen

Neben der Tab-Taste gibt es noch einige weitere Tastenkombinationen für die Vervollständigung.

| Tastenkombination | Funktion |
|-------------------|----------|
| `Alt`+`?` | Alle möglichen Vervollständigungen anzeigen. Auf den meisten Systemen genügt dafür auch ein zweites Drücken der `Tab`-Taste. |
| `Alt`+`*` | Alle möglichen Treffer direkt in die Kommandozeile einfügen. Praktisch, wenn mehrere Dateien gleichzeitig verwendet werden sollen. |

Darüber hinaus existieren noch einige weitere, eher selten genutzte Tastenkombinationen.

Eine vollständige Liste findest du im Abschnitt **READLINE** der `bash`-Manpage.

:::
## Programmierbare Autovervollständigung

Moderne Versionen von `bash` unterstützen eine besonders praktische Erweiterung: die **programmierbare Autovervollständigung** (_Programmable Completion_).

Damit können zusätzliche Regeln definiert werden, die Bash beim Drücken der `Tab`-Taste berücksichtigt.````markdown
## Autovervollständigung (Completion)

Eine der größten Zeitersparnisse beim Arbeiten mit der Shell ist die **Autovervollständigung**.

Sie wird durch die **Tabulatortaste** (`Tab`) ausgelöst.

Schauen wir uns ein Beispiel an.

Angenommen, dein Home-Verzeichnis sieht so aus:

```bash
[me@linuxbox ~]$ ls
Desktop  Documents  ls-output.txt  Music  Pictures  Public  Templates  Videos
```

Gib nun Folgendes ein – aber drücke **noch nicht** `Enter`:

```bash
[me@linuxbox ~]$ ls l
```

Drücke jetzt `Tab`.

```bash
[me@linuxbox ~]$ ls ls-output.txt
```

Die Shell hat den Dateinamen automatisch vervollständigt.

### Mehrdeutige Eingaben

Versuchen wir noch ein Beispiel.

```bash
[me@linuxbox ~]$ ls D
```

Drücke jetzt `Tab`.

Es passiert ... nichts.

Warum?

Weil mehrere Einträge mit **D** beginnen:

- `Desktop`
- `Documents`

Die Shell weiß also nicht, welchen du meinst.

Erst wenn deine Eingabe eindeutig wird,

```bash
[me@linuxbox ~]$ ls Do
```

kann `Tab` den Rest ergänzen:

```bash
[me@linuxbox ~]$ ls Documents
```

Je eindeutiger dein Präfix ist, desto besser funktioniert die Autovervollständigung.

## Mehr als nur Dateinamen

Die meisten denken bei der Tab-Vervollständigung zuerst an Dateinamen.

Tatsächlich kann Bash aber noch viel mehr automatisch ergänzen.

Je nach Situation lassen sich unter anderem vervollständigen:

- Datei- und Verzeichnisnamen
- Befehlsnamen
- Umgebungsvariablen (wenn das Wort mit `$` beginnt)
- Benutzernamen (wenn das Wort mit `~` beginnt)
- Hostnamen (wenn das Wort mit `@` beginnt)

Hostnamen können allerdings nur vervollständigt werden, wenn sie beispielsweise in `/etc/hosts` eingetragen sind.

## Weitere Tastenkombinationen

Neben der Tab-Taste gibt es noch einige weitere Tastenkombinationen für die Vervollständigung.

| Tastenkombination | Funktion |
|-------------------|----------|
| `Alt`+`?` | Alle möglichen Vervollständigungen anzeigen. Auf den meisten Systemen genügt dafür auch ein zweites Drücken der `Tab`-Taste. |
| `Alt`+`*` | Alle möglichen Treffer direkt in die Kommandozeile einfügen. Praktisch, wenn mehrere Dateien gleichzeitig verwendet werden sollen. |

Darüber hinaus existieren noch einige weitere, eher selten genutzte Tastenkombinationen.

Eine vollständige Liste findest du im Abschnitt **READLINE** der `bash`-Manpage.

:::
## Programmierbare Autovervollständigung

Moderne Versionen von `bash` unterstützen eine besonders praktische Erweiterung: die **programmierbare Autovervollständigung** (_Programmable Completion_).

Damit können zusätzliche Regeln definiert werden, die Bash beim Drücken der `Tab`-Taste berücksichtigt.

In den meisten Fällen musst du diese Regeln gar nicht selbst erstellen.

Sie werden bereits von deiner Linux-Distribution oder zusammen mit einer Anwendung installiert.

Dadurch kann Bash beispielsweise

- gültige Optionen eines Befehls vorschlagen,
- nur passende Dateitypen ergänzen,
- Git-Unterbefehle vervollständigen,
- Docker-Container anbieten,
- Kubernetes-Ressourcen ergänzen,
- SSH-Hosts oder viele andere spezielle Eingaben automatisch erkennen.

Ubuntu liefert bereits eine umfangreiche Sammlung solcher Vervollständigungen mit.

Intern werden sie durch **Shell-Funktionen** umgesetzt – kleine Shell-Skripte, die wir in späteren Kapiteln kennenlernen.

Wenn du neugierig bist, kannst du sie dir schon jetzt ansehen:

```bash
set | less
```

Je nach Linux-Distribution findest du dort zahlreiche Funktionen, die für die Autovervollständigung zuständig sind.

Nicht jede Distribution installiert diese Erweiterungen standardmäßig.
:::

:::
## Ein Tipp aus der Praxis

Gewöhne dir an, die `Tab`-Taste möglichst oft zu benutzen.

Viele erfahrene Linux-Nutzer tippen lange Dateinamen oder Verzeichnisse kaum noch vollständig aus.

Das spart nicht nur Zeit, sondern verhindert auch Tippfehler.

Gerade bei langen Pfaden oder komplizierten Dateinamen ist die Autovervollständigung eines der größten Komfortmerkmale der Shell.
:::

## Den Befehlsverlauf nutzen (History)

Wie wir bereits in Kapitel 1 gesehen haben, speichert `bash` automatisch die von uns eingegebenen Befehle.

Dieser **Befehlsverlauf** (_History_) befindet sich im Home-Verzeichnis in der Datei

```text
.bash_history
```

Der Befehlsverlauf ist eines der nützlichsten Werkzeuge der Shell.

Statt denselben langen Befehl immer wieder neu einzutippen, kannst du ihn einfach erneut aufrufen, bearbeiten und erneut ausführen.

Besonders leistungsfähig wird die History in Kombination mit den Tastenkombinationen von Readline, die wir in diesem Kapitel bereits kennengelernt haben.

## Den Befehlsverlauf anzeigen

Den kompletten Verlauf kannst du jederzeit mit folgendem Befehl anzeigen:

```bash
[me@linuxbox ~]$ history | less
```

Auf den meisten Linux-Systemen speichert Bash standardmäßig die letzten **1000 Befehle**.

Wie sich diese Anzahl ändern lässt, sehen wir später in Kapitel 11.

## Nach alten Befehlen suchen

Angenommen, wir möchten den Befehl wiederfinden, mit dem wir einmal den Inhalt von `/usr/bin` aufgelistet haben.

Dafür können wir `grep` verwenden:

```bash
[me@linuxbox ~]$ history | grep /usr/bin
```

Eine mögliche Ausgabe könnte so aussehen:

```text
88  ls -l /usr/bin > ls-output.txt
```

Die Zahl am Anfang ist die **Nummer des Befehls im Verlauf**.

Mit ihr lässt sich der Befehl direkt erneut ausführen.

:::note
## Was macht `grep`?

`grep` durchsucht Text nach einem bestimmten Suchbegriff und gibt alle passenden Zeilen aus.

Eine ausführliche Einführung in `grep` folgt in einem späteren Kapitel. Für dieses Beispiel genügt es zu wissen, dass `grep` Zeilen filtert, die den angegebenen Suchtext enthalten.
:::

## Befehle über ihre Nummer ausführen

Bash besitzt eine besondere Form der Expansion: die **History Expansion**.

Mit einem Ausrufezeichen (`!`) und der Nummer eines Eintrags kann ein früherer Befehl sofort erneut ausgeführt werden.

Zum Beispiel:

```bash
[me@linuxbox ~]$ !88
```

Bevor der Befehl ausgeführt wird, ersetzt Bash `!88` automatisch durch den Inhalt des 88. History-Eintrags.

In unserem Beispiel also durch:

```bash
ls -l /usr/bin > ls-output.txt
```

Später werden wir noch weitere Formen der History Expansion kennenlernen.

:::
## Vorsicht bei `!`

History Expansion ist äußerst praktisch, kann aber auch überraschend sein.

Sobald du `Enter` drückst, wird der gefundene Befehl sofort ausgeführt.

Gerade bei Befehlen, die Dateien löschen oder verändern, solltest du deshalb genau wissen, was sich hinter einem Ausdruck wie `!88` verbirgt.

Falls du einen alten Befehl zunächst nur bearbeiten möchtest, eignet sich die inkrementelle Suche (`Ctrl`+`r`) meist besser.
:::

## Inkrementelle Suche (`Ctrl`+`r`)

Noch praktischer als die Suche mit `history | grep` ist die **inkrementelle Suche**.

Dabei durchsucht Bash den Befehlsverlauf bereits während der Eingabe.

Starte die Suche mit:

```text
Ctrl+r
```

Die Eingabeaufforderung wechselt anschließend zu:

```text
(reverse-i-search)`':
```

Jetzt beginnst du einfach zu tippen.

Suchen wir erneut nach `/usr/bin`:

```text
(reverse-i-search)`/usr/bin': ls -l /usr/bin > ls-output.txt
```

Schon während der Eingabe zeigt Bash den ersten passenden Treffer an.

Nun hast du mehrere Möglichkeiten:

- `Enter` → den gefundenen Befehl sofort ausführen.
- `Ctrl`+`j` → den Befehl in die aktuelle Eingabe übernehmen und anschließend bearbeiten.
- `Ctrl`+`r` erneut → zum nächsten älteren Treffer springen.
- `Ctrl`+`g` oder `Ctrl`+`c` → Suche abbrechen.

Drücken wir beispielsweise `Ctrl`+`j`, erhalten wir:

```bash
[me@linuxbox ~]$ ls -l /usr/bin > ls-output.txt
```

Der Befehl befindet sich nun in der Eingabezeile und kann vor dem Ausführen noch verändert werden.

:::
## Warum `Ctrl`+`r` so beliebt ist

Viele erfahrene Linux-Nutzer verwenden den Pfeil nach oben (`↑`) kaum noch.

Stattdessen drücken sie fast automatisch `Ctrl`+`r` und geben ein markantes Wort aus dem gesuchten Befehl ein.

Das funktioniert auch dann hervorragend, wenn der gesuchte Befehl hunderte Einträge zurückliegt.

Wenn du dir aus diesem Kapitel nur **eine** Tastenkombination merken möchtest, dann ist es vermutlich `Ctrl`+`r`.
:::

## Wichtige Tastenkombinationen für die History

| Tastenkombination | Funktion |
|-------------------|----------|
| `Ctrl`+`p` | Zum vorherigen History-Eintrag wechseln (entspricht `↑`) |
| `Ctrl`+`n` | Zum nächsten History-Eintrag wechseln (entspricht `↓`) |
| `Alt`+`<` | Zum ersten Eintrag der History springen |
| `Alt`+`>` | Zum Ende der History bzw. zur aktuellen Eingabe springen |
| `Ctrl`+`r` | Inkrementelle Rückwärtssuche starten |
| `Alt`+`p` | Rückwärtssuche ohne Inkrement. Suchbegriff eingeben und anschließend `Enter` drücken. |
| `Alt`+`n` | Vorwärtssuche ohne Inkrement |
| `Ctrl`+`o` | Aktuellen History-Eintrag ausführen und anschließend automatisch zum nächsten wechseln |

`Ctrl`+`o` ist besonders praktisch, wenn mehrere ältere Befehle nacheinander erneut ausgeführt werden sollen.

Man kann sich damit Schritt für Schritt durch eine frühere Befehlsfolge bewegen, ohne jeden Befehl einzeln neu auswählen zu müssen.

## History Expansion

Neben der normalen History-Suche bietet Bash noch eine weitere praktische Funktion:

die **History Expansion**.

Dabei wird das Ausrufezeichen (`!`) verwendet, um frühere Befehle schnell erneut aufzurufen.

Die einfachste Variante haben wir bereits kennengelernt:

```bash
!88
```

Damit wird der 88. Eintrag aus dem Befehlsverlauf ausgeführt.

Es gibt jedoch noch einige weitere Möglichkeiten.

| Eingabe | Funktion |
|----------|----------|
| `!!` | Letzten Befehl erneut ausführen |
| `!Nummer` | History-Eintrag mit dieser Nummer ausführen |
| `!Text` | Letzten Befehl ausführen, der mit _Text_ beginnt |
| `!?Text` | Letzten Befehl ausführen, der _Text_ enthält |

### Den letzten Befehl wiederholen

Die wohl bekannteste History Expansion ist

```bash
!!
```

Sie führt den zuletzt ausgeführten Befehl erneut aus.

Beispiel:

```bash
[me@linuxbox ~]$ !!
```

In der Praxis greifen viele Benutzer allerdings lieber zur Pfeiltaste `↑` und drücken anschließend `Enter`.

Das Ergebnis ist identisch und oft etwas leichter nachvollziehbar.

### Befehle anhand ihres Beginns finden

Angenommen, dein letzter `ls`-Befehl war

```bash
ls -l /usr/bin > ls-output.txt
```

Dann genügt

```bash
!ls
```

und Bash führt genau diesen Befehl erneut aus.

Ebenso funktioniert eine Suche nach einem beliebigen Text innerhalb eines Befehls:

```bash
!?usr/bin
```

Bash sucht den letzten History-Eintrag, der diesen Text enthält.

:::
## Vorsicht bei `!Text`

Die Varianten

```bash
!Text
```

und

```bash
!?Text
```

können überraschend sein.

Bash verwendet **immer den zuletzt passenden Eintrag**.

Wenn du dir nicht ganz sicher bist, welcher Befehl gefunden wird, solltest du ihn zunächst anzeigen lassen, bevor du ihn ausführst.
:::

## Expansion nur anzeigen

Dafür gibt es den Zusatz

```text
:p
```

Er bewirkt, dass Bash die History Expansion lediglich ausgibt, anstatt sie sofort auszuführen.

Beispiel:

```bash
[me@linuxbox ~]$ !ls:p
ls -l /usr/bin > ls-output.txt
```

Der Befehl wird jetzt **nur angezeigt**.

Außerdem landet er als neuer Eintrag in der History.

Dadurch kannst du ihn anschließend bequem mit

- `↑`
- `!!`

oder einer anderen History-Funktion ausführen.

Gerade bei komplexen oder gefährlichen Befehlen ist `:p` eine gute Möglichkeit, noch einmal zu kontrollieren, was Bash tatsächlich ausführen würde.

:::
## Eine interessante Besonderheit

Die eigentliche History Expansion (z. B. `!!`) wird **nicht** in der History gespeichert.

Gespeichert wird stattdessen der fertige, expandierte Befehl.

Wenn du also später deine History ansiehst, findest du dort nicht

```bash
!!
```

sondern den tatsächlich ausgeführten Befehl.
:::

## Noch viel mehr Möglichkeiten

Die History Expansion von Bash beherrscht noch zahlreiche weitere Funktionen.

Sie können beispielsweise

- einzelne Argumente früherer Befehle übernehmen,
- nur bestimmte Wörter expandieren,
- Argumente austauschen oder verändern,
- mehrere frühere Befehle miteinander kombinieren.

Diese Möglichkeiten werden allerdings schnell recht komplex und gehören eher zu den fortgeschrittenen Funktionen von Bash.

Eine vollständige Beschreibung findest du im Abschnitt **HISTORY EXPANSION** der `bash`-Manpage.

---

## Shell-Sitzungen aufzeichnen (`script`)

Neben der normalen History besitzen viele Linux-Systeme noch ein weiteres nützliches Werkzeug:

```bash
script
```

Mit `script` lässt sich eine komplette Terminal-Sitzung aufzeichnen.

Dabei werden sämtliche Eingaben und Ausgaben in einer Datei gespeichert.

Die grundlegende Syntax lautet:

```bash
script [Dateiname]
```

Wird kein Dateiname angegeben, verwendet `script` standardmäßig die Datei

```text
typescript
```

Eine solche Aufzeichnung eignet sich beispielsweise

- zum Dokumentieren einer Installation,
- für Tutorials,
- zur Fehlersuche,
- oder um anderen genau zu zeigen, welche Befehle ausgeführt wurden.

Eine vollständige Beschreibung aller Optionen findest du in der Manpage:

```bash
man script
```

:::
## Moderne Alternative: `asciinema`

Heute verwenden viele Linux-Nutzer statt `script` das Open-Source-Projekt **asciinema**.

Es zeichnet Terminal-Sitzungen inklusive Zeitinformationen auf und ermöglicht später sogar eine interaktive Wiedergabe im Browser.

Für einfache Textprotokolle reicht `script` jedoch weiterhin völlig aus und ist auf den meisten Linux-Systemen bereits vorinstalliert.
:::

# Zusammenfassung

In diesem Kapitel haben wir zahlreiche Tastaturfunktionen kennengelernt, mit denen sich die Arbeit auf der Kommandozeile deutlich beschleunigen lässt.

Dazu gehören unter anderem

- effiziente Cursorbewegungen,
- schnelle Textbearbeitung,
- Ausschneiden und Einfügen,
- die Tab-Vervollständigung,
- der Befehlsverlauf,
- die inkrementelle History-Suche,
- sowie die History Expansion.

Du musst diese Tastenkombinationen nicht alle sofort beherrschen.

Viele davon werden mit der Zeit ganz automatisch zur Gewohnheit.

Je häufiger du die Kommandozeile verwendest, desto mehr wirst du merken, wie viel Zeit sich dadurch einsparen lässt.

Betrachte dieses Kapitel deshalb als Werkzeugkasten.

Nimm dir zunächst die Funktionen mit, die dir im Alltag am meisten helfen, und erweitere dein Repertoire Schritt für Schritt.

# Weiterführende Literatur

- Wikipedia bietet einen guten Überblick über die Geschichte und Entwicklung von Computerterminals:
https://en.wikipedia.org/wiki/Computer_terminal