# 2 – Navigation

Nachdem du nun weißt, wie man Befehle eingibt, lernen wir als Nächstes, uns im Dateisystem von Linux zurechtzufinden.

In diesem Kapitel begegnen dir drei grundlegende Befehle:

- **`pwd`** – Zeigt das aktuelle Arbeitsverzeichnis an.
- **`cd`** – Wechselt das Verzeichnis.
- **`ls`** – Listet den Inhalt eines Verzeichnisses auf.

## Den Verzeichnisbaum verstehen

Wie Windows organisiert auch ein Unix-ähnliches Betriebssystem wie Linux seine Dateien in einer **hierarchischen Verzeichnisstruktur**. Das bedeutet, dass alle Dateien und Verzeichnisse baumartig angeordnet sind. Ein Verzeichnis (auf anderen Betriebssystemen oft auch **Ordner** genannt) kann sowohl Dateien als auch weitere Unterverzeichnisse enthalten.

Ganz oben steht das **Wurzelverzeichnis** (_root directory_). Es bildet den Ausgangspunkt des gesamten Dateisystems. Von dort verzweigt sich der Verzeichnisbaum in weitere Verzeichnisse und Unterverzeichnisse, die wiederum Dateien und weitere Unterverzeichnisse enthalten können.

::: note
**Hinweis:** Im Gegensatz zu Windows, das für jedes Laufwerk einen eigenen Verzeichnisbaum verwendet (z. B. `C:\` oder `D:\`), besitzt Linux immer **genau einen** Verzeichnisbaum – unabhängig davon, wie viele Festplatten, SSDs oder andere Speichermedien an den Computer angeschlossen sind.

Zusätzliche Speichergeräte werden an einer beliebigen Stelle in diesen Verzeichnisbaum **eingehängt** (_mounted_). Wo genau das geschieht, entscheidet der Systemadministrator – also die Person, die das System verwaltet. Also in Idealfall bald DU
:::

## Das aktuelle Arbeitsverzeichnis

Die meisten kennen wahrscheinlich einen grafischen Dateimanager, der das Dateisystem als Baumstruktur darstellt – so wie in Abbildung 1. Dabei befindet sich das Wurzelverzeichnis normalerweise ganz oben, während sich die einzelnen Verzeichnisse darunter wie Äste eines Baumes verzweigen. Auf der Kommandozeile gibt es allerdings keine grafische Darstellung. Deshalb müssen wir uns das Dateisystem etwas anders vorstellen.

![Abbildung 1: Dateisystembaum, dargestellt in einem grafischen Dateimanager.](Images/Figure_1.png)

Stell dir vor, das Dateisystem ist ein Labyrinth in Form eines auf den Kopf gestellten Baumes, und du stehst mitten darin. Zu jedem Zeitpunkt befindest du dich genau in einem Verzeichnis. Von dort aus kannst du die Dateien in diesem Verzeichnis sehen, den Weg zum Verzeichnis über dir – dem **übergeordneten Verzeichnis** (_parent directory_) – sowie alle Unterverzeichnisse unter dir. Das Verzeichnis, in dem du dich gerade befindest, nennt man **aktuelles Arbeitsverzeichnis** (_current working directory_ oder kurz: cwd). Um es anzuzeigen, verwendest du den Befehl `pwd` (_print working directory_).

```bash
[me@linuxbox ~]$ pwd
/home/me
```

Wenn du dich an deinem Linux-System anmeldest oder eine neue Terminalsitzung startest, ist das aktuelle Arbeitsverzeichnis standardmäßig dein **Home-Verzeichnis**. Jeder Benutzer besitzt sein eigenes Home-Verzeichnis. Für normale Benutzer ist es außerdem der wichtigste Ort, an dem sie Dateien erstellen und bearbeiten dürfen.