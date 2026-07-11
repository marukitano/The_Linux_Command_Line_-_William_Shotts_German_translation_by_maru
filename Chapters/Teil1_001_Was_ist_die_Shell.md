# 1 – Was ist die Shell?

Wenn wir von der Kommandozeile sprechen, meinen wir damit eigentlich die **Shell**. Die Shell ist ein Programm, das deine Eingaben von der Tastatur entgegennimmt, sie an das Betriebssystem weitergibt und dort ausführen lässt. Fast alle Linux-Distributionen bringen eine Shell aus dem GNU-Projekt mit: **`bash`**. Der Name **`bash`** steht für **„Bourne Again SHell“** – ein Wortspiel, das darauf anspielt, dass `bash` als verbesserter Nachfolger von `sh` entwickelt wurde. `sh` war die ursprüngliche Unix-Shell und wurde von Steve Bourne geschrieben.

## Terminalemulatoren

Wenn du eine grafische Benutzeroberfläche (GUI) verwendest, brauchst du ein weiteres Programm, um mit der Shell zu arbeiten: einen **Terminalemulator**. Sieh dich einmal im Anwendungsmenü deiner Desktop-Umgebung um – wahrscheinlich findest du dort bereits einen. KDE verwendet **`konsole`**, GNOME **`gnome-terminal`**, wobei das Programm im Menü meist einfach **„Terminal“** heißt. Für Linux gibt es viele weitere Terminalemulatoren. Im Grunde erfüllen sie aber alle denselben Zweck: Sie ermöglichen dir den Zugriff auf die Shell. Mit der Zeit wirst du wahrscheinlich einen persönlichen Favoriten finden. Welcher dir am besten gefällt, hängt oft von den zusätzlichen Funktionen und Komfortmerkmalen ab, die er mitbringt.

## Die ersten Schritte im Terminal

Jetzt geht's los. Starte deinen Terminalemulator! Nach dem Öffnen solltest du in etwa Folgendes sehen:

```text
[me@linuxbox ~]$
```

Diese Zeile nennt man **Shell-Prompt** oder einfach **Prompt**. Er erscheint immer dann, wenn die Shell bereit ist, einen Befehl entgegenzunehmen. Je nach Linux-Distribution und Konfiguration kann der Prompt etwas anders aussehen. In der Regel enthält er jedoch deinen Benutzernamen (`username`), den Namen deines Computers (`machinename`), das aktuelle Arbeitsverzeichnis (dazu kommen wir gleich) und schließt mit einem Dollarzeichen (`$`) ab.

::: note
**Hinweis:** Endet der Prompt nicht mit einem Dollarzeichen (`$`), sondern mit einem Rautenzeichen (`#`), verfügt deine Terminalsitzung über **Superuser-Rechte**. Das bedeutet, dass du entweder als Benutzer `root` angemeldet bist oder einen Terminalemulator geöffnet hast, der automatisch mit Administratorrechten gestartet wurde.
:::

Gehen wir einmal davon aus, dass bisher alles funktioniert hat. Dann probieren wir jetzt die ersten Eingaben aus. Tippe am Prompt einfach irgendeinen Unsinn ein, zum Beispiel:

```bash
[me@linuxbox ~]$ kaekfjaeifj
```

Da dieser „Befehl“ natürlich keinen Sinn ergibt, teilt dir die Shell das mit und gibt dir sofort die nächste Gelegenheit, einen gültigen Befehl einzugeben:

```text
bash: kaekfjaeifj: command not found
[me@linuxbox ~]$
```

## Befehlsverlauf

Drückst du jetzt die **Pfeil-nach-oben-Taste**, erscheint der zuvor eingegebene Befehl `kaekfjaeifj` wieder am Prompt. Diese Funktion nennt sich **Befehlsverlauf** (_command history_). Standardmäßig speichern die meisten Linux-Distributionen die letzten 1.000 eingegebenen Befehle.

Drückst du anschließend die **Pfeil-nach-unten-Taste**, verschwindet der Befehl wieder.

## Den Cursor bewegen

Hole den vorherigen Befehl noch einmal mit der **Pfeil-nach-oben** zurück. Probiere anschließend die **Pfeil-nach-links und Pfeil-nach-rechts-Taste** aus. Du wirst sehen, dass sich der Cursor an jede beliebige Stelle der Befehlszeile bewegen lässt. Dadurch kannst du Befehle ganz einfach bearbeiten, ohne sie komplett neu eingeben zu müssen.

::: note
**Hinweis:** Verwende im Terminal zum Kopieren und Einfügen **nicht** die üblichen Tastenkombinationen **`Ctrl` + `C`** und **`Ctrl` + `V`**.

