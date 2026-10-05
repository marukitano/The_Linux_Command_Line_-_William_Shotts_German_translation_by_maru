# 10 – Prozesse

Moderne Betriebssysteme sind **multitaskingfähig**. Das bedeutet, dass viele Programme scheinbar gleichzeitig ausgeführt werden können.

Auf einem Prozessor mit mehreren CPU-Kernen können tatsächlich mehrere Aufgaben gleichzeitig laufen. Da aber normalerweise weit mehr Prozesse als CPU-Kerne vorhanden sind, verteilt der Kernel die verfügbare Rechenzeit fortlaufend zwischen ihnen.

Unter Linux werden laufende Programme in Form von **Prozessen** verwaltet.

Ein Prozess ist vereinfacht gesagt eine laufende Instanz eines Programms. Der Linux-Kernel verwaltet diese Prozesse und entscheidet unter anderem,

- wann ein Prozess CPU-Zeit erhält,
- wie viel Speicher ihm zur Verfügung steht,
- welchem Benutzer er gehört,
- und in welchem Zustand er sich befindet.

Im normalen Alltag bekommen wir davon wenig mit. Manchmal wird ein Rechner jedoch plötzlich langsam oder ein Programm reagiert nicht mehr.

Dann ist es hilfreich zu wissen,

- welche Prozesse gerade laufen,
- welche Ressourcen sie verbrauchen,
- wie wir sie anhalten oder fortsetzen,
- und wie wir einen problematischen Prozess beenden können.

In diesem Kapitel lernen wir dafür folgende Befehle kennen:

| Befehl | Beschreibung |
| ------ | ------------ |
| `ps` | Zeigt eine Momentaufnahme laufender Prozesse an. |
| `top` | Zeigt Prozesse und Systemauslastung fortlaufend an. |
| `jobs` | Listet die Jobs der aktuellen Shell auf. |
| `bg` | Setzt einen angehaltenen Job im Hintergrund fort. |
| `fg` | Holt einen Job in den Vordergrund. |
| `kill` | Sendet ein Signal an einen Prozess. |
| `killall` | Sendet ein Signal an Prozesse mit einem bestimmten Namen. |
| `nice` | Startet einen Prozess mit geänderter Scheduling-Priorität. |
| `renice` | Ändert die Priorität eines bereits laufenden Prozesses. |
| `nohup` | Startet einen Befehl so, dass er nicht beim Schließen des Terminals durch `SIGHUP` beendet wird. |
| `halt`, `poweroff`, `reboot` | Halten das System an, schalten es aus oder starten es neu. |
| `shutdown` | Fährt das System kontrolliert herunter oder startet es neu. |

:::note
## Prozess oder Programm?

Ein **Programm** ist beispielsweise eine ausführbare Datei auf deinem Datenträger.

Ein **Prozess** ist eine laufende Instanz dieses Programms.

Dasselbe Programm kann deshalb mehrfach gleichzeitig laufen. Jede Instanz besitzt dann einen eigenen Prozess und eine eigene **Process ID (PID)**.
:::

---

# Wie Prozesse funktionieren

Beim Start eines Linux-Systems beginnt zunächst der Kernel seine Arbeit. Anschließend startet er den ersten Prozess im sogenannten **Userspace**.

Traditionell wurde dieser Prozess `init` genannt.

Auf den meisten heutigen Linux-Distributionen übernimmt diese Aufgabe **`systemd`**. Es läuft als Prozess mit der PID `1` und startet anschließend die Dienste und weiteren Bestandteile, die das System benötigt.

Ältere Linux-Systeme verwendeten andere Init-Systeme und häufig sogenannte **Init-Skripte**, die beispielsweise unter `/etc/init.d/` lagen.

Viele Systemdienste laufen als sogenannte **Daemons**.

Ein Daemon ist ein Programm, das im Hintergrund arbeitet und normalerweise keine direkte Benutzeroberfläche besitzt.

Daemons übernehmen beispielsweise Aufgaben wie

- Netzwerkdienste bereitstellen,
- Systemprotokolle schreiben,
- Druckaufträge verwalten,
- Hardware überwachen,
- oder auf eingehende Verbindungen warten.

Deshalb ist auf einem Linux-System auch dann einiges los, wenn gerade kein Benutzer aktiv damit arbeitet.

:::note
## Was ist ein Daemon?

Ein **Daemon** ist ein dauerhaft oder bei Bedarf im Hintergrund laufendes Programm, das einen bestimmten Dienst bereitstellt.

Unter Windows wird dafür meist der Begriff **Service** verwendet.

Bei Linux erkennt man viele Systemdienste an einem `d` am Ende ihres Namens – zum Beispiel `sshd`.
:::

---

## Eltern- und Kindprozesse

Ein laufender Prozess kann weitere Prozesse starten.

Der bereits laufende Prozess wird dabei als **Elternprozess** (*Parent Process*) bezeichnet, der neu gestartete als **Kindprozess** (*Child Process*).

Wenn du beispielsweise in Bash

```bash
ls
```

eingibst, startet die Shell normalerweise einen neuen Prozess für `ls`.

So entsteht auf einem Linux-System eine ganze Hierarchie von Prozessen.

Diese lässt sich später beispielsweise mit

```bash
pstree
```

sichtbar machen.

---

## Die Process ID

Der Kernel speichert zu jedem Prozess verschiedene Informationen.

Dazu gehören unter anderem:

- die **Process ID (PID)**,
- die PID des Elternprozesses,
- Besitzer und Benutzerkennung,
- Speicherverbrauch,
- CPU-Nutzung,
- Priorität,
- und der aktuelle Zustand.

