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

Eine Bibliothek (*Library*) ist eine Sammlung fertiger Programmfunktionen, die von verschiedenen Programmen gemeinsam genutzt werden können.

Readline stellt zahlreiche Funktionen bereit, mit denen sich Eingaben bequem bearbeiten lassen.

Einige davon kennst du bereits.

So bewegen beispielsweise die Pfeiltasten den Cursor innerhalb der aktuellen Eingabe.

Readline bietet jedoch noch viele weitere Tastenkombinationen, mit denen sich Befehle schneller eingeben, bearbeiten und wiederverwenden lassen.

Du musst sie nicht alle auswendig lernen.

Suche dir einfach diejenigen aus, die gut zu deinem Arbeitsstil passen.

Mit der Zeit werden sie ganz automatisch in Fleisch und Blut übergehen.

:::
## Hinweis

Einige der folgenden Tastenkombinationen – insbesondere solche mit der **Alt**-Taste – werden unter grafischen Desktop-Umgebungen möglicherweise bereits für andere Funktionen verwendet.

In einer **virtuellen Konsole** (TTY) stehen dagegen alle Tastenkombinationen von Readline uneingeschränkt zur Verfügung.
:::