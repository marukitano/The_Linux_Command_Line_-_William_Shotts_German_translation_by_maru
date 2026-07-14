# 5 – Mit Befehlen arbeiten

Bis jetzt haben wir bereits eine ganze Reihe von Befehlen kennengelernt – jeder mit seinen eigenen Optionen und Argumenten.

Vielleicht wirken viele davon noch etwas geheimnisvoll.

Das werden wir jetzt ändern.

In diesem Kapitel schauen wir uns genauer an, wie Befehle eigentlich funktionieren, wie du Informationen über sie findest und wie du sogar deine eigenen Befehle erstellen kannst.

Dabei lernen wir die folgenden Werkzeuge kennen:

- **`type`** – Zeigt an, wie ein Befehlsname von der Shell interpretiert wird.
- **`which`** – Zeigt, welches ausführbare Programm tatsächlich gestartet wird.
- **`help`** – Zeigt die Hilfe zu den in die Shell eingebauten Befehlen.
- **`man`** – Öffnet die Handbuchseite eines Befehls.
- **`apropos`** – Sucht nach Befehlen zu einem bestimmten Thema.
- **`info`** – Zeigt die Info-Dokumentation eines Programms an.
- **`whatis`** – Zeigt eine kurze Beschreibung eines Befehls an.
- **`alias`** – Erstellt einen Alias für einen Befehl.

## Was ist eigentlich ein Befehl?

Ein Befehl kann unter Linux vier verschiedene Dinge sein:

- **Ein ausführbares Programm**

  Das sind die Programme, die wir bereits in Verzeichnissen wie `/usr/bin` kennengelernt haben.

  Dazu gehören sowohl kompilierte Programme – beispielsweise in **C** oder **C++** geschrieben – als auch Skripte, etwa in **Shell**, **Perl**, **Python**, **Ruby** oder anderen Programmiersprachen.

- **Ein in die Shell eingebauter Befehl (_Shell Builtin_)**

  Einige Befehle gehören direkt zur Shell und sind keine eigenständigen Programme.

  Der Befehl `cd` ist beispielsweise ein solches **Shell Builtin**.

- **Eine Shell-Funktion**

  Shell-Funktionen sind kleine Shell-Skripte, die direkt in deine Shell-Umgebung integriert sind.

  Wie du deine Umgebung anpasst und eigene Shell-Funktionen schreibst, lernst du in späteren Kapiteln. Für den Moment genügt es zu wissen, dass es sie gibt.

- **Ein Alias**

  Ein Alias ist ein selbst definierter Kurzbefehl, der einen anderen Befehl oder sogar eine ganze Befehlsfolge ersetzt.