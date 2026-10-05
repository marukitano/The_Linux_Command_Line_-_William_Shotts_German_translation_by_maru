# 12 – Eine sanfte Einführung in vi(m)

Es gibt einen alten Witz über einen Besucher in New York City, der einen Passanten nach dem Weg zur berühmten Carnegie Hall fragt:

**Besucher:** Entschuldigen Sie, wie komme ich zur Carnegie Hall?

**Passant:** Üben, üben, üben!

Die Linux-Kommandozeile zu lernen ist ein wenig wie Klavierspielen: Man beherrscht sie nicht an einem Nachmittag. Es braucht Zeit und vor allem Übung.

In diesem Kapitel lernen wir den Texteditor `vi` kennen – ausgesprochen „vee eye“ –, eines der klassischen Programme der Unix-Tradition. `vi` ist für seine ungewöhnliche Bedienung geradezu berüchtigt. Wer jedoch einmal einem erfahrenen `vi`-Benutzer dabei zugesehen hat, wie er über die Tastatur fliegt, versteht schnell, warum dieser Editor bis heute so viele begeisterte Anhänger hat.

Wir werden in diesem Kapitel keine `vi`-Meister. Aber wenn wir fertig sind, können wir zumindest schon ein wenig darauf „spielen“. :chatgpt-content-reference{index="0"}

---

# Warum sollten wir `vi` lernen?

In einer Zeit moderner grafischer Editoren und leicht zugänglicher Terminaleditoren wie `nano` stellt sich natürlich die Frage:

Warum sollten wir überhaupt noch `vi` lernen?

Dafür gibt es drei gute Gründe.

- **`vi` ist fast überall verfügbar.** Das kann enorm hilfreich sein, wenn wir auf einem System ohne funktionierende grafische Oberfläche arbeiten – beispielsweise auf einem Server über SSH oder auf einem Rechner, dessen Desktop nicht mehr startet. POSIX definiert `vi` als standardisierten Editor für Unix-artige Systeme.
- **`vi` ist leichtgewichtig und schnell.** Noch wichtiger ist jedoch seine Bedienphilosophie: `vi` wurde darauf ausgelegt, Text sehr effizient mit der Tastatur zu bearbeiten. Erfahrene Benutzer müssen ihre Hände kaum von der normalen Schreibposition wegbewegen.
- **Wir wollen natürlich nicht, dass andere Linux- und Unix-Benutzer uns für Feiglinge halten.**

Okay.

Vielleicht sind es doch nur zwei gute Gründe.

:::note
## Ist `vi` heute wirklich überall installiert?

Die Aussage „`vi` ist immer vorhanden“ sollte man heute nicht völlig wörtlich nehmen.

Auf klassischen Unix- und vollständigen Linux-Systemen ist ein `vi`-kompatibler Editor sehr verbreitet. Extrem minimale Container-Images, Embedded-Systeme oder speziell zusammengestellte Installationen können jedoch durchaus ohne `vi` ausgeliefert werden.

Trotzdem sind grundlegende `vi`-Kenntnisse weiterhin ausgesprochen nützlich – gerade auf Servern und fremden Systemen.
:::

---

# Ein wenig Hintergrund

Die erste Version von `vi` wurde 1976 von **Bill Joy** entwickelt, damals Student an der University of California, Berkeley. Später gehörte er zu den Mitgründern von Sun Microsystems.

Der Name `vi` stammt von **visual**.

Das klingt heute selbstverständlich, war damals aber eine wichtige Neuerung.

Vor visuellen Editoren waren sogenannte **Zeileneditoren** verbreitet. Sie bearbeiteten Text nicht als vollständige Seite auf dem Bildschirm, sondern im Wesentlichen zeilenweise. Wollte man etwas verändern, musste man dem Editor mitteilen, welche Zeile gemeint war und welche Operation darauf ausgeführt werden sollte.

Mit der Verbreitung von Bildschirmterminals wurde es möglich, Text direkt auf dem Bildschirm darzustellen und einen Cursor darin zu bewegen.

`vi` war für genau diese Arbeitsweise gedacht.

Interessanterweise steckt in `vi` weiterhin ein leistungsfähiger Zeileneditor namens `ex`. Viele der Befehle, die wir später mit einem führenden Doppelpunkt eingeben, stammen aus dieser Tradition.

---

# Von `vi` zu `vim`

Auf Linux-Systemen begegnet uns häufig nicht das ursprüngliche `vi`, sondern eine wesentlich erweiterte Variante:

```text
vim
```

Der Name steht für:

**Vi IMproved**

`vim` wurde von **Bram Moolenaar** entwickelt und erweitert die Möglichkeiten des klassischen `vi` erheblich.

Auf vielen Linux-Systemen verweist der Befehl

```bash
vi
```

deshalb auf `vim` oder auf einen anderen `vi`-kompatiblen Editor.

In diesem Kapitel verwenden wir weiterhin den Namen `vi`, gehen bei den Übungen aber im Wesentlichen von einer modernen `vim`-artigen Implementierung aus.

:::note
## Die `vi`-Familie ist heute größer

Neben dem klassischen `vi` und `vim` gibt es inzwischen weitere Editoren aus derselben Familie.

Besonders bekannt ist:

```text
Neovim
```

Neovim basiert auf Vim und entwickelt dessen Konzept mit moderner Architektur, Lua-Konfiguration und umfangreicher Plugin-Unterstützung weiter.

Die grundlegenden Konzepte dieses Kapitels – Normal Mode, Insert Mode, Bewegungsbefehle, Operatoren wie `d` und `y` – funktionieren weitgehend auch dort.

Wer `vi` lernt, lernt also nicht nur einen einzelnen Editor, sondern eine ganze Familie von Editoren.
:::