Jeder Prozess besitzt eine eindeutige Nummer, die **Process ID**, kurz **PID**.

PIDs werden vom Kernel vergeben und nach dem Ende eines Prozesses irgendwann wiederverwendet.

Der erste Userspace-Prozess besitzt die PID

```text
1
```

Auf einem modernen Linux-System ist das meistens `systemd`.

:::note
## PID 1 ist etwas Besonderes

PID 1 ist nicht einfach irgendein Prozess.

Dieser Prozess übernimmt eine besondere Rolle beim Starten und Verwalten des Systems und kümmert sich unter anderem auch um verwaiste Prozesse.

Auf den meisten aktuellen Desktop- und Server-Distributionen ist PID 1 `systemd`.
:::

---

# Prozesse anzeigen

Das klassische Werkzeug zum Anzeigen von Prozessen ist

```bash
ps
```

`ps` steht für **process status**.

In seiner einfachsten Form wird es ohne Optionen aufgerufen:

```bash
[me@linuxbox ~]$ ps
    PID TTY          TIME CMD
   5198 pts/1    00:00:00 bash
  10129 pts/1    00:00:00 ps
```

In diesem Beispiel sehen wir zwei Prozesse:

- `bash`
- `ps`

Standardmäßig zeigt `ps` nur eine kleine Auswahl der Prozesse an – insbesondere die Prozesse des aktuellen Benutzers, die mit dem aktuellen Terminal verbunden sind.

Die Spalten bedeuten:

| Spalte | Bedeutung |
| ------ | --------- |
| `PID` | Process ID |
| `TTY` | Zugeordnetes Terminal |
| `TIME` | Bisher verbrauchte CPU-Zeit |
| `CMD` | Gestarteter Befehl |

:::note
## Woher kommt der Name `ps`?

`ps` steht für **process status**.

Der Befehl zeigt eine Momentaufnahme laufender Prozesse und ihres Zustands an.
:::

---

## Was bedeutet `TTY`?

`TTY` steht ursprünglich für **Teletype**.

Der Begriff stammt aus einer Zeit, in der Computer tatsächlich über elektromechanische Fernschreiber bedient wurden.

Diese Geräte sind längst verschwunden, der Begriff hat jedoch überlebt.

Heute bezeichnet `TTY` beziehungsweise `PTY` ein Terminal oder ein virtuelles Terminal, über das ein Prozess mit einem Benutzer kommuniziert.

Ein Eintrag wie

```text
pts/1
```

bezeichnet beispielsweise ein Pseudoterminal, wie es von einem modernen Terminalemulator verwendet wird.

---

# Mehr Prozesse mit `ps x`

Mit

```bash
ps x
```

bekommen wir ein umfassenderes Bild:

```text
PID TTY      STAT   TIME COMMAND
...
```

Auffällig ist, dass bei manchen Prozessen in der Spalte `TTY` ein Fragezeichen erscheint:

```text
?
```

Das bedeutet, dass dieser Prozess **kein kontrollierendes Terminal** besitzt.

Das ist beispielsweise bei vielen Hintergrundprozessen der Fall.

Die Option `x` wird hier ohne führenden Bindestrich geschrieben.

Sie weist `ps` an, auch Prozesse des aktuellen Benutzers anzuzeigen, die keinem Terminal zugeordnet sind.

Da dadurch schnell eine lange Ausgabe entsteht, können wir sie mit `less` kombinieren:

```bash
ps x | less
```

---

# Prozesszustände

Mit `ps x` erscheint außerdem die Spalte

```text
STAT
```

Sie beschreibt den aktuellen Zustand des Prozesses.

Zu den wichtigsten Statuszeichen gehören:

| Zustand | Bedeutung |
| ------- | --------- |
| `R` | **Running** – Der Prozess läuft gerade oder ist bereit, CPU-Zeit zu erhalten. |
| `S` | **Sleeping** – Der Prozess wartet auf ein Ereignis. |
| `D` | **Uninterruptible Sleep** – Der Prozess wartet meist auf Ein-/Ausgabe und kann währenddessen nicht normal unterbrochen werden. |
| `T` | **Stopped** – Der Prozess wurde angehalten. |
| `Z` | **Zombie** – Der Prozess ist beendet, wurde aber von seinem Elternprozess noch nicht vollständig aufgeräumt. |
| `<` | Prozess mit erhöhter Priorität. |
| `N` | Prozess mit verringerter Priorität, also höherem Nice-Wert. |

Hinter dem eigentlichen Status können weitere Zeichen erscheinen.

Sie beschreiben zusätzliche Eigenschaften eines Prozesses.

Eine vollständige Liste findest du mit:

```bash
man ps
```

:::note
## Was ist ein Zombie?

Ein Zombie ist kein Prozess, der heimlich weiterarbeitet.

Im Gegenteil: Er ist bereits **beendet**.

Sein Elternprozess hat lediglich dessen Exit-Status noch nicht abgeholt. Deshalb bleibt ein kleiner Eintrag in der Prozesstabelle zurück.

Einzelne Zombies sind normalerweise harmlos. Wenn sich jedoch sehr viele davon ansammeln, deutet das häufig auf einen Fehler im Elternprozess hin.
:::

---

# `ps aux`

Eine der bekanntesten Varianten von `ps` lautet:

```bash
ps aux
```

Damit erhalten wir eine ausführliche Liste der Prozesse aller Benutzer.

Beispielsweise:

```text
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.1  ...    ... ?        Ss   ...     ...  /sbin/init
...
```

Die Schreibweise ist etwas ungewöhnlich:

```bash
ps aux
```

enthält **keinen Bindestrich** vor `aux`.

