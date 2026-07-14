from pathlib import Path

content = """# Übersetzungsleitfaden

## Ziel

Diese Übersetzung soll keine starre Wort-für-Wort-Übertragung sein. Ziel ist eine natürliche, gut lesbare deutsche Fassung, die dieselbe Stimmung und Wirkung vermittelt wie das englische Original.

Der Text soll sich so lesen, als wäre er von Anfang an auf Deutsch geschrieben worden.

## Grundton

Die Übersetzung soll:

- locker,
- freundlich,
- direkt,
- leicht nerdig,
- motivierend,
- technisch präzise,
- aber nicht trocken

wirken.

Der Autor spricht die Leserinnen und Leser direkt an. Der Ton erinnert eher an einen erfahrenen Linux-Nutzer, der sein Wissen gern weitergibt, als an ein Lehrbuch oder eine wissenschaftliche Abhandlung.

## Sprachstil

Verwendet wird modernes, gut verständliches Hochdeutsch.

Bevorzugt werden:

- kurze und flüssige Sätze,
- aktive Formulierungen,
- klare Aussagen,
- natürliche Satzstellungen,
- verständliche Begriffe,
- ein ruhiger, gelegentlich augenzwinkernder Ton.

Vermieden werden:

- unnötige Behördensprache,
- übertriebene Förmlichkeit,
- unnötig komplizierte Satzkonstruktionen,
- zwanghafte Eindeutschungen,
- ein steifer oder akademischer Stil.

Beispiel:

> Schauen wir uns an, was hier passiert.

statt:

> Im Folgenden wird erläutert, welche Vorgänge stattfinden.

## Übersetzungsprinzip

Übersetzt wird die **Wirkung**, nicht nur der Wortlaut.

Sätze dürfen umgestellt, geteilt oder zusammengeführt werden, wenn sie dadurch auf Deutsch natürlicher klingen. Kurze Absätze und einzelne hervorgehobene Sätze sollen erhalten bleiben, wenn sie den Rhythmus des Originals tragen.

Beispiel:

> Sie entwickeln Linux.

Ein solcher Satz darf bewusst allein stehen bleiben.

Die Übersetzung darf frei formuliert sein, aber keine neuen Aussagen hinzufügen, die im Original nicht enthalten sind.

## Rhythmus und Dramaturgie

Der Stil von William Shotts lebt von kurzen Absätzen, direkten Aussagen und kleinen dramaturgischen Pausen.

Diese Wirkung soll möglichst erhalten bleiben.

Wichtige Grundsätze:

- Kurze Sätze dürfen kurz bleiben.
- Einzelne Aussagen dürfen als eigener Absatz stehen.
- Wiederholungen dürfen erhalten bleiben, wenn sie bewusst eingesetzt werden.
- Pointen, Spannungsaufbau und Betonungen sollen nicht durch lange deutsche Satzkonstruktionen abgeschwächt werden.

## Fachbegriffe

Gebräuchliche Linux- und Unix-Begriffe werden nicht zwanghaft übersetzt.

In der Regel bleiben unter anderem folgende Begriffe erhalten:

- Shell
- Kernel
- Terminal
- Prompt
- Pipe
- Root
- Home-Verzeichnis
- Kommandozeile
- Standardausgabe
- Standardeingabe
- Prozess
- Skript

Bei mehrdeutigen oder uneinheitlich übersetzten Fachbegriffen soll das Projektglossar verwendet und bei Bedarf erweitert werden.

## Zielgruppe

Das Buch richtet sich an technisch interessierte Menschen, die Linux und die Kommandozeile kennenlernen oder besser verstehen möchten.

Es wird kein Expertenwissen vorausgesetzt.

Der Text soll:

- neugierig machen,
- zum Ausprobieren ermutigen,
- Zusammenhänge verständlich erklären,
- technische Präzision mit guter Lesbarkeit verbinden.

Die Leserinnen und Leser sollen sich begleitet, nicht belehrt fühlen.

## Direkte Ansprache

Die Leserschaft wird mit **du** angesprochen.

Bevorzugte Formulierungen sind zum Beispiel:

- Schauen wir uns das genauer an.
- Probieren wir es aus.
- Jetzt wird es interessant.
- Keine Sorge, das ist einfacher, als es zunächst aussieht.
- Du wirst gleich sehen, warum.

## Nicht erwünschter Stil

Zu vermeiden sind Formulierungen wie:

> Im Folgenden wird erläutert …

> Es besteht die Möglichkeit …

> Der Benutzer hat die Möglichkeit …

> Dies kann mittels des folgenden Befehls durchgeführt werden …

Besser:

> Schauen wir uns das an.

> Du kannst dafür folgenden Befehl verwenden.

> Probieren wir es direkt aus.

## Genauigkeit

Technische Inhalte, Befehle, Dateinamen, Pfade und Codebeispiele dürfen durch die Übersetzung nicht verändert werden, sofern keine bewusste Anpassung erforderlich ist.

Besonders zu prüfen sind:

- Befehle,
- Optionen und Parameter,
- Pfade,
- Dateinamen,
- Variablennamen,
- Ausgaben im Terminal,
- Querverweise,
- Kapitelnummern.

Bei Unsicherheiten soll die Bedeutung des Originals Vorrang vor einer besonders freien Formulierung haben.


## Platzhalter in Befehlen

Platzhalter in Befehlen, Syntaxangaben und Codebeispielen bleiben grundsätzlich auf Englisch.

Dazu gehören zum Beispiel:

- `filename`
- `directory`
- `source`
- `destination`
- `user_name`
- `pattern`
- `command`
- `options`
- `arguments`

Ihre Bedeutung wird im deutschen Fließtext erklärt, nicht durch eine Übersetzung innerhalb des Befehls.

Beispiel:

```text
cp source destination
```

Dabei steht `source` für die Quelldatei und `destination` für das Ziel.

Nicht verwendet wird:

```text
cp quelle ziel
```

Diese Regel erleichtert den späteren Umgang mit englischsprachigen `man`-Seiten, Hilfetexten und Linux-Dokumentationen.

Echte Befehle, Optionen, Dateinamen, Pfade, Benutzerkonten und Variablennamen bleiben ebenfalls unverändert und werden mit Backticks ausgezeichnet.

## Typografie

Für Markdown gelten folgende Grundregeln:

- Befehle, Dateinamen, Pfade und Code werden mit Backticks ausgezeichnet.
- Längere Terminalausgaben und Codebeispiele stehen in Codeblöcken.
- Buchtitel werden kursiv geschrieben.
- Hervorhebungen werden sparsam verwendet.
- Überschriften folgen einer klaren Hierarchie.
- Absätze bleiben eher kurz.

## Konsistenz

Die Übersetzung soll im gesamten Buch wie aus einer Hand wirken.

Dafür gelten:

- gleiche Fachbegriffe für gleiche Konzepte,
- einheitliche Anrede,
- einheitliche Schreibweisen,
- einheitliche Formatierung von Befehlen und Dateinamen,
- einheitlicher Umgang mit englischen Fachwörtern.

Neue oder unklare Begriffe sollen im Glossar dokumentiert werden.

## Entscheidungsregel bei Zweifelsfällen

Wenn mehrere Übersetzungen möglich sind, gilt folgende Reihenfolge:

1. Technische Korrektheit
2. Verständlichkeit
3. Natürliches Deutsch
4. Nähe zum Ton des Originals
5. Wortgetreue Nähe zum Ausgangstext

Eine Formulierung darf sich vom englischen Satzbau lösen, solange Inhalt, Aussage und Wirkung erhalten bleiben.

## Kurzfassung für Übersetzungsaufträge

Für neue Übersetzungen kann folgende Anweisung verwendet werden:

> Übersetze den folgenden Abschnitt nach dem Übersetzungsleitfaden dieses Projekts: natürliches, modernes Hochdeutsch, locker, direkt, leicht nerdig und technisch präzise. Übersetze die Wirkung statt starr den Wortlaut. Erhalte Rhythmus, kurze Absätze und dramaturgische Betonungen. Verwende gebräuchliche Linux-Fachbegriffe und erfinde keine neuen Inhalte.
"""

path = Path("/mnt/data/translation_style.md")
path.write_text(content, encoding="utf-8")
print(f"Erstellt: {path}")