---

# `vi` starten und beenden

Wir starten `vi` ganz einfach mit:

```bash
vi
```

Daraufhin erscheint eine weitgehend leere Editoransicht.

Bei Vim sehen wir möglicherweise Informationen wie:

```text
VIM - Vi IMproved
```

sowie mehrere Zeilen mit:

```text
~
~
~
~
```

Wie schon bei `nano` lernen wir zuerst die wichtigste Überlebenstechnik:

**Wie kommen wir hier wieder raus?**

Drücke zunächst:

```text
Esc
```

und gib anschließend ein:

```vim
:q
```

Danach drücken wir `Enter`.

Der Doppelpunkt gehört zum Befehl.

Wenn alles funktioniert, landen wir wieder am Shell-Prompt.

Falls `vi` sich weigert, das Programm zu beenden – normalerweise weil wir etwas verändert, aber noch nicht gespeichert haben –, können wir das Beenden erzwingen:

```vim
:q!
```

Damit verwerfen wir die ungespeicherten Änderungen.

:::note
## Wenn du dich in `vi` verirrt hast

Eine der wichtigsten Regeln für Anfänger lautet:

**Drücke `Esc`.**

Wenn du nicht mehr weißt, in welchem Modus du dich befindest, drücke ruhig zweimal `Esc`.

Damit gelangst du normalerweise wieder in den Normal Mode und hast einen definierten Ausgangspunkt.

Danach kannst du beispielsweise mit

```vim
:q!
```

den Editor verlassen, ohne Änderungen zu speichern.
:::

---

# Compatibility Mode

Ältere oder speziell konfigurierte Vim-Installationen können im sogenannten **Vi Compatible Mode** laufen.

Dabei verhält sich Vim stärker wie das ursprüngliche `vi`, und einige der modernen Vim-Funktionen stehen nicht oder anders zur Verfügung.

Falls der Befehl

```bash
vim
```

vorhanden ist, kannst du ihn direkt verwenden:

```bash
vim
```

Ob Vim gerade im kompatiblen Modus läuft, kannst du innerhalb von Vim mit

```vim
:set compatible?
```

prüfen.

Eine Ausgabe wie

```text
nocompatible
```

bedeutet, dass die erweiterten Vim-Funktionen aktiv sind.

:::note
## Alte Vim-Anleitungen und `set nocp`

Ältere Anleitungen empfehlen manchmal:

```vim
set nocp
```

beziehungsweise:

```vim
set nocompatible
```

in `~/.vimrc`.

Auf normalen modernen Vim-Installationen ist das meist nicht mehr nötig: Sobald Vim eine Vim-Konfigurationsdatei verwendet, arbeitet es üblicherweise ohnehin im erweiterten Vim-Modus.

Außerdem liefern manche Distributionen nur eine reduzierte Vim-Version aus. Falls bei den folgenden Übungen Funktionen fehlen, prüfe, ob auf deinem System das vollständige `vim`-Paket installiert ist.
:::

---

# Die verschiedenen Modi

Starten wir `vi` erneut – diesmal mit dem Namen einer noch nicht vorhandenen Datei:

```bash
rm -f foo.txt
vi foo.txt
```

Damit können wir eine neue Datei namens `foo.txt` erstellen.

Auf dem Bildschirm sehen wir wieder Zeilen wie:

```text
~
~
~
~
```

Die Tilden `~` am linken Rand bedeuten, dass dort keine Zeilen der Datei existieren.

Wir haben also eine leere Datei geöffnet.

**Tippe noch keinen Text ein.**

Denn nach dem Beenden ist die zweitwichtigste Sache, die wir über `vi` lernen müssen:

**`vi` ist ein modaler Editor.**

Das bedeutet, dass dieselben Tasten abhängig vom aktuellen Modus unterschiedliche Bedeutungen haben.

Wenn `vi` startet, befinden wir uns im **Normal Mode**.

In diesem Modus sind die meisten Tasten **Befehle**.

Wenn wir also einfach anfangen zu tippen, schreiben wir nicht unbedingt Text. Stattdessen führen wir eine wilde Folge von Editorbefehlen aus.

Das ist einer der Gründe, warum die erste Begegnung mit `vi` für viele Menschen etwas... speziell verläuft.

---

# In den Insert Mode wechseln

Um tatsächlich Text einzugeben, müssen wir in den **Insert Mode** wechseln.

Dazu drücken wir im Normal Mode:

```text
i
```

Bei Vim erscheint unten normalerweise:

```text
-- INSERT --
```

Jetzt können wir Text eingeben.

Schreibe:

```text
The quick brown fox jumps over the lazy dog.
```

Um den Insert Mode wieder zu verlassen und in den Normal Mode zurückzukehren, drücken wir:

```text
Esc
```

Damit haben wir bereits eines der wichtigsten Grundmuster von `vi` kennengelernt:

```text
Normal Mode → i → Insert Mode → Esc → Normal Mode
```

---

# Unsere Arbeit speichern

Um unsere Änderungen zu speichern, müssen wir zunächst im Normal Mode sein.

Drücke gegebenenfalls:

```text
Esc
```

Dann geben wir einen Doppelpunkt ein:

```text
:
```

Am unteren Bildschirmrand erscheint nun eine Kommandozeile.

Dort geben wir ein:

```vim
:w
```

und drücken `Enter`.

`w` steht für **write**.

Die Datei wird gespeichert.

Vim meldet anschließend beispielsweise:

```text
"foo.txt" [New] 1L, 45B written
```

Die genaue Meldung kann je nach Vim-Version und Konfiguration etwas anders aussehen.

:::note
## Die Namen der Modi können verwirrend sein

Vim bezeichnet seine wichtigsten Modi typischerweise als:

- **Normal Mode**
- **Insert Mode**
- **Command-line Mode**

In älterer `vi`-Dokumentation begegnen uns teilweise andere Bezeichnungen, beispielsweise **Command Mode** für das, was Vim heute Normal Mode nennt.

Auch der Doppelpunkt-Modus wird manchmal einfach als `ex`-Modus oder Command Mode bezeichnet.

Wenn unterschiedliche Tutorials scheinbar widersprüchliche Begriffe verwenden, meinen sie daher häufig trotzdem dieselben grundlegenden Zustände.
:::

---

# Den Cursor bewegen

Im Normal Mode stellt `vi` eine große Anzahl von Bewegungsbefehlen bereit.

Einige davon kennen wir bereits aus `less`.

| Taste | Bewegung |
| ----- | -------- |
| `l` oder `→` | Ein Zeichen nach rechts. |
| `h` oder `←` | Ein Zeichen nach links. |
| `j` oder `↓` | Eine Zeile nach unten. |
| `k` oder `↑` | Eine Zeile nach oben. |
| `0` | Zum Anfang der aktuellen Zeile. |
| `^` | Zum ersten Nicht-Leerzeichen der aktuellen Zeile. |
| `$` | Zum Ende der aktuellen Zeile. |
| `w` | Zum Anfang des nächsten Wortes beziehungsweise Satzzeichens. |
| `W` | Zum Anfang des nächsten durch Leerraum getrennten Wortes; Satzzeichen werden dabei als Teil des Wortes behandelt. |
| `b` | Zum Anfang des vorherigen Wortes beziehungsweise Satzzeichens. |
| `B` | Zum Anfang des vorherigen durch Leerraum getrennten Wortes. |
| `Ctrl-f` oder `Page Down` | Eine Bildschirmseite nach unten. |
| `Ctrl-b` oder `Page Up` | Eine Bildschirmseite nach oben. |
| `ZahlG` | Zur angegebenen Zeile, beispielsweise `20G` zu Zeile 20. |
| `G` | Zur letzten Zeile der Datei. |

Warum verwendet `vi` ausgerechnet

```text
h j k l
```

für die Cursorbewegung?

Als `vi` entwickelt wurde, hatten nicht alle Terminals eigene Pfeiltasten. Außerdem können geübte Schreiber mit `h`, `j`, `k` und `l` den Cursor bewegen, ohne die Hände von der normalen Schreibposition nehmen zu müssen.

Diese Tasten sind inzwischen so eng mit `vi` verbunden, dass sie auch in zahlreichen anderen Unix-Programmen auftauchen.

---

# Befehle wiederholen

Viele `vi`-Befehle können mit einer Zahl kombiniert werden.

Die Zahl gibt an, wie oft der folgende Befehl ausgeführt werden soll.

Zum Beispiel:

```vim
5j
```

bedeutet:

**Fünf Zeilen nach unten.**

Ebenso bewegt:

```vim
3w
```

den Cursor drei Wortbewegungen nach vorne.

Dieses Prinzip ist für `vi` fundamental:

```text
Anzahl + Befehl
```

Später werden wir sehen, dass sich Bewegungsbefehle außerdem mit Bearbeitungsoperationen kombinieren lassen.

Genau dadurch entsteht ein großer Teil der Effizienz von `vi`.

---

# Grundlegende Textbearbeitung

Die meisten Bearbeitungsvorgänge bestehen letztlich aus einigen wenigen Operationen:

- Text einfügen,
- Text löschen,
- Text kopieren,
- Text verschieben,
- Änderungen rückgängig machen.

Natürlich unterstützt `vi` all diese Dinge – nur eben auf seine eigene Art.

Eine besonders wichtige Taste ist:

```text
u
```

Im Normal Mode macht `u` die letzte Änderung rückgängig:

```vim
u
```

`u` steht für **undo**.

Wir werden diesen Befehl bei den folgenden Übungen häufig brauchen.

:::note
## Undo in `vi` und Vim

Das historische `vi` hatte nur sehr eingeschränkte Undo-Möglichkeiten.

Modernes Vim unterstützt dagegen eine umfangreiche Undo-History mit mehreren Ebenen.

Mit

```vim
u
```

machen wir Änderungen rückgängig.

Mit

```text
Ctrl-r
```

können wir in Vim eine rückgängig gemachte Änderung wiederherstellen – also **redo** ausführen.
:::

---

# Text anhängen

Wir haben bereits `i` verwendet, um vor der aktuellen Cursorposition Text einzufügen.

Nehmen wir wieder unsere Datei:

```text
The quick brown fox jumps over the lazy dog.
```

Wenn wir Text **nach** der aktuellen Cursorposition einfügen möchten, verwenden wir:

```text
a
```

`a` steht für **append**.

Bewegen wir den Cursor beispielsweise ans Ende der Zeile und drücken:

```vim
a
```

wechselt `vi` in den Insert Mode und wir können weiterschreiben:

```text
The quick brown fox jumps over the lazy dog. It was cool.
```

Danach drücken wir wieder:

```text
Esc
```

---

# Direkt am Zeilenende anhängen

Da wir sehr häufig Text am Ende einer Zeile ergänzen möchten, gibt es dafür einen eigenen Befehl:

```text
A
```

Das große `A` bewegt den Cursor ans Ende der aktuellen Zeile und wechselt direkt in den Insert Mode.

Das ist ein gutes Beispiel für die Philosophie von `vi`:

Häufig benötigte Bearbeitungsschritte lassen sich mit sehr wenigen Tastendrücken ausdrücken.

Probieren wir es aus.

Drücke im Normal Mode:

```vim
0
```

Damit springen wir an den Anfang der Zeile.