Der Grund dafür ist historisch. Die Linux-Version von `ps` unterstützt mehrere unterschiedliche Optionsstile, darunter die traditionelle Unix- und die BSD-Syntax.

`aux` verwendet den **BSD-Stil**.

Einige häufig verwendete BSD-Optionen sind:

| Option | Bedeutung |
| ------ | --------- |
| `x` | Auch Prozesse ohne kontrollierendes Terminal anzeigen. |
| `a` | Prozesse anderer Benutzer ebenfalls anzeigen. |
| `u` | Benutzerorientierte, ausführliche Darstellung. |
| `w` | Breitere beziehungsweise weniger gekürzte Ausgabe. |

:::note
## Warum hat `ps` so merkwürdige Optionen?

`ps` gehört zu den ältesten Unix-Werkzeugen.

Im Laufe der Jahrzehnte entstanden verschiedene Unix-Familien mit unterschiedlichen Varianten des Befehls.

Die Linux-Version von `ps` unterstützt deshalb mehrere historische Syntaxformen gleichzeitig.

Darum funktionieren beispielsweise sowohl Optionen mit als auch ohne führenden Bindestrich.
:::

---

## Die wichtigsten Spalten von `ps aux`

| Spalte | Bedeutung |
| ------ | --------- |
| `USER` | Besitzer des Prozesses |
| `PID` | Process ID |
| `%CPU` | CPU-Nutzung |
| `%MEM` | Anteil am physischen Arbeitsspeicher |
| `VSZ` | Größe des virtuellen Adressraums |
| `RSS` | Aktuell im RAM befindlicher Speicher |
| `TTY` | Kontrollierendes Terminal |
| `STAT` | Prozesszustand |
| `START` | Startzeitpunkt |
| `TIME` | Verbrauchte CPU-Zeit |
| `COMMAND` | Befehl einschließlich Argumenten |

:::note
## `VSZ` ist nicht gleich RAM-Verbrauch

Ein hoher `VSZ`-Wert bedeutet nicht automatisch, dass ein Prozess entsprechend viel physischen Arbeitsspeicher belegt.

`VSZ` beschreibt seinen virtuellen Adressraum.

`RSS` (*Resident Set Size*) gibt besser wieder, wie viel Speicher des Prozesses sich aktuell tatsächlich im RAM befindet.

Auch `RSS` ist allerdings kein perfekter Wert für den „wirklichen“ Speicherverbrauch, da Speicherbereiche zwischen mehreren Prozessen geteilt werden können.
:::

---

## Einen bestimmten Prozess anzeigen

Wenn wir die PID bereits kennen, können wir gezielt Informationen zu diesem Prozess anzeigen.

Beispielsweise:

```bash
ps uw 44719
```

Die Ausgabe könnte so aussehen:

```text
USER      PID %CPU %MEM   VSZ  RSS TTY   STAT START TIME COMMAND
me      44719  0.0  0.0 13480 6492 pts/1 S    15:57 0:00 bash
```

Damit erhalten wir eine Momentaufnahme dieses einzelnen Prozesses.

---

# Prozesse live beobachten mit `top`

`ps` zeigt immer nur den Zustand zum Zeitpunkt seines Aufrufs.

Für eine fortlaufend aktualisierte Ansicht verwenden wir:

```bash
top
```

`top` zeigt

- die allgemeine Systemauslastung,
- CPU- und Speichernutzung,
- die Anzahl der Prozesse,
- und eine laufend aktualisierte Prozessliste.

Standardmäßig wird die Anzeige regelmäßig aktualisiert.

Die Ausgabe besteht grob aus zwei Teilen:

1. einer Systemübersicht,
2. einer Liste der Prozesse.

Eine moderne `top`-Ausgabe sieht je nach Distribution und Version etwas unterschiedlich aus, enthält aber typischerweise Informationen wie:

```text
top - 14:59:20 up 6:30, 2 users, load average: 0.07, 0.02, 0.00
Tasks: 109 total, 1 running, 106 sleeping, 0 stopped, 2 zombie
%Cpu(s): ...
MiB Mem : ...
MiB Swap: ...
```

Darunter folgt die Prozessliste.

---

## Die Kopfzeile von `top`

Die erste Zeile enthält unter anderem:

### Aktuelle Uhrzeit

```text
14:59:20
```

### Uptime

```text
up 6:30
```

Die **Uptime** gibt an, wie lange das System seit dem letzten Start läuft.

Hier wären es sechs Stunden und 30 Minuten.

### Angemeldete Benutzer

```text
2 users
```

### Load Average

```text
load average: 0.07, 0.02, 0.00
```

Diese drei Werte beschreiben die durchschnittliche Systemlast der letzten

- 1 Minute,
- 5 Minuten,
- 15 Minuten.

:::note
## Load Average richtig verstehen

Load Average wird häufig als reine CPU-Auslastung missverstanden.

Unter Linux zählt die Load Average Tasks, die gerade ausführbar sind oder in einem nicht unterbrechbaren Wartezustand stecken – häufig wegen I/O.

Außerdem muss die Zahl im Verhältnis zur Anzahl der verfügbaren logischen CPUs betrachtet werden.

Auf einem Rechner mit **einer** logischen CPU bedeutet eine Load von ungefähr `1.0`, dass diese vollständig ausgelastet sein kann.

Auf einem Rechner mit **acht** logischen CPUs ist eine Load von `1.0` dagegen vergleichsweise gering.

Ein Wert unter `1.0` bedeutet daher auf modernen Mehrkernsystemen nicht automatisch, dass das System „kaum beschäftigt“ ist.
:::

---

## Tasks

Eine Zeile wie

```text
Tasks: 109 total, 1 running, 106 sleeping, 0 stopped, 2 zombie
```