Im Terminal haben diese Tasten eine andere Bedeutung: Mit **`Ctrl` + `C`** wird das aktuell laufende Programm in der Regel abgebrochen. Deshalb verwendest du zum Kopieren **`Ctrl` + `Shift` + `C`** und zum Einfügen **`Ctrl` + `Shift` + `V`**.

Viele Terminalemulatoren unterstützen außerdem das Kopieren und Einfügen über das Kontextmenü (Rechtsklick). Je nach Desktop-Umgebung kannst du markierten Text auch mit einem Klick auf die mittlere Maustaste einfügen.
:::

## Die ersten Befehle

Nachdem du nun weißt, wie du Befehle im Terminal eingibst, probieren wir ein paar einfache Kommandos aus.

Beginnen wir mit `date`. Dieser Befehl zeigt das aktuelle Datum und die Uhrzeit an.

```bash
[me@linuxbox ~]$ date
Thu Mar 8 15:09:41 EST 2025
```

Ein weiterer nützlicher Befehl ist `uptime`. Er zeigt an, wie lange dein System bereits läuft und wie hoch die durchschnittliche Systemlast in den letzten 1, 5 und 15 Minuten war.

```bash
[me@linuxbox ~]$ uptime
15:12:22 up 3 days, 23:40,
7 users,
load average: 0.37, 0.37, 0.64
```

Um zu sehen, wie viel Speicherplatz auf deinen Laufwerken noch verfügbar ist, verwendest du den Befehl `df`.

```bash
[me@linuxbox ~]$ df
Filesystem     1K-blocks     Used Available Use% Mounted on
/dev/sda2        15115452   5012392   9949716  34% /
/dev/sda5        59631908  26545424  30008432  47% /home
/dev/sda1          147764     17370    122765  13% /boot
tmpfs              256856         0    256856   0% /dev/shm
```

Möchtest du wissen, wie viel Arbeitsspeicher momentan verfügbar ist, verwende den Befehl `free`.

```bash
[me@linuxbox ~]$ free
              total       used       free     shared    buffers     cached
Mem:         513712     503976       9736          0       5312     122916
-/+ buffers/cache:      375748     137964
Swap:       1052248     104712     947536
```

## Eine Terminalsitzung beenden

Eine Terminalsitzung kannst du auf verschiedene Arten beenden:

- Schließe das Fenster des Terminalemulators.
- Gib am Prompt den Befehl `exit` ein.
- Oder drücke die Tastenkombination **`Ctrl` + `D`**.

```bash
[me@linuxbox ~]$ exit
```

::: note
**Hinweis:** Auch wenn gerade kein Terminalfenster geöffnet ist, laufen im Hintergrund mehrere textbasierte Anmeldesitzungen. Diese werden **virtuelle Konsolen** (oder **virtuelle Terminals**) genannt.

Auf den meisten Linux-Systemen erreichst du sie mit **`Ctrl` + `Alt` + `F2`** bis **`Ctrl` + `Alt` + `F6`**. Dort kannst du dich mit deinem Benutzernamen und Passwort anmelden und ganz ohne grafische Oberfläche arbeiten.

Zwischen den virtuellen Konsolen wechselst du anschließend mit **`Alt` + `F2`** bis **`Alt` + `F6`**.

Um zur grafischen Oberfläche zurückzukehren, wechselst du einfach wieder zu der virtuellen Konsole, auf der deine Desktop-Umgebung läuft. Je nach Distribution und Desktop kann das **`F1`**, **`F2`** oder eine andere Funktionstaste sein.
:::

## Zusammenfassung

In diesem Kapitel hast du die ersten Schritte auf der Linux-Kommandozeile gemacht. Du hast die Shell kennengelernt, einen ersten Blick auf das Terminal geworfen und gelernt, wie du eine Terminalsitzung startest und wieder beendest.

Außerdem hast du deine ersten Befehle ausgeführt und gesehen, wie sich Eingaben auf der Kommandozeile bearbeiten lassen.

War doch gar nicht so schlimm, oder?

Im nächsten Kapitel lernen wir weitere nützliche Befehle kennen und machen uns auf den Weg durch das Linux-Dateisystem.

## Weiterführende Informationen

- **Steve Bourne**, der Entwickler der Bourne Shell:
- <http://en.wikipedia.org/wiki/Steve_Bourne>

- **Brian Fox**, der ursprüngliche Autor von `bash`:
- <https://en.wikipedia.org/wiki/Brian_Fox_(computer_programmer)>

- **Die Shell als Konzept in der Informatik**:
- <http://en.wikipedia.org/wiki/Shell_(computing)>