Drücke anschließend:

```vim
A
```

und ergänze unsere Datei, sodass sie ungefähr so aussieht:

```text
The quick brown fox jumps over the lazy dog. It was cool.
Line 2
Line 3
Line 4
Line 5
```

Danach:

```text
Esc
```

---

# Neue Zeilen öffnen

Eine weitere Möglichkeit, Text einzufügen, besteht darin, eine neue Zeile zu „öffnen“.

Dafür gibt es zwei Befehle:

| Befehl | Wirkung |
| ------ | ------- |
| `o` | Öffnet eine neue Zeile **unterhalb** der aktuellen Zeile und wechselt in den Insert Mode. |
| `O` | Öffnet eine neue Zeile **oberhalb** der aktuellen Zeile und wechselt in den Insert Mode. |

Setze den Cursor beispielsweise auf Zeile 3 und drücke:

```vim
o
```

Unterhalb der aktuellen Zeile wird eine neue Zeile eingefügt und `vi` wechselt in den Insert Mode.

Drücke:

```text
Esc
```

und anschließend:

```vim
u
```

um die Änderung wieder rückgängig zu machen.

Nun probiere:

```vim
O
```

Diesmal wird die neue Zeile **oberhalb** der aktuellen Zeile geöffnet.

Verlasse anschließend wieder den Insert Mode mit `Esc` und mache die Änderung mit `u` rückgängig.

---

# Text löschen

`vi` bietet mehrere Möglichkeiten, Text zu löschen.

Zwei besonders wichtige Befehle sind:

```text
x
```

und:

```text
d
```

`x` löscht das Zeichen unter dem Cursor.

Zum Beispiel:

```vim
x
```

löscht ein Zeichen.

Wie viele andere Befehle kann auch `x` mit einer Zahl kombiniert werden:

```vim
3x
```

löscht drei Zeichen.

Der Befehl `d` ist wesentlich mächtiger.

`d` steht für **delete** und wird häufig mit einem Bewegungsbefehl kombiniert.

| Befehl | Wirkung |
| ------ | ------- |
| `x` | Löscht das Zeichen unter dem Cursor. |
| `3x` | Löscht das aktuelle und die nächsten zwei Zeichen. |
| `dd` | Löscht die aktuelle Zeile. |
| `5dd` | Löscht die aktuelle und die nächsten vier Zeilen. |
| `dW` | Löscht von der Cursorposition bis zum Anfang des nächsten durch Leerraum getrennten Wortes. |
| `d$` | Löscht von der Cursorposition bis zum Ende der aktuellen Zeile. |
| `d0` | Löscht von der Cursorposition bis zum Anfang der Zeile. |
| `d^` | Löscht von der Cursorposition bis zum ersten Nicht-Leerzeichen der Zeile. |
| `dG` | Löscht von der aktuellen Zeile bis zum Ende der Datei. |
| `d20G` | Löscht von der aktuellen Zeile bis einschließlich Zeile 20. |

Hier erkennen wir ein sehr wichtiges Konzept.

`d` beschreibt **was** wir tun wollen:

```text
delete
```

Der folgende Bewegungsbefehl beschreibt **worauf** die Operation angewendet wird.

Zum Beispiel:

```vim
d$
```

bedeutet sinngemäß:

```text
löschen + bis zum Zeilenende
```

Dieses Zusammensetzen kleiner Befehle ist eines der zentralen Konzepte von `vi`.

:::note
## Die „Sprache“ von `vi`

Viele Vim-Benutzer beschreiben die Befehle gerne als kleine Sprache.

Zum Beispiel:

```vim
d2w
```

kann man ungefähr lesen als:

**delete two words**

oder:

```vim
y$
```

als:

**yank to end of line**

Statt für jede mögliche Aktion einen eigenen Shortcut auswendig zu lernen, kombiniert man **Operatoren**, **Bewegungen** und **Anzahlen**.

Wenn dieses Prinzip einmal sitzt, wird `vi` deutlich weniger mysteriös.
:::

Probieren wir einige Löschoperationen aus.

Setze den Cursor in der ersten Zeile auf:

```text
It
```

und drücke mehrfach:

```vim
x
```

bis der Rest des Satzes gelöscht ist.

Anschließend können wir mit mehreren:

```vim
u
```

die Änderungen wieder rückgängig machen.

Versuchen wir es nun effizienter.

Setze den Cursor erneut auf `It` und gib ein:

```vim
dW
```

Danach sieht die Zeile ungefähr so aus:

```text
The quick brown fox jumps over the lazy dog. was cool.
```

Mit:

```vim
d$
```

löschen wir anschließend von der aktuellen Cursorposition bis zum Zeilenende.

Und mit:

```vim
dG
```

löschen wir von der aktuellen Zeile bis zum Ende der Datei.

Mit `u` können wir die Änderungen anschließend wieder rückgängig machen.

---

# Ausschneiden, Kopieren und Einfügen

Der `d`-Befehl löscht Text nicht einfach nur.

Der gelöschte Text wird zugleich in einem internen **Register** gespeichert und kann anschließend wieder eingefügt werden.

Das entspricht grob dem Ausschneiden und Einfügen, das wir aus grafischen Programmen kennen.

Zum Einfügen verwenden wir:

```text
p
```

oder:

```text
P
```

Dabei gilt vereinfacht:

- `p` fügt den Inhalt **nach** der aktuellen Position beziehungsweise unterhalb der aktuellen Zeile ein.
- `P` fügt ihn **vor** der aktuellen Position beziehungsweise oberhalb der aktuellen Zeile ein.

Zum Kopieren verwendet `vi` den Befehl:

```text
y
```

Das steht für **yank**.

In der `vi`-Sprache bedeutet „yank“ also ungefähr „kopieren“.