fasst die Prozesszustände zusammen.

Wir sehen beispielsweise,

- wie viele Tasks insgesamt existieren,
- wie viele gerade laufen,
- wie viele schlafen,
- wie viele angehalten wurden,
- und wie viele Zombies vorhanden sind.

---

## CPU-Auslastung

`top` zeigt die CPU-Nutzung in mehreren Kategorien an.

Häufig begegnen uns dabei Abkürzungen wie:

| Kürzel | Bedeutung |
| ------ | --------- |
| `us` | CPU-Zeit für Benutzerprozesse |
| `sy` | CPU-Zeit im Kernel |
| `ni` | CPU-Zeit für Prozesse mit verändertem Nice-Wert |
| `id` | Idle – ungenutzte CPU-Zeit |
| `wa` | Warten auf I/O |
| `hi` | Hardware-Interrupts |
| `si` | Software-Interrupts |

Ein hoher `id`-Wert bedeutet also, dass die CPU viel Zeit untätig ist.

---

## Arbeitsspeicher und Swap

`top` zeigt außerdem die Nutzung von

- physischem RAM,
- und Swap-Speicher.

Moderne Linux-Systeme verwenden freien Arbeitsspeicher bewusst für Caches. Deshalb bedeutet ein geringer Wert bei „free memory“ nicht automatisch, dass der Arbeitsspeicher knapp wird.

Der Kernel kann viele dieser Cache-Bereiche bei Bedarf wieder freigeben.

---

## `top` bedienen

`top` lässt sich während der Ausführung mit Tastaturbefehlen steuern.

Zwei besonders wichtige sind:

```text
h
```

zeigt die Hilfe an.

```text
q
```

beendet `top`.

:::note
## Moderne Alternativen

Neben `top` gibt es heute komfortablere Terminalprogramme wie `htop` oder `btop`.

Sie zeigen ähnliche Informationen übersichtlicher und teilweise interaktiv an.

`top` lohnt sich trotzdem zu kennen, weil es auf sehr vielen Linux-Systemen standardmäßig vorhanden ist – auch auf Servern, auf denen keine zusätzlichen Werkzeuge installiert wurden.
:::

---

# Prozesse steuern

Jetzt können wir Prozesse anzeigen und beobachten.

Als Nächstes wollen wir sie **steuern**.

Das ursprüngliche Beispiel dieses Buches verwendet dafür das alte X11-Demoprogramm `xlogo`.

Auf heutigen Linux-Desktops – insbesondere unter Wayland – ist `xlogo` häufig nicht mehr installiert. Für die folgenden Übungen kannst du deshalb grundsätzlich jedes grafische Programm verwenden, das sich aus dem Terminal starten lässt.

Falls `xlogo` vorhanden ist, können wir weiterhin damit arbeiten:

```bash
xlogo
```

Andernfalls eignet sich beispielsweise ein einfacher Texteditor oder ein anderes kleines grafisches Programm.

:::note
## X11 und Wayland

`xlogo` stammt aus dem **X Window System**, kurz X11.

X11 war jahrzehntelang die Grundlage grafischer Linux-Desktops.

Viele aktuelle Distributionen verwenden inzwischen standardmäßig **Wayland**. X11-Anwendungen können dank XWayland häufig trotzdem weiterhin ausgeführt werden.

Deshalb ist `xlogo` heute eher ein historisches Demonstrationsprogramm als ein typisches Desktop-Programm.
:::

---

## Ein Programm im Vordergrund

Starten wir:

```bash
xlogo
```

Es erscheint ein kleines Fenster.

Im Terminal fällt dabei etwas Wichtiges auf:

Der Shell-Prompt kehrt **nicht** zurück.

Die Shell wartet darauf, dass das gestartete Programm beendet wird.

Schließen wir das Programm, erscheint der Prompt wieder.

Das Programm läuft also im **Vordergrund** der aktuellen Shell.

---

# Einen Prozess unterbrechen

Starten wir `xlogo` erneut:

```bash
xlogo
```

Anschließend wechseln wir zurück zum Terminal und drücken:

```text
Ctrl-c
```

Das Programm wird beendet und der Prompt erscheint wieder.

`Ctrl-c` sendet dem Vordergrundprozess ein Signal namens

```text
SIGINT
```

also ein **Interrupt-Signal**.

Das Programm erhält damit die Aufforderung, seine Ausführung zu beenden.

Viele Kommandozeilenprogramme reagieren auf `Ctrl-c`, allerdings nicht zwingend alle.

---

# Einen Prozess im Hintergrund starten

Manchmal möchten wir ein Programm starten, aber gleichzeitig den Shell-Prompt weiter benutzen.

Dafür können wir das Programm direkt im Hintergrund starten.

Wir hängen dazu ein kaufmännisches Und an den Befehl:

```bash
xlogo &
```

Die Shell könnte daraufhin Folgendes anzeigen:

```text
[1] 28236
```

und unmittelbar wieder den Prompt ausgeben.

Die beiden Zahlen haben unterschiedliche Bedeutungen:

```text
[1]
```

ist die **Jobnummer** der Shell.

```text
28236
```

ist die **PID** des Prozesses.

:::note
## Jobnummer und PID sind nicht dasselbe

Eine PID wird vom Kernel vergeben und identifiziert einen Prozess im gesamten System.

Eine Jobnummer wird dagegen von deiner aktuellen Shell verwaltet.

Darum kann beispielsweise

```text
%1
```

in einer Shell einen ganz anderen Prozess bezeichnen als `%1` in einem anderen Terminal.
:::

---

## Hintergrundprozesse mit `ps` anzeigen

Da das Programm weiterhin läuft, erscheint es auch in `ps`:

```bash
ps
```

Beispielsweise:

```text
PID     TTY      TIME     CMD
10603   pts/1    00:00:00 bash
28236   pts/1    00:00:00 xlogo
28239   pts/1    00:00:00 ps
```

---

# Jobs der Shell anzeigen

Die Shell besitzt ein eigenes System zur Verwaltung gestarteter Jobs.

Mit

```bash
jobs
```

zeigen wir diese an:

```text
[1]+  Running    xlogo &
```

Hier sehen wir

- Jobnummer `1`,
- Zustand `Running`,
- und den gestarteten Befehl.

Wir können auch mehrere Programme in den Hintergrund schicken:

```bash
xlogo & gedit &
```

Die Shell vergibt dann unterschiedliche Jobnummern:

```text
[1] 47211
[2] 47212
```

---

# Einen Prozess in den Vordergrund holen

Ein Hintergrundjob erhält keine normale Tastatureingabe des Terminals.

Wenn wir ihn wieder in den Vordergrund holen möchten, verwenden wir:

```bash
fg
```

Bei mehreren Jobs geben wir zusätzlich die Jobnummer an:

```bash
fg %1
```

Das Prozentzeichen kennzeichnet dabei eine sogenannte **Jobspec**.

Wenn nur ein passender Job vorhanden ist, genügt häufig:

```bash
fg
```

Der Prozess läuft anschließend wieder im Vordergrund und kann beispielsweise mit

```text
Ctrl-c
```

unterbrochen werden.

---

# Einen Prozess anhalten

Manchmal möchten wir einen Prozess nicht beenden, sondern lediglich **pausieren**.

Dazu drücken wir bei einem Vordergrundprozess:

```text
Ctrl-z
```

Beispielsweise:

```bash
[me@linuxbox ~]$ xlogo
^Z
[1]+  Stopped    xlogo
[me@linuxbox ~]$
```

Der Prozess existiert weiterhin, führt aber momentan keinen Programmcode mehr aus.

Mit

```bash
fg %1
```

können wir ihn im Vordergrund fortsetzen.

Oder wir lassen ihn im Hintergrund weiterlaufen:

```bash
bg %1
```

Die Shell meldet beispielsweise:

```text
[1]+ xlogo &
```

Auch bei `bg` kann die Jobspec weggelassen werden, wenn eindeutig ist, welcher Job gemeint ist.

---

## Ein typischer Anwendungsfall

Angenommen, wir starten versehentlich:

```bash
programm
```

obwohl wir eigentlich

```bash
programm &
```

verwenden wollten.

Dann können wir:

1. mit `Ctrl-z` den Prozess anhalten,
2. mit `bg` im Hintergrund fortsetzen.

Also:

```text
Ctrl-z
```

danach:

```bash
bg
```

Der Prompt steht anschließend wieder zur Verfügung.

---

## Warum grafische Programme aus dem Terminal starten?

Das kann auch heute noch sehr nützlich sein.

Zum Beispiel:

- Das Programm ist nicht im Anwendungsmenü eingetragen.
- Wir möchten spezielle Kommandozeilenoptionen verwenden.
- Wir möchten Fehlermeldungen sehen.
- Wir möchten Debug-Ausgaben beobachten.

Gerade wenn eine grafische Anwendung nicht startet, kann der Aufruf im Terminal wertvolle Hinweise auf die Ursache liefern.

---

# Prozessprioritäten ändern

In der Ausgabe von `ps` und `top` begegnet uns eine Eigenschaft namens **Niceness**.

Sie beeinflusst die Scheduling-Priorität eines Prozesses.

Die Idee dahinter ist etwas humorvoll:

Ein Prozess mit einem hohen Nice-Wert ist „netter“ zu den anderen Prozessen, weil er ihnen eher CPU-Zeit überlässt.

Der Nice-Wert reicht unter Linux normalerweise von

```text
-20
```

bis

```text
19
```

Dabei gilt:

```text
-20 = hohe Priorität
  0 = normal
 19 = niedrige Priorität
```

Das wirkt zunächst verkehrt herum.

Merke dir deshalb:

**Je höher der Nice-Wert, desto netter verhält sich der Prozess gegenüber anderen Prozessen.**

---

# `nice`

Mit `nice` können wir ein Programm mit einem bestimmten Nice-Wert starten.

Angenommen, ein rechenintensives Programm namens `cpu-hog` soll andere Programme möglichst wenig stören:

```bash
nice -n 10 cpu-hog
```

Es erhält damit einen Nice-Wert von `10`.

Ein Prozess mit höherer Priorität könnte beispielsweise so gestartet werden:

```bash
sudo nice -n -10 must-run-fast
```

Dafür sind normalerweise erhöhte Rechte erforderlich.

:::note
## Hohe Priorität mit Vorsicht verwenden

Im Alltag ist es nur selten nötig, einem Programm eine höhere CPU-Priorität zu geben.

Ein aggressiv priorisierter, rechenintensiver Prozess kann andere Anwendungen oder wichtige Systemdienste beeinträchtigen.

Meist ist es sinnvoller, unwichtige rechenintensive Aufgaben mit einem **höheren Nice-Wert** etwas zurückzunehmen.
:::

---

# `renice`

`nice` legt den Nice-Wert beim Start eines Programms fest.

Mit

```bash
renice
```

können wir ihn bei einem bereits laufenden Prozess verändern.

Zuerst bestimmen wir beispielsweise dessen PID:

```bash
ps
```

Angenommen, wir erhalten:

```text
PID      TTY      TIME     CMD
379087   pts/9    00:00:00 bash
379215   pts/9    00:00:00 cpu-hog
379223   pts/9    00:00:00 ps
```

