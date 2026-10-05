# Translation Style Guide

Diese Datei beschreibt die verbindlichen Regeln für die deutsche Übersetzung von William Shotts' *The Linux Command Line*. Sie dient insbesondere dazu, dass verschiedene ChatGPT-Instanzen und menschliche Mitwirkende konsistent weiterarbeiten können.

## Grundprinzipien

- Nicht Wort für Wort übersetzen, sondern die **Wirkung, Verständlichkeit und den Ton des Originals** erhalten.
- Natürliches, modernes Deutsch verwenden.
- Die Leser direkt mit **du** ansprechen.
- Den Stil von William Shotts bewahren: freundlich, didaktisch, zugänglich und gelegentlich humorvoll.
- Veraltete Linux-Informationen dürfen behutsam modernisiert werden, wenn der ursprüngliche Gedanke erhalten bleibt.
- Wo es dem Verständnis hilft, dürfen kurze zusätzliche Erklärungen, Beispiele oder Hinweise ergänzt werden.
- Technische Aussagen müssen fachlich korrekt bleiben.

## Linux-Begriffe und Code

- Etablierte Linux- und Unix-Begriffe wie `Shell`, `Kernel`, `Prompt`, `Process`, `PID`, `Readline` usw. nicht zwanghaft eindeutschen.
- Befehle, Optionen, Dateinamen, Pfade, Variablen und Platzhalter bleiben im Original und werden als Code formatiert.
- Beispiele des Originals dürfen modernisiert werden, wenn Programme oder Systemkomponenten heute veraltet oder unüblich sind. Der ursprüngliche Lehrzweck muss erhalten bleiben.
- Moderne Alternativen können zusätzlich erwähnt werden, ohne historische Zusammenhänge zu verschweigen.

## Didaktische Ergänzungen

Zusätzliche Hinweise werden mit Markdown-Directives geschrieben:

```markdown
:::note
## Titel

Erklärung oder zusätzlicher Hinweis.
:::
```

Hinweise sollen einen echten didaktischen Mehrwert bieten und nicht lediglich den Fließtext wiederholen.

Innerhalb von `:::note` nach Möglichkeit keine Markdown-Blockquotes mit `>` verwenden, da diese je nach remark-Konfiguration zu Lint-Problemen führen können. Hervorhebungen stattdessen beispielsweise mit **Fettdruck** formulieren.

## Markdown-Ausgabe

Übersetzte Abschnitte werden vollständig in Markdown ausgegeben.

Wenn die Übersetzung im Chat geliefert wird, wird der gesamte Abschnitt in **einen äußeren Markdown-Codeblock mit vier Backticks** gesetzt. Dadurch können normale dreifache Codeblöcke innerhalb des übersetzten Textes verwendet werden.

## remark-lint

Die Markdown-Dateien müssen **remark-lint-sauber** sein. Bei der Ausgabe ist deshalb nicht nur auf gültiges Markdown, sondern auch auf die im Projekt verwendeten Formatierungsregeln zu achten.

### Tabellen

Markdown-Tabellen müssen an den Zellrändern mit Leerzeichen formatiert werden.

Richtig:

```markdown
| Befehl | Beschreibung |
| ------ | ------------ |
| `ps` | Zeigt Prozesse an. |
| `top` | Zeigt Prozesse fortlaufend an. |
```

Auch bei ausgerichteten Spalten stehen Leerzeichen zwischen Zellinhalt beziehungsweise Alignment-Markern und den senkrechten Tabellenkanten:

```markdown
| Zustand | Bedeutung |
| :-----: | --------- |
| `R` | Running |
| `S` | Sleeping |
```

Nicht verwenden:

```markdown
|Befehl|Beschreibung|
|------|------------|
```

und auch nicht:

```markdown
| Zustand | Bedeutung |
|:-------:|-----------|
```

Insbesondere sind `remark-lint`-Fehler wie `table-cell-padding` zu vermeiden.

## Redaktionelle Leitlinie

Verbesserungen gegenüber dem Original sind ausdrücklich erwünscht, wenn sie:

1. die Verständlichkeit erhöhen,
2. veraltete Linux-Informationen sinnvoll aktualisieren,
3. typische Missverständnisse verhindern oder
4. einen praktischen Bezug zu heutigen Linux-Systemen herstellen.

Dabei darf der Charakter des Buches nicht zu einem völlig neuen Lehrbuch umgeschrieben werden. Die Übersetzung soll weiterhin klar als deutsche Ausgabe von *The Linux Command Line* erkennbar bleiben.