Wie `d` lässt sich auch `y` mit Bewegungsbefehlen kombinieren.

| Befehl | Wirkung |
| ------ | ------- |
| `yy` | Kopiert die aktuelle Zeile. |
| `5yy` | Kopiert die aktuelle und die nächsten vier Zeilen. |
| `yW` | Kopiert von der Cursorposition bis zum Anfang des nächsten durch Leerraum getrennten Wortes. |
| `y$` | Kopiert von der Cursorposition bis zum Ende der aktuellen Zeile. |
| `y0` | Kopiert von der Cursorposition bis zum Anfang der Zeile. |
| `y^` | Kopiert von der Cursorposition bis zum ersten Nicht-Leerzeichen der Zeile. |
| `yG` | Kopiert von der aktuellen Zeile bis zum Ende der Datei. |
| `y20G` | Kopiert von der aktuellen Zeile bis einschließlich Zeile 20. |

Probieren wir es aus.

Setze den Cursor auf die erste Zeile und gib ein:

```vim
yy
```

Damit kopieren wir die komplette Zeile.

Springe anschließend mit:

```vim
G
```

zur letzten Zeile.

Drücke:

```vim
p
```

Die kopierte Zeile wird unterhalb der aktuellen Zeile eingefügt:

```text
The quick brown fox jumps over the lazy dog. It was cool.
Line 2
Line 3
Line 4
Line 5
The quick brown fox jumps over the lazy dog. It was cool.
```

Mit:

```vim
u
```

machen wir die Änderung rückgängig.

Drücken wir stattdessen:

```vim
P
```

wird die kopierte Zeile oberhalb der aktuellen Zeile eingefügt.

:::note
## Register statt nur einer Zwischenablage

Die Vorstellung einer einzelnen „Zwischenablage“ reicht für den Einstieg aus, aber Vim kann wesentlich mehr.

Vim besitzt mehrere sogenannte **Register**, in denen gelöschter, kopierter und anderer Text gespeichert werden kann.

Mit:

```vim
:registers
```

beziehungsweise kurz:

```vim
:reg
```

kannst du sie dir in Vim ansehen.

Außerdem ist die interne Vim-Zwischenablage nicht automatisch dasselbe wie die Zwischenablage deiner grafischen Desktop-Umgebung. Vim-Version, Konfiguration und Systemintegration bestimmen, wie auf die System-Clipboard zugegriffen werden kann.

Für unsere Übungen reicht zunächst das normale `y`, `d`, `p` und `P`.
:::

---

# Zeilen verbinden

`vi` behandelt Zeilen als klar getrennte Einheiten.

Um die aktuelle Zeile mit der folgenden Zeile zu verbinden, gibt es deshalb einen eigenen Befehl:

```text
J
```

Beachte das große `J`.

Das kleine:

```text
j
```

bewegt den Cursor eine Zeile nach unten.

Setzen wir den Cursor auf Zeile 3:

```text
The quick brown fox jumps over the lazy dog. It was cool.
Line 2
Line 3
Line 4
Line 5
```

und drücken:

```vim
J
```

erhalten wir:

```text
The quick brown fox jumps over the lazy dog. It was cool.
Line 2
Line 3 Line 4
Line 5
```

---

# Suchen und Ersetzen

`vi` kann den Cursor anhand von Suchmustern bewegen.

Wir können

- innerhalb einer Zeile suchen,
- in der gesamten Datei suchen,
- und Text automatisch ersetzen.

---

# Innerhalb einer Zeile suchen

Der Befehl:

```text
f
```

sucht innerhalb der aktuellen Zeile nach einem bestimmten Zeichen.

Zum Beispiel:

```vim
fa
```

bewegt den Cursor zum nächsten `a` in der aktuellen Zeile.

Nach einer solchen Zeichensuche können wir sie mit:

```text
;
```

wiederholen.

:::note
## Noch etwas komfortabler

Mit:

```text
,
```

kann die letzte `f`- beziehungsweise `t`-Suche in Vim und klassischem `vi` in die entgegengesetzte Richtung wiederholt werden.

Außerdem gibt es:

```text
F
```

für die Suche nach einem Zeichen rückwärts innerhalb der aktuellen Zeile.
:::

---

# Die gesamte Datei durchsuchen

Um nach einem Wort oder einer Zeichenfolge in der gesamten Datei zu suchen, verwenden wir:

```text
/
```

Das funktioniert ähnlich wie bei `less`.

Drücke:

```text
/
```

und gib anschließend den Suchbegriff ein.

Zum Beispiel:

```vim
/Line
```

Drücke danach `Enter`.

Der Cursor springt zum nächsten Treffer.

Mit:

```text
n
```

springen wir zum nächsten Treffer derselben Suche.

Mit:

```text
N
```

gehen wir in die entgegengesetzte Richtung.

Unsere Beispieldatei enthält:

```text
The quick brown fox jumps over the lazy dog. It was cool.
Line 2
Line 3
Line 4
Line 5
```

Wenn wir am Anfang der Datei:

```vim
/Line
```

eingeben, springt der Cursor zu `Line 2`.

Mit wiederholtem:

```vim
n
```

wandern wir durch die weiteren Treffer.

`vi` kann bei der Suche außerdem **reguläre Ausdrücke** verwenden.

Damit lassen sich sehr viel komplexere Textmuster beschreiben.

Reguläre Ausdrücke behandeln wir ausführlich in Kapitel 19.

---

# Global suchen und ersetzen

`vi` kann Text innerhalb eines Bereichs oder der gesamten Datei ersetzen.

Diese Operation heißt in `vi` **Substitution**.

Angenommen, wir möchten jedes:

```text
Line
```

durch:

```text
line
```

ersetzen.

Dann verwenden wir:

```vim
:%s/Line/line/g
```

Dieser zunächst etwas kryptisch wirkende Befehl lässt sich in einzelne Bestandteile zerlegen:

| Bestandteil | Bedeutung |
| ----------- | --------- |
| `:` | Öffnet die Kommandozeile. |
| `%` | Wählt alle Zeilen der Datei als Bereich aus. |
| `s` | Führt eine Substitution – also Suchen und Ersetzen – aus. |
| `/Line/line/` | Sucht nach `Line` und ersetzt es durch `line`. |
| `g` | Ersetzt alle Treffer innerhalb jeder betroffenen Zeile, nicht nur den ersten. |

Der Bereich `%` bedeutet:

```text
erste Zeile bis letzte Zeile
```

Wir könnten einen Bereich auch ausdrücklich angeben:

```vim
:1,5s/Line/line/g
```

Das beschränkt die Operation auf die Zeilen 1 bis 5.

Oder:

```vim
:1,$s/Line/line/g
```

Hier steht `$` für die letzte Zeile.

Lassen wir den Bereich ganz weg:

```vim
:s/Line/line/g
```

wird nur die aktuelle Zeile bearbeitet.

Nach:

```vim
:%s/Line/line/g
```

sieht unsere Datei so aus:

```text
The quick brown fox jumps over the lazy dog. It was cool.
line 2
line 3
line 4
line 5
```

---

# Ersetzungen bestätigen

Wir können `vi` auch anweisen, vor jeder Ersetzung nachzufragen.

Dafür ergänzen wir:

```text
c
```

für **confirm**.

Zum Beispiel:

```vim
:%s/line/Line/gc
```

Vor jedem Treffer erscheint eine Frage ähnlich dieser:

```text
replace with Line (y/n/a/q/l/^E/^Y)?
```

Die wichtigsten Antworten sind:

| Taste | Wirkung |
| ----- | ------- |
| `y` | Diese Ersetzung durchführen. |
| `n` | Diesen Treffer überspringen. |
| `a` | Diese und alle weiteren Ersetzungen durchführen. |
| `q` oder `Esc` | Ersetzen abbrechen. |
| `l` | Diese Ersetzung durchführen und danach abbrechen. |
| `Ctrl-e` | Anzeige nach unten scrollen. |
| `Ctrl-y` | Anzeige nach oben scrollen. |

Damit können wir eine größere Suchen-und-Ersetzen-Operation kontrolliert durchführen.

---

# Mehrere Dateien bearbeiten

Häufig möchten wir mehrere Dateien gleichzeitig bearbeiten.

Vielleicht müssen wir Änderungen in mehreren Dateien durchführen oder Text aus einer Datei in eine andere kopieren.

Wir können mehrere Dateien bereits beim Start angeben:

```bash
vi file1 file2 file3
```

Beenden wir zunächst unsere aktuelle Sitzung und speichern die Datei:

```vim
:wq
```

Nun erzeugen wir eine zweite Datei:

```bash
ls -l /usr/bin > ls-output.txt
```

Anschließend öffnen wir beide Dateien:

```bash
vi foo.txt ls-output.txt
```

`vi` startet zunächst mit der ersten Datei.

---

# Zwischen Dateien wechseln

Um zur nächsten geöffneten Datei beziehungsweise zum nächsten Buffer zu wechseln, verwenden wir:

```vim
:bn
```

`bn` steht für:

```text
buffer next
```

Zur vorherigen Datei gelangen wir mit:

```vim
:bp
```

also:

```text
buffer previous
```

Falls die aktuelle Datei ungespeicherte Änderungen enthält, verhindert Vim normalerweise, dass wir sie einfach verlassen.

Das schützt uns davor, Änderungen versehentlich zu verlieren.

Mit einem Ausrufezeichen können wir bestimmte Befehle erzwingen:

```vim
:bn!
```

Dabei können ungespeicherte Änderungen verloren gehen.

Also Vorsicht.

---

# Buffer anzeigen

Vim kann uns eine Liste der aktuell geöffneten Buffer anzeigen:

```vim
:buffers
```

Kurz funktioniert auch:

```vim
:ls
```

Eine Ausgabe könnte ungefähr so aussehen:

```text
  1 %a   "foo.txt"         line 1
  2      "ls-output.txt"   line 0
```

Zu einem bestimmten Buffer wechseln wir mit:

```vim
:buffer 2
```

oder kurz:

```vim
:b 2
```

Damit wechseln wir zu Buffer 2.

:::note
## Datei und Buffer sind nicht ganz dasselbe

Für den Einstieg können wir uns einen Buffer einfach als „geöffnete Datei“ vorstellen.

Technisch ist ein Vim-Buffer jedoch der im Speicher gehaltene Text, der einer Datei zugeordnet sein kann.

Diese Unterscheidung wird wichtig, sobald wir uns später mit mehreren Fenstern, Tabs oder ungespeicherten Buffern beschäftigen.

Für dieses Kapitel reicht die einfache Vorstellung:

**Buffer ≈ aktuell in Vim geladener Text einer Datei.**
:::

---

# Weitere Dateien öffnen

Wir müssen nicht alle Dateien bereits beim Start von `vi` angeben.

Während einer laufenden Sitzung können wir mit:

```vim
:e dateiname
```

eine weitere Datei öffnen.

`e` steht für:

```text
edit
```

Starten wir beispielsweise:

```bash
vi foo.txt
```

und geben anschließend ein:

```vim
:e ls-output.txt
```

Nun wird `ls-output.txt` angezeigt.

Mit:

```vim
:buffers
```

können wir überprüfen, dass `foo.txt` weiterhin als Buffer vorhanden ist.