Die PID von `cpu-hog` lautet also:

```text
379215
```

Nun setzen wir dessen Nice-Wert auf `19`:

```bash
renice -n 19 379215
```

Der Prozess erhält damit eine sehr niedrige Scheduling-Priorität gegenüber anderen normalen Prozessen.

:::note
## Nice ist keine feste CPU-Begrenzung

Ein Nice-Wert von `19` bedeutet nicht, dass ein Prozess nur einen bestimmten Prozentsatz der CPU verwenden darf.

Wenn sonst niemand Rechenzeit benötigt, kann auch ein sehr „netter“ Prozess die CPU stark auslasten.

Niceness beeinflusst vor allem, **wer bevorzugt wird, wenn mehrere Prozesse gleichzeitig CPU-Zeit benötigen**.
:::

---

# Signale

Bislang haben wir Programme mit `Ctrl-c` beendet und mit `Ctrl-z` angehalten.

Dahinter steckt ein wichtiges Unix-Konzept:

**Signale.**

Signale sind eine Möglichkeit, wie das Betriebssystem und andere Prozesse einem Prozess bestimmte Ereignisse mitteilen können.

Beispielsweise sendet

```text
Ctrl-c
```

das Signal

```text
SIGINT
```

während

```text
Ctrl-z
```

normalerweise

```text
SIGTSTP
```

sendet.

Programme können auf viele Signale reagieren und selbst entscheiden, was sie daraufhin tun.

Ein Programm könnte beispielsweise beim Empfang eines Beendigungssignals

- geöffnete Dateien schließen,
- temporäre Dateien entfernen,
- seinen aktuellen Zustand speichern,
- und sich anschließend sauber beenden.

---

# Signale mit `kill` senden

Der Name

```bash
kill
```

ist etwas irreführend.

`kill` bedeutet nicht zwangsläufig, dass ein Prozess sofort „getötet“ wird.

Der Befehl **sendet ein Signal** an einen Prozess.

Die grundlegende Syntax lautet:

```bash
kill [-Signal] PID ...
```

Ohne weitere Angabe sendet `kill` standardmäßig das Signal

```text
SIGTERM
```

Beispiel:

```bash
xlogo &
```

Die Shell meldet:

```text
[1] 28401
```

Nun:

```bash
kill 28401
```

Damit senden wir `SIGTERM` an den Prozess mit PID `28401`.

Alternativ können wir bei einem Shell-Job auch dessen Jobspec verwenden:

```bash
kill %1
```

---

# Wichtige Signale

| Nummer | Name | Bedeutung |
| ------ | ---- | --------- |
| `1` | `SIGHUP` | Hangup – signalisiert traditionell das Trennen eines Terminals. |
| `2` | `SIGINT` | Interrupt – entspricht normalerweise `Ctrl-c`. |
| `9` | `SIGKILL` | Beendet den Prozess unmittelbar durch den Kernel. |
| `15` | `SIGTERM` | Fordert den Prozess auf, sich zu beenden. |
| `18` | `SIGCONT` | Setzt einen angehaltenen Prozess fort. |
| `19` | `SIGSTOP` | Hält einen Prozess zwangsweise an. |
| `20` | `SIGTSTP` | Terminal Stop – wird typischerweise durch `Ctrl-z` ausgelöst. |

:::note
## Signalnummern

Die hier genannten Nummern gelten für Linux auf den üblichen Architekturen.

In Skripten und Dokumentation sind die symbolischen Namen wie `SIGTERM` oder `SIGKILL` meist verständlicher als die reinen Nummern.
:::

---

## `SIGHUP` – Hangup

`SIGHUP` ist ein Überbleibsel aus der Zeit physischer Terminals und Modemverbindungen.

Wenn die Verbindung zum Terminal getrennt wurde, erhielt der Prozess ein **Hangup-Signal**.

Heute spielt `SIGHUP` noch immer eine wichtige Rolle.

Viele Daemons interpretieren das Signal beispielsweise als Aufforderung, ihre Konfiguration neu einzulesen.

Welche Bedeutung `SIGHUP` genau besitzt, hängt allerdings vom jeweiligen Programm ab.

---

## `SIGINT` – Interrupt

`SIGINT` entspricht normalerweise dem Drücken von:

```text
Ctrl-c
```

Es fordert das Programm auf, seine aktuelle Tätigkeit zu unterbrechen.

Viele Programme beenden sich daraufhin.

---

## `SIGTERM` – ordentlich beenden

`SIGTERM` ist das Standardsignal von `kill`.

Der Befehl

```bash
kill 1234
```

entspricht daher normalerweise:

```bash
kill -TERM 1234
```

beziehungsweise:

```bash
kill -SIGTERM 1234
```

Das Programm bekommt dadurch Gelegenheit, sich kontrolliert zu beenden.

Deshalb sollte `SIGTERM` normalerweise der **erste Versuch** sein.

---

## `SIGKILL` – sofort beenden

Wenn ein Prozess nicht auf `SIGTERM` reagiert, gibt es als letzte Möglichkeit:

```text
SIGKILL
```

Zum Beispiel:

```bash
kill -KILL 1234
```

oder kurz:

```bash
kill -9 1234
```

`SIGKILL` unterscheidet sich grundlegend von den meisten anderen Signalen.

Der Prozess kann dieses Signal

- nicht abfangen,
- nicht ignorieren,
- und nicht behandeln.

Der Kernel beendet ihn unmittelbar.

Dadurch bekommt das Programm keine Gelegenheit mehr,

- Dateien sauber zu schließen,
- temporäre Daten zu entfernen,
- oder seinen Zustand zu speichern.

:::note
## `kill -9` ist nicht der normale Weg