---

# Inhalt zwischen Dateien kopieren

Wenn mehrere Dateien geöffnet sind, können wir die bereits bekannten Yank- und Paste-Befehle verwenden.

Wechseln wir zunächst zu Buffer 1:

```vim
:buffer 1
```

Setzen wir den Cursor auf die erste Zeile und kopieren sie:

```vim
yy
```

Dann wechseln wir zum zweiten Buffer:

```vim
:buffer 2
```

Setzen wir den Cursor an die gewünschte Position und drücken:

```vim
p
```

Die zuvor kopierte Zeile wird dort eingefügt.

Unsere Befehle:

```text
y
p
P
```

funktionieren also auch über Buffer hinweg.

---

# Eine ganze Datei einfügen

Wir können sogar den gesamten Inhalt einer Datei in die aktuell bearbeitete Datei einfügen.

Öffnen wir beispielsweise:

```bash
vi ls-output.txt
```

Bewegen wir den Cursor an die gewünschte Stelle und geben ein:

```vim
:r foo.txt
```

`r` steht hier für:

```text
read
```

Der Inhalt von `foo.txt` wird **unterhalb der aktuellen Zeile** eingefügt.

Das ist ausgesprochen praktisch, wenn wir Inhalte aus vorhandenen Dateien zusammensetzen möchten.

:::note
## `:r` kann noch mehr

Der `:read`-Befehl kann in Vim nicht nur Dateien einlesen.

Mit:

```vim
:r !command
```

kann sogar die Ausgabe eines externen Befehls in den aktuellen Buffer eingefügt werden.

Zum Beispiel:

```vim
:r !date
```

fügt die Ausgabe von `date` unterhalb der aktuellen Zeile ein.

Das ist ein schönes Beispiel dafür, wie eng Vim und die Unix-Kommandozeile miteinander zusammenspielen.
:::

---

# Unsere Arbeit speichern

Wie bei fast allem in `vi` gibt es auch zum Speichern mehrere Möglichkeiten.

Den grundlegenden Befehl kennen wir bereits:

```vim
:w
```

Er speichert die aktuelle Datei.

Eine sehr bekannte Kombination lautet:

```vim
:wq
```

Sie bedeutet:

```text
write + quit
```

also:

**Speichern und beenden.**

Im Normal Mode können wir außerdem:

```text
ZZ
```

drücken.

Auch damit wird die Datei gespeichert und Vim anschließend beendet, sofern Änderungen vorliegen.

---

# Unter einem anderen Namen speichern

Der `:w`-Befehl kann zusätzlich einen Dateinamen erhalten.

Wenn wir beispielsweise `foo.txt` bearbeiten und eine Kopie als `foo1.txt` speichern möchten:

```vim
:w foo1.txt
```

Das ähnelt einem **Speichern unter ...**

Allerdings gibt es einen wichtigen Unterschied:

Die Datei wird zwar unter dem neuen Namen geschrieben, aber der aktuell bearbeitete Buffer bleibt weiterhin mit der ursprünglichen Datei `foo.txt` verbunden.

Wenn wir danach weiterarbeiten und wieder:

```vim
:w
```

eingeben, speichern wir also weiterhin `foo.txt`.

:::note
## Wirklich zu einem neuen Dateinamen wechseln

Wenn du nicht nur eine Kopie schreiben, sondern den aktuellen Buffer unter einem neuen Namen weiterbearbeiten möchtest, bietet Vim beispielsweise:

```vim
:saveas foo1.txt
```

Danach ist der aktuelle Buffer mit `foo1.txt` verbunden.

Das geht über das ursprüngliche `vi` hinaus, ist in modernem Vim aber ausgesprochen praktisch.
:::

---

# Auch Bash kann `vi`

In Kapitel 8 haben wir gesehen, dass Bash eine leistungsfähige Bearbeitung der aktuellen Kommandozeile besitzt.

Standardmäßig verwendet Bash dafür Tastenkombinationen, die stark von **Emacs** beeinflusst sind.

Bash kann jedoch auch eine `vi`-artige Kommandozeilenbearbeitung verwenden.

Aktivieren können wir sie mit:

```bash
set -o vi
```

Ab diesem Moment können wir viele der gerade gelernten `vi`-Befehle direkt am Shell-Prompt verwenden.

Probieren wir es aus.

Beginne eine Kommandozeile mit:

```text
the quick brown fox jumps over the lazy dog
```

Während wir schreiben, befinden wir uns zunächst in einem `vi`-ähnlichen Insert Mode.

Drücken wir:

```text
Esc
```

wechseln wir in einen Normal Mode.

Nun funktionieren viele bekannte Bewegungs- und Bearbeitungsbefehle:

```text
h  j  k  l
w  b
0  $
x
d
y
p
```

Mit:

```text
i
```

oder:

```text
A
```

wechseln wir wieder in den Insert Mode.

Das ist eine ausgezeichnete Möglichkeit, die `vi`-Bewegungen im Alltag zu üben.

---

# Vi-Modus dauerhaft in Bash aktivieren

Wenn uns diese Art der Kommandozeilenbearbeitung gefällt, können wir:

```bash
set -o vi
```

in unsere:

```text
~/.bashrc
```

eintragen.

Danach verwendet Bash für interaktive Sitzungen dauerhaft den Vi-Modus.

Zurück zum standardmäßigen Emacs-Stil gelangen wir mit:

```bash
set -o emacs
```

:::note
## Bash verwendet dafür Readline

Die interaktive Kommandozeilenbearbeitung von Bash wird von der Bibliothek **GNU Readline** bereitgestellt.

Readline unterstützt sowohl einen Emacs- als auch einen Vi-Modus.

Deshalb fühlt sich:

```bash
set -o vi
```

ähnlich wie Vim an, ist aber kein eingebetteter Vim-Editor.

Nicht jeder Vim-Befehl funktioniert dort. Die wichtigsten Bewegungs- und Bearbeitungskonzepte sind jedoch vorhanden.
:::

---

# Die wichtigsten Befehle auf einen Blick

Nach all den neuen Tasten lohnt sich eine kompakte Übersicht.

| Befehl | Bedeutung |
| ------ | --------- |
| `Esc` | Zurück in den Normal Mode. |
| `i` | Vor dem Cursor Text einfügen. |
| `a` | Nach dem Cursor Text einfügen. |
| `A` | Am Ende der Zeile Text anhängen. |
| `o` | Neue Zeile unterhalb öffnen. |
| `O` | Neue Zeile oberhalb öffnen. |
| `h` `j` `k` `l` | Cursor bewegen. |
| `w` | Zum nächsten Wort. |
| `b` | Zum vorherigen Wort. |
| `0` | Zum Zeilenanfang. |
| `^` | Zum ersten Nicht-Leerzeichen. |
| `$` | Zum Zeilenende. |
| `G` | Zur letzten Zeile. |
| `20G` | Zu Zeile 20. |
| `x` | Zeichen löschen. |
| `dd` | Zeile löschen. |
| `d$` | Bis zum Zeilenende löschen. |
| `yy` | Zeile kopieren. |
| `p` | Nach beziehungsweise unter der aktuellen Position einfügen. |
| `P` | Vor beziehungsweise über der aktuellen Position einfügen. |
| `u` | Änderung rückgängig machen. |
| `Ctrl-r` | In Vim eine rückgängig gemachte Änderung wiederherstellen. |
| `J` | Aktuelle und folgende Zeile verbinden. |
| `/text` | Nach `text` suchen. |
| `n` | Nächsten Suchtreffer anzeigen. |
| `N` | Vorherigen Suchtreffer anzeigen. |
| `:w` | Speichern. |
| `:q` | Beenden. |
| `:q!` | Beenden und ungespeicherte Änderungen verwerfen. |
| `:wq` | Speichern und beenden. |
| `ZZ` | Speichern und beenden. |

:::note
## Du musst das nicht alles sofort auswendig lernen

Gerade am Anfang wirkt `vi` wie eine Wand aus einzelnen Tastenkürzeln.

Versuche stattdessen zunächst, dir nur diesen kleinen Ablauf zu merken:

```text
i       Text eingeben
Esc     zurück zum Normal Mode
:w      speichern
:q      beenden
```

Danach kommen:

```text
h j k l
w b
0 $
```

und schließlich die Bearbeitungsbefehle:

```text
x
dd
yy
p
u
```

Wenn diese Befehle selbstverständlich geworden sind, ergibt der Rest zunehmend Sinn.

Und wie bei der Carnegie Hall gilt:

**Üben, üben, üben.**
:::

---

# Zusammenfassung

Mit den Grundlagen aus diesem Kapitel können wir bereits einen großen Teil der Textbearbeitung erledigen, die bei der Administration eines typischen Linux-Systems anfällt.

Wir haben gelernt,

- warum grundlegende `vi`-Kenntnisse weiterhin nützlich sind,
- wie `vi`, Vim und moderne Varianten wie Neovim zusammenhängen,
- wie wir `vi` starten und wieder verlassen,
- warum `vi` ein modaler Editor ist,
- wie wir zwischen Normal Mode und Insert Mode wechseln,
- wie wir Text eingeben und speichern,
- wie wir den Cursor effizient bewegen,
- wie Zahlen Befehle wiederholen,
- wie wir Text löschen, kopieren und einfügen,
- wie Operatoren und Bewegungsbefehle miteinander kombiniert werden,
- wie wir Zeilen verbinden,
- wie wir suchen und ersetzen,
- wie wir mehrere Dateien beziehungsweise Buffer bearbeiten,
- wie wir den Inhalt einer Datei in eine andere einfügen,
- und wie wir Bash selbst auf eine `vi`-artige Kommandozeilenbearbeitung umstellen.

Wer Vim regelmäßig verwendet, wird mit der Zeit immer schneller.

Noch wichtiger ist jedoch, dass die `vi`-Philosophie tief in der Unix-Kultur verwurzelt ist. Viele andere Programme übernehmen Teile ihrer Bedienung.

`less` ist ein gutes Beispiel dafür.

Auch zahlreiche moderne Terminalprogramme, Dateimanager, Entwicklungsumgebungen und Browser-Erweiterungen bieten sogenannte **Vim Keybindings** an.

Die Zeit, die wir in diese Grundlagen investieren, zahlt sich daher weit über den eigentlichen Editor hinaus aus.

---

# Weiterführende Informationen

Wir haben in diesem Kapitel nur an der Oberfläche dessen gekratzt, was Vim kann.

Ein sehr guter nächster Schritt ist das mit Vim ausgelieferte interaktive Tutorial:

```bash
vimtutor
```

Es führt direkt im Terminal durch die wichtigsten Vim-Befehle und eignet sich hervorragend, um das Gelernte praktisch zu üben.

Innerhalb von Vim steht außerdem ein umfangreiches Hilfesystem zur Verfügung:

```vim
:help
```

Für einen bestimmten Befehl können wir beispielsweise eingeben:

```vim
:help dd
```

oder:

```vim
:help :substitute
```

Gerade bei Vim ist diese eingebaute Dokumentation eine der besten Informationsquellen.

Wer `vi` wirklich lernen möchte, sollte deshalb nicht versuchen, hunderte Befehle auf einmal auswendig zu lernen.

Die bessere Methode kennen wir bereits:

**Üben, üben, üben.**