Es ist verlockend, bei einem störenden Prozess sofort

```bash
kill -9 PID
```

zu verwenden.

Das sollte jedoch die **letzte** Möglichkeit sein.

Versuche normalerweise zuerst:

```bash
kill PID
```

und gib dem Prozess einen Moment Zeit, sich sauber zu beenden.

Erst wenn er darauf nicht reagiert, ist `SIGKILL` sinnvoll.
:::

---

## `SIGSTOP` und `SIGCONT`

Mit `SIGSTOP` wird ein Prozess angehalten.

Wie `SIGKILL` kann auch dieses Signal nicht vom Prozess ignoriert werden.

Mit `SIGCONT` wird ein angehaltener Prozess wieder fortgesetzt.

Die Shell-Befehle `fg` und `bg` verwenden unter anderem solche Mechanismen, um angehaltene Jobs wieder auszuführen.

---

## `SIGTSTP`

`SIGTSTP` ist das Signal, das ein Terminal normalerweise beim Drücken von

```text
Ctrl-z
```

sendet.

Im Gegensatz zu `SIGSTOP` kann ein Programm auf `SIGTSTP` reagieren oder es unter bestimmten Umständen ignorieren.

---

# Signale ausprobieren

Wir starten erneut einen Hintergrundprozess:

```bash
xlogo &
```

Angenommen, dessen PID lautet:

```text
13546
```

Dann können wir beispielsweise `SIGHUP` senden:

```bash
kill -1 13546
```

Dasselbe Signal lässt sich auch über seinen Namen angeben:

```bash
kill -HUP 13546
```

oder:

```bash
kill -SIGHUP 13546
```

Ebenso können wir `SIGINT` senden:

```bash
kill -INT 13546
```

oder:

```bash
kill -SIGINT 13546
```

Die symbolische Schreibweise ist häufig leichter zu lesen.

---

# Weitere Signale

Einige weitere Signale, denen du gelegentlich begegnen wirst:

| Nummer | Name | Bedeutung |
| ------ | ---- | --------- |
| `3` | `SIGQUIT` | Beendet den Prozess und kann zusätzlich einen Core Dump erzeugen. |
| `11` | `SIGSEGV` | Signalisiert einen ungültigen Speicherzugriff. |
| `28` | `SIGWINCH` | Signalisiert eine Änderung der Terminalfenstergröße. |

`SIGSEGV` ist beispielsweise die Ursache hinter der bekannten Meldung:

```text
Segmentation fault
```

Sie tritt auf, wenn ein Programm auf Speicher zugreift, auf den es nicht zugreifen darf.

`SIGWINCH` wird dagegen ausgelöst, wenn sich die Größe eines Terminalfensters ändert.

Programme wie `top` oder `less` können darauf reagieren und ihre Darstellung an die neue Größe anpassen.

Eine vollständige Liste der verfügbaren Signale erhalten wir mit:

```bash
kill -l
```

---

## Wer darf einem Prozess Signale senden?

Prozesse besitzen – ähnlich wie Dateien – einen Besitzer.

Ein normaler Benutzer darf daher grundsätzlich Signale an seine **eigenen Prozesse** senden.

Für Prozesse anderer Benutzer werden entsprechende Berechtigungen benötigt.

`root` kann praktisch jedem Prozess Signale senden.

---

# Prozesse vom Terminal unabhängig machen

Viele Programme reagieren auf das Schließen ihres kontrollierenden Terminals mit `SIGHUP`.

Das kann unerwünscht sein, wenn ein länger laufender Befehl nach dem Abmelden weiterarbeiten soll.

Dafür gibt es:

```bash
nohup
```

Der Name steht für:

**no hangup**

Ein Programm kann beispielsweise so gestartet werden:

```bash
nohup mein_programm &
```

Bei vielen Implementierungen wird die Ausgabe, sofern sie noch auf das Terminal zeigen würde, in eine Datei wie

```text
nohup.out
```

umgeleitet.

:::note
## `nohup` heute

`nohup` ist weiterhin nützlich, aber für länger laufende interaktive Arbeiten auf entfernten Rechnern werden heute häufig Terminal-Multiplexer wie `tmux` oder `screen` verwendet.

Für dauerhaft laufende Dienste ist dagegen ein Service-Manager wie `systemd` meist die bessere Lösung.

`nohup` bleibt jedoch ein einfaches und nahezu überall verfügbares Werkzeug.
:::

---

# Mehrere Prozesse mit `killall` erreichen

Mit

```bash
killall
```

können wir Signale an Prozesse anhand ihres Namens senden.

Die grundlegende Syntax lautet:

```bash
killall [-u Benutzer] [-Signal] Name ...
```

Starten wir beispielsweise zwei Instanzen von `xlogo`:

```bash
xlogo &
xlogo &
```

Dann können wir beide mit

```bash
killall xlogo
```

beenden.

Wie bei `kill` gilt:

Du benötigst die entsprechenden Rechte, um Signale an Prozesse anderer Benutzer zu senden.

:::note
## Vorsicht mit `killall`

`killall` arbeitet mit Prozessnamen.

Wenn mehrere Prozesse mit diesem Namen laufen, können sie **alle** betroffen sein.

Prüfe daher insbesondere auf Mehrbenutzersystemen genau, welche Prozesse du erreichen möchtest.
:::

---

# Das System herunterfahren

Beim Herunterfahren eines Linux-Systems wird nicht einfach der Strom abgeschaltet.

Das Betriebssystem beendet kontrolliert seine Dienste und Prozesse und sorgt dafür, dass noch ausstehende Daten auf die Datenträger geschrieben werden.

Zu den klassischen Befehlen gehören:

```bash
halt
poweroff
reboot
shutdown
```

Auf modernen `systemd`-Systemen werden diese Befehle in der Regel über `systemd` beziehungsweise `systemctl` abgewickelt.

---

## Neustarten

Ein System lässt sich beispielsweise mit

```bash
sudo reboot
```

neu starten.

---

## Ausschalten

Zum Ausschalten kann verwendet werden:

```bash
sudo poweroff
```

Auch `shutdown` kann dafür benutzt werden:

```bash
sudo shutdown -h now
```

---

## Neustart mit `shutdown`

Für einen Neustart:

```bash
sudo shutdown -r now
```

Dabei steht

```text
-r
```

für Reboot.

`shutdown` kann außerdem einen Zeitpunkt beziehungsweise eine Verzögerung erhalten.

Weitere Möglichkeiten zeigt:

```bash
man shutdown
```

Auf Mehrbenutzersystemen können angemeldete Benutzer über den bevorstehenden Shutdown informiert werden.

:::note
## Welchen Befehl sollte ich heute verwenden?

Auf einem normalen modernen Linux-System sind

```bash
sudo reboot
```

und

```bash
sudo poweroff
```

für einen sofortigen Neustart beziehungsweise das Ausschalten meist am einfachsten.

`shutdown` ist besonders praktisch, wenn der Vorgang geplant oder verzögert ausgeführt werden soll.
:::

---

# Weitere Befehle rund um Prozesse

Linux besitzt noch viele weitere Werkzeuge zur Prozess- und Systemüberwachung.

Einige davon sind einen Blick wert.

| Befehl | Beschreibung |
| ------ | ------------ |
| `pstree` | Zeigt Prozesse hierarchisch als Baum an. |
| `vmstat` | Zeigt Statistiken zu Prozessen, Speicher, Swap, CPU und I/O. |
| `xload` | Historisches grafisches Werkzeug zur Anzeige der Systemlast unter X11. |
| `tload` | Zeigt die Systemlast als einfache Grafik direkt im Terminal an. |

---

## `pstree`

Mit

```bash
pstree
```

können wir die Eltern-Kind-Beziehungen zwischen Prozessen sichtbar machen.

Eine vereinfachte Ausgabe könnte beispielsweise so aussehen:

```text
systemd─┬─NetworkManager
        ├─sshd
        ├─systemd─┬─bash───vim
        │         └─...
        └─...
```

Damit wird deutlich, dass Prozesse nicht einfach als flache Liste existieren, sondern eine Hierarchie bilden.

---

## `vmstat`

`vmstat` liefert eine kompakte Übersicht verschiedener Systemressourcen.

Zum Beispiel:

```bash
vmstat
```

Für eine fortlaufende Aktualisierung können wir ein Intervall in Sekunden angeben:

```bash
vmstat 5
```

Die Anzeige wird dann alle fünf Sekunden aktualisiert.

Beenden können wir sie mit:

```text
Ctrl-c
```

`vmstat` ist besonders nützlich, um Probleme mit

- CPU-Auslastung,
- Speicher,
- Swap,
- und Ein-/Ausgabe

zu untersuchen.

---

## `xload` und `tload`

`xload` ist ein sehr altes grafisches X11-Programm, das die Systemlast als Diagramm darstellt.

Auf modernen Linux-Desktops ist es häufig nicht installiert und spielt im Alltag kaum noch eine Rolle.

`tload` verfolgt dieselbe Grundidee, zeichnet die Lastkurve jedoch direkt im Terminal:

```bash
tload
```

Beendet wird es mit:

```text
Ctrl-c
```

Heute gibt es deutlich komfortablere Werkzeuge zur Systemüberwachung, doch beide Programme zeigen schön, wie lange viele Unix-Konzepte bereits existieren.

---

# Zusammenfassung

Linux besitzt ein leistungsfähiges System zur Verwaltung von Prozessen.

In diesem Kapitel haben wir gelernt,

- was ein Prozess ist,
- wie Eltern- und Kindprozesse entstehen,
- was eine PID ist,
- wie wir Prozesse mit `ps` anzeigen,
- wie wir das System mit `top` live beobachten,
- wie Vordergrund- und Hintergrundjobs funktionieren,
- wie `Ctrl-c` und `Ctrl-z` Prozesse beeinflussen,
- wie wir mit `jobs`, `fg` und `bg` die Job Control der Shell verwenden,
- wie `nice` und `renice` die Scheduling-Priorität beeinflussen,
- wie Unix-Signale funktionieren,
- warum `kill` nicht zwangsläufig „töten“ bedeutet,
- warum `kill -9` nur als letzte Möglichkeit verwendet werden sollte,
- wie `nohup` einen Prozess vom Terminal unabhängiger macht,
- und wie ein Linux-System kontrolliert heruntergefahren oder neu gestartet wird.

Prozessverwaltung gehört zu den grundlegenden Fähigkeiten im Umgang mit Linux.

Gerade wenn ein System langsam wird, ein Programm nicht mehr reagiert oder wir auf einem entfernten Server arbeiten, sind die Kommandozeilenwerkzeuge besonders wertvoll.

:::note
## Die wichtigsten Befehle dieses Kapitels

Für den Alltag solltest du dir zunächst vor allem diese Befehle merken:

```bash
ps aux
top
jobs
fg
bg
kill
```

Und insbesondere diesen Unterschied:

```bash
kill PID
```

bedeutet normalerweise:

**„Bitte beende dich.“**

Während

```bash
kill -9 PID
```

sinngemäß bedeutet:

**„Kernel, beende diesen Prozess sofort.“**

Genau deshalb sollte `kill -9` nicht der erste Versuch sein.
:::